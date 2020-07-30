<%--
  Created by IntelliJ IDEA.
  User: yongho
  Date: 2019-05-25
  Time: 22:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="freetalk.FreeTalk" %>
<%@ page import="freetalk.FreeTalkComment" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="ftDAO" class="freetalk.FreeTalkDAO"/>


<%
    if (session.getAttribute("session_id") != null) {
%>

<%
    int num = Integer.parseInt(request.getParameter("id"));  // 글 번호 가져오기
    String userId = session.getAttribute("session_id").toString(); // 현재 로그인한 사용자의 아이디 저장

    ftDAO.upCount(num);   // 조회수 증가

    FreeTalk freeTalk = ftDAO.getContent(num);

    session.setAttribute("freeTalk", freeTalk);

    Vector<FreeTalkComment> list = null;
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/style.css">
    <title>KBU BOOK</title>
    <script>
        function commentCheck() {
            var comment = document.getElementById("comment");

            if (comment.value.trim() === "") {
                alert("댓글을 작성하세요");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<header class="text-center">
    <h1><img src="../img/Logo.png" width="300"></h1>
</header>
<hr style="background: #dbdab8">
<h3 class="text-center">게시글</h3><br>
<div class="container" style="margin-bottom: 30px">
    <!-- 게시판 글 내용 시작 -->
    <table class="view-table view-table-bordered">
        <thead class="view-table view-table-bordered">
        <tr>
            <th colspan="2">&nbsp;&nbsp;<%=freeTalk.getTitle()%>
            </th>
        </tr>
        </thead>
        <tbody class="view-table view-table-bordered">
        <tr>
            <td colspan="2" style="padding-left: 10px">
                작성자 : <%=freeTalk.getWriter()%>&nbsp;&nbsp;&nbsp;&nbsp;
                작성일 : <%=freeTalk.getDate()%>&nbsp;&nbsp;&nbsp;&nbsp;
                조회수 : <%=freeTalk.getCount()%>&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
        </tr>
        </tbody>
        <tfoot class="view-table view-table-bordered">
        <tr>
            <td style="padding: 10px;"><%=freeTalk.getContent().replace("\r\n", "<br>")%>
            </td>
        </tr>
        </tfoot>
    </table>
    <!-- 게시판 글 내용 끝 -->
    <%
        list = ftDAO.getCommentList(num);  // DB 에서 글 목록을 받아서 리스트에 저장
        if (!list.isEmpty()) {   // 리스트가 비어 있을
    %>
    <!-- 게시판 댓글 시작 -->
    <form method="post" action="deleteComment.jsp">
        <div class="comment-box">
            <ul style="list-style: none; padding-top: 10px">
                <%for (FreeTalkComment ftk : list) {%>
                <li class="comment-wrap">
                    <div>
                        <div class="cmt-writer-box"><%=ftk.getWriter()%>
                        </div>
                        <div class="cmt-content-box"><%=ftk.getContent().replace("\r\n", "<br>")%>
                        </div>
                        <div class="pull-right">
                            <div class="pull-left"><%=ftk.getDate()%>
                            </div>
                            <% if (ftk.getWriter().equals(userId) || userId.equals("admin")) {%>
                            <div class="pull-right">&nbsp;<input class="delete-bt" type="submit" value="X">
                                <input type="hidden" name="c_id" value="<%=ftk.getCid()%>">
                            </div>
                            <%} else {%>
                            <div class="pull-right">&nbsp;<input class="hidden-bt" type="button" value="X"
                                                                 style="cursor: default;"></div>
                            <%}%>
                        </div>
                    </div>
                </li>
                <%}%>
            </ul>
        </div>
        <%}%>
        <input type="hidden" name="l_id" value="<%=num%>">
    </form>
    <!-- 게시판 댓글 끝 -->
    <br>
    <!-- 댓글 작성 시작 -->
    <form method="post" action="viewAction.jsp" onsubmit="return commentCheck();">
        <div class="comment-form">
            <div class="user-info-form" id="wrapper">
                <div id="cell">
                    <%=userId%>
                </div>
            </div>
            <br>
            <textarea id="comment" name="comment" style="resize: none; width: 100%; height: 100px; padding: 13px;"
                      placeholder="댓글을 입력하세요."></textarea>
            <br>
            <br>
            <input type="submit" class="btn btn-success pull-right" value="댓글작성">
            <input type="hidden" name="l_id" value="<%=num%>">
            <input type="hidden" name="writer" value=<%=session.getAttribute("session_id")%>>
            <input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
        </div>
    </form>
    <!-- 댓글 작성 끝 -->
    <br>
    <div class="pull-right">
        <a href="freeTalk.jsp" class="btn btn-success">글목록</a>
        <% if (freeTalk.getWriter().equals(userId)) {%>
        <a href="update.jsp?id=<%=num%>" class="btn btn-primary">글수정</a>
        <%}%>
        <% if (freeTalk.getWriter().equals(userId) || userId.equals("admin")) { // 작성자와 로그인 한사람이 같을 경우 글수정, 글삭제 버튼 보이게 하기 %>
        <a href="delete.jsp?id=<%=num%>" class="btn btn-danger" onclick="return confirm('글을 삭제하시겠습니까?')">글삭제</a>
        <%}%>
    </div>
</div>
</body>
</html>
<%
    } else {
        out.print("<script>alert('로그인을 해주세요.'); location.href='../index.jsp';</script>");
    }
%>