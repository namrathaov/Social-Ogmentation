Pre-requisites to run maven project, a Spring Boot application:

1. Tomcat Server
2. JSoup - A java library to connect to a URL and scrape data
3. Library files: jsoup jar, lucene - core, common, queryparser
4. To install maven dependencies from the maven repository.

To build the project: mvn install

To deploy the project: deploy the war file in the project to tomcat webapp folder or run mvn deploy to generate new war file. 
The context for the project is assignment2. 
http://localhost:8080/assignment2
http://localhost:8080/assignment2/search

Project details:

Content extraction: Parsed all the content in the required links on java wikibooks and oracle java tutorials using jsoup. 
The content is preprocessed and stored in text files for later use. To re-run the scraping, a new folder "scraped" is recommended and 
its path to be mentioned in WebCrawler and LuceneIndexer.  
In the Homecontroller, the crawling can be verified by changing the URL to the required study board.

Content Indexing: Used Apache Lucene to index the scraped content after removing the stopwords. 
When a query is searched, the preprocessed content without HTML tags and stopwords provides a better indexing compared to fully downloaded file
s. The indexing is not implemented page-wise but query matching with each paragraph in the content and determining the top scores. 
Overall, topscore returned better results than couple of ranking algorithms like BM25, average occurences by number of documents, 
custom tf-idf formula, etc. 

Web App: As mentioned above, the web application is built on spring boot and requires a server such as tomcat to view the project in browser
(JSP files). The welcome page has a dropdown with 10 inputs corresponding to the queries in the excel sheet. Selecting any input will display 
10 recommendations for the given input in a new page including the code snippets. Each recommendation can be scrolled to view the full content
for each recommendation. User can navigate back to home page to view another recommendation.

Scrollbars are used to improve the visualization and whole content is displayed for readability. 
In the home page, there is also a link to search custom user query. To know more information about Java that is not covered in the 10 queries,
user can utilize the search functionality to search through Oracle and Java Wikibook files to get more recommendations. 
User can manually type the query in the search box on the search page in the webapp. On searching, user can see the top 10 recommendations 
for the custom query.