<%--
  Created by IntelliJ IDEA.
  User: yongho
  Date: 2019-05-30
  Time: 23:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="freetalk.FreeTalkDAO" %>

<%
    FreeTalkDAO freeTalkDAO = new FreeTalkDAO();

    int pageNum = Integer.parseInt(request.getParameter("id"));

    freeTalkDAO.delete(pageNum);
    response.sendRedirect("freeTalk.jsp");
%>