<%@ page import="com.example.webproject.BookmarkGroupService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    try {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        int num = Integer.parseInt(request.getParameter("num"));

        BookmarkGroupService bookmarkGroupService = new BookmarkGroupService();
        bookmarkGroupService.updateBookmark(id, name, num);
        response.sendRedirect("bookmark-group.jsp");
    } catch (Exception e) {
        out.println("<p>수정 중 오류가 발생했습니다.</p>");
        out.println("<a href='bookmark-group.jsp'>돌아가기</a>");
    }
%>
</body>
</html>