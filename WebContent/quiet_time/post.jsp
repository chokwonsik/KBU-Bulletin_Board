<%@ page contentType="text/html; charset=UTF-8" %>

<% if (session.getAttribute("session_id") != null) {%>
<html>
<head>
    <title>묵상지 작성</title>
    <link href="../css/style.css" rel="stylesheet" type="text/css">
    <script>
        function postCheck() {
            var mem_name = document.getElementById("mem_name");
            var title = document.getElementById("title");
            var content = document.getElementById("content");
            var pass = document.getElementById("pass");

            if (mem_name.value.trim() === "") {
                alert("이름을 입력하세요");
                return false;
            }
            if (title.value.trim() === "") {
                alert("제목을 입력하세요");
                return false;
            }
            if (content.value.trim() === "") {
                alert("내용을 입력하세요");
                return false;
            }
            if (pass.value.trim() === "") {
                alert("비밀번호를 입력하세요");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<div align="center">
    <br/>
    <br/>
    <table style="width: 960; cellpadding: 3;">
        <tr>
            <td bgcolor="e9e9e9" height="25" align="center">묵상지 작성</td>
        </tr>
    </table>
    <br/>
    <form name="postFrm" method="post" action="../quiet_time/postProc.jsp" onsubmit="return postCheck();">
        <table style="width: 960; cellpadding: 3; align: center">
            <tr>
                <td align=center>
                    <table style="width: 960; cellpadding: 3; align: center">
                        <tr>
                            <td width="10%">성 명</td>
                            <td width="90%"><input id="mem_name" name="mem_name" size="10"
                                                   maxlength="8"></td>
                        </tr>
                        <tr>
                            <td>제 목</td>
                            <td><input id="title" name="title" size="50" maxlength="30"></td>
                        </tr>
                        <tr>
                            <td>내 용</td>
                            <td><textarea id="content" name="content" rows="10" cols="50"></textarea></td>
                        </tr>
                        <tr>
                            <td>비밀 번호</td>
                            <td><input type="password" id="pass" name="pass" size="15"
                                       maxlength="15"></td>
                        </tr>

                        <tr>
                            <td colspan="2"><input type="submit" value="등록"> <input
                                    type="reset" value="다시쓰기"> <input type="button"
                                                                      value="리스트"
                                                                      onClick="javascript:location.href='../quiet_time/list.jsp'">
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
    </form>
</div>
</body>
</html>

<%} else {
    out.print("<script>alert('로그인을 해주세요.'); location.href='../index.jsp';</script>");
}%>