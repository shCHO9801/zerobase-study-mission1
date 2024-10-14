<%@ page import="java.lang.Integer" %>
<%@ page import="java.lang.String" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <link rel="stylesheet" type="text/css" href="../style.css">
</head>
<body>
<h1>북마크 삭제</h1>
<div class="navbar">
    <a href="../index.jsp">홈</a>
    <a class="separator">|</a>
    <a href="../history.jsp">위치 히스토리 목록</a>
    <a class="separator">|</a>
    <a href="../wifi/load-wifi.jsp">OpenAPI 와이파이 정보 가져오기</a>
    <a class="separator">|</a>
    <a href="bookmark.jsp">북마크 보기</a>
    <a class="separator">|</a>
    <a href="../bookmarkGroup/bookmark-group.jsp">북마크 그룹 관리</a>
</div>
<%
    request.setCharacterEncoding("UTF-8");
    String idParam = request.getParameter("id");
    String name = request.getParameter("name");
    String wifiName = request.getParameter("wifi_name");
    String createdDt = request.getParameter("created_dt");

    if (idParam != null && !idParam.isEmpty()) {
        int id = Integer.parseInt(idParam);
%>
<table class="info_table">
    <tr>
        <th>북마크 이름</th>
        <td><%= name %>
        </td>
    </tr>
    <tr>
        <th>와이파이명</th>
        <td><%= wifiName %>
        </td>
    </tr>
    <tr>
        <th>등록일자</th>
        <td><%= createdDt %>
        </td>
    </tr>
</table>

<div style="text-align: center;">
    <a href="bookmark.jsp">돌아가기</a>
    <a class="separator">|</a>
    <form action="bookmark_delete_submit.jsp" method="post" style="display:inline;">
        <input type="hidden" name="id" value="<%= id %>">
        <button type="submit">삭제</button>
    </form>
</div>
<%
} else {
%>
<p>잘못된 요청입니다. 삭제할 북마크가 없습니다.</p>
<a href="bookmark.jsp">돌아가기</a>
<%
    }
%>
</body>
</html>