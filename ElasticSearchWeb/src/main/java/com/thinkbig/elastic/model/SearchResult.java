/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.thinkbig.elastic.model;

import java.util.LinkedList;
import java.util.Map;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.elasticsearch.search.SearchHit;

/**
 *
 * @author glennm
 */
public class SearchResult {
    private Logger logger = LogManager.getLogger();

    private String searchText;

    /**
     * Get the value of searchText
     *
     * @return the value of searchText
     */
    public String getSearchText() {
        return searchText;
    }

    /**
     * Set the value of searchText
     *
     * @param searchText new value of searchText
     */
    public void setSearchText(String searchText) {
        this.searchText = searchText;
    }
    
    
        private boolean showScore = true;

    /**
     * Get the value of showScore
     *
     * @return the value of showScore
     */
    public boolean isShowScore() {
        return showScore;
    }

    /**
     * Set the value of showScore
     *
     * @param showScore new value of showScore
     */
    public void setShowScore(boolean showScore) {
        this.showScore = showScore;
    }


    private String message;

    /**
     * Get the value of message
     *
     * @return the value of message
     */
    public String getMessage() {
        return message;
    }

    /**
     * Set the value of message
     *
     * @param message new value of message
     */
    public void setMessage(String message) {
        this.message = message;
    }


    private Throwable throwable;

    /**
     * Get the value of throwable
     *
     * @return the value of throwable
     */
    public Throwable getThrowable() {
        return throwable;
    }

    /**
     * Set the value of throwable
     *
     * @param throwable new value of throwable
     */
    public void setThrowable(Throwable throwable) {
        this.throwable = throwable;
    }

    
    private long totalHits;

    /**
     * Get the value of totalHits that match
     * the search as potentially available from
     * the search engine.
     *
     * @return the value of totalHits
     */
    public long getTotalHits() {
        return totalHits;
    }

    /**
     * Set the value of totalHits that match
     * the search as potentially available from
     * the search engine.
     *
     * @param totalHits new value of totalHits
     */
    public void setTotalHits(long totalHits) {
        this.totalHits = totalHits;
    }
    
        private long hitsRetrieved;

    /**
     * Get the total number of hits retrieved from the
     * search engine. That is, the number of hits in this
     * result set.
     *
     * @return the value of hitsRetrieved
     */
    public long getHitsRetrieved() {
        return hitsRetrieved;
    }

    /**
     * Set the total number of hits retrieved from the
     * search engine. That is, the number of hits in this
     * result set.
     *
     * @param hitsRetrieved new value of hitsRetrieved
     */
    public void setHitsRetrieved(long hitsRetrieved) {
        this.hitsRetrieved = hitsRetrieved;
    }

    
    private long searchIndex;

    /**
     * Get the value of searchIndex used to generate this result set.
     *
     * @return the value of searchIndex
     */
    public long getSearchIndex() {
        return searchIndex;
    }

    /**
     * Set the value of searchIndex used to generate this result set.
     *
     * @param searchIndex new value of searchIndex
     */
    public void setSearchIndex(long searchIndex) {
        this.searchIndex = searchIndex;
    }

    
        private long searchTimeMilliseconds;

    /**
     * Get the value of searchTimeMilliseconds
     *
     * @return the value of searchTimeMilliseconds
     */
    public long getSearchTimeMilliseconds() {
        return searchTimeMilliseconds;
    }

    /**
     * Set the value of searchTimeMilliseconds
     *
     * @param searchTimeMilliseconds new value of searchTimeMilliseconds
     */
    public void setSearchTimeMilliseconds(long searchTimeMilliseconds) {
        this.searchTimeMilliseconds = searchTimeMilliseconds;
    }


    
    private LinkedList<Schema> schemaList = new LinkedList<>();

    public LinkedList<Schema> getSchemaList() {
        return schemaList;
    }
    
    
    
    public void add(SearchHit hit, String schemaName, String tableName) {
        Map<String, Object> src = hit.getSource();
        if (logger.isDebugEnabled()) {
            logger.debug("hit: " + hit);
            logger.debug("Score: " + hit.getScore());
            logger.debug("string: " + hit.getSourceAsString());
            logger.debug("index: " + hit.getIndex());
            logger.debug("type: " + hit.getType());
            for (String key : src.keySet()) {
                logger.debug(" " + key + "=" + src.get(key));
            }
        }
        
        boolean hasSchema = src.containsKey(schemaName);
        boolean hasTable = src.containsKey(tableName);
        Schema schema;
        if (hasSchema) {
            schema = findSchema((String) src.get(schemaName));
        } else {
            schema = findSchema(null);
        }
        
        Table table;
        if (hasTable) {
            table = findTable(schema, (String) src.get(tableName));
        } else {
            table = findTable(schema, null);
        }
        
        Record record = table.addRecord();
        record.setScore(hit.getScore());
        
        for (String key : src.keySet()) {
            if (! (key.equalsIgnoreCase(schemaName) || key.equalsIgnoreCase(tableName))) {
                record.addProperty(key, src.get(key));
            }
        }
        
    }
    
    
    private Schema findSchema(String schemaName) {
        for (Schema s : schemaList) {
            if (schemaName == null && s.getName() == null) {
                return s;
            } else if (schemaName != null && schemaName.equalsIgnoreCase(s.getName())) {
                return s;
            }
        }
        Schema s = new Schema();
        s.setName(schemaName);
        schemaList.add(s);
        return s;
    }
    
    private Table findTable(Schema schema, String tableName) {
        for (Table t : schema.getTableList()) {
            if (tableName == null && t.getName() == null) {
                return t;
            } else if (tableName != null && tableName.equalsIgnoreCase(t.getName())) {
                return t;
            }
        }
        Table t = new Table();
        t.setName(tableName);
        schema.getTableList().add(t);
        return t;
    }
}
