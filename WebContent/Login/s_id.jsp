<%--
  Created by IntelliJ IDEA.
  User: HWJ
  Date: 2019-06-01
  Time: 오전 5:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=EUC-KR" pageEncoding="EUC-KR" language="java" %>
<html>
<link rel="stylesheet" href="../css/bootstrap.min.css"><!--부트스트랩 css를 불러옴-->
<style>
    @import "../css/style.css";
    body{background-color: rgba(243,206,90,0.53);}
</style>
<head>
    <title>KBUBOOK SEARCH ID</title>
</head>

<body>
<form name="search_id" method="post" action="id.jsp">
<div align="center">
    <serach>아이디 & 비밀번호 찾기</serach>
	<hr></hr>
	<p><input type="text" class="text-form" placeholder="학번 입력해라!" name="std_id" align="center" required> </p>
	<p><input type="text" class="text-form" placeholder="학교 이메일 입력해라!" name="email" align="center" required> </p>
	<p><input type="submit" value="아이디 찾기" name="search" class="btn btn-info"> <input type="button" value="닫기" name="exit" onclick="window.close()" class="btn btn-info"></p>
	
</div>
</form>
</body>
</html>
