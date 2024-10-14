<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <link rel="stylesheet" type="text/css" href="../style.css">
</head>
<body>
<h1>북마크 그룹 수정</h1>
<div class="navbar">
    <a href="../index.jsp">홈</a>
    <a class="separator">|</a>
    <a href="../history.jsp">위치 히스토리 목록</a>
    <a class="separator">|</a>
    <a href="../wifi/load-wifi.jsp">OpenAPI 와이파이 정보 가져오기</a>
    <a class="separator">|</a>
    <a href="bookmark.jsp">북마크 보기</a>
    <a class="separator">|</a>
    <a href="bookmark-group.jsp">북마크 그룹 관리</a>
</div>
<%--테이블 생성--%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<form action="bookmark-group-update-submit.jsp" method="post">
    <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
    <table class="info_table">
        <tr>
            <th>북마크 이름</th>
            <td><input type="text" name="name" value="<%=request.getParameter("name")%>" required>
            </td>
        </tr>
        <tr>
            <th>순서</th>
            <td class="gray"><input type="text" name="num" value="<%=request.getParameter("num")%>" required>
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <a href="bookmark-group.jsp">돌아가기</a>
                <a class="separator">|</a>
                <button type="submit">수정</button>
            </td>
        </tr>
    </table>
</form>
</body>
</html>
