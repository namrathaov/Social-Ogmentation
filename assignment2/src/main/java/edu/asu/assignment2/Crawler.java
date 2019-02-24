package edu.asu.assignment2;

import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

/* Used in HomeController to initialize Crawling. */
public class Crawler
{
  private static final int MAX_PAGES_TO_SEARCH = 122;
  private Set<String> pagesVisited = new HashSet<String>();
  private List<String> pagesToVisit = new LinkedList<String>();

  public void search(String url)
  {
      while(this.pagesVisited.size() < MAX_PAGES_TO_SEARCH)
      {
          String currentUrl;
          WebCrawler leg = new WebCrawler();
          if(this.pagesToVisit.isEmpty())
          {
              currentUrl = url;
              this.pagesVisited.add(url);
          }
          else
          {
              currentUrl = this.nextUrl();
          }
          leg.crawl(currentUrl);
          this.pagesToVisit.addAll(leg.getLinks());
      }
  }

  private String nextUrl()
  {
      String nextUrl;
      do
      { nextUrl = this.pagesToVisit.remove(0);
      } while(this.pagesVisited.contains(nextUrl));
      this.pagesVisited.add(nextUrl);
      return nextUrl;
  }
}
