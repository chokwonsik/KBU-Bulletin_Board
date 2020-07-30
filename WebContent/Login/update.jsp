<%--
  Created by IntelliJ IDEA.
  User: HWJ
  Date: 2019-06-11
  Time: 오전 12:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="MemberDAO" class="kbu.MemberDAO"/>
<jsp:useBean id="Member" class="kbu.Member"/>
<jsp:setProperty name="Member" property="*"/>
<%
    String id = (String)session.getAttribute("session_id");
    Member.setId(id);


    boolean result = MemberDAO.update_member(Member);
    String msg = "회원정보 업데이트 실패!";
    String url = "update_member.jsp";
    if(result==false) {
        msg = "회원정보 업데이트 성공!";
        url ="../index.jsp";
    }

%>
<script>
    alert("<%=msg%>");
    location.href ="<%=url%>"
</script>

<html>
<head>
    <title>Title</title>
</head>
<body>
회원정보 변경중
</body>
</html>
