<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="edu.rit.se.creativecrowd.DBProcess" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  <%@ include file="head.jsp" %>
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
		<%@ include file="menu.jsp" %>
		
		<%
		  DBProcess dbProc = new DBProcess();
			ResultSet rs2 = dbProc.getQuestions("creativity_questions");
			String[] GenericQuestions = {"There are twenty questions on this page", "August has thirty one days", "Mercury is closer to the sun than Jupiter"};
			int gencount = 0;
			int counter = 1;
		%>
		
        <!-- page content -->
        
		
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Creativity Questions</h3>
              </div>

            </div>
            <div class="clearfix"></div>
            <div class="row">
              <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Creativity Questions <small>Step 3</small></h2>
                    <div class="clearfix"></div>
                  </div>
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
                    <br />
                    
                    <form class="form-horizontal form-label-left" method="post" id="persona" action="exec/creativity.jsp">
                     <table class="table" style="border:0px;">
                     <thead>
                     	<th style="width:40%;">Question</th>
                     	<th style="width:12%;">1</th>
                     	<th style="width:12%;">2</th>
                     	<th style="width:12%;">3</th>
                     	<th style="width:12%;">4</th>
                     	<th style="width:12%;">5</th>
                     </thead>
                      <tbody>
                        <% while(rs2.next()) { %>
												<% if( counter==8 || counter==18 || counter==26 ) {%>
												<tr>
													<td><label class="" for="generic<%= gencount %>"><%= counter %>. <%= GenericQuestions[gencount] %></label></td>
													<% for(int i=0;i<5;i++) { %>
													<td><input type="radio" name="creativegeneric<%= gencount+1 %>"
														value="<%= i+1 %>" required></td>
													<% } %>
												</tr>
												<% 		counter++;
							                        	gencount++;	                        
							                        } %>
	                        <tr>
	                          <td><label class="" for="<%= rs2.getInt("id") %>"><%= counter %>. <%= rs2.getString("description") %> </label></td>
	                          <% for(int i=0;i<5;i++) { %>
	                          		<td><input type="radio" name="<%= rs2.getInt("id") %>" value="<%= i+1 %>" required></td>
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

        
	<%@ include file="scripts.jsp" %>
	<script type="text/javascript">
			   $("#subm").click(function(){
			       console.log($('#presurvey').serialize());
			  }); 
	</script>
  </body>
</html>
<%
	dbProc.disConnect();
%>