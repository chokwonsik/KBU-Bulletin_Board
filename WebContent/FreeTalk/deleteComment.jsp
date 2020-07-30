<%@ page import="freetalk.FreeTalkDAO" %><%--
  Created by IntelliJ IDEA.
  User: yongho
  Date: 2019-06-08
  Time: 14:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    FreeTalkDAO freeTalkDAO = new FreeTalkDAO();

    int viewNum = Integer.parseInt(request.getParameter("l_id"));
    int commentNum = Integer.parseInt(request.getParameter("c_id"));

    freeTalkDAO.deleteComment(commentNum);
    response.sendRedirect("view.jsp?id="+viewNum);
%>