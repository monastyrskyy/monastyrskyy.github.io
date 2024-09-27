---
title: "Podcast Transcription Pipeline and App" 
date: 2024-9-20
excerpt: "A data pipeline for automatically transcribing podcast episdes in German, analysing the data, and designing in a front end App."
mathjax: "true"
tags: [Azure, pipeline, ETL, API, whisper AI, AI, airflow, Funciton App]
#classes: wide # frontmatter that should make the page wider.
toc: true
toc_sticky: true
toc_label: "Table of Contents"

defaults:
  # _posts
  - scope:
      path: ""
      type: posts
    values:
      layout: single
      author_profile: true
      comments: true
      share: true
      related: true
---

<script src='https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML' async></script>


# Podcast Transcription and Language Learning App

In my journey of learning the German language, nothing has been as helpful as consuming German language content such as books, videos, and podcasts. One of the most helpful ways to learn useful everyday vocab, phrases, and sentence structure is hearing everyday conversation, and nothing is more filled with everyday conversation than long-form podcasts. The trouble is not a lot of podcasts come with subtitles, making it hard to tell what is being said. 

As a solution, I have discovered whisper AI, an open source model developed and published by OpenAI. One can download this model, and run audio files through it, and have them transcribed. 

The model, while imperfect, is very good at telling what is being said even in noisy environments, in colloquial phrases, anglicisms, unclear speech, and so on.

The following is my attempt to automatically download, transcribe and parse podcast episodes using a data pipeline. I want a hands off approach, where all I have to do is add a podcast's RSS link to my app, and receive the transcriptions for all episodes (new and exisiting) through a front end.

>_The following is written with the help of ChatGPT_
<br>

## Technical Overview

The standardization that exists in the world of podcasting makes this process possible. At the heart of the system is the RSS file. An RSS file is a standardized set of metadata about the podcast and its episodes. It contains information such as the podcast and epside titles, descriptions, publish dates, and most crucially links to the .mp3 files of the podcast episodes themselves.

The goal of this project is to set up an automatic process that would parse these RSS files, refresh them daily to look for new episodes, store the episode and podcast data in a relational database, transcribe the episodes, for a given podcast. **Everything revoles around the RSS files.**

The parsing of the RSS file will be done on Azure with the use of Function Apps; the storage of the data will be done on Azure Container Blob Storage; the storage of the podcast and episode metadata will be on a Azure-hosted relational database; and the transcription will be done using whisper AI on my local machine because of cost concerns (it is far cheaper to run these models locally than on the cloud).

For reference, here is what a sample RSS file might look like:

```xml
<rss>
  <channel>
    # This is the podcast-level information
    <title>PODCAST TITLE</title>
    <language>de</language>
    <pubDate>Mon, 12 Oct 2020 10:52:11 +0000</pubDate>
    <description>
      Podcast description would go here.
    </description>
    <link>https://link-to-the-podcast.com</link>
    ...
      More potential podcast-level info here.
    ...

    # Here is the episode-level information. Each episode is considered its own item.
    <item>
      <title>Most recent podcast episode</title>
      <description>
        Episode description. 
      </description>
      <pubDate>Thu, 13 Jun 2024 15:30:00 +0000</pubDate>
      ...
        More potential episode-level info here.
      ...
      <enclosure url="https://most_recent_podcast_episode.mp3?source=feed" type="audio/mpeg" length="74689861"/>
    </item>

    <item>
      <title>Another podcast episode</title>
      <description>
        Episode description. 
      </description>
      <pubDate>Wed, 12 Jun 2024 15:30:00 +0000</pubDate>
      ...
        More potential episode-level info here.
      ...
      <enclosure url="https://another_podcast_episode.mp3?source=feed" type="audio/mpeg" length="74689861"/>
    </item>
  </channel>
</rss>
```

<br>

## Cloud Setup - Azure SQL Server

The SQL Server component is comprised of several tables. They are used to keep track of the processing of the RSS files and also the individual episodes.

