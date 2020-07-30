<%--
  Created by IntelliJ IDEA.
  User: HWJ
  Date: 2019-06-04
  Time: 오전 1:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="kbu.MemberDAO" %>
<%@ page import="kbu.Student" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="../css/bootstrap.min.css"><!--부트스트랩 css를 불러옴-->
<style>
    @import "../css/style.css";
    body{background-color: rgba(243,206,90,0.53);}
</style>
<%  String std_id = request.getParameter("std_id");
    kbu.MemberDAO d = MemberDAO.getInstance();
 //   Member member = new Member();
  Student student = d.search_student(std_id);
%>
<html>
<head>
    <title>KBUBOOK JOIN</title>
</head>
<body>

<div align="center">
    <serach>학번 인증 하기</serach>
    <hr></hr>
    <span style="font-size: 19px">
    <b><%=std_id%></b>님의 학적 정보 입니다.
    <% if(student.getName() == null || student.getName() == "")
        { %>

    <p> 학적 정보가 없습니다.<br> 학번을 다시 확인해주시기 바랍니다! </p>
    <p><input type="button" value="닫기" name="exit" onclick="window.close()" class="btn btn-info"></p>
    <%
        } else{ %>

    <p>이름:<b><%=student.getName()%></b></p>
    <p>학년: <b><%=student.getGrade()%></b>학년 </p>
    <p>학과: <b><%=student.getDepartment()%>과</b> </p></span>
    <p><input type="button" value="확인" name="exit" onclick="window.close()" class="btn btn-info"></p>
<% } %>
</div>

</body>
</html>
