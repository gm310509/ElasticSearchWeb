/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.thinkbig.elastic.model;

import java.security.Timestamp;
import java.sql.Time;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map.Entry;

/**
 *
 * @author glennm
 */
public class Record {

        private float score;

    /**
     * Get the value of score
     *
     * @return the value of score
     */
    public float getScore() {
        return score;
    }

    /**
     * Set the value of score
     *
     * @param score new value of score
     */
    public void setScore(float score) {
        this.score = score;
    }

   
    private LinkedHashMap<String, Object> properties = new LinkedHashMap<>();
    
    public void addProperty(String key, Object value) {
        properties.put(key, value);
    }
    
    
    public LinkedHashMap<String, Object> getProperties() {
        return properties;
    }
    
    
    public String getSqlText(String tableName) {
        
        StringBuilder sb = new StringBuilder();
        
        sb.append("Select *\\nfrom ");
        sb.append(tableName);
        sb.append("\\n");
        sb.append("where ");
        boolean first = true;
        for (Entry<String,Object> property : properties.entrySet()) {
            sb.append ("    ");
            if (!first) {
                sb.append (" AND ");
            }
            first = false;
            
            sb.append(property.getKey());
            sb.append(" = ");
            
            Object value = property.getValue();
            boolean quoted = value instanceof String
                    || value instanceof Date
                    || value instanceof Time
                    || value instanceof Timestamp
                    ;
            if (quoted) {
                sb.append("\\'");
                sb.append(value);
                sb.append("\\'");
            } else {
                sb.append(value);
            }
            sb.append("\\n");
        }
        sb.append(";\\n");
        
        return sb.toString();
    }
    
}
