<%@ page import="com.example.webproject.BookmarkService" %>
<%@ page import="java.lang.Integer" %>
<%@ page import="java.lang.String" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <script type="text/javascript">
        function redirectToBookmark() {
            alert('북마크가 삭제되었습니다.');
            window.location.href = 'bookmark.jsp';
        }
    </script>
</head>
<body>
<%
    String idParam = request.getParameter("id");

    if (idParam != null && !idParam.isEmpty()) {
        int id = Integer.parseInt(idParam);
        BookmarkService bookmarkService = new BookmarkService();
        bookmarkService.deleteBookmark(id);
%>
<script type="text/javascript">
    redirectToBookmark();
</script>
<%
    } else {
        out.println("<p>잘못된 요청입니다.</p>");
    }
%>
</body>
</html>
