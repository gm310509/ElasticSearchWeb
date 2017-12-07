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
public class Table extends DatabaseObject {

    private LinkedList<Record> records = new LinkedList<> ();

    /**
     * Get the value of records
     *
     * @return the value of records
     */
    public LinkedList<Record> getRecords() {
        return records;
    }

    /**
     * Set the value of records
     *
     * @param records new value of records
     */
    public void setRecords(LinkedList<Record> records) {
        this.records = records;
    }

    public Record addRecord() {
        Record r = new Record();
        this.records.add(r);
        return r;
    }
}
