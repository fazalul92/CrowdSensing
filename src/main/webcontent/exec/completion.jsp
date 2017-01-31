<%@ page import="java.util.Enumeration"%>
<%@ page import="edu.rit.se.creativecrowd.DBProcess"%>
<%
	String uid = session.getAttribute("userid").toString();
	DBProcess dbProc = new DBProcess();
	int ret = 0;
	try {
		dbProc.updateCompletionState(uid);
		session.setAttribute("completion", 2);
		String[] StateInfo = dbProc.updateState(uid, session.getAttribute("state").toString());
		session.setAttribute("state", StateInfo[0]);
		response.sendRedirect("../" + StateInfo[1]);
	} finally {
		dbProc.disConnect();
	}
%>