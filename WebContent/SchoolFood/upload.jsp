<%--
  Created by IntelliJ IDEA.
  User: yongho
  Date: 2019-06-10
  Time: 09:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%

    if (session.getAttribute("session_id") != null) {
        String user_id = session.getAttribute("session_id").toString();
        if (user_id.equals("wellsfarm")) {%>
<html>
<head>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <meta charset="utf-8">
    <title>KBU BOOK</title>
    <script>
        function checkForm() {
            if (upload.file.value === "") {
                alert("파일을 업로드해주세요.");
                return false;
            } else if (!checkFileType(upload.file.value)) {
                alert("엑셀파일만 업로드 해주세요.");
                return false;
            }
            document.upload.submit();
        }

        function checkFileType(filePath) {
            var fileLen = filePath.length;
            var fileFormat = filePath.substring(fileLen - 5);
            fileFormat = fileFormat.toLowerCase();

            return fileFormat === ".xlsx";
        }
    </script>
</head>
<body>
<jsp:include page="../top.jsp"/>
<div style="text-align: center">
    <br>
    <h1>
        한국성서대 식단표 업로드 페이지
    </h1>
</div>
<br><br>
<div style="margin-left: 40%">
    <form action="uploadPro.jsp" method="POST" name="upload" enctype="multipart/form-data">
        <input class="btn btn-primary btn-sm" type="file" name="file">
        <br>
        <input class="btn btn-success btn-sm" type="submit" onclick="return checkForm();" value="전송">
    </form>
</div>
<jsp:include page="../footer.jsp"/>
</body>
</html>
<%
        } else {
            out.print("<script>alert('영양사만 접근 가능합니다.'); history.back();</script>");
        }
    } else {
        out.print("<script>alert('잘못된 접근입니다.'); history.back();</script>");
    }
%>