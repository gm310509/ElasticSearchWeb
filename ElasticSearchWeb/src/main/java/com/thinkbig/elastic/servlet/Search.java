/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.thinkbig.elastic.servlet;

import com.thinkbig.elastic.model.SearchResult;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.List;
import java.util.Properties;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.elasticsearch.action.search.SearchRequestBuilder;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.cluster.node.DiscoveryNode;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.transport.InetSocketTransportAddress;
import org.elasticsearch.index.query.QueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.transport.client.PreBuiltTransportClient;

/**
 *
 * @author glennm
 */
public class Search extends HttpServlet {

    
    private AppProperties appProperties = new AppProperties();
    private Logger logger = LogManager.getRootLogger();
    
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        appProperties = initMyProperties(getServletContext());
        
        String searchResultPage = request.getServletContext().getContextPath();
        if (searchResultPage == null || searchResultPage.length() == 0) {
            searchResultPage = "/";
        }

        HttpSession session = request.getSession();
        
        SearchResult result = new SearchResult();
        result.setSearchText(request.getParameter(Constants.FIELD_SEARCH_TEXT));
        result.setShowScore(appProperties.isShowScore());
        
        // TODO: Parameterise the retrieve limit.
        performSearch(result, request.getParameter(Constants.PROP_SEARCH_OFFSET), appProperties.getSearchRetreiveLimit());
        
        session.setAttribute(Constants.PROP_SEARCH_RESULT, result);
        logger.info("Redirecting to : " + searchResultPage);

