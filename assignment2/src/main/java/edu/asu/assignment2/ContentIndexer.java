package edu.asu.assignment2;

import org.apache.lucene.analysis.core.StopAnalyzer;
import org.apache.lucene.analysis.core.WhitespaceAnalyzer;
import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.TextField;
import org.apache.lucene.index.DirectoryReader;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.queryparser.classic.ParseException;
import org.apache.lucene.queryparser.classic.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopScoreDocCollector;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.RAMDirectory;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class ContentIndexer {
    List<String> contents = new ArrayList<String>();
    private void indexDirectory(IndexWriter writer, File dir) throws IOException {
        File[] files = dir.listFiles();
        for (int i = 0; i < files.length; i++) {
            File f = files[i];
            if (f.isDirectory()) {
                indexDirectory(writer, f);
            } else if (f.getName().endsWith(".txt")) {
                indexFile(writer, f);
            }
        }
    }
    private void indexFile(IndexWriter writer, File f) throws IOException {
        System.out.println("Indexing " + f.getName());
        Document doc = new Document();
        doc.add(new TextField("filename", f.getName(), TextField.Store.YES));
       try{
            FileInputStream is = new FileInputStream(f);
            BufferedReader reader = new BufferedReader(new InputStreamReader(is));
            StringBuffer stringBuffer = new StringBuffer();
            String line = null;
            while((line = reader.readLine())!=null){
                stringBuffer.append(line).append("\n");
            }
            reader.close();
            doc.add(new TextField("contents", stringBuffer.toString(), TextField.Store.YES));
        }catch (Exception e) {
            System.out.println("something wrong with indexing content of the files");
        }
        writer.addDocument(doc);
    }

    public List<String> getResults(String query) throws IOException, ParseException {

        File dataDir = new File("C:\\Users\\ovnam\\Courses\\Fall18\\CSE591\\assignment2\\scraped");
        if (!dataDir.exists() || !dataDir.isDirectory()) {
            System.out.println(
                    dataDir + " does not exist or is not a directory");
        }
        Directory indexDir = new RAMDirectory();

        StopAnalyzer analyzer = new StopAnalyzer();
        IndexWriterConfig config = new IndexWriterConfig(analyzer);
        IndexWriter writer = new IndexWriter(indexDir, config);

        indexDirectory(writer, dataDir);
        writer.close();

		Query q = new QueryParser( "contents", analyzer).parse(QueryParser.escape(query));
        int hitsPerPage = 10;
        IndexReader reader = null;
        TopScoreDocCollector collector = null;
        IndexSearcher searcher = null;
        reader = DirectoryReader.open(indexDir);
        searcher = new IndexSearcher(reader);
        collector = TopScoreDocCollector.create(hitsPerPage);
        searcher.search(q, collector);
        ScoreDoc[] hits = collector.topDocs().scoreDocs;
        System.out.println("Found " + hits.length + " hits.");
        System.out.println();
        for (int i = 0; i < hits.length; ++i) {
            int docId = hits[i].doc;
            Document d;
            d = searcher.doc(docId);
            contents.add(getContentsOfIndexedFile(d.get("filename"))+"\n\n");
            //System.out.println((i + 1) + ". " + d.get("filename"));
            //System.out.println(contents);
        }
        reader.close();
        return contents;
    }
    public String getContentsOfIndexedFile(String fileName) throws IOException {
        File file = new File("C:\\Users\\ovnam\\Courses\\Fall18\\CSE591\\assignment2\\scraped\\"+fileName);

        BufferedReader br = null;
        try {
            br = new BufferedReader(new FileReader(file));
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        String st, contents="";
        while ((st = br.readLine()) != null)
                contents +=st+"\n";
        return contents;
    }
}