- **Table 1: rss_urls**
  - Contains the podcast level information and the URL of the podcasts' RSS files.
  - Table structure:

  | Column Name          | Description                                          | Data Type | Nullable            |
  |----------------------|------------------------------------------------------|-----------|---------------------|
  | podcast_name         | Name of the podcast                                  | nvarchar  | not null            |
  | rss_url              | URL of the podcast RSS feed                          | nvarchar  | not null            |
  | daily_refresh_paused | Indicates if daily refresh of the RSS file is paused | varchar   | null                |
  | last_parsed          | Date the podcast was last parsed                     | date      | null                |
  | podcast_id           | Unique identifier for the podcast            | int (Primary Key) | not null            |

  - Details:
    - If the field daily_refresh_paused equals 'Y', then the RSS Feed for that podcast is not parsed. This allows for easy management of processing the podcasts.
    - podcast_id is there to work with the front end of the app, which expects a primary key. Otherwise it is not used.

  - A few of the rows from the table for visual reference:  
    <div align="center" style="color:gray;"><small>(click to zoom in)</small></div>
    [![foobar]({{ site.url }}{{ site.baseurl }}/images/9.language_app/1.rss_urls.png)]({{ site.url }}{{ site.baseurl }}/images/9.language_app/1.rss_urls.png)

- **Table 2: rss_feed** 
  - Contains the episode level information. Serves (aspirationally) as the single source of truth on the status of the processing of the episodes.
  - Table structure:
 
  | Column Name               | Description                                | Extracted from the RSS File? | Data Type              | Nullable |
  |---------------------------|--------------------------------------------|--------------------------|------------------------|----------|
  | id                         | Primary key                               | No                       | int                    | not null |
  | title                      | Episode title                             | Yes                      | nvarchar               | not null |
  | description                | Episode description                       | Yes                      | nvarchar               | null     |
  | pubDate                    | Publication date of the episode            | Yes                      | datetime               | null     |
  | link                       | URL link to the episode mp3 file           | Yes                      | varchar                | null     |
  | podcast_title              | Title of the podcast                      | Yes                      | nvarchar               | null     |
  | language                   | Language of the podcast                   | Yes                      | nvarchar               | null     |
  | parse_dt                   | Date when the feed was parsed, and the episode was added to this table              | No                       | datetime               | not null |
  | download_flag_azure        | Indicates whether the episode mp3 was downloaded to Azure blob storage                 | No                       | char                   | not null |
  | download_dt_azure          | The datetime when the episode mp3 was downloaded to Azure blob storage             | No                       | datetime               | null     |
  | transcription_dt           | Transcription completion date              | No                       | datetime               | null     |
  | transcription_location     | Location of the transcription file        | No                       | nvarchar               | null     |
  | download_flag_local        | Indicates whether the episode mp3 was downloaded to my local machine, to be transcribed                 | No                       | char                   | not null |
  | download_dt_local          | The datetime when the episode mp3 was downloaded to my local machine              | No                       | datetime               | null     |
  | nouns_extraction_flag      | Flag for noun extraction status                | No                       | varchar                | null     |
  | nouns_extraction_dt        | Noun extraction completion date            | No                       | datetime               | null     |
  | schon_gehoert_flag         | Indicates whether I already listened to the episode   | No                       | varchar                | null     |
  | verbs_extraction_flag      | Verb extraction status flag                | No                       | varchar                | null     |
  | verbs_extraction_dt        | Verb extraction completion date            | No                       | datetime               | null     |

  - Details:
    - The *id* field is there to work with the front end of the app, which expects a primary key. Otherwise it is not used.
    - The *transcription_dt* really indicates when the transcription was uploaded to Azure blob storage, rather than when it the file was actually transcribed. The same is true for the fields *nouns_extraction_dt* and *verbs_extraction_dt*. For all intents and purposes, this is an unimportant distinction.

  - A few of records from the table for visual reference:  
    <div align="center" style="color:gray;"><small>(click to zoom in)</small></div>
    [![foobar]({{ site.url }}{{ site.baseurl }}/images/9.language_app/2.rss_feed.png)]({{ site.url }}{{ site.baseurl }}/images/9.language_app/2.rss_feed.png)



