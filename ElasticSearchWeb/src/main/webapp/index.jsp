<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<%@page import="org.apache.logging.log4j.Logger"%>
<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="com.thinkbig.elastic.servlet.Search"%>
<%@page import="com.thinkbig.elastic.servlet.AppProperties"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.ResourceBundle"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="com.thinkbig.elastic.servlet.Constants"%>
<!DOCTYPE html>
<%@ page import="com.thinkbig.elastic.model.*" %>

<%!
    private String getResourceString(ResourceBundle messageBundle, String key) {
        String result = null;

        if (messageBundle.containsKey(key)) {
            result = messageBundle.getString(key);
        } else {
            result = "???" + key;
        }
        return result;
    }

    private Pattern searchTextPattern = null;
    private String searchText = null;
    private void initHighlightMatch(String searchText) {
        this.searchText = searchText;
        if (searchText != null) {
            if (!searchText.matches("[\\w\\s]+")) {
                searchTextPattern = null;
                return;
            } else {
                searchText = "(" + searchText + ")";
}
        }
        try {
            searchTextPattern = Pattern.compile(searchText, Pattern.CASE_INSENSITIVE + Pattern.MULTILINE);
        } catch (Exception e) {
            searchTextPattern = Pattern.compile("unknown searchText pattern matcher");
        }
    }


    private Object highlightMatch(Object foundObject) {
        if (foundObject == null) {
            return null;
        }

        if (searchTextPattern == null) {
            return foundObject;
        }

        Matcher m = searchTextPattern.matcher(foundObject.toString());
        if (m.find()) {
            String ret = m.replaceAll("<mark>" + m.group(1) + "</mark>");
            return ret;
        }
        
        return foundObject;

    }

%>
<%
    String rootURLTxt = request.getServletContext().getContextPath() + "/";
    System.out.println("RootURL: " + rootURLTxt);
    Logger logger = LogManager.getRootLogger();
    
    ResourceBundle messageBundle = ResourceBundle.getBundle("message");
    
    logger.debug("URL: " + rootURLTxt);
    
    SearchResult result = (SearchResult) session.getAttribute(Constants.PROP_SEARCH_RESULT);
    session.removeAttribute(Constants.PROP_SEARCH_RESULT);
    
    String searchText = "";
    if (result != null) {
        searchText = result.getSearchText();
    }
    
    int showHitsLimit = Integer.MAX_VALUE;
    
    AppProperties appProperties = Search.initMyProperties(application, logger);

%>
<!--
 * Elastic Search demo home page.
 * Uses infrastructure Bootstrap.js which can be found:
 *   download:      http://blog.getbootstrap.com/2016/07/25/bootstrap-3-3-7-released/
 *   documentation: https://getbootstrap.com/docs/3.3/getting-started/

-->
<fmt:bundle basename="message" prefix="index">
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        
<!--        <title>Think Big Analytics Elastic Search</title> -->
            <title><fmt:message key="Title"></fmt:message></title>

        <!-- Bootstrap -->
        <link href="<%= rootURLTxt %>resources/css/bootstrap.min.css" rel="stylesheet">

        <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
          <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type='text/javascript'>
    
function showSql(str, label) {

    newwindow=window.open('', '<fmt:message key="SQLWindowHeader" />','height=400,width=800');

    
    //strFormatted = str.replace(/ /g, '&nbsp;');
    strFormatted = str;
    
    if (window.focus) {
        newwindow.document.open()
        newwindow.document.write('<head>');
        newwindow.document.write('<link rel="stylesheet" href="<%= rootURLTxt %>resources/css/elasticSearch.css" >');
        newwindow.document.write('<body>');
        newwindow.document.write('<h1>' + label + '</h1>');
        newwindow.document.write('<textarea rows="20" cols="90">')
        newwindow.document.write(strFormatted);
        newwindow.document.write('</textarea>')
        newwindow.document.write('<br><br>')
        newwindow.document.write('<button onclick="window.close()"><fmt:message key="CloseWindow" /></button>')
        newwindow.document.write('</body>');
        newwindow.focus();
    }
    return false;
}

