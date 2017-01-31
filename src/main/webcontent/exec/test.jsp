<%@ page import ="edu.rit.se.creativecrowd.DBProcess" %>
<%@ page import ="edu.rit.se.creativecrowd.GroupPersonalities" %>
<%
	/* DBProcess dbProc = new DBProcess();
	dbProc.processPersonalities(session.getAttribute("userid").toString());
	dbProc.disConnect();*/
	GroupPersonalities grp = new GroupPersonalities();
	grp.groupData();
%>