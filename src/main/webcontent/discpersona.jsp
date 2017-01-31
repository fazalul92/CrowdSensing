<%@ page import ="java.sql.ResultSet" %>
<%@ page import ="edu.rit.se.creativecrowd.DBProcess" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  <%@ include file="head.jsp" %>
  <style>
  	.f2 {
  		text-align: center;
  	}
  </style>
  </head>

  <body class="nav-md">
		<div class="container body">
			<div class="main_container">
				<%@ include file="menu.jsp" %>
				
				<%
				  DBProcess dbProc = new DBProcess();
					ResultSet rs2 = dbProc.getQuestions("discpersonality_questions");
					rs2.next();
					String[] Generic = {"For most questions on this page, how many phrases are in each group:", "Six", "Four", "How many days does August have:", "Thirty One", "Thirty", "Where is 2016 Olympic games held:", "Toronto, Canada", "Rio, Brazil", "Which planet is closest to the Sun:", "Mercury", "Jupiter"};
					int gencount = 0;
					int counter = 1;
				%>
				
				<!-- page content -->
				
				
				<div class="right_col" role="main">
					<div class="">
						<div class="page-title">
							<div class="title_left">
								<h3>Pre-Survey 3</h3>
							</div>
						</div>
						<div class="clearfix"></div>
						<p>For the questions below in groups of four phrases, select
the phrase that describes you the most in the first column, , and
select the phrase that describes you the least in the second
column. You cannot choose the same phrase in both columns. For
some generic questions in between, choose the option that you
agree to the most.</p>
<p>
<b>Note: </b> Describe yourself as you generally are now, not as
you wish to be in the future. Describe yourself as you honestly
see yourself, in relation to other people you know of the same
sex as you are, and roughly your same age. So that you can
describe yourself in an honest manner, your responses will be
kept in absolute confidence. Please read each statement
carefully, but do not over-analyze them. Some seem worded
poorly. Go with what feels best.
</p>
						
						<form id="discform" class="form-horizontal form-label-left" action="exec/discsubmit.jsp" method="POST">
							<% for(int i = 0; i<16 ; i++) { %>
							<div class="row">
								<% for(int j=0;j<2;j++) { %>
								<% if(counter == 5 || counter==10 || counter==17 || counter==23) { %>
								<div class="col-md-6 col-sm-12 col-xs-12">
									<div class="x_panel">
										<div class="x_content">

												<table style="width:100%;margin-left:8px;">
													<div class="set">
														<% for(int tc = 0, temp = gencount/3;tc<3;tc++,gencount++) { 
														%>
														<div class="group">
														<tr>	
																<% if(gencount%3==0) {  %>
																<td style="width:80%;"> 
																	<b><%= Generic[gencount] %></b>
																</td>
																<% } else { %>
																<td style="width:80%;">
																	<input type="radio" required name="discgeneric<%= temp+1 %>" value="<%= tc %>" style="margin-left: 32px;">
																	<%= Generic[gencount] %>
																</td>
																<% } %>
															
														</tr>
														</div>
														<% } %>
													</div>
												</table>
											
										</div>
								  
									</div>
								</div>
								<% 
										counter++;
										continue;
									} %>
								<div class="col-md-6 col-sm-12 col-xs-12">
									<div class="x_panel">
										<div class="x_content">

											
										  
												<table style="width:100%;">
													<div class="set<%= rs2.getString("group_no") %>">
													<div class="group">
														<tr>
															
																<td style="width:20%;" class="f2">
																	 <b>Most like me</b>
																</td>
																<td style="width:20%;" class="f2">
																	<b>Least like me</b>
																</td>
																<td style="width:60%;">
																	
																</td>
															
														</tr>
														</div>
														<% for(int k=0;k<4;k++) { %>
														<div class="group<%= rs2.getString("group_no") %><%= rs2.getString("item_no") %>">
														<tr>
															
																<td style="width:20%;" class="f2">
																	<input type="radio" name="<%= rs2.getString("group_no") %>.<%= rs2.getString("item_no") %>" class="team<%= rs2.getString("group_no") %>1" value="yes"> 
																</td>
																<td style="width:20%;" class="f2">
																	<input type="radio" name="<%= rs2.getString("group_no") %>.<%= rs2.getString("item_no") %>" class="team<%= rs2.getString("group_no") %>2" value="no">
																</td>
																<td style="width:60%;">
																	<%= rs2.getString("description") %>
																	<% rs2.next(); %>
																</td>
															
														</tr>
														</div>
														<% } %>
													
													</div>
												</table>
											
										</div>
								  
									</div>
								</div>
								<% 
								counter++;
								} %>
							</div>
							<% } %>
							<button type="submit" class="btn btn-success">Submit</button>
						</form>
					</div>
				</div>
			</div>
		</div>
        <!-- /page content -->

        
	<%@ include file="scripts.jsp" %>
	<script type="text/javascript">
		$("input:radio").change(function(){
			var group = ":radio[name='"+ $(this).attr("name") + "']";
			if ($(this).is(':checked')) {
			 $("input:radio[class^='"+ $(this).attr('class')+"']").each(function(i) {
			   this.checked = false;
			 });
			 $(this).prop('checked', 'checked');
			}
		});

		$("#discform").submit(function(e){
		    if($( "input:checked" ).length!=60){
				e.preventDefault();
				alert("It looks like you have not answered one or more questions. Please check the questions carefully.");
		    }
		  });
	</script>
  </body>
</html>