package com.example.webproject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HistoryService {
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/wifi?useUnicode=true&characterEncoding=utf8mb4";

    public static class History {
        private int id;
        private double lat;
        private double lnt;
        private Timestamp searchDate;

        public History(int id, double lat, double lnt, Timestamp searchDate) {
            this.id = id;
            this.lat = lat;
            this.lnt = lnt;
            this.searchDate = searchDate;
        }

        public int getId() {
            return id;
        }

        public double getLat() {
            return lat;
        }

        public double getLnt() {
            return lnt;
        }

        public Timestamp getSearchDate() {
            return searchDate;
        }
    }

    public void saveHistory(double lat, double lnt) {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, "wifi", "1234");

            String sql = " insert into history (lat, lnt) values (?, ?) ";
            PreparedStatement pstm = conn.prepareStatement(sql);
            pstm.setDouble(1, lat);
            pstm.setDouble(2, lnt);

            pstm.executeUpdate();

            pstm.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<History> getHistoryList() {
        List<History> historyList = new ArrayList<History>();
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/wifi", "wifi", "1234");

            String sql = " select id, lat, lnt, search_date from history order by search_date desc";
            PreparedStatement pstm = conn.prepareStatement(sql);
            ResultSet rs = pstm.executeQuery();

            while (rs.next()) {
                History history = new History(
                        rs.getInt("id"),
                        rs.getDouble("lat"),
                        rs.getDouble("lnt"),
                        rs.getTimestamp("search_date")
                );
                historyList.add(history);
            }

            rs.close();
            pstm.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return historyList;
    }

    public void deleteHistory(int id) {
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/wifi", "wifi", "1234");

            String sql = " delete from history where id = ? ";
            PreparedStatement pstm = conn.prepareStatement(sql);
            pstm.setInt(1, id);

            pstm.executeUpdate();
            pstm.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
