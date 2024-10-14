<%@ page import="com.example.webproject.HistoryService" %>
<%@ page import="java.lang.Integer" %>
<%@ page import="java.lang.String" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: sunghyun
  Date: 24. 10. 9.
  Time: 오후 11:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>와이파이 정보 구하기</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>

<body>
<h1>위치 히스토리 목록</h1>

<!-- 상단 탭 메뉴 -->
<div class="navbar">
    <a href="index.jsp">홈</a>
    <a class="separator">|</a>
    <a href="history.jsp">위치 히스토리 목록</a>
    <a class="separator">|</a>
    <a href="wifi/load-wifi.jsp">OpenAPI 와이파이 정보 가져오기</a>
</div>

<!-- 히스토리 목록 불러오기 -->
<%
    HistoryService historyService = new HistoryService();
    List<HistoryService.History> historyList = historyService.getHistoryList();

    String deleteId = request.getParameter("deleteId");
    if (deleteId != null) {
        historyService.deleteHistory(Integer.parseInt(deleteId));
        historyList = historyService.getHistoryList();
    }
%>

<!-- 데이터 출력 테이블 -->
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>X좌표</th>
        <th>Y좌표</th>
        <th>조회일자</th>
        <th>비고</th>
    </tr>
    </thead>
    <tbody>
    <!-- 데이터 표시 영역 -->
    <%
        if (!historyList.isEmpty()) {
            for (HistoryService.History history : historyList) {
    %>
    <tr>
        <td><%= history.getId()%>
        </td>
        <td><%= history.getLat()%>
        </td>
        <td><%= history.getLnt()%>
        </td>
        <td><%= history.getSearchDate()%>
        </td>
        <td>
            <form action="history.jsp" method="get" style="display:inline;">
                <input type="hidden" name="deleteId" value="<%= history.getId() %>">
                <button type="submit">삭제</button>
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="5">조회된 히스토리가 없습니다.</td>
    </tr>
    <% } %>
    </tbody>
</table>
</body>
</html>
