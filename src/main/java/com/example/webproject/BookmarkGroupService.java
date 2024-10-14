package com.example.webproject;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookmarkGroupService {
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/wifi?useUnicode=true&characterEncoding=utf8mb4";
    private static final String USER = "wifi";
    private static final String PASS = "1234";

    public static class bookmarkInfo {
        private int id;
        private String name;
        private int num;
        private Timestamp create_dt;
        private Timestamp updated_dt;

        public bookmarkInfo(int id, String name, int num, Timestamp create_dt, Timestamp updated_dt) {
            this.id = id;
            this.name = name;
            this.num = num;
            this.create_dt = create_dt;
            this.updated_dt = updated_dt;
        }

        public int getId() {
            return id;
        }

        public String getName() {
            return name;
        }

        public int getNum() {
            return num;
        }

        public Timestamp getCreate_dt() {
            return create_dt;
        }

        public Timestamp getUpdated_dt() {
            return updated_dt;
        }
    }

    public void addBookmark(String name, int num) {
        String sql = " insert into bookmark_group (name, num) values (?, ?) ";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql);) {
                ps.setString(1, name);
                ps.setInt(2, num);
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public void updateBookmark(int id, String newName, int newNum) {
        String sql = " update bookmark_group set name=?, num=?, updated_dt = CURRENT_TIMESTAMP where id=? ";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql);) {
                ps.setString(1, newName);
                ps.setInt(2, newNum);
                ps.setInt(3, id);
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public List<bookmarkInfo> getBookmarks() {
        List<bookmarkInfo> bookmarks = new ArrayList<>();
        String sql = " select * from bookmark_group ";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery();) {

                while (rs.next()) {
                    bookmarkInfo bookmark = new bookmarkInfo(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getInt("num"),
                            rs.getTimestamp("create_dt"),
                            rs.getTimestamp("updated_dt")
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
        String sql = " delete from bookmark_group where id=? ";
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
                 PreparedStatement ps = conn.prepareStatement(sql);) {
                ps.setInt(1, id);
                ps.executeUpdate();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public List<String> getBookmarkGroups() {
        List<String> groupList = new ArrayList<>();
        String sql = " select name from bookmark_group ";

        try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                groupList.add(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return groupList;
    }
}
