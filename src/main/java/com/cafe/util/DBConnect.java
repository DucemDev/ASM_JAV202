/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.cafe.util;

import java.sql.*;

public class DBConnect {

    public static final String HOSTNAME = "localhost";
    public static final String PORT = "1433";
    public static final String DBNAME = "PolyCafe_JAV202";

    public static final String USERNAME = "sa";
    public static final String PASSWORD = "123456789";

    public static Connection getConnection() {
        String connectionUrl = "jdbc:sqlserver://" + HOSTNAME + ":" + PORT + ";"
                + "databaseName=" + DBNAME + ";encrypt=true;trustServerCertificate=true";
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            return DriverManager.getConnection(connectionUrl, USERNAME, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace(System.out);
        }
        return null;
    }


    public static PreparedStatement createPreStmt(String sql, Object... values) throws SQLException {
        Connection connection = getConnection();
        PreparedStatement stmt = null;
        if (sql.trim().startsWith("{")) {
            stmt = connection.prepareCall(sql);
        } else {
            stmt = connection.prepareStatement(sql);
        }

        for (int i = 0; i < values.length; i++) {
            if (values[i] == null) {
                stmt.setNull(i + 1, Types.NULL);
            } else {
                stmt.setObject(i + 1, values[i]);
            }
        }

        return stmt;
    }

    public static int executeUpdate(String sql, Object... values) throws SQLException {
        try (PreparedStatement stmt = DBConnect.createPreStmt(sql, values)) {
            return stmt.executeUpdate();
        }
    }

    /**
     * Truy vấn dữ liệu
     */
    public static ResultSet executeQuery(String sql, Object... values) throws SQLException {
        PreparedStatement stmt = DBConnect.createPreStmt(sql, values);
        return stmt.executeQuery();

    }

}

