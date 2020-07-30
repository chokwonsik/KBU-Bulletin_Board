<%--
  Created by IntelliJ IDEA.
  User: yongho
  Date: 2019-05-31
  Time: 01:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

    <title>KBU BOOK</title>
</head>
<body>
<header class="text-center">
    <h1><img src="../img/Logo.png" width="300"></h1>
</header>
<br>
<nav class="navbar navbar-light" style="background-color: #e3f2fd;">
    <div class="container-fluid">
        <ul class="nav navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" href="../main.jsp">Home</a>
            </li>
            <li>
                <a href="../FreeTalk/freeTalk.jsp">자유수다방</a>
            </li>
            <li><a href="../quiet_time/list.jsp">묵상지</a></li>
            <%
                if (session.getAttribute("session_id").equals("wellsfarm")) {
            %>
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#">영양사 전용<span class="caret"></span></a>
                <ul class="dropdown-menu">
                    <li><a href="../SchoolFood/schoolFood.jsp">식단표</a></li>
                    <li><a href="../SchoolFood/upload.jsp">식단표 업로드</a></li>
                </ul>
            </li>
            <%} else {%>
            <li><a href="../SchoolFood/schoolFood.jsp">식단표</a></li>
            <% } %>
        </ul> <!--식단표 메뉴까지 -->
        <ul class="nav navbar-nav navbar-right">
            <li class="dropdown">
                <a class="dropdown-toggle" data-toggle="dropdown" href="#"><%= session.getAttribute("session_id")%>님
                    메뉴<span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                    <li><a href="../Login/logoutProc.jsp">로그아웃</a></li>
                    <% if (!(session.getAttribute("session_id").equals("wellsfarm") || session.getAttribute("session_id").equals("admin"))) { %>
                    <li class="divider"></li>
                    <li><a href="../Login/update_member.jsp">회원정보 수정</a></li>
                    <%}%>
                </ul>
            </li>
        </ul>
    </div>
</nav>
</body>
</html>
