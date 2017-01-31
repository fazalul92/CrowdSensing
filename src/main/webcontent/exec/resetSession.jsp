<%@ page import="java.sql.ResultSet"%>
<%@ page import="edu.rit.se.creativecrowd.DBProcess"%>
<%
	String uid = session.getAttribute("userid").toString();
	DBProcess dbProc = new DBProcess();
	ResultSet rs = dbProc.getUser(uid);
	if (rs.next()) {
		session.setAttribute("userid", rs.getString("id"));
		session.setAttribute("groupid", rs.getString("gid"));
		session.setAttribute("group_type", rs.getInt("group_type"));
		session.setAttribute("name", rs.getString("name"));
		session.setAttribute("auth", true);
		String[] StateInfo = dbProc.updateState(uid, session.getAttribute("state").toString());
		session.setAttribute("state", StateInfo[0]);
		dbProc.disConnect();
		response.sendRedirect("../" + StateInfo[1]);
	} else {
		dbProc.disConnect();
		response.sendRedirect("../index.jsp");
	}
%>