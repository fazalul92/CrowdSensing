<%@ page import="edu.rit.se.creativecrowd.DBProcess"%>
<%
	DBProcess dbProc = new DBProcess();
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
									requirements engineering.
								</p>
								<p>
									If you have questions or experience technical problems during
									the study, please contact the researcher,Muhammad Fazalul
									Rahman, at <a href="mailto:mf3791@rit.edu" class="text-primary">mf3791@rit.edu.</a>
								</p>

								<h3>Study Overview</h3>

								<p>The objective of this study is to learn the varying
									requirements of users, like you, and use them to dynamically understand user requirements. To complete this study you are required to
									possess knowledge of using smartphones. The study consists of three main
									steps:</p>

								<ul>
									<li><b>Presurvey</b> collect information about your
										demographics. Estimated time: 0.5 to 1
										minutes.</li>
									<li><b>Main task</b> requires you to imagine your daily routine and imagine requirements. Details on this task will be provided
										after presurveys. Estimated time: 15 to 20 minutes.</li>
									<li><b>Postsurvey</b> collects information about your
										experience on the main task. Estimated time: 2 minutes.</li>
								</ul>

								<p>
									You will complete these tasks sequentially. Once you finish a
									step, you will be redirected to the next step, automatically.
									After the post survey, you will be given a <b>completion
										code</b> to submit the task on the Amazon MTurk website.
								</p>


								<p>The HIT expires in 1 hours. So, you should finish all
									steps within 1 hours.</p>

								<h3>Payment and Bonus</h3>

								<p>The base payment for completing the required tasks is USD
									3.</p>

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