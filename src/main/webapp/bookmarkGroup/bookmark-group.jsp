<%@ page import="com.example.webproject.BookmarkGroupService" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <link rel="stylesheet" type="text/css" href="../style.css">
</head>
<body>
<h1>위치 히스토리 목록</h1>
<div class="navbar">
    <a href="../index.jsp">홈</a>
    <a class="separator">|</a>
    <a href="../history.jsp">위치 히스토리 목록</a>
    <a class="separator">|</a>
    <a href="../wifi/load-wifi.jsp">OpenAPI 와이파이 정보 가져오기</a>
    <a class="separator">|</a>
    <a href="../bookmark/bookmark.jsp">북마크 보기</a>
    <a class="separator">|</a>
    <a href="bookmark-group.jsp">북마크 그룹 관리</a>
</div>
<button onclick="location.href='Bookmark-group-add.jsp'">북마크 그룹 이름 추가</button>

<%
    BookmarkGroupService bookmarkGroupService = new BookmarkGroupService();
    List<BookmarkGroupService.bookmarkInfo> bookmarkList = bookmarkGroupService.getBookmarks();
    if (bookmarkList.size() == 0) {
%>
<table>
    <tr>
        <td>정보가 존재하지 않습니다.</td>
    </tr>
</table>
<%
} else {
%>
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>북마크 이름</th>
        <th>순서</th>
        <th>등록일자</th>
        <th>수정일자</th>
        <th>비고</th>
    </tr>
    </thead>
    <tbody>
    <%
        for (BookmarkGroupService.bookmarkInfo bookmark : bookmarkList) {
    %>
    <tr>
        <td><%= bookmark.getId()%>
        </td>
        <td><%= bookmark.getName()%>
        </td>
        <td><%= bookmark.getNum()%>
        </td>
        <td><%= bookmark.getCreate_dt()%>
        </td>
        <td><%= bookmark.getUpdated_dt() != null ? bookmark.getUpdated_dt() : ""%>
        </td>
        <td>
            <a href="bookmark-group-update.jsp?id=<%= bookmark.getId() %>&name=<%= bookmark.getName()%>&num=<%= bookmark.getNum()%>">수정</a>
            <a href="bookmark-group-delete.jsp?id=<%= bookmark.getId() %>&name=<%= bookmark.getName()%>&num=<%= bookmark.getNum()%>">삭제</a>
        </td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
<%
    }
%>
</body>
</html>
