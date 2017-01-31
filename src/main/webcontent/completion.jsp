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
	                    <p> You have completed the minimum requirements for the survey. You can continue contributing and become eligible for bonus payment or you could click the button below and complete the study without proceeding. Once you click the button below, you won't be able to come back.
	                    </p>
	                  </div>
	                  <div class="ln_solid"></div>
	                  <a href="exec/completion.jsp">
	                  	<button type="button" class="btn btn-success">Proceed to completion</button>
	                  </a>
	            </div>
            </div>
            <!-- End Panel -->
            
            
           </div>
        </div>
        <!-- /page content -->

        
	<%@ include file="scripts.jsp" %>
  </body>
</html>