<%@ page contentType="text/html; charset=UTF-8" %>
<%@page import="quiet_time.Quiet_time" %>
<%@page import="java.sql.Date" %>
<jsp:useBean id="bMgr" class="quiet_time.Quiet_timeMgr"/>

<% if (session.getAttribute("session_id") != null) {%>
<%
    request.setCharacterEncoding("UTF-8");
    int num = Integer.parseInt(request.getParameter("num"));
    String nowPage = request.getParameter("nowPage");
    String keyField = request.getParameter("keyField");
    String keyWord = request.getParameter("keyWord");
    bMgr.upCount(num);//조회수 증가
    Quiet_time bean = bMgr.getBoard(num);//게시물 가져오기
    String name = bean.getMem_name();
    String title = bean.getTitle();
    Date reg_date = bean.getReg_date();
    String content = bean.getContent();
    String ip = bean.getIp();
    int count = bean.getCount();
    session.setAttribute("bean", bean);//게시물을 세션에 저장
%>
<html>
<head>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="../css/style.css">
    <title>KBU BOOK</title>
    <script type="text/javascript">
        function commentCheck() {
            var comment = document.getElementById("content");
            var name = document.getElementById("name");
            var pass = document.getElementById("pass");

            if (name.value.trim() === "") {
                alert("이름을 입력하세요")
                return false;
            }

            if (pass.value.trim() === "") {
                alert("비밀번호를 입력하세요")
                return false;
            }

            if (comment.value.trim() === "") {
                alert("댓글을 작성하세요");
                return false;
            }

            return true;
        }

        function list() {
            document.listFrm.submit();
        }
    </script>
</head>
<body>
<header class="text-center">
    <h1><img src="../img/Logo.png" width="300"></h1>
</header>
<hr style="background: #dbdab8">
<div align="center">
    <br/> <br/>
    <table style="width: 960px; cellpadding: 3;">
        <tr>
            <td style="background-color: #e9e9e9; height: 30px;" align="center">묵상지</td>
        </tr>
        <tr>
            <td colspan="2">
                <table style="cellpadding: 3; cellspacing: 0; width: 100%">
                    <tr>
                        <td align="center" bgcolor="#DDDDDD" width="10%">이 름</td>
                        <td><%=name%>
                        </td>
                        <td align="center" bgcolor="#DDDDDD" width="10%">등록날짜</td>
                        <td><%=reg_date%>
                        </td>

                    </tr>
                    <tr>
                        <td align="center" bgcolor="#DDDDDD">제 목</td>
                        <td colspan="3"><%=title%>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding: 20px; 	border-top: 2px solid #dddddd;
	border-bottom: 2px solid #dddddd;" colspan="4">
                            <%=content%>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" align="right"><br>조회수 <%=count%>

                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>

            <!-- 댓글 -->
            <td>
                <hr/>
                <form action="commentProc.jsp" method="post" onsubmit="return commentCheck();">
                    <table style="width: 960px; cellpadding: 4; align: center">
                        <tr>
                            <td width="20%">이 름</td>
                            <td width="30%"><input type="text" id="name" name="name" size="10"
                                                   maxlength="8"></td>
                            <td width="20%">비밀번호</td>
                            <td width="30%"><input type="password" id="pass" name="pass"
                                                   size="50" maxlength="30"></td>
                        </tr>
                        <tr>
                            <td width="20%">내 용</td>
                            <td colspan="3" width="50%"><textarea id="content" name="content"
                                                                  rows="3" cols="100" style="resize: none;"></textarea></td>
                            <td width="30%"><input type="submit" value="전송"></td>
                        </tr>
                    </table>
                    <input type="hidden" name="num" value="<%=num%>"> <input
                        type="hidden" name="nowPage" value="<%=nowPage%>">
                    <%
                        if (!(keyWord == null || keyWord.equals(""))) {
                    %>
                    <input type="hidden" name="keyField" value="<%=keyField%>">
                    <input type="hidden" name="keyWord" value="<%=keyWord%>">
                    <%
                        }
                    %>
                </form>
            </td>
        </tr>
        <tr>
            <td>
                <hr/>
                <jsp:include page="commentlist.jsp"/>
            </td>
        </tr>

        <!-- 댓글 -->
        <tr>
            <td align="center" colspan="2">
                <br>
                [ <a href="javascript:list()">리스트</a> | <a
                    href="update.jsp?nowPage=<%=nowPage%>&num=<%=num%>">수 정</a> | <a
                    href="delete.jsp?nowPage=<%=nowPage%>&num=<%=num%>">삭 제</a> ]<br/>
            </td>
        </tr>
    </table>
    <form name="listFrm" method="post" action="list.jsp">
        <input type="hidden" name="nowPage" value="<%=nowPage%>">
        <%
            if (!(keyWord == null || keyWord.equals(""))) {
        %>
        <input type="hidden" name="keyField" value="<%=keyField%>"> <input
            type="hidden" name="keyWord" value="<%=keyWord%>">
        <%
            }
        %>
    </form>
</div>
</body>
</html>
<%} else {
    out.print("<script>alert('로그인을 해주세요.'); location.href='../index.jsp';</script>");
}%>