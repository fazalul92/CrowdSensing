<%@ page import="java.sql.ResultSet"%>
<%@ page import="edu.rit.se.creativecrowd.DBProcess"%>
<%
	String mturk = request.getParameter("mturk");
	DBProcess dbProc = new DBProcess();
	try {
		int ret = dbProc.loginUser(mturk);
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
			session.setAttribute("name", ret);
			session.setAttribute("state", rs.getInt("state"));
			session.setAttribute("completion", rs.getInt("completion"));
			session.setAttribute("auth", true);
			session.setAttribute("routineDay",dbProc.getUserTaskDay(Integer.toString(ret)));
			dbProc.addLog(ret,"Login");
			response.sendRedirect("../dashboard.jsp");
		}
	} finally {
		dbProc.disConnect();
	}
%>