## Cloud Setup - Azure Function Apps

The next step is to explain the function apps. There are three in total:
- The **rss_refresh_daily** script refreshes the RSS files, by downloading the RSS file again.
- The **reading_in_rss_and_writing_to_sql** script parses the RSS Files and extracts useful information.
- The **mp3_download** script downloads the mp3 episode files and stores them on Azure blob storage. 

All other processing happens locally. 

The most up-to-date code with logging and error handling is available here, and dependencies too: <a href="https://github.com/monastyrskyy/rss-parse-function-app-python/blob/main/function_app.py" target="_blank">Code for the RSS Function App</a>

Below is the most recent code, as of this writing, with comprehensive expalanations in the comments.

### Function 1: rss_refresh_daily
```python
'''
The script runs automatically daily at 3:00 AM.

Setup:
1. Database Connection: Connect to the SQL database using SQLAlchemy.
2. Execute a SQL query to select podcast names and RSS URLs where `daily_refresh_paused` is 'N'.

Podcast Processing:
1. Sanitize the podcast name to create a safe filename.
2. Download RSS Feed: Send an HTTP GET request to the RSS URL, and save the response content as an XML file in a temporary local directory.
3. Refresh the Azure Blob Storage content: Upload the local X

Podcast Processing:
1. Sanitize the podcast name to create a safe filename.
2. Download RSS Feed: Send an HTTP GET request to the RSS URL, and save the response content as an XML file in a temporary local directory.
3. Refresh the Azure Blob Storage content: Upload the local XML file to Azure, overwriting the blob if it already exists.
'''

# The script runs automatically daily at 3:00 AM.
@app.schedule(schedule="0 0 3 * * *", arg_name="myTimer", run_on_startup=False, use_monitor=False)
def rss_refresh_daily(myTimer: func.TimerRequest) -> None:
    logging.info('Starting rss_refresh_daily')

    # Setting up connection to Azure
    credential = DefaultAzureCredential()
    key_vault_name = os.environ["MyKeyVault"]
    key_vault_uri = f"https://{key_vault_name}.vault.azure.net/"
    client = SecretClient(vault_url=key_vault_uri, credential=credential)
    logging.info(f"Connected to client: {client}")
    server_name = client.get_secret("SQLServerName").value
    database_name = client.get_secret("DBName").value
    username = client.get_secret("SQLUserName").value
    password = client.get_secret("SQLPass").value
    storage_account_name = client.get_secret("storageAccountName").value
    storage_account_key = client.get_secret("storageAccountKey").value
    logging.info("Fetched database connection details from Key Vault successfully.")
    connection_string = f"mssql+pymssql://{username}:{password}@{server_name}/{database_name}"

    # Connect to SQL Database using SQLAlchemy
    try:
        engine = create_engine(connection_string)
        with engine.connect() as conn:
            query = text("SELECT podcast_name, rss_url FROM dbo.rss_urls WHERE daily_refresh_paused = 'N'")
            result = conn.execute(query)
            podcasts = result.fetchall()

        logging.info(f"RSS URLs and podcast names fetched from SQL Database successfully: {podcasts}")
    except Exception as e:
        logging.error(f"Failed to fetch RSS URLs and podcast names from SQL Database. Error: {str(e)}")
        raise

    # Download and process each podcast
    for podcast_name, rss_url in podcasts:
        safe_podcast_name = podcast_name.replace(' ', '_')
        try:
            # Download the podcast to the function app's storage
            local_filename = os.path.join("/tmp", f"{safe_podcast_name}.xml")
            response = requests.get(rss_url)
            with open(local_filename, 'wb') as file:
                file.write(response.content)
            logging.info(f"XML file downloaded to {local_filename}")

            # Upload to Azure Blob Storage
            blob_service_client = BlobServiceClient(account_url=f"https://{storage_account_name}.blob.core.windows.net/", credential=credential)
            blob_client = blob_service_client.get_blob_client(container="xml", blob=f"{safe_podcast_name}.xml")
            with open(local_filename, "rb") as data:
                blob_client.upload_blob(data, overwrite=True)
            logging.info("XML file has been uploaded to blob storage successfully.")

            # Clean up local file
            os.remove(local_filename)
            logging.info("Local XML file cleaned up successfully.")
        except Exception as e:
            logging.error(f"Failed to process podcast '{podcast_name}' with URL '{rss_url}'. Error: {str(e)}")
            continue

    logging.info("Function completed successfully.")
```


