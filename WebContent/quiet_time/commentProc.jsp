<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="EUC-KR"%>
<jsp:useBean id="rMgr" class="quiet_time.Quiet_time_CommentMgr" />
<%
	request.setCharacterEncoding("UTF-8");
	int board_idx = Integer.parseInt(request.getParameter("num"));
	String nowPage = request.getParameter("nowPage");
	String keyField = "";
	String keyWord = "";
	if (!(request.getParameter("keyField") == null || request.getParameter("keyWord").equals(""))) {
		keyField = request.getParameter("keyField");
		keyWord = request.getParameter("keyWord");
	}
	rMgr.insertReply(request, board_idx);
	String url = "read.jsp?num=" + board_idx + "&nowPage=" + nowPage + "&keyField=" + keyField + "&keyWord="
			+ keyWord;
	response.sendRedirect(url);
%>