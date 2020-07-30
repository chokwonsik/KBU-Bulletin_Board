<%--
  Created by IntelliJ IDEA.
  User: yongho
  Date: 2019-06-01
  Time: 14:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%
    session.invalidate(); // 세션 무효
    out.print("<script>alert('로그아웃 되었습니다.'); location.href='../index.jsp';</script>"); // alert 출력
%>
