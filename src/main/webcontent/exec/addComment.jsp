<%@ page import="edu.rit.se.creativecrowd.DBProcess"%>
<%
	/* String testcaseID = request.getParameter("testcaseID");
	String pid = request.getParameter("parentID");
	String uid = session.getAttribute("userid").toString();
	String gid = session.getAttribute("groupid").toString();
	String descr = request.getParameter("descr");
	String type = request.getParameter("type");
	DBProcess dbProc = new DBProcess();
	try {
		int ret = dbProc.addComment(type, pid, uid, gid, descr);
		if (ret == 1) {
			if (Integer.parseInt(testcaseID) == 0) {
				dbProc.addNotification("discussion", "0", gid, session.getAttribute("name").toString());
				response.sendRedirect("../discussions.jsp");
			} else {
				dbProc.addNotification("comment", testcaseID, gid, session.getAttribute("name").toString());
				response.sendRedirect("../viewComments.jsp?id=" + testcaseID);
			}
		} else {
			if (Integer.parseInt(testcaseID) == 0)
				response.sendRedirect("../discussions.jsp?error=2");
			else
				response.sendRedirect("../viewComments.jsp?error=2&id=" + testcaseID);
		}
	} finally {
		dbProc.disConnect();
	} */
%>