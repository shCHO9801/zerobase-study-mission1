import java.sql.*;

public class DBConnectionTest {
    public static void main(String[] args) {
        String jdbcUrl = "jdbc:mariadb://localhost:3306/wifi";
        String username = "wifi";
        String password = "1234";

        try (Connection connection = DriverManager.getConnection(jdbcUrl, username, password)){
            System.out.println("DB 연결 성공");
        } catch (SQLException e){
            System.out.println("DB 연결 실패");
            e.printStackTrace();
        }
    }
}
