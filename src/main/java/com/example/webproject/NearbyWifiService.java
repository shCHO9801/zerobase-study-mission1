package com.example.webproject;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class NearbyWifiService {
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/wifi?useUnicode=true&characterEncoding=utf8mb4";
    private static final String USER = "wifi";
    private static final String PASS = "1234";


    public static class WifiInfo {
        private double distance;
        private String wifiMgrNo;
        private String borough;
        private String wifiName;
        private String roadAddress;
        private String detailAddress;
        private String installFloor;
        private String installType;
        private String installAgency;
        private String serviceType;
        private String networkType;
        private int installYear;
        private String indoorOutdoor;
        private String wifiCondition;
        private double lat;
        private double lnt;
        private String workDttm;

        public WifiInfo(double distance, String wifiMgrNo, String borough, String wifiName, String roadAddress, String detailAddress, String installFloor, String installType, String installAgency, String serviceType, String networkType, int installYear, String indoorOutdoor, String wifiCondition, double lat, double lnt, String workDttm) {
            this.distance = distance;
            this.wifiMgrNo = wifiMgrNo;
            this.borough = borough;
            this.wifiName = wifiName;
            this.roadAddress = roadAddress;
            this.detailAddress = detailAddress;
            this.installFloor = installFloor;
            this.installType = installType;
            this.installAgency = installAgency;
            this.serviceType = serviceType;
            this.networkType = networkType;
            this.installYear = installYear;
            this.indoorOutdoor = indoorOutdoor;
            this.wifiCondition = wifiCondition;
            this.lat = lat;
            this.lnt = lnt;
            this.workDttm = workDttm;
        }

        public double getDistance() {
            return distance;
        }

        public String getWifiMgrNo() {
            return wifiMgrNo;
        }

        public String getBorough() {
            return borough;
        }

        public String getWifiName() {
            return wifiName;
        }

        public String getRoadAddress() {
            return roadAddress;
        }

        public String getDetailAddress() {
            return detailAddress;
        }

        public String getInstallFloor() {
            return installFloor;
        }

        public String getInstallType() {
            return installType;
        }

        public String getInstallAgency() {
            return installAgency;
        }

        public String getServiceType() {
            return serviceType;
        }

        public String getNetworkType() {
            return networkType;
        }

        public int getInstallYear() {
            return installYear;
        }

        public String getIndoorOutdoor() {
            return indoorOutdoor;
        }

        public String getWifiCondition() {
            return wifiCondition;
        }

        public double getLat() {
            return lat;
        }

        public double getLnt() {
            return lnt;
        }

        public String getWorkDttm() {
            return workDttm;
        }
    }

    public List<WifiInfo> getNearbyWifi(double lat, double lnt) {
        List<WifiInfo> wifilist = new ArrayList<>();
        String sql = " select *, " +
                " round((6371 * acos(cos(radians(?)) * cos(radians(lat)) * cos(radians(lnt) - radians(?)) + sin(radians(?)) * sin(radians(lat)))), 4)as distance " +
                " from wifi_info order by distance limit 20 ";


        try {
            Class.forName("org.mariadb.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setDouble(1, lat);
                pstmt.setDouble(2, lnt);
                pstmt.setDouble(3, lat);

                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    WifiInfo wifi = new WifiInfo(
                            rs.getDouble("distance"),
                            rs.getString("wifi_mgr_no"),
                            rs.getString("borough"),
                            rs.getString("wifi_name"),
                            rs.getString("road_address"),
                            rs.getString("detail_address"),
                            rs.getString("install_floor"),
                            rs.getString("install_type"),
                            rs.getString("install_agency"),
                            rs.getString("service_type"),
                            rs.getString("network_type"),
                            rs.getInt("install_year"),
                            rs.getString("indoor_outdoor"),
                            rs.getString("wifi_condition"),
                            rs.getDouble("lat"),
                            rs.getDouble("lnt"),
                            rs.getString("work_dttm")
                    );
                    wifilist.add(wifi);
                }

                rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return wifilist;
    }

    public WifiInfo getWifiById(String wifiNgrNo) {
        WifiInfo wifi = null;
        String sql = " select * from wifi_info where wifi_mgr_no = ? ";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                 PreparedStatement pstmt = conn.prepareStatement(sql);) {

                pstmt.setString(1, wifiNgrNo);
                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                    wifi = new WifiInfo(
                            0.0000,
                            rs.getString("wifi_mgr_no"),
                            rs.getString("borough"),
                            rs.getString("wifi_name"),
                            rs.getString("road_address"),
                            rs.getString("detail_address"),
                            rs.getString("install_floor"),
                            rs.getString("install_type"),
                            rs.getString("install_agency"),
                            rs.getString("service_type"),
                            rs.getString("network_type"),
                            rs.getInt("install_year"),
                            rs.getString("indoor_outdoor"),
                            rs.getString("wifi_condition"),
                            rs.getDouble("lat"),
                            rs.getDouble("lnt"),
                            rs.getString("work_dttm")
                    );
                }

                rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return wifi;
    }
}
