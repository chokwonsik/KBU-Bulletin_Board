<%--
  Created by IntelliJ IDEA.
  User: HWJ
  Date: 2019-06-12
  Time: 오후 8:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<jsp:useBean id="MemberDAO" class="kbu.MemberDAO"/>
<jsp:useBean id="Member" class="kbu.Member"/>
<jsp:setProperty name="Member" property="*"/>
<% String id= request.getParameter("id");
    String email=request.getParameter("email");
    String pwd=MemberDAO.temp_pwd(email);
    Member.setId(id);
    Member.setPwd(pwd);
    MemberDAO.temp_pwdchange(Member);
%>
<script>
    alert("임시 비밀번호가 학교 이메일로 전송 되었습니다. \n 로그인후 비밀번호를 변경 하세요!");
    window.close();
</script>
<html>
<head>
    <title>temp password send</title>
</head>
<body>
<%=id%> <%=email%>
</body>
</html>
