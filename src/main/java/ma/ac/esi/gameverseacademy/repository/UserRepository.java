package ma.ac.esi.gameverseacademy.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import ma.ac.esi.gameverseacademy.util.DBUtil;

public class UserRepository {

    public boolean userExists(String login, String password) {

        String sql = "SELECT * FROM users WHERE login=? AND password=?";

        try {
            Connection connection = DBUtil.getConnection();
            PreparedStatement statement = connection.prepareStatement(sql);

            statement.setString(1, login);
            statement.setString(2, password);

            ResultSet resultset = statement.executeQuery();

            if (resultset.next()) {
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
}