<%@ page import="com.example.webproject.BookmarkService" %>
<%@ page import="java.lang.String" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <script type="text/javascript">
        function redirectToBookmark() {
            alert('북마크 정보를 추가하였습니다.');
            window.location.href = 'bookmark.jsp';
        }
    </script>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    String bookmarkName = request.getParameter("bookmarkGroup");
    String wifiName = request.getParameter("wifi_name");

    BookmarkService bookmarkService = new BookmarkService();
    bookmarkService.addBookmark(bookmarkName, wifiName);
%>

<script type="text/javascript">
    redirectToBookmark();
</script>
</body>
</html>
