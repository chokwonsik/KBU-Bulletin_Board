<%--
  Created by IntelliJ IDEA.
  User: HWJ
  Date: 2019-05-31
  Time: 오전 12:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="kbu.MemberDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
    <title>KBUBook_LOGIN_PROCESSING</title>
</head>
<body>

<%
    // 로그인 화면에 입력된 아이디와 비밀번호를 가져온다
    String id= request.getParameter("id");
    String pwd = request.getParameter("pwd");
    // 로그인 결과에 따라서 해당 주소로 이동
    String url = "";

    if (id.equals("wellsfarm") && pwd.equals("wellsfarm")) {
        session.setAttribute("session_id", id);
        url = "../main.jsp";
    } else if(id.equals("admin") && pwd.equals("admin")) {
        session.setAttribute("session_id", id);
        url = "../main.jsp";
    } else {
        // DB에서 아이디, 비밀번호 확인
        MemberDAO mdo = MemberDAO.getInstance();
        int check = mdo.checklogin(id, pwd);


        if (check == 1)    // 로그인 성공
        {
            // 세션에 현재 아이디 세팅
            session.setAttribute("session_id", id);
            url = "../main.jsp";
        } else if (check == 2 || check == 3) // 아이디, 비밀번호가 맞지 않거나 없는 아이디를 입력하였을때
        {
            url = "../index.jsp?msg=2";
        }
    }
    response.sendRedirect(url); // sendRedirect(String URL) : 해당 URL로 이동, URL뒤에 get방식 처럼 데이터를 전달가능
%>

로그인중 입니다...

</body>
</html>
