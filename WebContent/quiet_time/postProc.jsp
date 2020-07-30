<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="EUC-KR"%>
<jsp:useBean id="bMgr" class="quiet_time.Quiet_timeMgr" />
<%
request.setCharacterEncoding("UTF-8");
bMgr.insertBoard(request);
response.sendRedirect("../quiet_time/list.jsp");
%>