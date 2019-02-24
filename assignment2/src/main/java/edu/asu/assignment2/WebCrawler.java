package edu.asu.assignment2;

import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.*;
import java.util.LinkedList;
import java.util.List;

public class WebCrawler
{
   private static final String USER_AGENT =
            "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/535.1 (KHTML, like Gecko) Chrome/13.0.782.112 Safari/535.1";
    private List<String> links = new LinkedList<String>();
    private Document htmlDocument;

    public boolean crawl(String url)
    {
        try
        {
            Connection connection = Jsoup.connect(url).userAgent(USER_AGENT);
            Document htmlDocument = connection.get();
            this.htmlDocument = htmlDocument;
            if(connection.response().statusCode() == 200 && (url.contains("en.wikibooks.org") || url.contains("docs.oracle.com"))) // 200 is the HTTP OK status code
            {
                Element html = null;
                try {
          			html = Jsoup.connect(url).get().select("body").first();
          		} catch (IOException e) {
          			// TODO Auto-generated catch block
          			e.printStackTrace();
          		}

                 // System.out.println(html);
                String filename="";
                  try {
                      filename = this.htmlDocument.title().replaceAll("-|/|&>™,","");
                      filename.replaceAll("\\(","");
                      filename.replaceAll("\\)","");
                      int maxLength = (filename.length() < 20)?filename.length():20;
                      filename = filename.substring(0, maxLength);
                      File statText = new File("C:\\Users\\ovnam\\Courses\\Fall18\\CSE591\\assignment2\\scraped\\"+filename+".txt");
                      FileOutputStream is = new FileOutputStream(statText);
                      OutputStreamWriter osw = new OutputStreamWriter(is);    
                      Writer w = new BufferedWriter(osw);
                      if(html!=null)
                        w.write(html.text().replaceAll(".",".<br>"));
                      w.close();
                  } catch (IOException e) {

                      System.err.println("Problem writing to the file "+filename+".txt");
                      e.printStackTrace();
                  }
            }
            if(!connection.response().contentType().contains("text/html"))
            {
                System.out.println("**Failure** Retrieved something other than HTML");
                return false;
            }
            Elements linksOnPage = htmlDocument.select("a[href]");
            for(Element link : linksOnPage)
            {
                this.links.add(link.absUrl("href"));
            }
            return true;
        }
        catch(IOException ioe)
        {
            return false;
        }
    }

    public List<String> getLinks()
    {
        return this.links;
    }

}
