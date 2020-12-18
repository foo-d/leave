package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    private Connection connection;

    public void connect () {
        try {
            this.connection = DriverManager
                .getConnection("jdbc:mysql://localhost/food", "root", "");
        } catch (SQLException e) {
            System.out.println("");
        }
    }

    public void disconnect () {
        try {
            if (this.connection != null) this.connection.close();
        } catch (SQLException e) {
            System.out.println("");
        }
    }

    public Connection getConnection () {
        return connection;
    }
}
