<%--
  Created by IntelliJ IDEA.
  User: yongho
  Date: 2019-06-07
  Time: 00:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="freetalk.FreeTalkDAO" %>
<%request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="freetalk" class="freetalk.FreeTalkComment" scope="page">
    <jsp:setProperty name="freetalk" property="writer" param="writer"/>
    <jsp:setProperty name="freetalk" property="content" param="comment"/>
    <jsp:setProperty name="freetalk" property="ip" param="ip"/>
</jsp:useBean>
<%
    int id = Integer.parseInt(request.getParameter("l_id"));  // 글 번호

    FreeTalkDAO freeTalkDAO = new FreeTalkDAO();
    freeTalkDAO.writeComment(id, freetalk.getWriter(), freetalk.getContent().replace("/r/n", "<br>"), freetalk.getIp());

    response.sendRedirect("view.jsp?id="+id);
%>