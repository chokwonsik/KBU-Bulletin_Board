<%--
  Created by IntelliJ IDEA.
  User: HWJ
  Date: 2019-06-01
  Time: ���� 5:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=EUC-KR" pageEncoding="EUC-KR" language="java" %>
<html>
<link rel="stylesheet" href="../css/bootstrap.min.css"><!--��Ʈ��Ʈ�� css�� �ҷ���-->
<style>
    @import "../css/style.css";
    body{background-color: rgba(243,206,90,0.53);}
</style>
<head>
    <title>KBUBOOK SEARCH ID</title>
</head>

<body>
<form name="search_id" method="post" action="id.jsp">
<div align="center">
    <serach>���̵� & ��й�ȣ ã��</serach>
	<hr></hr>
	<p><input type="text" class="text-form" placeholder="�й� �Է��ض�!" name="std_id" align="center" required> </p>
	<p><input type="text" class="text-form" placeholder="�б� �̸��� �Է��ض�!" name="email" align="center" required> </p>
	<p><input type="submit" value="���̵� ã��" name="search" class="btn btn-info"> <input type="button" value="�ݱ�" name="exit" onclick="window.close()" class="btn btn-info"></p>
	
</div>
</form>
</body>
</html>
