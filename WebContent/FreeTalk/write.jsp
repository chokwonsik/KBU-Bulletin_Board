<%--
  Created by IntelliJ IDEA.
  User: yongho
  Date: 2019-05-24
  Time: 00:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <title>KBU BOOK</title>
    <script>
        function writeCheck() {
            var title = document.getElementById("title");
            var content = document.getElementById("content");

            if (title.value.trim() === "") {
                alert("글제목을 작성하세요");
                return false;
            }
            if (content.value.trim() === "") {
                alert("내용을 작성하세요");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<h1 class="text-center">KBU BOOK</h1>
<hr>
<h3 class="text-center">글쓰기</h3><br>
<div class="container">
    <form method="post" action="writeAction.jsp" onsubmit="return writeCheck();">
        <table class="table table-striped" style="text-align: center; border: 1px #dddddd;">
            <tbody>
            <tr>
                <td><input id="title" name="title" class="form-control" type="text" placeholder="제목을 입력하세요" maxlength="50"></td>
            </tr>
            <tr>
                <td><textarea id="content" name="content" class="form-control" placeholder="내용을 입력하세요"
                              style="resize: none; height: 600px" maxlength="2048"></textarea></td>
            </tr>
            </tbody>
        </table>
        <input type="hidden" name="writer" value=<%=session.getAttribute("session_id")%>>
        <input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
        <input type="submit" class="btn btn-success pull-right" value="글쓰기">
    </form>
</div>
</body>
</html>