### Function 2: reading_in_rss_and_writing_to_sql

```
The script runs automatically every 20 minutes.

Setup:
1. Database Connection: Connect to the SQL database using SQLAlchemy.
2. Blob Storage Connection: Initialize the Blob Service 
3. Create a helper function to insert RSS items into the rss_feed table, with checks to prevent duplicates.

Blob Processing:
1. Iterate over each RSS file in the Azure container.
2. Parse the RSS file to extract podcast metadata and episodes.
3. For each item in the RSS feed, extract details and insert them into the database using the helper function.
```



### Funcation 3: mp3_download
```
The script runs automatically every 20 minutes.

Setup:
1. Database Connection: Connect to the SQL database using SQLAlchemy.
2. Blob Storage Connection: Initialize the Blob Service 
3. Episode Selection: Execute a SQL query to select episodes that haven't been downloaded yet.

Episode Processing:
1. Clean and prepare the podcast and episode titles for use in file paths.
2. Download the MP3 file from the episode's RSS URL.
3. Upload the MP3 file to Azure Blob Storage.
4. Update the database to mark the episode as downloaded.
```




<br><br>
<br><br>
<br><br>

<br><br>
<br><br>
<br><br>

<br><br>
<br><br>
<br><br>
 


  
### Local
### Airflow within Docker
#### All the DAGs

### Front end 
#### Submit a phrase
Here you can submit a phrase (in either English or German), and get just the translation back, or the translation, along with some sample sentences that use the submitted word or phrase.
    <div align="center" style="color:gray;"><small>(click to zoom in)</small></div>
    [![foobar]({{ site.url }}{{ site.baseurl }}/images/9.language_app/submit_a_phrase.png)]({{ site.url }}{{ site.baseurl }}/images/9.language_app/submit_a_phrase.png)




### Phrase flashcards
nah, this should be replaced with a gif - for linux
Step 1: Install Peek
Open a terminal window.

Run the following commands based on your Linux distribution:

For Ubuntu/Debian:

bash
Code kopieren
sudo add-apt-repository ppa:peek-developers/stable
sudo apt update
sudo apt install peek
For Fedora:

bash
Code kopieren
sudo dnf install peek
For Arch Linux:

bash
Code kopieren
sudo pacman -S peek

| ![Image 1]({{ site.url }}{{ site.baseurl }}/images/9.language_app/phrase_flashcards/phrase_flashcard1.png) | ![Image 2]({{ site.url }}{{ site.baseurl }}/images/9.language_app/phrase_flashcards/phrase_flashcard2.png) |
|:---------------------------------------------:|:---------------------------------------------:|
| ![Image 1]({{ site.url }}{{ site.baseurl }}/images/9.language_app/phrase_flashcards/phrase_flashcard3.png) | ![Image 2]({{ site.url }}{{ site.baseurl }}/images/9.language_app/phrase_flashcards/phrase_flashcard4.png) |
| ![Image 1]({{ site.url }}{{ site.baseurl }}/images/9.language_app/phrase_flashcards/phrase_flashcard5.png) | ![Image 2]({{ site.url }}{{ site.baseurl }}/images/9.language_app/phrase_flashcards/phrase_flashcard6.png) |













  







  







  