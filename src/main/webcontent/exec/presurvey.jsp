<%@ page import="java.util.Enumeration"%>
<%@ page import="edu.rit.se.creativecrowd.DBProcess"%>
<%
	String uid = session.getAttribute("userid").toString();
	Enumeration<String> en = request.getParameterNames();
	DBProcess dbProc = new DBProcess();
	int ret = 0;
	try {
		while (en.hasMoreElements()) {
			String parameterName = (String) en.nextElement();
			String parameterValue = request.getParameter(parameterName);
			ret += dbProc.responseData("presurvey_responses", uid, parameterName, parameterValue);
		}
		if (ret > 0) {
			String[] StateInfo = dbProc.updateState(uid, session.getAttribute("state").toString());
			session.setAttribute("state", StateInfo[0]);
			response.sendRedirect("../" + StateInfo[1]);
		} else {
			response.sendRedirect("../presurvey.jsp");
		}
	} finally {
		dbProc.disConnect();
	}
%>