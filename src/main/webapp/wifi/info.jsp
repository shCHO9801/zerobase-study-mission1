<%@ page import="com.example.webproject.BookmarkGroupService" %>
<%@ page import="com.example.webproject.NearbyWifiService" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: sunghyun
  Date: 24. 10. 12.
  Time: 오후 7:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="../style.css">
    <title>와이파이 정보 구하기</title>
</head>
<body>
<h1>와이파이 정보 구하기</h1>

<div class="navbar">
    <a href="../index.jsp">홈</a>
    <a class="separator">|</a>
    <a href="../history.jsp">위치 히스토리 목록</a>
    <a class="separator">|</a>
    <a href="load-wifi.jsp">OpenAPI 와이파이 정보 가져오기</a>
    <a class="separator">|</a>
    <a href="../bookmark/bookmark.jsp">북마크 보기</a>
    <a class="separator">|</a>
    <a href="../bookmarkGroup/bookmark-group.jsp">북마크 그룹 관리</a>
</div>

<%
    BookmarkGroupService bookmarkGroupService = new BookmarkGroupService();
    List<String> bookmarkGroups = bookmarkGroupService.getBookmarkGroups();
%>
<!--  드롭 박스 추가 북마크 그룹 이름 선택 -->

<%
    String wifiMgrNo = request.getParameter("wifi_mgr_no");
    if (wifiMgrNo != null) {
        NearbyWifiService wifiService = new NearbyWifiService();
        NearbyWifiService.WifiInfo wifi = wifiService.getWifiById(wifiMgrNo);

        if (wifi != null) {

%>
<div class="sub-nav">
    <form action="../bookmark/bookmark-add-submit.jsp" method="post">
        <select name="bookmarkGroup" required>
            <option value="">북마크 그룹 선택</option>
            <%
                for (String groupName : bookmarkGroups) {
            %>
            <option value="<%= groupName %>"><%= groupName %>
            </option>
            <%
                }
            %>
        </select>
        <input type="hidden" name="wifi_name" value="<%= wifi.getWifiName() %>">
        <button type="submit">북마크 추가하기</button>
    </form>

</div>
<table class="info_table">
    <tr>
        <th>거리</th>
        <td><%= wifi.getDistance() %>
        </td>
    </tr>
    <tr>
        <th>관리번호</th>
        <td class="gray"><%= wifi.getWifiMgrNo() %>
        </td>
    </tr>
    <tr>
        <th>자치구</th>
        <td><%= wifi.getBorough() %>
        </td>
    </tr>
    <tr>
        <th>와이파이명</th>
        <td class="gray"><a href=""><%= wifi.getWifiName() %>
        </a></td>
    </tr>
    <tr>
        <th>도로명주소</th>
        <td><%= wifi.getRoadAddress() %>
        </td>
    </tr>
    <tr>
        <th>상세주소</th>
        <td class="gray"><%= wifi.getDetailAddress() %>
        </td>
    </tr>
    <tr>
        <th>설치위치</th>
        <td><%= wifi.getInstallFloor() %>
        </td>
    </tr>
    <tr>
        <th>설치유형</th>
        <td class="gray"><%= wifi.getInstallType() %>
        </td>
    </tr>
    <tr>
        <th>설치기관</th>
        <td><%= wifi.getInstallAgency() %>
        </td>
    </tr>
    <tr>
        <th>서비스 구분</th>
        <td class="gray"><%= wifi.getServiceType() %>
        </td>
    </tr>
    <tr>
        <th>망 종류</th>
        <td><%= wifi.getNetworkType() %>
        </td>
    </tr>
    <tr>
        <th>설치년도</th>
        <td class="gray"><%= wifi.getInstallYear() %>
        </td>
    </tr>
    <tr>
        <th>실내외구분</th>
        <td><%= wifi.getIndoorOutdoor() %>
        </td>
    </tr>
    <tr>
        <th>WIFI접속환경</th>
        <td class="gray"><%= wifi.getWifiCondition() %>
        </td>
    </tr>
    <tr>
        <th>X좌표</th>
        <td><%= wifi.getLat() %>
        </td>
    </tr>
    <tr>
        <th>Y좌표</th>
        <td class="gray"><%= wifi.getLnt() %>
        </td>
    </tr>
    <tr>
        <th>작업일자</th>
        <td><%= wifi.getWorkDttm() %>
        </td>
    </tr>
</table>

<%

        } else {
            out.println("<p>해당 와이파이 정보를 찾을 수 없습니다.</p");
        }
    } else {
        out.println("<p>유효한 관리번호가 제공되지 않았습니다.</p");
    }
%>
</body>
</html>


