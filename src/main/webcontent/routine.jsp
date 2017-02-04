<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="edu.rit.se.creativecrowd.DBProcess" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  <%@ include file="head.jsp" %>
	<link href="http://cdn.jsdelivr.net/timepicker.js/latest/timepicker.min.css" rel="stylesheet"/>
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
		<%@ include file="menu.jsp" %>
		
		<%
		  DBProcess dbProcess = new DBProcess();
			int gencount = 0;
			int counter = 1;
			//int dayCounter = 1;
			int dayCounter = (Integer) session.getAttribute("routineDay");
			String[] days = {"Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Saturday"};
		%>
		
        <!-- page content -->
        
		
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Routine Questions - <%= days[dayCounter] %></h3>
              </div>

            </div>
            <div class="clearfix"></div>
            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Routine Questions <small>Step 2</small></h2>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
									<p>
									Please provide the details about your routine, and the corresponding requirements for the two applications
									</p>


									<p>
										<b>Note: </b> 
										<ul>
											<li><b>Start Time and End Time</b> are to be given in 24 hour format. eg: <b>16:00</b></li>
											<li>Your location can be anything like <b>home</b>, <b>office</b>, <b>shopping mall</b>, etc</li>
											<li>Please select the most prominent activity in the given time period. For example, if you are at a shopping mall, and mostly walking, select Walking.</li>
										</ul>
									</p>
                    <br />
                    <% if(dayCounter>0) { %>
                    <div class="col-md-4 col-sm-4 col-xs-4">
                    <form class="form-horizontal form-label-left" method="POST" id="dayReplace" action="routine.jsp">
                    Same as <br/>
                    <table style="width:100%;">
                    	<tr>
                    		<td>
                    			<select name="fillDayData" class="form-control">
	                     			<% for(int i=0;i<dayCounter;i++){ %>
	                     				<option value="<%= days[i] %>"><%= days[i] %></option>
	                     			<% } %>
                     			</select>
                     		</td>
                     		<td style="margin-left:10px;">
                     	 		<input type="submit" value="Submit" class="btn btn-success btn-sm" style="margin-left:10px;"/>
                     	 	</td>
                     	</tr>
                   	</table>
                    </form>
                    </div>
                    <% } %>
                    
                    <form class="form-horizontal form-label-left" method="post" id="persona" action="exec/submitRoutine.jsp">
                     
                     <table class="table" style="border:0px;">
                     <thead>
                     	<th style="width:7%;">Start TIme</th>
                     	<th style="width:7%;">End Time</th>
                     	<th style="width:16%;">Location</th>
                     	<th style="width:10%;">Activity</th>
                     	<th style="width:20%;">Music Player App</th>
                     	<th style="width:20%;">Ringer Manager App</th>
                     </thead>
                    <% if(request.getParameter("fillDayData")!=null){ 
                    	ResultSet rs = dbProcess.getRoutineResponse(session.getAttribute("userid").toString(), request.getParameter("fillDayData").toString());
                    	
                    %>
                    	<tbody>
                        <input type="hidden" name="day" value="<%= days[dayCounter] %>" class="form-control" />
                        <% if(dayCounter<6) { %>
                        	<input type="hidden" name="nextDay" value="<%= days[dayCounter+1] %>" class="form-control" />
                        <% } else {%>
                        	<input type="hidden" name="nextDay" value="end" class="form-control" />
                        <% } 
                        	int j = 0;
                        %>
                        <% for(;rs.next()&&j<24;j++) { %>
                      		<tr>
		                    	<td><input type="text" name="<%= j %>-beginTime" class="form-control" value="<%= rs.getString("beginTime") %>"/></td>
		                    	<td><input type="text" name="<%= j %>-endTime" class="form-control" value="<%= rs.getString("endTime") %>"/></td>
                        		<td><input type="text" name="<%= j %>-location" class="form-control" value="<%= rs.getString("location") %>"/></td>
                        		<td>
                        			<select name="<%= j %>-activity" class="form-control">
                        				<option value="IN_VEHICLE" <% if(rs.getString("activity").equals("IN_VEHICLE")) { out.println("selected"); } %> >In Vehicle</option>
                        				<option value="ON_BICYCLE" <% if(rs.getString("activity").equals("ON_BICYCLE")) { out.println("selected"); } %> >On Bicycle</option>
                        				<option value="ON_FOOT" <% if(rs.getString("activity").equals("ON_FOOT")) { out.println("selected"); } %> >Walking</option>
                        				<option value="RUNNING" <% if(rs.getString("activity").equals("RUNNING")) { out.println("selected"); } %> >Running</option>
                        				<option value="STILL" <% if(rs.getString("activity").equals("STILL")) { out.println("selected"); } %> >Still</option>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-musicPlayerApp" class="form-control">
                        				<option value="NONE" <% if(rs.getString("musicPlayerApp").equals("NONE")) { out.println("selected"); } %> >None</option>
                        				<option value="JAZZ" <% if(rs.getString("musicPlayerApp").equals("JAZZ")) { out.println("selected"); } %> >Jazz</option>
                        				<option value="POP" <% if(rs.getString("musicPlayerApp").equals("POP")) { out.println("selected"); } %> >Pop</option>
                        				<option value="COUNTRY" <% if(rs.getString("musicPlayerApp").equals("COUNTRY")) { out.println("selected"); } %> >Country</option>
                        				<option value="ROCK" <% if(rs.getString("musicPlayerApp").equals("ROCK")) { out.println("selected"); } %> >Rock</option>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-ringerManagerApp" class="form-control">
                        				<option value="NORMAL" <% if(rs.getString("ringerManagerApp").equals("NORMAL")) { out.println("selected"); } %> >Normal</option>
                        				<option value="SILENT" <% if(rs.getString("ringerManagerApp").equals("SILENT")) { out.println("selected"); } %> >Silent</option>
                        				<option value="VIBRATE" <% if(rs.getString("ringerManagerApp").equals("VIBRATE")) { out.println("selected"); } %> >Vibrate</option>
                        			</select>
                        		</td>
                       		</tr>
                        <% } %>
                      	<% for(;j<24;j++) { %>
                      	<tr>
		                    	<td><input type="text" name="<%= j %>-beginTime" class="form-control" placeholder="15:15"/></td>
		                    	<td><input type="text" name="<%= j %>-endTime" class="form-control" placeholder="15:15"/></td>
                        		<td><input type="text" name="<%= j %>-location" class="form-control" placeholder="home, office, mall, etc."></td>
                        		<td>
                        			<select name="<%= j %>-activity" class="form-control">
                        				<option value="IN_VEHICLE">In Vehicle</option>
                        				<option value="ON_BICYCLE">On Bicycle</option>
                        				<option value="ON_FOOT">Walking</option>
                        				<option value="RUNNING">Running</option>
                        				<option value="STILL">Still</option>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-musicPlayerApp" class="form-control">
                        				<option value="NONE">None</option>
                        				<option value="JAZZ">Jazz</option>
                        				<option value="POP">Pop</option>
                        				<option value="COUNTRY">Country</option>
                        				<option value="ROCK">Rock</option>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-ringerManagerApp" class="form-control">
                        				<option value="NORMAL">Normal</option>
                        				<option value="SILENT">Silent</option>
                        				<option value=VIBRATE>Vibrate</option>
                        			</select>
                        		</td>
                       	</tr>
                       	<% } %>
                      </tbody>
                    <% } else { %>
                      <tbody>
                        <input type="hidden" name="day" value="<%= days[dayCounter] %>" class="form-control" />
                        <% if(dayCounter<6) { %>
                        	<input type="hidden" name="nextDay" value="<%= days[dayCounter+1] %>" class="form-control" />
                        <% } else {%>
                        	<input type="hidden" name="nextDay" value="end" class="form-control" />
                        <% } %>
                      	<% for(int j=0;j<24;j++) { %>
                      	<tr>
		                    	<td><input type="text" name="<%= j %>-beginTime" class="form-control" placeholder="15:15"/></td>
		                    	<td><input type="text" name="<%= j %>-endTime" class="form-control" placeholder="15:15"/></td>
                        		<td><input type="text" name="<%= j %>-location" class="form-control"  placeholder="home, office, mall, etc."></td>
                        		<td>
                        			<select name="<%= j %>-activity" class="form-control">
                        				<option value="IN_VEHICLE">In Vehicle</option>
                        				<option value="ON_BICYCLE">On Bicycle</option>
                        				<option value="ON_FOOT">Walking</option>
                        				<option value="RUNNING">Running</option>
                        				<option value="STILL">Still</option>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-musicPlayerApp" class="form-control">
                        				<option value="NONE">None</option>
                        				<option value="JAZZ">Jazz</option>
                        				<option value="POP">Pop</option>
                        				<option value="COUNTRY">Country</option>
                        				<option value="ROCK">Rock</option>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-ringerManagerApp" class="form-control">
                        				<option value="NORMAL">Normal</option>
                        				<option value="SILENT">Silent</option>
                        				<option value=VIBRATE>Vibrate</option>
                        			</select>
                        		</td>
                       	</tr>
                       	<% } %>
                      </tbody>
                      <% } %>
                    </table> 
                    <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                          <button class="btn btn-primary">Cancel</button>
                          <button id="subm" class="btn btn-success">Submit</button>
                        </div>
                 </form>
                    
                    
                    
                  </div>
                </div>
              </div>
            </div>
              </div>
            </div>
          </div>
        </div>
        
        <!-- /page content -->

        
	<%@ include file="scripts.jsp" %>
	<script src="http://cdn.jsdelivr.net/timepicker.js/latest/timepicker.min.js"></script>
	</script>
	<script type="text/javascript">
	/*var timepicker = new TimePicker('time1', {
		  lang: 'en',
		  theme: 'dark'
		});

		var input = document.getElementById('time1');

		timepicker.on('change', function(evt) {
		  
		  var value = (evt.hour || '00') + ':' + (evt.minute || '00');
		  evt.element.value = value;

		});*/
			   $("#subm").click(function(){
			       console.log($('#presurvey').serialize());
			  }); 
	</script>
  </body>
</html>
<%
	dbProcess.disConnect();
%>