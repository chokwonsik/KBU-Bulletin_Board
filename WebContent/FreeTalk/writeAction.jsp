<%--
  Created by IntelliJ IDEA.
  User: yongho
  Date: 2019-05-24
  Time: 01:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="freetalk.FreeTalkDAO" %>
<%request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="freetalk" class="freetalk.FreeTalk" scope="page">
    <jsp:setProperty name="freetalk" property="writer" param="writer"/>
    <jsp:setProperty name="freetalk" property="title" param="title"/>
    <jsp:setProperty name="freetalk" property="content" param="content"/>
    <jsp:setProperty name="freetalk" property="ip" param="ip"/>
</jsp:useBean>
<%
    FreeTalkDAO freeTalkDAO = new FreeTalkDAO();
    freeTalkDAO.write(freetalk.getTitle(), freetalk.getWriter(), freetalk.getContent(), freetalk.getIp());
    response.sendRedirect("freeTalk.jsp");
%>
