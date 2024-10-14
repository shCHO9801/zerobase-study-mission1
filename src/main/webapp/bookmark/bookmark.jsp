<%@ page import="com.example.webproject.BookmarkService" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <link rel="stylesheet" type="text/css" href="../style.css">
</head>
<body>
<h1>북마크 목록</h1>
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

<table class="info_table">
    <thead>
    <tr>
        <th>ID</th>
        <th>북마크 이름</th>
        <th>와이파이명</th>
        <th>등록일자</th>
        <th>비고</th>
    </tr>
    </thead>
    <tbody>
    <%
        BookmarkService bookmarkService = new BookmarkService();
        List<BookmarkService.Bookmark> bookmarks = bookmarkService.getBookmarks();

        for (BookmarkService.Bookmark bookmark : bookmarks) {
    %>
    <tr>
        <td><%= bookmark.getId() %>
        </td>
        <td><%= bookmark.getBookmarkName() %>
        </td>
        <td><%= bookmark.getWifiName() %>
        </td>
        <td><%= bookmark.getCreatedDt() %>
        </td>
        <td>
            <a href="bookmark_delete.jsp?id=<%= bookmark.getId() %>&name=<%= bookmark.getBookmarkName() %>&wifi_name=<%= bookmark.getWifiName() %>&created_dt=<%= bookmark.getCreatedDt() %>">삭제</a>
        </td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
</body>
</html>
