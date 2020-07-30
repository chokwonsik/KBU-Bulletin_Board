<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.Vector"%>
<%@page import="quiet_time.Quiet_time_Comment"%>
<%@ page import="java.util.Date" %>
<jsp:useBean id="rMgr" class="quiet_time.Quiet_time_CommentMgr" />

<% if (session.getAttribute("session_id") != null ) {%>
<%
	request.setCharacterEncoding("UTF-8");
	int board_idx = Integer.parseInt(request.getParameter("num"));
	int nowPage = Integer.parseInt(request.getParameter("nowPage"));
	Vector<Quiet_time_Comment> vlist = null;
%>
<html>
<head>
<title>JSP Board</title>
</head>
<body>
	<div align="center">
		<table style="width: 960; cellpadding: 3; align: center;">
			<tr>
				<td align="center" colspan="2">
					<%
						vlist = rMgr.getReplyList(board_idx);
						if (vlist.isEmpty()) {
							out.println("댓글이 없습니다.");
						} else {
					%>
					<table border=1
						style="width: 100%; cellpadding: 2; cellspacing: 0; align: center; border-collapse: collapse">
						<tr align="center" bgcolor="#e9e9e9" height="120%">
							<td width="5%">번 호</td>
							<td width="60%">내용</td>
							<td width="15%">이 름</td>
							<td width="17%">날 짜</td>
							<td width="3%">삭제</td>
						</tr>
						<%
							for (int i = 0; i < vlist.size(); i++) {
									Quiet_time_Comment bean = vlist.get(i);
									int reply_idx = bean.getIdx();
									String name = bean.getName();
									String content = bean.getContent();
									Date regdate = bean.getReg_date();
						%>
						<tr>
							<td align="center"><%=i + 1%></td>
							<td><pre><%=content%></pre></td>
							<td align="center"><%=name%></td>
							<td align="center"><%=regdate%></td>
							<td align="center"><a
								href="../quiet_time/delete_comment.jsp?nowPage=<%=nowPage%>&num=<%=board_idx%>&idx=<%=reply_idx%>">x</a>
						</tr>
						<%
} //for
%>
					</table> <%
} //if
%>
				</td>
			</tr>
		</table>
	</div>
</body>
</html>

<%} else {
	out.print("<script>alert('로그인을 해주세요.'); location.href='../index.jsp';</script>");
}%>