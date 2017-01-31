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
                <h3>Use Cases</h3>
              </div>

            </div>
            <div class="clearfix"></div>
            <div class="row">
            
                        <div class="col-md-12 col-sm-12 col-xs-12">
              <div class="x_panel">
                <div class="x_title">
                  <h2>Add Use Case<small></small></h2>
                  <div class="clearfix"></div>
                </div>
                <form method="post" action="exec/addUseCase.jsp">
                <div class="x_content ">
                  <div id="alerts"></div>
                <div class="row">
                  <div class="col-md-12 col-sm-12 col-xs-12 form-group">
                    <textarea name="descr" id="benefit" style="height:200px" class="col-md-12 col-sm-12 col-xs-12 form-group" placeholder="Description"></textarea>
                  </div>
                  
                </div>
                  
                  
                  <br />

                  <div class="ln_solid"></div>

                      <div class="form-group">
                        <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                          <button type="submit" class="btn btn-primary">Cancel</button>
                          <button type="submit" class="btn btn-success">Submit</button>
                        </div>
                      </div>
                </div>
                </form>
              </div>
            </div>
            
            
            </div>
              </div>
            </div>
          </div>
        </div>
        
        <!-- /page content -->

        
	<%@ include file="scripts.jsp" %>
  </body>
</html>