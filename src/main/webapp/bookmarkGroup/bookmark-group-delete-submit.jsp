<%@ page import="com.example.webproject.BookmarkGroupService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <script type="text/javascript">
        function redirectToGroupPage() {
            alert('북마크 그룹 정보를 삭제하였습니다.');
            window.location.href = 'bookmark-group.jsp';
        }
    </script>
</head>
<body>
<%
    try {
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isEmpty()) {
            int id = Integer.parseInt(idParam);
            BookmarkGroupService bookmarkGroupService = new BookmarkGroupService();
            bookmarkGroupService.deleteBookmark(id);
            response.sendRedirect("bookmark-group.jsp");
        } else {
%>
<p>삭제할 북마크 정보가 없습니다.</p>
<a href="bookmark-group.jsp">돌아가기</a>
<%
        }
    } catch (NumberFormatException e) {
        out.println("<p>잘못된 ID 값입니다.</p>");
        out.println("<a href='bookmark-group.jsp'>돌아가기</a>");
    }
%>
</body>
</html>