</script>
    </head>
    <body>
        
        <div class="container">
            <div class="row">
                <div class="col-sm-12">&nbsp;</div>
            </div>
            <div class="row">
                <div class="col-sm-2">
                    <img src="<%= rootURLTxt %>resources/logo/Customer.png" class="media-object" style="width:100px">   
                </div>
                <div class="col-sm-8">&nbsp;</div>
                <div class="col-sm-2, media-right">
                    <img src="<%= rootURLTxt %>resources/logo/ThinkBig.png" class="media-object" style="width:100px">
                </div>
            </div>
            
            
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <h4><fmt:message key="PageHeader" /></h4>
                </div>
                <div class="col-sm-2"></div>
              <!-- <p>Lorem ipsum...</p> -->
            </div>
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <form action="<%=rootURLTxt %>servlet/Search">
                        <div class="form-group">
                            <label for="<%= Constants.FIELD_SEARCH_TEXT %>"><fmt:message key="SearchPrompt" /></label>
                            <input type="text" class="form-control" name="<%= Constants.FIELD_SEARCH_TEXT %>" id="<%= Constants.FIELD_SEARCH_TEXT %>" value='<%= searchText %>' autofocus >
                        </div>
                        <button type="submit" class="btn btn-default" ><fmt:message key="SubmitButtonLabel" /></button>
                        &nbsp;&nbsp;&nbsp;    <a href="<%=rootURLTxt %>help.jsp"><fmt:message key="HelpLinkText" /></a>
                    </form>
                </div>
                <div class="col-sm-2"></div>
              <!-- <p>Lorem ipsum...</p> -->
            </div>
            <%
                if (result != null) {
            %>
<!--
            <div class="row">
                <div class="col-sm-12">Search text: <%= result.getSearchText() %> </div>
            </div>
-->            
            <div class="row">
                <p>&nbsp;</p>
            </div>
            <div class="row">
<%
                    for (Schema schema : result.getSchemaList()) {
                        //out.println("schema: " + schema.getName() + "<br>");
                        for (Table table : schema.getTableList()) {
                            //out.println("&nbsp;&nbsp;&nbsp;&nbsp; table: " + table.getName() + "<br>");
                            String tableName = getResourceString(messageBundle, "indexUnknownTableName");
                            //System.out.println("******  unknown: " + tableName);
                            if (schema.getName() != null && table.getName() != null) {
                                tableName = String.format("%s.%s", schema.getName(), table.getName());
                            } else if (schema.getName() != null) {
                                tableName = String.format("%s.%s", schema.getName(), tableName /* <= is initialised to the "unknown" string value. thereby producing schemaname.unknown in the local language.*/);
                            } else {
                                tableName = table.getName();
                            }

%>
                <p class="lead"><%= tableName %></p>
                <p class="small">
                    <% String matchCountKey = "MatchCount";
                        if (table.getRecords().size() == 1) {
                            matchCountKey = "SingleMatchCount";
                        }
                    %>
                    <fmt:message key="<%= matchCountKey %>">
                        <fmt:param value="<%= table.getRecords().size() %>" />
                    </fmt:message>
                </p>
            </div>
            
            <div class="row">
                            <table class="table">
<%
                            Set<String> keys = table.getRecords().getFirst().getProperties().keySet();
%>                              <thead>
                                    <tr>
                                        <th>&nbsp;</th>
<%
                                for (String key : keys) {
%>                                      <th><%= key %></th>
<%
                                }
                                if (result.isShowScore()) {
%>                                      <th><fmt:message key="ResultTblHdrScore" /></th>
<%
                                }
%>
                                    </tr>
                                </thead>
                                <tbody>
<%
                            int i = 0;             
                            for (Record record : table.getRecords()) {
                                i++;
                                if (i >= showHitsLimit) {
%>                                  <tr>
                                        <td colspan="10">
                                            <span class="small">
                                                <fmt:message key="TblContinues">
                                                    <fmt:param value="<%=(table.getRecords().size() - showHitsLimit) %>"/>
                                                </fmt:message>
                                            </span>
                                        </td>
                                    </tr>
<%
                                    break;
                                }
%>                                  <tr>
                                    <!-- button created using https://dabuttonfactory.com/ -->
                                    <td><a onclick="showSql('<%= record.getSqlText(tableName)%>', '<fmt:message key="SQLButtonHdr"><fmt:param value="<%= tableName %>"/></fmt:message>' )"><img src="<%= rootURLTxt %>resources/images/button_sql.png"></a></td>
<%
                                initHighlightMatch(searchText);
                                for (String key : keys) {
                                    
%>                                      <td><%= highlightMatch(record.getProperties().get(key)) %></td>
<%
                                }
                                if (result.isShowScore()) {
%>                                      
                                    <td><span class="small"><%= String.format("%.2f", record.getScore()) %></span></td>
<%                              }
%>
                                </tr>
<%
                            }

%>                              </tbody>
                            </table>
<%
                        }
                        out.println("<br>");
                    }
%>
            </div>
<%
                    if (result.getSchemaList().size() == 0) {
%>
                        <div class="col-sm-12"><fmt:message key="NoSearchResults"/></div>

<%
                    } else {
%>
            <div class="row">
                <div class="col-sm-12">
                    <fmt:message key="SearchPaginationSummary">
                        <fmt:param value="<%= result.getSearchIndex() / appProperties.getSearchRetreiveLimit() + 1 %>"/>
                        <fmt:param value="<%= result.getSearchIndex() + 1 %>"/>
                        <fmt:param value="<%= Math.min(result.getSearchIndex() + appProperties.getSearchRetreiveLimit(), result.getTotalHits()) %>"/>
                    </fmt:message>
                    
                </div>
            </div>
<%
}
%>
            <div class="row">
                <div class="col-sm-12">
                    <fmt:message key="SearchHitCountSummary">
                        <fmt:param value="<%= result.getTotalHits() %>" />
                        <fmt:param value="<%= result.getSearchTimeMilliseconds() %>" />
                    </fmt:message>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">&nbsp;</div>
            </div>
            <div class="row">
                <div class="col-sm-2">&nbsp;</div>
                <div class="col-sm-2">
<%

                String searchTextEscaped = URLEncoder.encode(searchText, "UTF-8");
                logger.info("Escaped search text: " + searchTextEscaped);
                
                long startingIndex = Math.max(0, result.getSearchIndex() - appProperties.getSearchRetreiveLimit());
                logger.debug("Starting index = " + startingIndex + ", searchIndex = " + result.getSearchIndex()+ ", ret limit = " + appProperties.getSearchRetreiveLimit());
                if (result.getSearchIndex() > 0) {
%>
                        <a href="<%=rootURLTxt %>servlet/Search?<%= Constants.PROP_SEARCH_OFFSET %>=<%= startingIndex %>&<%= Constants.FIELD_SEARCH_TEXT %>=<%= searchTextEscaped %>"><img src="<%= rootURLTxt %>resources/images/button_previous.png"></a>
<%
                } else {
%>
                        <img src="<%= rootURLTxt %>resources/images/button_previous_grey.png">
<%
                }
%>
                </div>
                <div class="col-sm-2">
<%
                startingIndex = result.getSearchIndex() + appProperties.getSearchRetreiveLimit();
                if (startingIndex < result.getTotalHits()) {
%>
                        <a href="<%=rootURLTxt %>servlet/Search?<%= Constants.PROP_SEARCH_OFFSET %>=<%= startingIndex %>&<%= Constants.FIELD_SEARCH_TEXT %>=<%= searchTextEscaped %>"><img src="<%= rootURLTxt %>resources/images/button_next.png"></a>
<%
                } else {
%>
                        <img src="<%= rootURLTxt %>resources/images/button_next_grey.png">
<%
                }
%>
                </div>
                <div class="col-sm-6">&nbsp;</div>
            </div>
            <div class="row">
                <div class="col-sm-12">&nbsp;</div>
            </div>
            <%
                }
            %>
        </div>
    </body>
</html>
</fmt:bundle>
