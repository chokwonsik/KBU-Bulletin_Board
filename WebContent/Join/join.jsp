<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>

<!doctype html>
<link rel="stylesheet" href="../css/bootstrap.min.css"><!--부트스트랩 css를 불러옴-->
<style>
@import "../css/style.css";

body{
background-color: rgba(69, 255, 57, 0.06);
background-position: center;
background-repeat: no-repeat;
background-size: auto;
}
</style>

<script>
 function getTypeCheck(s, spc) {
        var i;
        
        for (i = 0; i < s.length; i++) {
            if (spc.indexOf(s.substring(i, i + 1)) < 0) {
                return false;
            }
        }
        
        return true;
    }
    
    function check_Num(obj,n) {  //학번 입력 조건
        var re = /[^0-9]/gi;
        var NUM = "0123456789";
        var str_space = /\s/;
     
        if(n == undefined || n == null) {
            var n = "";
            var n2 = "";
        } 
        else {
            if(n == "") {
                var n = "";
                var n2 = "";
            } 
            else {
                var n = eval(n);
                var n2 = n;
            }
        }
     
        if(!getTypeCheck(obj.value, NUM)) {
            alert("학번은 숫자만 입력 가능 합니다!");
            
            obj.value = obj.value.replace(re,"");
            obj.value = n2;
            
            obj.focus();
            
            return false;
        }
    }
    function check_id(inputid) { //id중복 확인
    if(inputid.id.value ==""){
        alert("아이디를 입력하세요! (error:1)");
        return false;
    }
     else if((inputid.id.value < "0" || inputid.id.value > "9") && (inputid.id.value < "A" || inputid.id.value > "Z") && (inputid.id.value < "a" || inputid.id.value > "z")){
        alert("아이디는 한글 및 특수문자는 사용할 수 없습니다!\n 다시 확인후 입력을 해주시기 바랍니다!!");
         return false;
        }
    url="id_check.jsp?id="+inputid.id.value; //url+사용자 입력 id값 조회
    window.open(url, "id_check","toolbar=no, location=center, statusbar=no, resizable=no, width=500, height=300");  //팝업창을 통해 중복 아이디를 확인 가능!
    }

    function inputid_check() { // 아이디 입력창에 값 입력시 hidden에 idUncheck를 저장한다. 이렇게 하는 이유는 중복체크 후 다시 아이디 창이 새로운 아이디를 입력했을 때 다시 중복체크를 하기 위해서이다.
        document.form.idcheck.value="idUncheck";
    }
    function check_tel(inputtel) {
    if((inputtel.phone_num.value < "0" || inputtel.phone_num.value > "9") && (inputtel.phone_num.value == "+")){
        alert("전화번호는 숫자, +(국가번호) 이외 입력할 수 없습니다.");
        return false;
    }

}
 function studentid_checek(instdid) {
     if(instdid.std_id.value ==""){
         alert("학번을 입력하세요!");
         return false;
     }
     url="stdid_check.jsp?std_id="+instdid.std_id.value; //url+사용자 입력 id값 조회
     window.open(url, "stdid_check","toolbar=no, location=center, statusbar=no, resizable=no, width=500, height=300");
 }
 function email_c(email1, email2) {

     if(! email1.email.value){
         alert("이메일을 입력하세요!!");
         form.email.focus();
         return false;
     }
     var form = document.form;
     email1=form.email.value;
     email2=form.email2.value;
     url="email_check.jsp?email="+email1+"@"+email2;
     window.open(url, "email_check", "statusbar=no, toolbar=no, location=center, resizable=no, width=650, height=270");
 }

 function emailcheck() {
     document.form.emailcheck.value="emUncheck"
 }
 function check_join() {
     var form = document.form;
     if(form.idcheck.value != "check_id"){
         alert("아이디 중복 확인을 하셔야 회원가입 할 수 있습니다.");
         return false;
     }
    else if(form.emailcheck.value != "email_c"){
         alert("이메일 인증을 하셔야 회원가입을 할 수 있습니다!");
         return false;
     }

 }

</script>

<head> <title>KBUBook join</title> </head>
<body onload="document.form.std_id.focus();"> <!--페이지가 로딩되면 바로 학번 입력이 가능한 상태가 됨-->
<div id="main">
<form action ="/Join/Signup_Join.jsp" name="form" method="post" onsubmit="return check_join()" onreset="">

    <p align="center"><img src="../img/Join.png" style="width: 800px;"/></p>
	<hr class="hr"></hr>

 <fieldset><p align="center">학번: <input type="text" placeholder="학번 입력후 확인 해주세요!" minlength="9" maxlength="9" onKeyUp="check_Num(this, '');" onChange="check_Num(this, '');" class="text-form" name="std_id" value="" required> <input type="button" value="학번확인" class="btn btn-info" onclick="studentid_checek(this.form)" > </p></fieldset>
    <!--name="" 값만 DB에서 읽을수 있도록 설정 -->

<p align="center">아이디: <input type="text" size="50" value="" placeholder="아이디 입력후 중복확인 해주세요!" name="id" class="text-form" onkeydown="inputid_check()" required> <input type="button"  class="btn btn-info" value="중복확인" onclick="check_id(this.form)"> <input type="hidden" name="idcheck" value="idUncheck"></p>
<p align="center">비밀번호: <input type="password" size="50" value="" minlength="4" placeholder="사용할 비밀번호를 정확히 입력하시오." name="pwd" class="text-form" onkeyup="check_pwd(this)" onchange="check_pwd(this)" required></p>
<p align="center">학교이메일: <input type="text" name="email" class="text-form" required>@<select name="email2"> <option value="bible.ac.kr" selected>bible.ac.kr</option><option value="stu.bible.ac.kr">stu.bible.ac.kr</option></select> <input type="button" name="email_check" class="btn btn-primary" value="인증하기" onclick="email_c(this.form)">
    <input type="hidden" name="emailcheck" value="emUncheck"> </p>
<p align="center">휴대전화번호: <input type="tel" name="phone_num" class="text-form" onchange="check_tel(this.form)" maxlength="11" required> </p>
<p align="center"><input type="button" class="btn btn-success" value="Home" onClick="location.href='../index.jsp'"> <input type="reset" value="다시 쓰기" class="btn btn-success"> <input type="submit" value="회원가입" class="btn btn-success" > </p>

<jsp:include page="../footer.jsp"/>
</form>
</div>
</body>
</html>