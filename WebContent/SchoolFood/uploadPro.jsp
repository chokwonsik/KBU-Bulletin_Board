<%--
  Created by IntelliJ IDEA.
  User: yongho
  Date: 2019-06-10
  Time: 09:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page import="org.apache.poi.ss.usermodel.Cell" %>
<%@ page import="org.apache.poi.ss.usermodel.Row" %>
<%@ page import="org.apache.poi.ss.usermodel.Sheet" %>
<%@ page import="org.apache.poi.openxml4j.opc.OPCPackage" %>
<%@ page import="org.apache.poi.ss.usermodel.Workbook" %>
<%@ page import="org.apache.poi.xssf.usermodel.XSSFWorkbook" %>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.util.Vector" %>
<%@ page import="schoolfood.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>KBU BOOK</title>
</head>
<body>
<%
    try {
        String path = application.getRealPath("/");
        MultipartRequest multipartRequest = new MultipartRequest(request, path, 1024 * 1024 * 3, "utf-8", new DefaultFileRenamePolicy());

        String originalFileName = multipartRequest.getOriginalFileName("file");
        File file = multipartRequest.getFile("file");

        FileInputStream excelFile = new FileInputStream(file);

        Workbook workbook = null;
        OPCPackage opcPackage = null;
        if (originalFileName.endsWith("xlsx") || originalFileName.endsWith("xlsm")) {
            opcPackage = OPCPackage.open(excelFile);
            workbook = new XSSFWorkbook(opcPackage);
        } else {
            workbook = new HSSFWorkbook(excelFile);
        }

        Row row = null;
        Cell cell = null;

        Sheet sheet = workbook.getSheetAt(0);

        String cellString = "";

        Vector<Lunch> lunches = new Vector<Lunch>();
        Vector<Dinner> dinners = new Vector<Dinner>();
        Vector<Fix> fixes = new Vector<Fix>();
        Vector<Daily> dailies = new Vector<Daily>();

        String[] day = {"월요일", "화요일", "수요일", "목요일", "금요일"};


        // 각 식단의 날짜를 저장하는 반복문

        for (int col = 2; col <= 10; col += 2) {
            Lunch lunch = new Lunch();
            Dinner dinner = new Dinner();
            Fix fix = new Fix();
            Daily daily = new Daily();

            String[] food = new String[6];  // 중식용 배열
            String[] food2 = new String[6];  // 석식용 배열
            String[] food3 = new String[2]; // 고정메뉴용 배열
            row = sheet.getRow(1);
            cell = row.getCell(col);
            Date date_format = cell.getDateCellValue();
            cellString = new SimpleDateFormat("yyyyMMdd").format(date_format);
            lunch.setDate(cellString);
            dinner.setDate(cellString);
            fix.setDate(cellString);
            daily.setDate(cellString);

            lunch.setDay(day[col / 2 - 1]);
            dinner.setDay(day[col / 2 - 1]);
            fix.setDay(day[col / 2 - 1]);
            daily.setDay(day[col / 2 - 1]);

            // 엑셀 파일 중식 데이터 접근 반복문
            for (int r = 3; r <= 8; r++) {
                row = sheet.getRow(r);
                cell = row.getCell(col);
                food[r - 3] = cell.toString();
            }
            lunch.setFood(food); // 중식을 Lunch 객체에 저장

            // 엑셀 파일 석식 데이터 접근 반복문
            for (int r = 15; r <= 20; r++) {
                row = sheet.getRow(r);
                cell = row.getCell(col);
                food2[r - 15] = cell.toString();
            }
            dinner.setFood(food2);

            // 엑셀 파일 고정메뉴 데이터 접근 반복문
            for (int r = 10; r <= 11; r++) {
                row = sheet.getRow(r);
                cell = row.getCell(col);
                food3[r - 10] = cell.toString();
            }
            fix.setFood(food3);

            // 엑셀 파일 데일리메뉴 데이터 접근 반복문
            row = sheet.getRow(13);
            cell = row.getCell(col);
            daily.setFood(cell.toString());

            lunches.add(col / 2 - 1, lunch);
            dinners.add(col / 2 - 1, dinner);
            fixes.add(col / 2 - 1, fix);
            dailies.add(col / 2 - 1, daily);
        }

        workbook.close();
        if (opcPackage != null) {
            opcPackage.close();
        }

        SchoolFoodDAO schoolFoodDAO = new SchoolFoodDAO();

        schoolFoodDAO.upload(lunches, dinners, fixes, dailies);

        response.sendRedirect("schoolFood.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        out.print("<script>alert('잘못된 접근입니다.'); history.back();</script>");
    }
%>
</body>