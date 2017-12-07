/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.thinkbig.elastic.model;

import java.util.LinkedList;

/**
 *
 * @author glennm
 */
public class Schema extends DatabaseObject {
    
    private LinkedList<Table> tableList = new LinkedList<>();

    /**
     * Get the value of tableList
     *
     * @return the value of tableList
     */
    public LinkedList<Table> getTableList() {
        return tableList;
    }

    /**
     * Set the value of tableList
     *
     * @param tableList new value of tableList
     */
    public void setTableList(LinkedList<Table> tableList) {
        this.tableList = tableList;
    }

}
