<%--
  Created by IntelliJ IDEA.
  User: yongho
  Date: 2019-05-23
  Time: 21:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="freetalk.FreeTalk" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.util.Vector" %>

<jsp:useBean id="freetalk" class="freetalk.FreeTalkDAO"/>

<%
    if (session.getAttribute("session_id") != null) {
%>

<%
    request.setCharacterEncoding("utf-8");

    int totalRecord = 0; // 전체레코드 수
    int numPerPage = 10; // 페이지당 레코드 수
    int pagePerBlock = 15; // 블럭당 페이지 수

    int totalPage = 0; // 전체 페이지 수
    int totalBlock = 0; // 전체 블럭 수

    int nowPage = 1; // 현재 페이지
    int nowBlock = 1; // 햔재 블럭

    int start = 0; // DB의 select 시작번호
    int end = 0; // 시작번호로 부터 가져올 select 갯수

    int listSize = 0; // 햔재 읽어온 게시물의 수

    String keyWord = "", keyField = "";
    Vector<FreeTalk> list = null;

    if (request.getParameter("keyWord") != null) {
        keyWord = request.getParameter("keyWord");
        keyField = request.getParameter("keyField");
    }

    if (request.getParameter("reload") != null) {
        if (request.getParameter("reload").equals("true")) {
            keyWord = "";
            keyField = "";
        }
    }

    if (request.getParameter("nowPage") != null) {
        nowPage = Integer.parseInt(request.getParameter("nowPage"));
    }

    start = (nowPage * numPerPage) - numPerPage;
    end = numPerPage;

    totalRecord = freetalk.getTotalCount(keyField, keyWord);
    totalPage = (int) Math.ceil((double) totalRecord / numPerPage); // 전체페이지 수
    nowBlock = (int) Math.ceil((double) nowPage / pagePerBlock); // 현재블럭 계산
    totalBlock = (int) Math.ceil((double) totalPage / pagePerBlock); // 전체블럭 계산
%>
<jsp:include page="../top.jsp"/>
<html>
<head>
    <link rel="stylesheet" href="../css/bootstrap.css">
    <title>KBU BOOK</title>

    <style type="text/css">
        td > a, td > a:hover {
            color: #000;
            text-decoration-line: none;
        }
    </style>

    <script type="text/javascript">
        function block(value) {
            document.readFrm.nowPage.value =
            <%=pagePerBlock%>*
            (value - 1) + 1;
            document.readFrm.submit();
        }

        function paging(page) {
            document.readFrm.nowPage.value = page;
            document.readFrm.submit();
        }

        function check() {
            if (document.searchFrm.keyWord.value == "") {
                alert("검색어를 입력하세요.");
                document.searchFrm.keyWord.focus();
                return;
            }
            document.searchFrm.submit();
        }
    </script>
</head>
<body>
<div style="margin: 0 50px 0 50px">
    <table style="width: 960px;">
        <tr>
            <td>Total : <%=totalRecord%> Articles( <font color="red"><%=nowPage%>/<%=totalPage%> Pages
            </font>)
            </td>
        </tr>
    </table>
    <div class="pull-right">
        <form name="searchFrm" method="get" action="../FreeTalk/freeTalk.jsp">
            <select name="keyField" size="1">
                <option value="writer"> 이 름</option>
                <option value="title"> 제 목</option>
                <option value="content"> 내 용</option>
            </select>
            <input size="16" name="keyWord">
            <input style="width: 18px;" type="image" src="../img/search.png" onclick="return check()">
            <input type="hidden" name="nowPage" value="1">
        </form>
    </div>
    <%
        list = freetalk.getList(keyField, keyWord, start, end);  // DB 에서 글 목록을 받아서 리스트에 저장
        listSize = list.size(); // 리스트에 길이를 저장
        if (list.isEmpty()) {   // 리스트가 비어 있을
    %>
    <h2 class="text-center">등록된 게시물이 없습니다.</h2>
    <%
    } else {
    %>
    <table class="table table-hover">
        <colgroup>
            <col width="10%"/>
            <col width="*"/>
            <col width="20%"/>
            <col width="15%"/>
            <col width="10%"/>
        </colgroup>
        <thead>
        <tr>
            <td align="center">번 호</td>
            <td align="center">제 목</td>
            <td align="center">이 름</td>
            <td align="center">날 짜</td>
            <td align="center">조회수</td>
        </tr>
        </thead>
        <tbody>
        <%
            for (int i = 0; i < listSize; i++) {
                int id = list.get(i).getId();
                String writer = list.get(i).getWriter();
                String title = list.get(i).getTitle();
                Date date = list.get(i).getDate();
                int count = list.get(i).getCount();
        %>
        <tr>
            <td align="center"><%=totalRecord - ((nowPage - 1) * numPerPage) - i%>
            </td>
            <td><a href="view.jsp?id=<%=id%>"><%=title%>
            </a></td>
            <td align="center"><%=writer%>
            </td>
            <td align="center"><%=date%>
            </td>
            <td align="center"><%=count%>
            </td>
        </tr>
        <%}%>
        </tbody>
    </table>
    <%}%>
    <div class="pull-right">
        <a href="write.jsp" class="btn btn-success">글쓰기</a>
        <a href="freeTalk.jsp" class="btn btn-primary">처음으로</a>
    </div>
    <br>
    <div class="text-center">
        <%
            int pageStart = (nowBlock - 1) * pagePerBlock + 1; //하단 페이지 시작번호
            int pageEnd = ((pageStart + pagePerBlock) <= totalPage) ? (pageStart + pagePerBlock) : totalPage + 1; //하단 페이지 끝번호
            if (totalPage != 0) {
                if (nowBlock > 1) {%>
        <ul class="pagination">
            <li>
                <a href="javascript:block('<%=nowBlock-1%>')">prev</a>
            </li>
        </ul>
        <%}%>
        <ul class="pagination">
            <% for (; pageStart < pageEnd; pageStart++) {%>
            <li>
                <a href="javascript:paging('<%=pageStart%>')">
                    <%if (pageStart == nowPage) {%><font color="red"><%}%>
                    <%=pageStart%>
                    <%if (pageStart == nowPage) {%></font><%}%></a>
            </li>
            <%}//for%>
        </ul>
        <% if (totalBlock > nowBlock) {%>
        <ul class="pagination">
            <li>
                <a href="javascript:block('<%=nowBlock+1%>')">next</a>
            </li>
        </ul>
        <%}%>&nbsp;
        <%}%>
    </div>
</div>
<form name="readFrm" method="get">
    <input type="hidden" name="num">
    <input type="hidden" name="nowPage" value="<%=nowPage%>">
    <input type="hidden" name="keyField" value="<%=keyField%>">
    <input type="hidden" name="keyWord" value="<%=keyWord%>">
</form>
<br>
<jsp:include page="../footer.jsp"/>
</body>
</html>
<%
    } else {
        out.print("<script>alert('로그인을 해주세요.'); location.href='../index.jsp';</script>");
    }
%>