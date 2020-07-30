<%@ page import="freetalk.FreeTalk" %><%--
  Created by IntelliJ IDEA.
  User: yongho
  Date: 2019-05-31
  Time: 03:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));
    String nowPage = request.getParameter("nowPage");
    FreeTalk freeTalk = (FreeTalk) session.getAttribute("freeTalk");
    String title = freeTalk.getTitle();
    String content = freeTalk.getContent();
%>
<html>
<head>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <title>KBU BOOK</title>
    <script>
        function writeCheck() {
            var title = document.getElementById("title");
            var content = document.getElementById("content");
            console.log(title.value);

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
    <form method="post" action="updateAction.jsp?id=<%=id%>" onsubmit="return writeCheck();">
        <table class="table table-striped" style="text-align: center; border: 1px #dddddd;">
            <tbody>
            <tr>
                <td><input id="title" name="title" class="form-control" type="text" value="<%=title%>"
                           maxlength="50"></td>
            </tr>
            <tr>
                <td><textarea id="content" name="content" class="form-control"
                              style="resize: none; height: 600px"><%=content%></textarea></td>
            </tr>
            </tbody>
        </table>
        <input type="hidden" name="writer" value="<%=session.getAttribute("session_id")%>">
        <input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
        <div class="pull-right">
            <input type="button" class="btn btn-info" value="뒤로가기" onclick="history.go(-1)">
            <input type="submit" class="btn btn-success" value="글수정" onclick="return confirm('글을 수정하시겠습니까?')">
        </div>
    </form>
</div>
</body>
</html>

