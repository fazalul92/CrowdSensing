<!DOCTYPE html>
<html lang="en">
  <head>
  <%@ include file="head.jsp" %>
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
		<%@ include file="menu.jsp" %>
        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Completion Code</h3>
              </div>

            </div>
            <!--  Start Panel -->
            <div class="col-md-12 col-sm-12 col-xs-12">
	            <div class="x_panel">
	                  <div class="x_title">
	                    <div class="clearfix"></div>
	                  </div>
	                  <div class="x_content">
								<p>Thank you for participating in this research. Please
									submit the completion code given below in MTurk so that we can
									verify that you have completed the tasks.</p>

								<p>
									<b>Important Note: </b> You can only submit this HIT once
									across batches. If you submit this HIT multiple times, your
									work will be rejected.
								</p>

								<br />

								<% 
	                    	DBProcess dbProc = new DBProcess();
	                    	String uid = session.getAttribute("userid").toString();
	                    	String ccode = dbProc.getCompletionCode(uid);
	                    	dbProc.disConnect();
	                    %>
	                    Completion code: <b><%= ccode %></b>
	                  </div>
	            </div>
            </div>
            <!-- End Panel -->
            
            
           </div>
        </div>
        <!-- /page content -->

        
	<%@ include file="scripts.jsp" %>
  </body>
</html>