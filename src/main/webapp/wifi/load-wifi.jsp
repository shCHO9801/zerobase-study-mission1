<%--
  Created by IntelliJ IDEA.
  User: sunghyun
  Date: 24. 10. 8.
  Time: 오전 12:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="com.example.webproject.wifiApiCall" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>와이파이 정보 구하기</title>
    <link rel="stylesheet" type="text/css" href="../style.css">
</head>
<body>
<%
    wifiApiCall apiCall = new wifiApiCall();
    int totalCount = apiCall.callApi();

    out.println("<p class=\"result-message\">" + totalCount + "개의 WIFI 정보를 정상적으로 저장하였습니다.</p>");
%>
<a href="../index.jsp" class="home-link">홈으로 돌아가기</a>
</body>
</html>
