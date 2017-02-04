<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="head.jsp"%>
<style>
h2 {
	font-size: 24px
}

h3 {
	font-size: 18px
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
							<div class="x_content">
								<h2>Task Description</h2>

								<p>
									Your main task is to imagine your daily routine and the requirements
									for two mobile applications for these daily tasks.  You do not need to
									use any application to complete this task. Just imagine how you would
									expect your mobile phone to behave during certain times in your routine.
									Below, we provide basic information on some key
									concepts and examples.
								</p>

								<h2> Task Details</h2>
								
								<p>
									Imagine a real life scenario for each day. The day starts at 00:00 AM,
									and you might be in bed till 9 AM. During this time, you're at home, 
									your phone will be kept on the table, and you do not require
									any music but you want your volume to be silent. Similarly, you can imagine the various 
									things you do on a daily basis. For each of these events, you have to provide
									the most common activity that the phone will encounter. For example, when sleeping,
									the phone will be kept still, and while awake and cooking breakfast, you are most likely 
									to walk around the house. Later, your location will change from home to road, and then
									office. You are required to provide such routines and the corresponding behaviors
									you expect from the follwing two applications:
								</p>
								
								<p>
									<b>Music Player Application</b> This application contains music in four genres - Jazz,
									Pop, Country and Rock. You have to select the type of music you like for different scenarios you
									go through.
								</p>
								
								<p>
									<b>Ringer Manager Application</b> This application controls your ringer volume, and has three
									options - Normal, Silent and Vibrate. In Normal settings, the phone plays the regular notification
									sounds and vibrates. In Silent settings, the notifications are completely muted. In Vibrate setting, the 
									phone vibrates, but does not make any sound. Choose your setting for each scenario you go encounter.
								</p>
								
								<p>
									A sample task is shown below. Do not copy the exact task, but rather imagine your own routine:
									<img src="./images/sampletask.png" style="width:100%;"/>
								</p>

								<h2>Quantity and Quality</h2>

								<p>You required to come up with at least five routine events per day and provide the information about
									seven days. For that, you will receive a base pay of USD 3.
									However, we encourage you to come up with as many
									scenarios as possible.</p>

							</div>
							<a href="routine.jsp">
								<button type="button" class="btn btn-success">I
									Understand, Continue</button>
							</a>
						</div>
					</div>
					<!-- End Panel -->

				</div>
			</div>
			<!-- /page content -->


			<%@ include file="scripts.jsp"%>
</body>
</html>