/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.thinkbig.elastic.servlet;

import java.util.Properties;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

/**
 *
 * @author glennm
 */
public class AppProperties {

    private int searchRetreiveLimit = 10;
    private String kyloSchemaName = "kylo_schema";
    private String kyloTableName = "kylo_table";
    private String hostName = "localhost";
    private int hostPort = 9300;
    private boolean showScore = true;

    public int getSearchRetreiveLimit() {
        return searchRetreiveLimit;
    }

    public void setSearchRetreiveLimit(int searchRetreiveLimit) {
        this.searchRetreiveLimit = searchRetreiveLimit;
    }

    public String getKyloSchemaName() {
        return kyloSchemaName;
    }

    public void setKyloSchemaName(String kyloSchemaName) {
        this.kyloSchemaName = kyloSchemaName;
    }

    public String getKyloTableName() {
        return kyloTableName;
    }

    public void setKyloTableName(String kyloTableName) {
        this.kyloTableName = kyloTableName;
    }

    public String getHostName() {
        return hostName;
    }

    public void setHostName(String hostName) {
        this.hostName = hostName;
    }

    public int getHostPort() {
        return hostPort;
    }

    public void setHostPort(int hostPort) {
        this.hostPort = hostPort;
    }

    public boolean isShowScore() {
        return showScore;
    }

    public void setShowScore(boolean showScore) {
        this.showScore = showScore;
    }
    
    
    public void setShowScore(String showScoreStr) {
        System.out.println("Set show score: " + showScoreStr);
        if (showScoreStr != null) {
            this.showScore = showScoreStr.equals("1") || showScoreStr.equalsIgnoreCase("yes") || showScoreStr.equalsIgnoreCase("true")
                    || showScoreStr.equalsIgnoreCase("y") || showScoreStr.equalsIgnoreCase("t")
                    || showScoreStr.equalsIgnoreCase("on") || showScoreStr.equalsIgnoreCase("o")
                ;
        }
    }
    private Logger logger = LogManager.getRootLogger();
    public void dump() {
        logger.info(
            String.format(
                    "Elastic Search Host:port                 : %s:%d", hostName, hostPort
                )
            );
        logger.info("Elastic Search hits to retrieve per query: " + searchRetreiveLimit);
        logger.info("Elastic Search show scores               : " + showScore);
        logger.info("Elastic Search kylo_schema field name    : " + kyloSchemaName);
        logger.info("Elastic Search kylo_table field name     : " + kyloTableName);
    }

}
