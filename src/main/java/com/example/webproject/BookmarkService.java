package com.example.webproject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookmarkService {
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/wifi?useUnicode=true&characterEncoding=utf8mb4";
    private static final String USER = "wifi";
    private static final String PASS = "1234";

    public static class Bookmark {
        private int id;
        private String bookmarkName;
        private String wifiName;
        private Timestamp createdDt;

        public Bookmark(int id, String bookmarkName, String wifiName, Timestamp createdDt) {
            this.id = id;
            this.bookmarkName = bookmarkName;
            this.wifiName = wifiName;
            this.createdDt = createdDt;
        }

        public int getId() {
            return id;
        }

        public String getBookmarkName() {
            return bookmarkName;
        }

        public String getWifiName() {
            return wifiName;
        }

        public Timestamp getCreatedDt() {
            return createdDt;
        }
    }

    public void addBookmark(String bookmarkName, String wifiName) {
        String sql = " insert into bookmark (bookmark_Name, wifi_Name) values (?, ?) ";
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, bookmarkName);
                ps.setString(2, wifiName);
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public List<Bookmark> getBookmarks() {
        List<Bookmark> bookmarks = new ArrayList<>();
        String sql = " select * from bookmark ";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Bookmark bookmark = new Bookmark(
                            rs.getInt("id"),
                            rs.getString("bookmark_name"),
                            rs.getString("wifi_name"),
                            rs.getTimestamp("created_dt")
                    );
                    bookmarks.add(bookmark);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return bookmarks;
    }

    public void deleteBookmark(int id) {
        String sql = " delete from bookmark where id = ? ";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setInt(1, id);
                ps.executeUpdate();

            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
}
