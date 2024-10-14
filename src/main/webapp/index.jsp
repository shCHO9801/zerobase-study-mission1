<%@ page import="com.example.webproject.HistoryService" %>
<%@ page import="com.example.webproject.NearbyWifiService" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>와이파이 정보 구하기</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script>
        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(showPosition, showError);
            } else {
                alert("오류");
            }
        }

        function showPosition(position) {
            document.getElementById("lat").value = position.coords.latitude;
            document.getElementById("lnt").value = position.coords.longitude;
        }

        function showError(error) {
            switch (error.code) {
                case error.PERMISSION_DENIED:
                    alert("사용자가 위치 정보 제공을 거부했습니다.");
                    break;
                case error.POSITION_UNAVAILABLE:
                    alert("위치 정보를 사용할 수 없습니다.");
                    break;
                case error.TIMEOUT:
                    alert("위치 정보를 가져오는 시간이 초과되었습니다.");
                    break;
                case error.UNKNOWN_ERR:
                    alert("알 수 없는 오류가 발생했습니다.");
                    break;
            }
        }
    </script>
</head>
<body>
<h1>와이파이 정보 구하기</h1>

<!-- 상단 탭 메뉴 -->
<div class="navbar">
    <a href="index.jsp">홈</a>
    <a class="separator">|</a>
    <a href="history.jsp">위치 히스토리 목록</a>
    <a class="separator">|</a>
    <a href="wifi/load-wifi.jsp">OpenAPI 와이파이 정보 가져오기</a>
    <a class="separator">|</a>
    <a href="bookmark/bookmark.jsp">북마크 보기</a>
    <a class="separator">|</a>
    <a href="bookmarkGroup/bookmark-group.jsp">북마크 그룹 관리</a>
</div>

<!-- 입력 필드 및 버튼 -->
<div class="form-search">
    <form method="get">
        <label for="lat">LAT:</label>
        <input type="text" id="lat" name="lat"
               value="<%= request.getParameter("lat") != null ? request.getParameter("lat") : "" %>" placeholder="0.0">

        <label for="lnt">,LNT:</label>
        <input type="text" id="lnt" name="lnt"
               value="<%= request.getParameter("lnt") != null ? request.getParameter("lnt") : "" %>" placeholder="0.0">

        <button type="button" onclick="getLocation()">내 위치 가져오기</button>
        <button type="submit">근처 WIFI 정보 가져오기</button>
    </form>
</div>

<!-- 데이터 출력 테이블 -->
<table>
    <thead>
    <tr>
        <th>거리</th>
        <th>관리번호</th>
        <th>자치구</th>
        <th>와이파이명</th>
        <th>도로명주소</th>
        <th>상세주소</th>
        <th>설치위치(층)</th>
        <th>설치유형</th>
        <th>설치기관</th>
        <th>서비스구분</th>
        <th>망종류</th>
        <th>설치년도</th>
        <th>실내외구분</th>
        <th>WIFI접속환경</th>
        <th>X좌표</th>
        <th>Y좌표</th>
        <th>작업일자</th>
    </tr>
    </thead>
    <tbody>
    <!-- 데이터 표시 영역 -->
    <%
        String lat = request.getParameter("lat");
        String lnt = request.getParameter("lnt");

        if (lat != null && lnt != null) {

            HistoryService historyService = new HistoryService();
            historyService.saveHistory(Double.parseDouble(lat), Double.parseDouble(lnt));
            NearbyWifiService wifiService = new NearbyWifiService();
            List<NearbyWifiService.WifiInfo> wifiList = wifiService.getNearbyWifi(Double.parseDouble(lat), Double.parseDouble(lnt));

            for (NearbyWifiService.WifiInfo wifi : wifiList) {
    %>
    <tr>
        <td><%= wifi.getDistance() %>
        </td>
        <td><%= wifi.getWifiMgrNo() %>
        </td>
        <td><%= wifi.getBorough() %>
        </td>
        <td><a href="wifi/info.jsp?wifi_mgr_no=<%= wifi.getWifiMgrNo() %>"><%= wifi.getWifiName() %>
        </a></td>
        <td><%= wifi.getRoadAddress() %>
        </td>
        <td><%= wifi.getDetailAddress() %>
        </td>
        <td><%= wifi.getInstallFloor() %>
        </td>
        <td><%= wifi.getInstallType() %>
        </td>
        <td><%= wifi.getInstallAgency() %>
        </td>
        <td><%= wifi.getServiceType() %>
        </td>
        <td><%= wifi.getNetworkType() %>
        </td>
        <td><%= wifi.getInstallYear() %>
        </td>
        <td><%= wifi.getIndoorOutdoor() %>
        </td>
        <td><%= wifi.getWifiCondition() %>
        </td>
        <td><%= wifi.getLat() %>
        </td>
        <td><%= wifi.getLnt() %>
        </td>
        <td><%= wifi.getWorkDttm() %>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="17">위치 정보를 입력한 후에 조회해 주세요</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
</body>
</html>