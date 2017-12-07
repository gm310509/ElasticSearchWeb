<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!DOCTYPE html>
<%
    String rootURLTxt = request.getServletContext().getContextPath() + "/";

%>
<!--
 * Elastic Search demo home page.
 * Uses infrastructure Bootstrap.js which can be found:
 *   download:      http://blog.getbootstrap.com/2016/07/25/bootstrap-3-3-7-released/
 *   documentation: https://getbootstrap.com/docs/3.3/getting-started/

-->
<fmt:bundle basename="message" prefix="help">
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
                <div class="col-sm-1"></div>
                <div class="col-sm-9">
                    <h3><fmt:message key="PageHeader" /></h3>
                </div>
                <div class="col-sm-2"></div>
                
              <!-- <p>Lorem ipsum...</p> -->
            </div>
            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-9">
                    <h4><fmt:message key="BasicUsageHeader" /></h4>
                </div>
                <div class="col-sm-2"></div>
            </div>
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <p><fmt:message key="BasicUsageBody01" /></p>
                </div>
                <div class="col-sm-2"></div>
            </div>
            <div class="row">
                <div class="col-sm-3"></div>
                <div class="col-sm-7">
                    <p><a href="<%= rootURLTxt %>"><fmt:message key="BackToSearch" /></a></p>
                </div>
                <div class="col-sm-2"></div>
            </div>
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <p><fmt:message key="BasicUsageBody02" /></p>
                </div>
                <div class="col-sm-2"></div>
            </div>

            <div class="row">
                <div class="col-sm-3"></div>
                <div class="col-sm-7">
                    <p><a href="<%= rootURLTxt %>"><fmt:message key="BackToSearch" /></a></p>
                </div>
                <div class="col-sm-2"></div>
            </div>
 
            <div class="row">
                <div class="col-sm-12">&nbsp;</div>
            </div>

            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <p class="lead">mydb.mytbl</p>
                    <p class="small">
                        2 matches
                    </p>
                </div>
                <div class="col-sm-2"></div>
            </div>
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>id</th>
                                <th>name</th>
                                <th>description</th>
                                <th>score</th>
                                <th>&nbsp;</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>411-2303</td>
                                <td>Fred Smith</td>
                                <td>Has 12 trees.</td>
                                <td>6.2</td>
                                <td><img src="<%= rootURLTxt %>resources/images/button_sql.png"></td>
                            </tr>
                            <tr>
                                <td>781-2457</td>
                                <td>John Jones</td>
                                <td>Has 3 garden beds with trees.</td>
                                <td>5.9</td>
                                <td><img src="<%= rootURLTxt %>resources/images/button_sql.png"></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-sm-2"></div>
            </div>
 
            <div class="row">
                <div class="col-sm-12">&nbsp;</div>
            </div>
 
            <div class="row">
                <div class="col-sm-3"></div>
                <div class="col-sm-7">
                    <p><a href="<%= rootURLTxt %>"><fmt:message key="BackToSearch" /></a></p>
                </div>
                <div class="col-sm-2"></div>
            </div>
           
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <p>
                        <fmt:message key="BasicUsageBody03" />
                    </p>
                        <ul>
                            <li><fmt:message key="BasicUsageLi01" /></li>
                            <li><fmt:message key="BasicUsageLi02" /></li>
                        </ul>
                </div>
                <div class="col-sm-2"></div>
            </div>
 
            <div class="row">
                <div class="col-sm-3"></div>
                <div class="col-sm-7">
                    <p><a href="<%= rootURLTxt %>"><fmt:message key="BackToSearch" /></a></p>
                </div>
                <div class="col-sm-2"></div>
            </div>




            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-9">
                    <h4><fmt:message key="SearchStringsHeader" /></h4>
                </div>
                <div class="col-sm-2"></div>
            </div>
            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-9">
                    <h5><fmt:message key="SearchBasicStringsHdr" /></h5>
                </div>
                <div class="col-sm-2"></div>
            </div>
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <p><fmt:message key="SearchBasicStringsBody01" /></p>
                </div>
                <div class="col-sm-2"></div>
            </div>
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <p><fmt:message key="SearchBasicStringsBody02" /></p>
                    <ul>
                        <li><fmt:message key="SearchBasicStringsExMatch01" /></li>
                        <li><fmt:message key="SearchBasicStringsExMatch02" /></li>
                        <li><fmt:message key="SearchBasicStringsExMatch03" /></li>
                        <li><fmt:message key="SearchBasicStringsExMatch04" /></li>
                        <li><fmt:message key="SearchBasicStringsExMatch05" /></li>
                    </ul>
                </div>
                <div class="col-sm-2"></div>
            </div>
                    
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <p><fmt:message key="SearchBasicStringsBody03" /></p>
                    <ul>
                        <li><fmt:message key="SearchBasicStringsExNoMatch01" /></li>
                        <li><fmt:message key="SearchBasicStringsExNoMatch02" /></li>
                    </ul>
                </div>
                <div class="col-sm-2"></div>
            </div>
                    
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <p><fmt:message key="SearchBasicStringsBody04" /></p>
                </div>
                <div class="col-sm-2"></div>
            </div>

            <div class="row">
                <div class="col-sm-3"></div>
                <div class="col-sm-7">
                    <p><a href="<%= rootURLTxt %>"><fmt:message key="BackToSearch" /></a></p>
                </div>
                <div class="col-sm-2"></div>
            </div>
                
                
                
                
            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-9">
                    <h5><fmt:message key="SearchCompoundStringsHdr" /></h5>
                </div>
                <div class="col-sm-2"></div>
            </div>
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <p><fmt:message key="SearchCompoundStringsBody01" /></p>
                </div>
                <div class="col-sm-2"></div>
            </div>
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <p><fmt:message key="SearchCompoundStringsBody02" /></p>
                    <ul>
                        <li><fmt:message key="SearchCompoundStringsExMatch01" /></li>
                        <li><fmt:message key="SearchCompoundStringsExMatch02" /></li>
                        <li><fmt:message key="SearchCompoundStringsExMatch03" /></li>
                    </ul>
                </div>
                <div class="col-sm-2"></div>
            </div>

            <div class="row">
                <div class="col-sm-3"></div>
                <div class="col-sm-7">
                    <p><a href="<%= rootURLTxt %>"><fmt:message key="BackToSearch" /></a></p>
                </div>
                <div class="col-sm-2"></div>
            </div>

            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <p><fmt:message key="SearchCompoundStringsBody03" /></p>
                </div>
                <div class="col-sm-2"></div>
            </div>

            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <p><fmt:message key="SearchCompoundStringsBody04" /></p>
                </div>
                <div class="col-sm-2"></div>
            </div>
                

            <div class="row">
                <div class="col-sm-1"></div>
                <div class="col-sm-9">
                    <h5><fmt:message key="SearchQueryOperators" /></h5>
                </div>
                <div class="col-sm-2"></div>
            </div>
            <div class="row">
                <div class="col-sm-2"></div>
                <div class="col-sm-8">
                    <dt><fmt:message key="SearchQueryOperatorsAnd" /></dt>
                    <dd><fmt:message key="SearchQueryOperatorsAndEx01" /></dd>
                    <br>
                    
                    <dt><fmt:message key="SearchQueryOperatorsOr" /></dt>
                    <dd><fmt:message key="SearchQueryOperatorsOrEx01" /></dd>
                    <dd><fmt:message key="SearchQueryOperatorsOrEx02" /></dd>
                    <br>
                    
                    <dt><fmt:message key="SearchQueryOperatorsNegate" /></dt>
                    <dd><fmt:message key="SearchQueryOperatorsNegateEx01" /></dd>
                    <dd><fmt:message key="SearchQueryOperatorsNegateEx02" /></dd>
                    <dd><fmt:message key="SearchQueryOperatorsNegateEx03" /></dd>
                    <br>

                    <dt><fmt:message key="SearchQueryOperatorsPhrase" /></dt>
                    <dd><fmt:message key="SearchQueryOperatorsPhraseEx01" /></dd>
                    <dd><fmt:message key="SearchQueryOperatorsPhraseEx02" /></dd>
                    <br>
                    
                    <dt><fmt:message key="SearchQueryOperatorsWildCard" /></dt>
                    <dd><fmt:message key="SearchQueryOperatorsWildCardEx01" /></dd>
                    <dd><fmt:message key="SearchQueryOperatorsWildCardEx02" /></dd>
                    <dd><fmt:message key="SearchQueryOperatorsWildCardEx03" /></dd>
                    <dd><fmt:message key="SearchQueryOperatorsWildCardEx04" /></dd>
                    <br>
                    
                    <dt><fmt:message key="SearchQueryOperatorsFuzzy" /></dt>
                    <dd><fmt:message key="SearchQueryOperatorsFuzzyEx01" /></dd>
                    <dd><fmt:message key="SearchQueryOperatorsFuzzyEx02" /></dd>
                    <br>
                    
                    <dt><fmt:message key="SearchQueryOperatorsNear" /></dt>
                    <dd><fmt:message key="SearchQueryOperatorsNearEx01" /></dd>
                    <dd><fmt:message key="SearchQueryOperatorsNearEx02" /></dd>
                    <br>
                    
                    <dt><fmt:message key="SearchQueryOperatorsPrecedence" /></dt>
                    <dd>- Normally operators are evaluated from left to right. However brackets can be used to change the order.</dd>
                    <dd>- for example a + b | c means match anything that contains both a and b or anything containing c (but not necessarily a).</dd>
                    <dd>- whereas a + (b | c) means match anything that contains both either a and b or a and c. This may be read as matching anything that contains "a" along with either a "b" or "c".</dd>
                    <br>
                    
                </div>
                <div class="col-sm-2"></div>
            </div>

            <div class="row">
                <div class="col-sm-3"></div>
                <div class="col-sm-7">
                    <p><a href="<%= rootURLTxt %>"><fmt:message key="BackToSearch" /></a></p>
                </div>
                <div class="col-sm-2"></div>
            </div>
            <div class="row">
                <div class="col-sm-3"></div>
                <div class="col-sm-7">
                    <p>&nbsp;</p>
                </div>
                <div class="col-sm-2"></div>
            </div>
            <div class="row">
                <div class="col-sm-3"></div>
                <div class="col-sm-7">
                    <p>&nbsp;</p>
                </div>
                <div class="col-sm-2"></div>
            </div>

        </div>
    </body>
</html>
</fmt:bundle>
