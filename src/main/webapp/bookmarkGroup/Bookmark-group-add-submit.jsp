<%@ page import="com.example.webproject.BookmarkGroupService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <script type="text/javascript">
        function redirectToGroupPage() {
            alert('북마크 그룹 정보를 추가하였습니다.');
            window.location.href = 'bookmark-group.jsp';
        }
    </script>
</head>
<body>

<%
    request.setCharacterEncoding("UTF-8");
    String name = request.getParameter("name");
    int num = Integer.parseInt(request.getParameter("num"));

    BookmarkGroupService bookmarkGroupService = new BookmarkGroupService();
    bookmarkGroupService.addBookmark(name, num);
%>

<script type="text/javascript">
    redirectToGroupPage();
</script>
</body>
</html>