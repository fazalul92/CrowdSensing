<%@ page import="java.sql.ResultSet"%>
<%@ page import="edu.rit.se.creativecrowd.DBProcess"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="head.jsp"%>
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<%@ include file="menu.jsp"%>
			<%
		  DBProcess dbProc = new DBProcess();
			ResultSet rs2 = dbProc.getQuestions("personality_questions");
			String[] GenericQuestions = {"Eight plus seven is nineteen", "New York is in United States of America"};
			int gencount = 0;
			int counter = 1;
		%>


			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>Pre-Survey 2</h3>
						</div>

					</div>
					<div class="clearfix"></div>
					<div class="row">
						<div class="col-md-12 col-sm-12 col-xs-12">
							<div class="x_panel">
								<div class="x_content">
									<p>
										Please describe the extent to which you agree to the following
										statements on a scale of <span style="color: #e82c2c;">1
											(Strongly disagree)</span> to <span style="color: #e82c2c;">5
											(Strongly agree)</span>.
									</p>

									<!-- <ol>
  <li>Very Inaccurate</li>
  <li>Moderately Inaccurate</li>
  <li>Neither Inaccurate nor Accurate</li>
  <li>Moderately Accurate</li>
  <li>Very Accurate</li>
 </ol> -->


									<p>
										<b>Note: </b> Describe yourself as you generally are now, not
										as you wish to be in the future. Describe yourself as you
										honestly see yourself, in relation to other people you know of
										the same sex as you are, and roughly your same age. So that
										you can describe yourself in an honest manner, your responses
										will be kept in absolute confidence. Please read each
										statement carefully, but do not over-analyze them. Some seem
										worded poorly. Go with what feels best.
									</p>


									<form class="form-horizontal form-label-left" method="post"
										id="persona" action="exec/persona.jsp">
										<table class="table" style="border: 0px;">
											<thead>
												<th style="width: 50%">Question</th>
												<th style="width: 10%">1</th>
												<th style="width: 10%">2</th>
												<th style="width: 10%">3</th>
												<th style="width: 10%">4</th>
												<th style="width: 10%">5</th>
											</thead>
											<tbody>
												<% while(rs2.next()) { %>
												<% if( counter==8 || counter==17 ) {%>
												<tr>
													<td><label class="" for="generic<%= gencount %>"><%= GenericQuestions[gencount] %></label></td>
													<% for(int i=0;i<5;i++) { %>
													<td><input type="radio" name="personageneric<%= gencount+1 %>"
														value="<%= i+1 %>" required></td>
													<% } %>
												</tr>
												<% 
							                        	gencount++;	                        
							                        } %>
												<tr>
													<td><label class="" for="<%= rs2.getInt("id") %>"><%= rs2.getString("description") %>
													</label></td>
													<% for(int i=0;i<5;i++) { %>
													<td><input type="radio" name="<%= rs2.getInt("id") %>"
														value="<%= i+1 %>" required></td>
													<% } %>
												</tr>
												<% 
	                    	counter++;
                        } %>

											</tbody>
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


	<%@ include file="scripts.jsp"%>
</body>
</html>