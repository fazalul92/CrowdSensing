<%@ page import="java.util.Enumeration"%>
<%@ page import="edu.rit.se.creativecrowd.DBProcess"%>
<%
  /* if(Integer.parseInt(session.getAttribute("groupid").toString())==0) {
	  String uid = session.getAttribute("userid").toString();
	  DBProcess dbProc = new DBProcess();
	  dbProc.processPersonalities(uid);
	  int ret = dbProc.assignTeam(uid);
	  response.sendRedirect("resetSession.jsp");
  }
  else {
  	response.sendRedirect("../dashboard.jsp");
  } */
%>