        response.sendRedirect(searchResultPage);
    }
    
    
    private void performSearch(SearchResult result, String searchOffset, int retrieveLimit) {
        Settings settings = Settings.builder().put("cluster.name", "demo-cluster")
                .put("client.transport.sniff", true)
                .put("node.name", "node-1")
                .build();

        int searchIndex = 0;
        
        if (searchOffset != null) {
            try {
                searchIndex = Integer.parseInt(searchOffset);
            } catch (NumberFormatException e) {
                logger.warn(String.format("Search offset text (%s) failed to convert to a number.", searchOffset));
            }
        }
        
        // Perform some minimal offset verification.
        if (searchIndex < 0) {
            searchIndex = 0;
        }
        
        long startTime = System.currentTimeMillis();
        TransportClient client = new PreBuiltTransportClient(settings);
        try {
            client = client.addTransportAddress(new InetSocketTransportAddress(InetAddress.getByName(appProperties.getHostName()), appProperties.getHostPort()));
            
            logger.info("Connected to elastic search: " + client.nodeName());
            logger.debug(client.toString());
            if (logger.isDebugEnabled()) {
                logger.debug("Nodes:");
                List<DiscoveryNode> nodeList = client.listedNodes();
                for (DiscoveryNode node : nodeList) {
                    logger.debug("  " + node);
                }
            }
        
            logger.info(String.format("elastic search client session establishment took %d ms.", System.currentTimeMillis() - startTime));
            logger.info("Running a search: " + result.getSearchText());
            
            startTime = System.currentTimeMillis();
            SearchResponse response = null;
            try {
                //response = client.prepareSearch()
//                       .setIndices("hackaton")
//                       .setTypes("tweets")
//                       .addFields("id", "text")
                //       .setQuery(/*QueryBuilders.fieldQuery("text", "rod") */ QueryBuilders.simpleQueryStringQuery("rod")).execute().actionGet();
                QueryBuilder query = QueryBuilders.simpleQueryStringQuery(result.getSearchText());
//                String [] includes = {};
//                String [] excludes = {"kylo_schema", "kylo_table"};
                SearchRequestBuilder searchRequest = client.prepareSearch("kylo-data")
                        .setTypes("hive-data")
                        .setQuery(query)
                        .setSize(retrieveLimit)
                        //.setFetchSource(includes, excludes)     // Fields to include or exclude.
                        .setFrom(searchIndex); // TODO: set the starting index. (.setFrom(int starting index)
                response = searchRequest.get();
            } catch (Throwable e) {
                logger.error("Error running search: " + e);
                result.setMessage("Error running search: " + e);
                result.setThrowable(e);
            }
            logger.info(String.format("elastic search search time %d ms.", System.currentTimeMillis() - startTime));
            
//            Set<String> result = new HashSet<String>();
//            for (SearchHit hit : response.getHits()) {
//                Long id = hit.field("id").<Long>getValue();
//                result.add(String.valueOf(id));
//            }

            startTime = System.currentTimeMillis();
            if (response != null) {
                logger.info("Search complete: " + response.getTookInMillis() + " ms, " + response.getHits().getTotalHits() + " hits (total), " + response.getHits().getHits().length + " hits retrieved.");
                for (SearchHit hit : response.getHits()) {
                    result.add(hit, appProperties.getKyloSchemaName(), appProperties.getKyloTableName());
                }
                result.setTotalHits(response.getHits().getTotalHits());
                result.setSearchTimeMilliseconds(response.getTookInMillis());
            }
            result.setHitsRetrieved(appProperties.getSearchRetreiveLimit());
            result.setSearchIndex(searchIndex);
            logger.info(String.format("elastic search retrieval time %d ms.", System.currentTimeMillis() - startTime));
            
        } catch (UnknownHostException e) {
            logger.error("Unknown host exception looking up: " + appProperties.getHostName());
        } finally {
            client.close();
            logger.info("Closed connection to Elastic Search server.");
        }
    }
    
    
    public AppProperties initMyProperties(ServletContext context) {
        return initMyProperties(context, logger);
    }
    
    public static AppProperties initMyProperties(ServletContext context, Logger logger) {
        
        Object o = context.getAttribute(Constants.ATTR_PROPERTIES);
        
        if (o != null && o instanceof AppProperties) {
            logger.info("Retrieving app properties found in application context.");
            return (AppProperties) o;
        }
        
        AppProperties ap = new AppProperties();
        logger.info("Creating new app properties.");
        
        ap.setHostName(getInitString(context, Constants.PROP_HOST_NAME, ap.getHostName()));
        ap.setHostPort(getInitInt(context, Constants.PROP_HOST_PORT, ap.getHostPort(), logger));
        
        ap.setSearchRetreiveLimit(getInitInt(context, Constants.PROP_SEARCH_RETR_LIMIT, ap.getSearchRetreiveLimit(), logger));
        ap.setKyloSchemaName(getInitString(context, Constants.PROP_SCHEMA_FLD_NAME, ap.getKyloSchemaName()));
        ap.setKyloTableName(getInitString(context, Constants.PROP_TABLE_FLD_NAME, ap.getKyloTableName()));
        ap.setShowScore (getInitString(context, Constants.PROP_SHOW_SCORE, ap.isShowScore() ? "1" : "0"));

        for (String path : Constants.PROPERTIES_FILE_PATHS) {
            if (loadFromFile(path, ap, logger)) {
                break;
            }
        }

        context.setAttribute(Constants.ATTR_PROPERTIES, ap);

        logger.info("Application properties loaded...");
        ap.dump();
        
        return ap;
    }
    
    public static boolean loadFromFile(String path, AppProperties appProperties, Logger logger) {
        String fullyQualifiedFileName = path + File.separator + Constants.PROPERTIES_FILE_NAME;
        InputStream is = null;
        try {
            
            is = new FileInputStream(fullyQualifiedFileName);
            Properties p = new Properties();
            p.load(is);
            System.out.println("All properties in " + fullyQualifiedFileName + ":\n" + p);
            
            appProperties.setHostName(p.getProperty(Constants.PROP_HOST_NAME, appProperties.getHostName()));
            appProperties.setHostPort(intFromStr(p.getProperty(Constants.PROP_HOST_PORT), appProperties.getHostPort(), Constants.PROP_HOST_PORT, logger));
            
            appProperties.setSearchRetreiveLimit(intFromStr(p.getProperty(Constants.PROP_SEARCH_RETR_LIMIT), appProperties.getSearchRetreiveLimit(), Constants.PROP_SEARCH_RETR_LIMIT, logger));
            
            appProperties.setKyloSchemaName(p.getProperty(Constants.PROP_SCHEMA_FLD_NAME, appProperties.getKyloSchemaName()));
            appProperties.setKyloTableName(p.getProperty(Constants.PROP_TABLE_FLD_NAME, appProperties.getKyloTableName()));
            System.out.println("Show Score Property: " + p.getProperty(Constants.PROP_SHOW_SCORE));
            appProperties.setShowScore(p.getProperty(Constants.PROP_SHOW_SCORE));
            
            logger.info("Properties loaded from: " + fullyQualifiedFileName);
        } catch (FileNotFoundException e) {
            logger.info("Attempting to load properties from " + fullyQualifiedFileName + " - not found.");
            return false;
        } catch (IOException e) {
            logger.error("Error loading properties file: " + path + "\n" + e.getMessage());
            return false;
        } finally {
            if (is != null) {
                try {
                    is.close();
                } catch (Exception e) {
                    logger.warn("Error closing " + fullyQualifiedFileName + "\n" + e.getMessage());
                }
            }
        }
        return true;
    }
    
    public static int intFromStr(String val, int defaultValue, String propertyName, Logger logger) {
        if (val == null) {
            return defaultValue;
        }

        try {
            return Integer.parseInt(val);
        } catch (NumberFormatException e) {
            logger.warn(String.format("Error in property \"%s\" can not be converted to an integer. Property value = \"%s\"", propertyName, val));
            return defaultValue;
        }
    }
    
    public static String getInitString(ServletContext context, String propertyName, String defaultValue) {
        String wrk = context.getInitParameter(propertyName);
        if (wrk == null) {
            return defaultValue;
        } else {
            return wrk;
        }
    }
    
    public static int getInitInt(ServletContext context, String propertyName, int defaultValue, Logger logger) {
        String wrk = getInitString(context, propertyName, null);
        
        if (wrk == null) {
            return defaultValue;
        }
        return intFromStr(wrk, defaultValue, propertyName, logger);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
