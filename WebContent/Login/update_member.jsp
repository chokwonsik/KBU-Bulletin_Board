<%--
  Created by IntelliJ IDEA.
  User: HWJ
  Date: 2019-06-10
  Time: 오후 9:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<!--부트스트랩 css를 불러옴-->
<style>
    @import "../css/style.css";

    body {
        background-color: rgba(69, 255, 57, 0.06);
    }
</style>
<%@ page import="kbu.Member" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<jsp:useBean id="MemberDAO" class="kbu.MemberDAO"/>
<%
    SimpleDateFormat formatter = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분");
    String id = (String) session.getAttribute("session_id");
    Member mem = MemberDAO.getmember(id);
    if (id == null) {
%>
<script>
    alert("로그인을 하셔야 회원정보 수정이 가능 합니다!");
    location.href = "../index.jsp";
</script>
<%
    } else if (id != null) {

    }%>
<script>
    function check(f) {
        if (!f.pwd.value) {
            alert("변경할 비밀번호를 입력하십시오!");
            return false;
        }
        if (f.pwd.value == f.now_pwd.value) {
            alert("변경할 비밀번호가 동일합니다. \n 다른 비밀번호를 입력하세요!");
            return false;
        }

    }

    function delmember() {
        var ans = confirm("정말로 탈퇴 하시겠습니까?");
        if (ans == true) {
            location.href = "delete.jsp";
        }
        if (ans == false) {

        }
    }
</script>
<jsp:include page="../top.jsp"/>

<html>
<head>
    <title>KBUBook UserUpdate Page</title>
</head>
<body>
<div align="center">
    <form name="rejoin" method="post" action="update.jsp" onsubmit="">
        <table border="3" style="background: rgba(178,243,223,0.53)">
            <tr>
                <td align="center" colspan="2" style="width: 600px; font-size: 20px"><b>회원정보 수정</b></td>
            </tr>

            <tbody>
            <tr>
                <td align="center" style="width:auto; height: 30px">학번</td>
                <td><b>&nbsp;<%=mem.getStd_id()%>
                </b></td>
            </tr>
            <tr>
                <td align="center" style="height: 30px">회원가입 날짜</td>
                <td><b>&nbsp;<%=mem.getJoin_date()%>
                </b></td>
            </tr>
            <tr>
                <td align="center" style="height: 30px">ID</td>
                <td><b>&nbsp;<%=id%>
                </b></td>
            </tr>
            <tr>
                <td align="center" style="height: 30px">학교이메일</td>
                <td><b>&nbsp;<%=mem.getEmail()%>
                </b></td>
            </tr>
            <tr>
                <td align="center" colspan="2" style="width: auto; height: auto"><b>회원정보 수정은 비밀번호, 휴대전화번호만 가능하며, 회원탈퇴도 할
                    수 있습니다!</b></td>
            </tr>
            <tr>
                <td align="center" style="height: 30px">비밀번호</td>
                <td>&nbsp;<input type="password" name="pwd" value="<%=mem.getPwd()%>" class="text-form" size="50"
                                 required> <input type="hidden" value="<%=mem.getPwd()%>" name="now_pwd"></td>
            </tr>
            <tr>
                <td align="center" style="height: 30px">휴대전화 번호</td>
                <td>&nbsp;<input type="tel" name="tel" value="<%=mem.getTel()%>" class="text-form" maxlength="11"
                                 size="50" required></td>
            </tr>
            </tbody>
            <tr>
                <td align="center" colspan="2" style="height: 80px;"><input type="submit" name="re_join" value="정보수정"
                                                                            onclick="return check(this.form)"
                                                                            class="btn btn-primary">&nbsp;&nbsp;<input
                        type="button" name="del_member" value="회원탈퇴" onclick="delmember(this.rejoin)"
                        class="btn btn-danger"></td>
            </tr>
        </table>
    </form>
    [마지막으로 회원정보 수정한 시간: <b><%=formatter.format(session.getLastAccessedTime())%>
</b>]
</div>
<jsp:include page="../footer.jsp"/>
</body>
</html>
