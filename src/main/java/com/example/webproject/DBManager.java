package com.example.webproject;

import org.json.JSONArray;
import org.json.JSONObject;

import java.sql.*;
import java.util.HashSet;
import java.util.Set;

public class DBManager {
    // DB 정보

    private static final String DB_URL = "jdbc:mariadb://localhost:3306/wifi?useUnicode=true&characterEncoding=utf8mb4";
    private static final String DB_USER = "wifi";
    private static final String DB_PASSWORD = "1234";

    private int count = 0;

    public int getTotalWifiCount() {
        int totalCount = 0;
        String sql = "SELECT COUNT(*) FROM wifi_info ";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sql);) {

                if (rs.next()) {
                    totalCount = rs.getInt(1);
                }
            } catch (SQLException e) {
                System.out.println("DB 연결 실패");
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            System.out.println("MariaDB JDBC 드라이버를 찾을 수 없음");
            e.printStackTrace();
        }

        return totalCount;
    }

    private Set<String> fetchExistingWifiMgrNos() {
        Set<String> existingWifiMgrNos = new HashSet<>();
        String sql = "SELECT wifi_mgr_no FROM wifi_info";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(sql);) {


                while (rs.next()) {
                    existingWifiMgrNos.add(rs.getString("wifi_mgr_no"));
                }

            } catch (SQLException e) {
                System.out.println("DB 확인 중 오류 발생");
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.out.println("MariaDB JDBC 드라이버를 찾을 수 없음");
        }


        return existingWifiMgrNos;
    }

    public int saveDataToDB(String data) {
        Set<String> existingWifiMgrNos = fetchExistingWifiMgrNos(); // 기존 데이터 조회
        String sql = " INSERT INTO wifi_info (wifi_mgr_no, borough, wifi_name, road_address, detail_address, install_floor, install_type, install_agency, service_type, network_type, install_year, indoor_outdoor, wifi_condition, lat, lng, work_dttm) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            // 연결 성공 시 아래 문구 출력
            System.out.println("DB 연결 성공");

            JSONObject jsonObject = new JSONObject(data);
            JSONObject wifiData = jsonObject.getJSONObject("TbPublicWifiInfo");

            this.count = wifiData.getInt("list_total_count");

            JSONArray rows = wifiData.getJSONArray("row");


            PreparedStatement pstmt = conn.prepareStatement(sql);

            for (int i = 0; i < rows.length(); i++) {
                JSONObject wifi = rows.getJSONObject(i);
                String wifiMgrNo = wifi.getString("X_SWIFI_MGR_NO");

                // 중복 확인을 메모리에서 처리
                if (!existingWifiMgrNos.contains(wifiMgrNo)) {
                    pstmt.setString(1, wifiMgrNo);
                    pstmt.setString(2, wifi.getString("X_SWIFI_WRDOFC"));
                    pstmt.setString(3, wifi.getString("X_SWIFI_MAIN_NM"));
                    pstmt.setString(4, wifi.getString("X_SWIFI_ADRES1"));
                    pstmt.setString(5, wifi.getString("X_SWIFI_ADRES2"));
                    pstmt.setString(6, wifi.getString("X_SWIFI_INSTL_FLOOR"));
                    pstmt.setString(7, wifi.getString("X_SWIFI_INSTL_TY"));
                    pstmt.setString(8, wifi.getString("X_SWIFI_INSTL_MBY"));
                    pstmt.setString(9, wifi.getString("X_SWIFI_SVC_SE"));
                    pstmt.setString(10, wifi.getString("X_SWIFI_CMCWR"));
                    pstmt.setInt(11, wifi.getInt("X_SWIFI_CNSTC_YEAR"));
                    pstmt.setString(12, wifi.getString("X_SWIFI_INOUT_DOOR"));
                    pstmt.setString(13, wifi.getString("X_SWIFI_REMARS3"));
                    pstmt.setDouble(14, wifi.getDouble("LAT"));
                    pstmt.setDouble(15, wifi.getDouble("LNT"));
                    pstmt.setString(16, wifi.getString("WORK_DTTM"));
                    pstmt.addBatch();
                    this.count++;
                } else {
                    System.out.println("중복된 데이터: " + wifiMgrNo);
                }
            }

            pstmt.executeBatch(); // 일괄처리 실행
            System.out.println("DB 저장 완료");

        } catch (ClassNotFoundException e) {
            System.out.println("MariaDB JDBC 드라이버를 찾을 수 없음");
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("DB 연결 실패");
            e.printStackTrace();
        }

        return this.count;
    }
}
