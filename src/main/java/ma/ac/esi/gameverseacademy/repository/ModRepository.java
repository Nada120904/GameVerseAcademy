package ma.ac.esi.gameverseacademy.repository;

import ma.ac.esi.gameverseacademy.model.mod;
import ma.ac.esi.gameverseacademy.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ModRepository {

    private static final String SELECT_ALL =
        "SELECT id, title, category, author, description, " +
        "downloads, created_at, developer, publisher, " +
        "platform, release_date, metacritic " +
        "FROM mods ORDER BY id ASC";

    public List<mod> getAllMods() {
        List<mod> mods = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ALL);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                mods.add(new mod(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("category"),
                    rs.getString("author"),
                    rs.getString("description"),
                    rs.getInt("downloads"),
                    rs.getTimestamp("created_at"),
                    rs.getString("developer"),
                    rs.getString("publisher"),
                    rs.getString("platform"),
                    rs.getString("release_date"),
                    rs.getInt("metacritic")
                ));
            }
        } catch (SQLException e) {
            System.err.println("Erreur SQL dans getAllMods() : " + e.getMessage());
            e.printStackTrace();
        }
        return mods;
    }

    public mod getModById(int id) {
        final String sql =
            "SELECT id, title, category, author, description, " +
            "downloads, created_at, developer, publisher, " +
            "platform, release_date, metacritic " +
            "FROM mods WHERE id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new mod(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("category"),
                        rs.getString("author"),
                        rs.getString("description"),
                        rs.getInt("downloads"),
                        rs.getTimestamp("created_at"),
                        rs.getString("developer"),
                        rs.getString("publisher"),
                        rs.getString("platform"),
                        rs.getString("release_date"),
                        rs.getInt("metacritic")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Erreur SQL dans getModById() : " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }  

    public boolean insertMod(mod m) {
        String sql = "INSERT INTO mods (title, category, author, description) "
                   + "VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, m.getTitle());
            stmt.setString(2, m.getCategory());
            stmt.setString(3, m.getAuthor());
            stmt.setString(4, m.getDescription());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }  

}  


