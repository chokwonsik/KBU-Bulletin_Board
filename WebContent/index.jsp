<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<% request.setCharacterEncoding("UTF-8");
	String id= (String)session.getAttribute("session_id");
	String msg=request.getParameter("msg");
	if(msg!= null && msg.equals("2")){
		out.println("<script>alert('아이디 또는 비밀번호를 확인 하십시오!');</script>");

	}
%>

<!DOCTYPE html>
<style>
@import "css/style.css";
</style>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>KBUBook</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/signin.css">
</head>
<body onload="document.Login.id.focus();">
	<header class="text-center">
		<h1><img src="img/Logo.png" style="width: 650px;"/></h1>
	</header>
	<br>
	<div class="container">
		<form class="form-signin" method="post" name="Login" action="Login/Loginpro.jsp">
			<input class="form-control" type="text" placeholder="아이디를 입력하세요!" name="id" required><br>
			<input class="form-control" type="password" placeholder="비밀번호를 입력하세요!" name="pwd" required><br>
			<input class="btn btn-lg btn-primary btn-block" type="submit" value="로그인">
		<br><a href="Join/join.jsp"><p align="center">회원가입<a href='Login/s_id.jsp' onclick="window.open(this.href,'ID찾기','toolbar=no, location=center, status=no, resizable=no, width=800, height=200'); return false;"> 아이디&비밀번호 찾기 </a></p><br>
		</a>
		</form>
	</div>
	<br>
	<div class="text-center">
	</div>
	<jsp:include page="footer.jsp"/>
</body>
</html>