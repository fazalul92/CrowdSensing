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
									Your main task is to come up with <b>test scenarios</b> for
									smart home applications. You do not require any specific domain
									knowledge to complete this task. Just <b>use you
										imagination</b>! Below, we provide basic information on some key
									concepts and examples of test scenarios.
								</p>

								<h3>What is a smart home?</h3>

								<p>
									A smart home consists of smart things! Smart things are objects
									that can sense their surroundings, compute from the sensed
									data, and communicate the computed results to humans or other
									smart things. In addition to gadgets such as laptops and smart
									phones, an increasing variety of household objects such as TVs,
									light bulbs, heaters, stoves, doors and windows, sprinklers,
									and cars are becoming smart things.
									<!-- The picture to the right shows some Smart Home sensors. -->
								</p>

								<h3>What is a smart home requirement?</h3>

								<p>A smart home may host several applications. Each smart
									home application addresses one or more user requirements. You
									will produce test scenarios for one specific application with a
									given set of requirements (described in the next page). Below,
									we describe a smart home application with two requirements as
									an example.</p>

								<ul>
									<li><b>Application:</b> Smart doors&mdash;A smart home should
										automatically lock and unlock doors.</li>
									<li><b>Requirement 1:</b> When an authorized vehicle
										approaches the garage, the smart home automatically opens the
										garage door.</li>
									<li><b>Requirement 2:</b> After a vehicle enters the
										garage, the smart home automatically locks the garage door.</li>
									<!--<ul>
											<li>When an authorized vehicle comes to the front gate,
												the smart home automatically opens the gate.</li>
											<li>When an authorized person comes to the front door,
												the smart home automatically unlocks the door for the
												person.</li>
										</ul>-->
								</ul>

								<h3>What is a test scenario?</h3>

								<p>A test scenario describes a way to check whether the
									application meets a prescribed requirement or not. A test
									scenario consists of three components: stimulus, context, and
									response.</p>

								<ul>
									<li><b>Stimulus</b> describes how you initiate the
										application to react in some way.</li>
                  <li><b>Context</b> describes the condition in which the
                    stimulus occurs.</li>										
									<li><b>Response</b> describes what you expect the
										application to do in response to the stimulus.</li>
								</ul>

								<p>Consider three test scenarios for the requirements, for
									example.</p>

								<ul>
									<li>Test scenario 1 for Requirement 1:
										<ul>
											<li><b>Stimulus: </b>I drive my motorbike towards the
												garage door.</li>
											<li><b>Context: </b>My motorbike is authorized; it is
                        night time.</li>												
											<li><b>Response: </b>Garage door should open.</li>
										</ul>
									</li>
									<li>Test scenario 2 for Requirement 1:
										<ul>
											<li><b>Stimulus: </b>My friend drives his car towards my
												garage door.</li>
											<li><b>Context: </b>My friend's car is not authorized.
                        His car is same make, model, and color as my authorized car.
                        It is day time.</li>												
											<li><b>Response: </b>Garage door should not open.</li>
										</ul>
									</li>
                  <li>Test scenario 3 for Requirement 2:
                    <ul>
											<li><b>Stimulus: </b>Once the garage door is open, I
												drive my car into the garage, but stop it before completely
												entering the garage.</li>
											<li><b>Context: </b>My car is authorized. </li>
											<li><b>Response: </b>Garage door should not close as
												long as my car is not completely inside.</li>
										</ul>
                  </li>									
								</ul>

                <h3>Hints to Get Started</h3>

								<p>
									It is important to be <b>creative</b> in generating test
									scenarios. The following are some points you can keep in mind
									to get started.
								</p>

								<ul>
									<li>Imagine how end-users employ the application.</li>
									<li>Imagine some potential ways in which the application
										may be misused.</li>
									<li>Imagine potential scenarios in which the application
										may break.</li>
									<li>Imagine potential ways in which the application may be
										stressed.</li>
								</ul>
								<!-- Nominal Group Instructions -->
								<%
									  if (Integer.parseInt(session.getAttribute("group_type").toString()) == 1) {
									%>

								<!-- Non-interacting Group Instructions -->
								<%
									  } else if (Integer.parseInt(session.getAttribute("group_type").toString()) == 2) {
									%>
								<h2>Group Work</h2>
								<p>You will work in a group for this task. As part of the
									group, you can see what test scenarios others are producing.
									Although your scenarios can be inspired from the ones others
									produce, your scenarios must be different from the ones others
									produce in some aspect (e.g., different stimulus, response, or
									context).</p>

								<p>Please keep in mind that your group mates may not be
									online at the same time you are.</p>

								<!-- Interacting Group Instructions -->
								<%
									  } else if (Integer.parseInt(session.getAttribute("group_type").toString()) == 3) {
									%>
								<h2>Group Work</h2>
								<p>You will work in a group for this task. As part of the
									group, you can see what test scenarios others are producing and
									comment on those scenarios. Although your scenarios can be
									inspired from the ones others produce, your scenarios must be
									different from the ones others produce in some aspect (e.g.,
									different stimulus, response, or context).</p>

								<p>You can use the Discussions page to ask questions your
									group members and answer others' questions.</p>

                <p>Please keep in mind that your group mates may not be
                  online at the same time you are.</p>

								<p>Be a team player! You can contribute to your group, e.g.,
									by answering questions and providing constructive comments.</p>

								<%
								  }
								%>

								<h2>Quantity and Quality</h2>

								<p>You required to come up with at least two unique test
									scenarios. For that, you will receive a base pay of USD 3.
									However, we encourage you to come up with as many test
									scenarios as possible.</p>

								<p>
									<b>Bonus: </b>Depending on the the number of test scenarios you
									produce and their quality, you may receive a Bonus of up to USD
									3. High quality test scenarios are easy to understand, cover
									a variety of scenarios, and, most importantly, help find faults
									in the application.
								</p>

							</div>
							<a href="requirements.jsp">
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