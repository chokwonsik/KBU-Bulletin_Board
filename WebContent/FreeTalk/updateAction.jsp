<%--
  Created by IntelliJ IDEA.
  User: yongho
  Date: 2019-05-31
  Time: 03:44
  To change this template use File | Settings | File Templates.
--%>
%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="freetalk.FreeTalk" %>
<%request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="ftDAO" class="freetalk.FreeTalkDAO"/>

<%
    FreeTalk freeTalk = new FreeTalk();

    int id = Integer.parseInt(request.getParameter("id"));
    String url = "view.jsp?id=" + id;
    freeTalk.setId(id);
    freeTalk.setTitle(request.getParameter("title"));
    freeTalk.setWriter(request.getParameter("writer"));
    freeTalk.setContent(request.getParameter("content"));
    freeTalk.setIp(request.getParameter("ip"));

    ftDAO.update(freeTalk);

    response.sendRedirect(url);
%>