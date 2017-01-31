<%@ page import="java.sql.ResultSet"%>
<%@ page import="edu.rit.se.creativecrowd.DBProcess"%>
<%
	String mturk = request.getParameter("mturk");
	DBProcess dbProc = new DBProcess();
	int ret = dbProc.loginUser(mturk);
	try {
		if (ret == 0) {
			ret = dbProc.registerUser(mturk);
		}
		if (ret == 0) {
			//TODO add error page
			response.sendRedirect("../index.jsp");
		} else {
			ResultSet rs = dbProc.getUser(Integer.toString(ret));
			rs.next();
			session.setAttribute("userid", ret);
			session.setAttribute("state", rs.getInt("status_state"));
			if(rs.getInt("completion")==0){
				int comp = dbProc.timeOutCheck(ret);
				session.setAttribute("completion", comp);
			} else {
				session.setAttribute("completion", rs.getInt("completion_state"));
			}
			session.setAttribute("auth", true);
			dbProc.addLog(ret,"Login");
			response.sendRedirect("../dashboard.jsp");
		}
	} finally {
		dbProc.disConnect();
	}
%>