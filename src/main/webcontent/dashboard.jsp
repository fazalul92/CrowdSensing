<%@ page import="edu.rit.se.creativecrowd.DBProcess"%>
<%
	DBProcess dbProc = new DBProcess();
	if(Integer.parseInt(session.getAttribute("completion").toString())==0){
		int comp = dbProc.timeOutCheck(Integer.parseInt(session.getAttribute("userid").toString()));
		session.setAttribute("completion", comp);
	}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="head.jsp"%>
<style>
#detailsTable {
	padding: 5px;
	width: 60%;
	margin: 50px auto;
}

#detailsTable td {
	padding: 5px;
	margin: 0 auto;
	text-align: center;
	font-weight: bold;
}
</style>
</head>

<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<%@ include file="menu.jsp"%>
			<!-- page content -->
			<div class="right_col" role="main">
				<div class="">
					<div class="page-title">
						<div class="title_left">
							<h3>Instructions</h3>
						</div>

					</div>
					<!--  Start Panel -->
					<div class="col-md-12 col-sm-12 col-xs-12">
						<div class="x_panel">
							<div class="x_title">
								<div class="clearfix"></div>
							</div>
							<div class="x_content">
								<p>
									<b>Thank you</b> for choosing to participate in this research
									study. Your participation helps advance the state of the art on
									crowd computing.
								</p>
								<p>
									If you have questions or experience technical problems during
									the study, please contact the researcher, Pradeep Murukannaiah,
									at <a href="mailto:pkmvse@rit.edu" class="text-primary">pkmvse@rit.edu.</a>
								</p>

								<h3>Study Overview</h3>

								<p>The objective of this study is to engage members of the
									crowd, like you, in generating ideas for test scenarios. To
									complete this study you are not required to possess any
									specific domain knowledge. However, you need to exercise your
									creativity. The study consists of three main steps:</p>

								<ul>
									<li><b>Presurveys</b> collect information about your
										demographics and personality. Estimated time: 10 to 15
										minutes.</li>
									<li><b>Main task</b> requires you to come up with atleast
										two test scenarios. Details on this task will be provided
										after presurveys. Estimated time: 15 to 30 minutes.</li>
									<li><b>Postsurvey</b> collects information about your
										experience on the main task. Estimated time: 5 minutes.</li>
								</ul>

								<p>
									You will complete these tasks sequentially. Once you finish a
									step, you will be redirected to the next step, automatically.
									After the post survey, you will be given a <b>completion
										code</b> to submit the task on the Amazon MTurk website.
								</p>

								<h3>Important: Time Requirement for the Main Task</h3>

								<p>
									Although the actual time the main task might take is about 15
									to 30 minutes, we require that you sit on the task for <b>at
										least three hours</b>. Thus, the postsurvey will only appear after
									three hours from the time of your first login.
								</p>

								<p>Please note that we do not require you to work on the
									main task for all three hours. You can work on the main task
									intermittently, even in multiple sittings. Your work is saved
									at each step. You can login any number of times and each time
									you login, you can start from where you left. If you experience
									any problems, please start over from the login page.</p>

								<p>The HIT expires in 24 hours. So, you should finish all
									steps with in 24 hours.</p>

								<h3>Payment and Bonus</h3>

								<p>The base payment for completing the required tasks is USD
									3. However, you may receive an additional bonus of upto USD 3
									based on the quality and quantity of your work. More details
									will follow. The table below summarizes your progress.</p>

								<table border="1" id="detailsTable">
									<tr>
										<td></td>
										<td>Completed</td>
										<td>Minimum Required</td>
									</tr>
									<tr>
										<td>Time</td>
										<td><%= dbProc.timeSinceLogin(session.getAttribute("userid").toString()) %>
										</td>
										<td>3 hours</td>
									</tr>
									<tr>
										<td>Pre-Surveys</td>
										<td><%= dbProc.preSurveyCount(Integer.parseInt(session.getAttribute("userid").toString())) %>
										</td>
										<td>3</td>
									</tr>
								</table>
							</div>
						</div>
					</div>
					<!-- End Panel -->


				</div>
			</div>
			<!-- /page content -->


			<%@ include file="scripts.jsp"%>
</body>
</html>
<%
	dbProc.disConnect();
%>