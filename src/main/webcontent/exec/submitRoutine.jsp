<%@ page import="java.util.Enumeration"%>
<%@ page import="edu.rit.se.creativecrowd.DBProcess"%>
<%	
	String uid = session.getAttribute("userid").toString();
	String day = request.getParameter("day");
	Enumeration<String> en = request.getParameterNames();
	DBProcess dbProcess = new DBProcess();
	int ret = 0;
	for(int i=0;i<24;i++){
		if(request.getParameter(i+"-beginTime")=="")
			continue;
		String beginTime = request.getParameter(i+"-beginTime");
		String endTime = request.getParameter(i+"-endTime");
		String location = request.getParameter(i+"-location");
		String activity = request.getParameter(i+"-activity");
		String socialCircle = request.getParameter(i+"-socialCircle");
		String mood = request.getParameter(i+"-mood");
		String musicPlayerApp = request.getParameter(i+"-musicPlayerApp");
		String ringerManagerApp = request.getParameter(i+"-ringerManagerApp");
		ret += dbProcess.addRoutineResponse(uid, day, beginTime, endTime, location, activity, socialCircle, mood, musicPlayerApp, ringerManagerApp);
	}
    if (ret > 0) {
	    int dayCounter = (Integer) session.getAttribute("routineDay");
	    if(dayCounter<6){
	    	session.setAttribute("routineDay",dayCounter+1);
	    	dbProcess.disConnect();
	    	response.sendRedirect("../routine.jsp");
	    } else {
		    String[] StateInfo = dbProcess.updateState(uid,session.getAttribute("state").toString());
			session.setAttribute("state", StateInfo[0]);
			dbProcess.disConnect();
	        response.sendRedirect("../"+StateInfo[1]);
	    }
    } else {
    	dbProcess.disConnect();
        response.sendRedirect("../routine.jsp");
    }
%>