<%--
  Created by IntelliJ IDEA.
  User: yongho
  Date: 2019-06-03
  Time: 20:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="schoolfood.Daily" %>
<%@ page import="schoolfood.Dinner" %>
<%@ page import="schoolfood.Fix" %>
<%@ page import="schoolfood.Lunch" %>
<%@ page import="java.util.Vector" %>

<%
    if (session.getAttribute("session_id") != null) {
%>

<jsp:useBean id="foodDAO" class="schoolfood.SchoolFoodDAO"/>
<%
    Vector<Lunch> lunchList = foodDAO.getLunch();
    Vector<Dinner> dinnerList = foodDAO.getDinner();
    Vector<Fix> fixList = foodDAO.getFix();
    Vector<Daily> dailyList = foodDAO.getDaily();
%>
<jsp:include page="../top.jsp"/>

<html>
<head>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/table.css">

    <title>KBU BOOK</title>
</head>
<body>
<% if (lunchList.isEmpty()) { // 디비에 없는 데이터를 불러오려 할 때 예외처리 %>
<h1 class="text-center">아직 학식메뉴가 업데이트 되지 않았습니다.</h1>
<%} else {%>
<h1 class="text-center">이번주 학식</h1>
<br>
<div style="margin: 0 50px 0 50px">
    <table class="schoolfood">
        <thead>
        <tr>
            <th style="background-color: white;"></th>
            <% for (Lunch lunch : lunchList) { %>
            <td>
                <%=lunch.getDate()%><br>
                <%=lunch.getDay()%>
            </td>
            <%}%>
        </tr>
        </thead>
        <tbody>
        <tr>
            <th>중식</th>
            <% for (Lunch lunch : lunchList) { %>
            <td>
                <%for (String food : lunch.getFood()) {%>
                <%=food%><br>
                <%}%>
            </td>
            <%}%>
        </tr>
        <tr>
            <th>석식</th>
            <% for (Dinner dinner : dinnerList) { %>
            <td>
                <%for (String food : dinner.getFood()) {%>
                <%=food%><br>
                <%}%>
            </td>
            <%}%>
        </tr>
        <tr>
            <th>고정메뉴</th>
            <% for (Fix fix : fixList) { %>
            <td>
                <%for (String food : fix.getFood()) {%>
                <%=food%><br>
                <%}%>
            </td>
            <%}%>
        </tr>
        <tr>
            <th>데일리메뉴</th>
            <% for (Daily daily : dailyList) { %>
            <td>
                <%=daily.getFood()%><br>
            </td>
            <%}%>
        </tr>
        </tbody>
    </table>
</div>
<%}%>
<br>
<jsp:include page="../footer.jsp"/>
</body>
</html>
<%
    } else {
        out.print("<script>alert('로그인을 해주세요.'); location.href='../index.jsp';</script>");
    }
%>