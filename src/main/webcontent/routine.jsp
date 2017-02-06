<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="java.util.Arrays" %>
<%@ page import ="edu.rit.se.creativecrowd.DBProcess" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  <%@ include file="head.jsp" %>
	<link href="http://cdn.jsdelivr.net/timepicker.js/latest/timepicker.min.css" rel="stylesheet"/>
	<link rel="stylesheet" type="text/css" href="./vendors/selectize/selectize.css" />
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
			String[] days = {"Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"};
			String[] activityArray = {"","In Vehicle","On Bicycle","Running","Still","Walking"};
			String[] locationArray = {"","Grocery Store","Mall","Home","Office","Road","School","University"};
			String[] socialCircleArray = {"","Alone","Family","Friends","Colleagues","Strangers"};
			String[] moodArray = {"","Happy","Sad","Angry","Stressed","Neutral","Relaxed"};
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
									Please provide the details about your routine, and the corresponding requirements for the two applications. if you fill out the routine for one day, you may choose to 
									copy the routine towards another day and modify it.
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
                    Copy routine from: <br/>
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
                     	<th style="width:8%;">Location</th>
                     	<th style="width:10%;">Activity</th>
                     	<th style="width:14%;">Social Circle</th>
                     	<th style="width:14%;">Mood</th>
                     	<th style="width:10%;">Music Player App</th>
                     	<th style="width:10%;">Ringer Manager App</th>
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
		                    	<td><input type="text" name="<%= j %>-beginTime" class="form-control" value="<%= rs.getString("beginTime") %>" <% if(j<5){ out.println("required"); } %> /></td>
		                    	<td><input type="text" name="<%= j %>-endTime" class="form-control" value="<%= rs.getString("endTime") %>" <% if(j<5){ out.println("required"); } %> /></td>
                        		<td>
                        			<select name="<%= j %>-location" class="selectize-activity" <% if(j<5){ out.println("required"); } %> >
                        				<option value="" <% if(rs.getString("location").equals("")) { out.println("selected"); } %> > </option>
                        				<option value="Home" <% if(rs.getString("location").equals("Home")) { out.println("selected"); } %> >Home</option>
                        				<option value="Road" <% if(rs.getString("location").equals("Road")) { out.println("selected"); } %> >Road</option>
                        				<option value="Office" <% if(rs.getString("location").equals("Office")) { out.println("selected"); } %> >Office</option>
                        				<option value="Mall" <% if(rs.getString("location").equals("Mall")) { out.println("selected"); } %> >Mall</option>
                        				<option value="Grocery Store" <% if(rs.getString("location").equals("Grocery Store")) { out.println("selected"); } %> >Grocery Store</option>
                        				<option value="School" <% if(rs.getString("location").equals("School")) { out.println("selected"); } %> >School</option>
                        				<option value="University" <% if(rs.getString("location").equals("University")) { out.println("selected"); } %> >University</option>
                        				<% if(!Arrays.asList(locationArray).contains(rs.getString("location"))) { out.println("<option selected value=\""+rs.getString("location")+"\">"+rs.getString("location")+"</option>"); } %>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-activity" class="selectize-activity" <% if(j<5){ out.println("required"); } %> >
                        				<option value="" <% if(rs.getString("activity").equals("")) { out.println("selected"); } %> > </option>
                        				<option value="In Vehicle" <% if(rs.getString("activity").equals("In Vehicle")) { out.println("selected"); } %> >In Vehicle</option>
                        				<option value="On Bicycle" <% if(rs.getString("activity").equals("On Bicycle")) { out.println("selected"); } %> >On Bicycle</option>
                        				<option value="Walking" <% if(rs.getString("activity").equals("Walking")) { out.println("selected"); } %> >Walking</option>
                        				<option value="Running" <% if(rs.getString("activity").equals("Running")) { out.println("selected"); } %> >Running</option>
                        				<option value="Still" <% if(rs.getString("activity").equals("Still")) { out.println("selected"); } %> >Still</option>
                        				<% if(!Arrays.asList(activityArray).contains(rs.getString("activity"))) { out.println("<option selected value=\""+rs.getString("activity")+"\">"+rs.getString("activity")+"</option>"); } %> 
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-socialCircle" class="selectize-activity" <% if(j<5){ out.println("required"); } %> >
                        				<option value="" <% if(rs.getString("socialCircle").equals("")) { out.println("selected"); } %> > </option>
                        				<option value="Alone" <% if(rs.getString("socialCircle").equals("Alone")) { out.println("selected"); } %> >Alone</option>
                        				<option value="Family" <% if(rs.getString("socialCircle").equals("Family")) { out.println("selected"); } %> >Family</option>
                        				<option value="Friends" <% if(rs.getString("socialCircle").equals("Friends")) { out.println("selected"); } %> >Friends</option>
                        				<option value="Colleagues" <% if(rs.getString("socialCircle").equals("Colleagues")) { out.println("selected"); } %> >Colleagues</option>
                        				<option value="Strangers" <% if(rs.getString("socialCircle").equals("Strangers")) { out.println("selected"); } %> >Strangers</option>
                        				<% if(!Arrays.asList(socialCircleArray).contains(rs.getString("socialCircle"))) { out.println("<option selected value=\""+rs.getString("socialCircle")+"\">"+rs.getString("socialCircle")+"</option>"); } %> 
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-mood" class="selectize-activity" <% if(j<5){ out.println("required"); } %> >
                        				<option value="" <% if(rs.getString("mood").equals("")) { out.println("selected"); } %> > </option>
                        				<option value="Happy" <% if(rs.getString("mood").equals("Happy")) { out.println("selected"); } %> >Happy</option>
                        				<option value="Sad" <% if(rs.getString("mood").equals("Sad")) { out.println("selected"); } %> >Sad</option>
                        				<option value="Angry" <% if(rs.getString("mood").equals("Angry")) { out.println("selected"); } %> >Angry</option>
                        				<option value="Stressed" <% if(rs.getString("mood").equals("Stressed")) { out.println("selected"); } %> >Stressed</option>
                        				<option value="Neutral" <% if(rs.getString("mood").equals("Neutral")) { out.println("selected"); } %> >Neutral</option>
                        				<option value="Relaxed" <% if(rs.getString("mood").equals("Relaxed")) { out.println("selected"); } %> >Relaxed</option>
                        				<% if(!Arrays.asList(moodArray).contains(rs.getString("mood"))) { out.println("<option selected value=\""+rs.getString("mood")+"\">"+rs.getString("mood")+"</option>"); } %>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-musicPlayerApp" class="form-control" <% if(j<5){ out.println("required"); } %> >
                        				<option value="" <% if(rs.getString("musicPlayerApp").equals("")) { out.println("selected"); } %> > </option>
                        				<option value="None" <% if(rs.getString("musicPlayerApp").equals("None")) { out.println("selected"); } %> >None</option>
                        				<option value="Jazz" <% if(rs.getString("musicPlayerApp").equals("Jazz")) { out.println("selected"); } %> >Jazz</option>
                        				<option value="Pop" <% if(rs.getString("musicPlayerApp").equals("Pop")) { out.println("selected"); } %> >Pop</option>
                        				<option value="Country" <% if(rs.getString("musicPlayerApp").equals("Country")) { out.println("selected"); } %> >Country</option>
                        				<option value="Rock" <% if(rs.getString("musicPlayerApp").equals("Rock")) { out.println("selected"); } %> >Rock</option>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-ringerManagerApp" class="form-control" <% if(j<5){ out.println("required"); } %> >
                        				<option value="" <% if(rs.getString("ringerManagerApp").equals("")) { out.println("selected"); } %> > </option>
                        				<option value="Normal" <% if(rs.getString("ringerManagerApp").equals("Normal")) { out.println("selected"); } %> >Normal</option>
                        				<option value="Silent" <% if(rs.getString("ringerManagerApp").equals("Silent")) { out.println("selected"); } %> >Silent</option>
                        				<option value="Vibrate" <% if(rs.getString("ringerManagerApp").equals("Vibrate")) { out.println("selected"); } %> >Vibrate</option>
                        			</select>
                        		</td>
                       		</tr>
                        <% } %>
                      	<% for(;j<24;j++) { %>
                      	<tr>
		                    	<td><input type="text" name="<%= j %>-beginTime" class="form-control" placeholder="15:15" <% if(j<5){ out.println("required"); } %> /></td>
		                    	<td><input type="text" name="<%= j %>-endTime" class="form-control" placeholder="15:15" <% if(j<5){ out.println("required"); } %> /></td>
                        		<td>
                        			<select name="<%= j %>-location" class="selectize-activity" <% if(j<5){ out.println("required"); } %> >
                        				<option value=""> </option>
                        				<option value="Home">Home</option>
                        				<option value="Road">Road</option>
                        				<option value="Office">Office</option>
                        				<option value="Mall">Mall</option>
                        				<option value="Grocery Store">Grocery Store</option>
                        				<option value="School">School</option>
                        				<option value="University">University</option>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-activity" class="selectize-activity" <% if(j<5){ out.println("required"); } %> >
                        				<option value="In Vehicle">In Vehicle</option>
                        				<option value="On Bicycle">On Bicycle</option>
                        				<option value="Walking">Walking</option>
                        				<option value="Running">Running</option>
                        				<option value="Still">Still</option>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-socialCircle" class="selectize-activity" <% if(j<5){ out.println("required"); } %> >
                        				<option value=""> </option>
                        				<option value="Alone">Alone</option>
                        				<option value="Family">Family</option>
                        				<option value="Friends">Friends</option>
                        				<option value="Colleagues">Colleagues</option>
                        				<option value="Strangers">Strangers</option>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-mood" class="selectize-activity" <% if(j<5){ out.println("required"); } %> >
                        				<option value=""> </option>
                        				<option value="Happy">Happy</option>
                        				<option value="Sad">Sad</option>
                        				<option value="Angry">Angry</option>
                        				<option value="Stressed">Stressed</option>
                        				<option value="Neutral">Neutral</option>
                        				<option value="Relaxed">Relaxed</option>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-musicPlayerApp" class="form-control" <% if(j<5){ out.println("required"); } %> >
                        				<option value="None">None</option>
                        				<option value="Jazz">Jazz</option>
                        				<option value="Pop">Pop</option>
                        				<option value="Country">Country</option>
                        				<option value="Rock">Rock</option>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-ringerManagerApp" class="form-control" <% if(j<5){ out.println("required"); } %> >
                        				<option value="Normal">Normal</option>
                        				<option value="Silent">Silent</option>
                        				<option value="Vibrate">Vibrate</option>
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
		                    	<td><input type="text" name="<%= j %>-beginTime" class="form-control" placeholder="15:15" <% if(j<5){ out.println("required"); } %> /></td>
		                    	<td><input type="text" name="<%= j %>-endTime" class="form-control" placeholder="15:15" <% if(j<5){ out.println("required"); } %> /></td>
                        		<td>
                        			<select name="<%= j %>-location" class="selectize-activity" <% if(j<5){ out.println("required"); } %> >
                        				<option value=""> </option>
                        				<option value="Home">Home</option>
                        				<option value="Road">Road</option>
                        				<option value="Office">Office</option>
                        				<option value="Mall">Mall</option>
                        				<option value="Grocery Store">Grocery Store</option>
                        				<option value="School">School</option>
                        				<option value="University">University</option>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-activity" class="selectize-activity" <% if(j<5){ out.println("required"); } %> >
                        				<option value=""> </option>
                        				<option value="In Vehicle">In Vehicle</option>
                        				<option value="On Bicycle">On Bicycle</option>
                        				<option value="Walking">Walking</option>
                        				<option value="Running">Running</option>
                        				<option value="Still">Still</option>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-socialCircle" class="selectize-activity" <% if(j<5){ out.println("required"); } %> >
                        				<option value=""> </option>
                        				<option value="Alone">Alone</option>
                        				<option value="Family">Family</option>
                        				<option value="Friends">Friends</option>
                        				<option value="Colleagues">Colleagues</option>
                        				<option value="Strangers">Strangers</option>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-mood" class="selectize-activity" <% if(j<5){ out.println("required"); } %> >
                        				<option value=""> </option>
                        				<option value="Happy">Happy</option>
                        				<option value="Sad">Sad</option>
                        				<option value="Angry">Angry</option>
                        				<option value="Stressed">Stressed</option>
                        				<option value="Neutral">Neutral</option>
                        				<option value="Relaxed">Relaxed</option>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-musicPlayerApp" class="form-control" <% if(j<5){ out.println("required"); } %> >
                        				<option value=""> </option>
                        				<option value="None">None</option>
                        				<option value="Jazz">Jazz</option>
                        				<option value="Pop">Pop</option>
                        				<option value="Country">Country</option>
                        				<option value="Rock">Rock</option>
                        			</select>
                        		</td>
                        		<td>
                        			<select name="<%= j %>-ringerManagerApp" class="form-control" <% if(j<5){ out.println("required"); } %> >
                        				<option value=""> </option>
                        				<option value="Normal">Normal</option>
                        				<option value="Silent">Silent</option>
                        				<option value="Vibrate">Vibrate</option>
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
	<script type="text/javascript" src="./vendors/selectize/selectize.js"></script>
	<script>
		$(function() {
		    $('.selectize-activity').selectize({
			    create: true,
			    createOnBlur: true,
			    sortField: 'text'
			});
		});
	</script>
  </body>
</html>
<% dbProcess.disConnect(); %>