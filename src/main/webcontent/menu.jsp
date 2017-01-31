<%@page import="edu.rit.se.creativecrowd.DBProcess"%>
<%@ page import ="java.sql.ResultSet" %>
        <%@page import="edu.rit.se.creativecrowd.DBProcess"%>
<div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="dashboard.jsp" class="site_title"><i class="fa fa-paw"></i> <span>Crowd Testing Research!</span></a>
            </div>

            <div class="clearfix"></div>


            <br />
            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
                <h3>General</h3>
                <ul class="nav side-menu">
                  <li><a href="dashboard.jsp"><i class="fa fa-home"></i> Home <span class="fa fa-chevron-down"></span></a>
                  </li>                  
                  <%
                  	String state = session.getAttribute("state").toString();
                  	DBProcess dbp = new DBProcess();
                  	ResultSet Notifications = dbp.getNotifications(Integer.parseInt(session.getAttribute("groupid").toString()));
                  	int notificationCount = 0;
                  	ResultSet rsm = dbp.getMenu(state);
                  	while(rsm.next()) {
                  %>
                  	<li><a href="<%= rsm.getString("filename") %>"><i class="fa fa-bar-chart-o"></i> <%= rsm.getString("title") %> <span class="fa fa-chevron-down"></span></a>
                  </li>
                  <% } %>
                  <% if(Integer.parseInt(session.getAttribute("group_type").toString())==3 && Integer.parseInt(session.getAttribute("state").toString())>4) { %>
                  <li><a href="discussions.jsp"><i class="fa fa-users"></i> Discussions <span class="fa fa-chevron-down"></span></a>
                  </li>  
                  <% } %>
                  <% if(Integer.parseInt(session.getAttribute("completion").toString())==1) { %>
                  <li><a href="completion.jsp"><i class="fa fa-external-link"></i> Get Completion Code <span class="fa fa-chevron-down"></span></a>
                  </li>  
                  <% } %>
                </ul>
              </div>

            </div>
            <!-- /sidebar menu -->

          </div>
        </div>

        <!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
            <nav>
				<div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>
              
              <ul class="nav navbar-nav navbar-right">
                <li>
                	<a href="exec/logout.jsp">
	                  	<button type="button" class="btn btn-success">Log Out</button>
	                  </a>
                
                </li>
                
                <%  if(Integer.parseInt(session.getAttribute("group_type").toString()) > 1) {%>
                <li role="presentation" class="dropdown" style="float:left;">
                	
                  <a href="javascript:;" class="dropdown-toggle info-number" data-toggle="dropdown" aria-expanded="false">
                    <i class="fa fa-envelope-o"></i>
                    <span class="badge bg-green" id="NotificationCount">0</span>
                  </a>
                  <ul id="menu1" class="dropdown-menu list-unstyled msg_list" role="menu">
                    <% while(Notifications.next()) { %>
	                    <li>
	                      <a href="<%= Notifications.getString("link") %>">
	                        <span>
	                          <span></span>
	                          <span class="time"><%= Notifications.getString("created_at") %></span>
	                        </span>
	                        <span class="message" style="margin-top:15px;">
	                          <%= Notifications.getString("content") %>
	                        </span>
	                      </a>
	                    </li>
                    <% 
                    	notificationCount++;
                    } %>
                    <!-- <li>
                      <div class="text-center">
                        <a href="notifications.jsp">
                          <strong>See All Alerts</strong>
                          <i class="fa fa-angle-right"></i>
                        </a>
                      </div>
                    </li> -->
                  </ul>
                </li>
                
				<li role="presentation" style="float:left;color: #2a3f54;margin-top: 18px;font-weight: bold;font-size: medium;">
                	Group Updates
                </li>
                <% } %>
                <li style="color: #2a3f54;margin-top: 18px;font-weight: bold;font-size: medium;">
                	<%= session.getAttribute("name").toString() %>
                </li>
              </ul>
            </nav>
          </div>
        </div>
        <!-- /top navigation -->
        <script>
        	var notCount = <%= notificationCount %>;
	        document.getElementById("NotificationCount").innerHTML = notCount;
	        if(notCount > 0){
	        	document.getElementById("NotificationCount").className = "badge bg-red";
	        }
        </script>

<% dbp.disConnect(); %>