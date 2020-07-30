<%--
  Created by IntelliJ IDEA.
  User: HWJ
  Date: 2019-06-09
  Time: 오전 3:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="kbu.MemberDAO" %>

<% String email=null;
String email1=request.getParameter("email");
    email=email1; //인증번호 이메일 전송
    MemberDAO.Email mail = new MemberDAO.Email();
    String Num=mail.connectEmail(email);
    %>
<html>
<link rel="stylesheet" href="../css/bootstrap.min.css"><!--부트스트랩 css를 불러옴-->
<style>
    @import "../css/style.css";
    body{background-color: rgba(243,170,127,0.53);}
</style>

<head>
    <title>KBUBook Email Check</title>
</head>
<body onload="document.email_check.emailbox.focus();">
<form method="post" name="email_check">
    <div align="center">
        <serach>학교 이메일 인증</serach>
        <hr></hr>
    <p> <input type="text" name="emailbox" placeholder="인증번호를 입력하십시오!" class="text-form" size="10" maxlength="6" > <input type="button" value="인증" onclick="check_e(this.form, <%=Num%>)" class="btn btn-success"> </p>
        <p><b><%=email1%> 로 인증번호가 </b> 전송되었습니다. 정확히 입력해주세요 ^.^</p>
    </div>
</form>

<script>
function check_e(f, Num) {

    if(! f.emailbox.value){
        alert("인증번호를 입력하십시오!!");
        return false;
    }
   else if(f.emailbox.value != Num){
        alert("인증번호가 틀립니다. 다시 입력하세요!");
        return false;
    }
   else if(f.emailbox.value == Num){
       alert("이메일 인증이 되었습니다!");
       opener.document.form.emailcheck.value="email_c"; //이메일 인증 확인 결과 전달.
       self.close();
    }
}

</script>
</body>
</html>
