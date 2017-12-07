/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.thinkbig.elastic.servlet;

/**
 *
 * @author glennm
 */
public class Constants {
    
    private Constants() {
        
    }
    public static final String ATTR_PROPERTIES = "web appp properties";
    public static final String PROP_HOST_NAME = "host";
    public static final String PROP_HOST_PORT = "port";
    public static final String PROP_SEARCH_RETR_LIMIT = "retrieveLimit";
    public static final String PROP_SHOW_SCORE = "showScore";
    public static final String PROP_SCHEMA_FLD_NAME = "indexSchemaFieldName";
    public static final String PROP_TABLE_FLD_NAME = "indexTableFieldName";
    
    public static final String PROPERTIES_FILE_NAME = "elasticsearchweb.properties";
    public static final String [] PROPERTIES_FILE_PATHS = {
            "/etc/elasticsearch",
            "/etc"
        };
    

    public static final String PROP_SEARCH_RESULT = "SearchResult";
    public static final String PROP_SEARCH_OFFSET = "searchOffset";

    public static final String FIELD_SEARCH_TEXT = "searchText";
    
}
