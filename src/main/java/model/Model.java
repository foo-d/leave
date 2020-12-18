package model;

import controller.Employee;
import controller.Leaves;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class Model {
    private static final Database database = new Database();

    public static String login (String email, String password) {
        String id = null;
        try {
            database.connect();
            Statement statement = database.getConnection().createStatement();
            ResultSet resultSet = statement.executeQuery("SELECT login('" +
                    email + "', '" + password +"');");
            if (resultSet.next()) {
                id = resultSet
                    .getString("login('" + email + "', '" + password + "')");
            }
            statement.close();
            database.disconnect();
        } catch (SQLException e) {
            System.out.println("");
        }
        return id;
    }

    public static void refresh (int id) {
        try {
            database.connect();
            Statement statement = database.getConnection().createStatement();
            statement.execute("CALL refresh('" + id + "');");
        } catch (SQLException e) {
            System.out.println("");
        }
    }

    public static Employee selectWhereEmployee (int id) {
        Employee employee = null;
        try {
            database.connect();
            Statement statement = database.getConnection().createStatement();
            ResultSet resultSet = statement
                .executeQuery("SELECT * FROM employee WHERE id = '" + id +
                    "';");
            if (resultSet.next()) {
                employee = new Employee(resultSet.getInt("id"),
                    resultSet.getString("last_name"),
                    resultSet.getString("first_name"),
                    resultSet.getString("email"),
                    resultSet.getString("date_of_birth"),
                    resultSet.getString("country"),
                    resultSet.getString("city"),
                    resultSet.getString("zip_code"),
                    resultSet.getString("date_of_hire"),
                    resultSet.getString("password"),
                    resultSet.getFloat("remaining"),
                    resultSet.getFloat("used"));
            }
            statement.close();
            database.disconnect();
        } catch (SQLException e) {
            System.out.println("");
        }
        return employee;
    }

    public static ArrayList<Leaves> selectWhereLeaves (int idEmployee) {
        ArrayList<Leaves> leaves = new ArrayList<>();
        try {
            database.connect();
            Statement statement = database.getConnection().createStatement();
            ResultSet resultSet = statement
                .executeQuery("SELECT * FROM leaves WHERE id_employee = '" +
                    idEmployee + "';");
            while (resultSet.next()) {
                Leaves aLeaves = new Leaves(resultSet.getInt("id"),
                    resultSet.getString("start"),
                    resultSet.getString("end"),
                    resultSet.getString("full_day"),
                    resultSet.getString("reason"),
                    resultSet.getInt("id_employee"));
                leaves.add(aLeaves);
            }
            statement.close();
            database.disconnect();
        } catch (SQLException e) {
            System.out.println("");
        }
        return leaves;
    }

    public static void deleteLeaves (int id) {
        try {
            database.connect();
            Statement statement = database.getConnection().createStatement();
            statement.execute("DELETE FROM leaves WHERE id = '" + id + "';");
            statement.close();
            database.disconnect();
        } catch (SQLException e) {
            System.out.println("");
        }
    }

    public static void insertLeaves (Leaves leaves) {
        try {
            database.connect();
            Statement statement = database.getConnection().createStatement();
            statement.execute("INSERT INTO leaves VALUES (NULL, '" +
                leaves.getStart() + "', '" + leaves.getEnd() + "', '" + leaves
                .getReason() + "', '" + leaves.getIdEmployee() + "');");
            statement.close();
            database.disconnect();
        } catch (SQLException e) {
            System.out.println("");
        }
    }
}
