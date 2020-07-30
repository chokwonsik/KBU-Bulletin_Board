<%--
  Created by IntelliJ IDEA.
  User: HWJ
  Date: 2019-06-11
  Time: 오전 3:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="MemberDAO" class="kbu.MemberDAO"/>
<jsp:useBean id="Member" class="kbu.Member"/>
<%
    String id = (String)session.getAttribute("session_id");
    boolean result = MemberDAO.delete_member(id);
    String msg ="회원탈퇴를 하지 못하였습니다!";
    String url = "update_member.jsp";
    if(result==true) {
        session.invalidate();
        msg = "회원탈퇴가 되었습니다.";
        url ="../index.jsp";
    }
%>
<script>
    alert("<%=msg%>");
    location.href ="<%=url%>"
</script>
<html>
<head>
    <title>KBUBOOK User Delete</title>
</head>
<body>

</body>
</html>
