package ma.ac.esi.gameverseacademy.repository;

import ma.ac.esi.gameverseacademy.model.Player;
import ma.ac.esi.gameverseacademy.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PlayerRepository {

    // ── READ ALL ──────────────────────────────────────────
    public List<Player> getAllPlayers() {
        List<Player> players = new ArrayList<>();
        String sql = "SELECT * FROM players ORDER BY id ASC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                players.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return players;
    }

    // ── READ ONE ──────────────────────────────────────────
    public Player getPlayerById(int id) {
        String sql = "SELECT * FROM players WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ── CREATE ────────────────────────────────────────────
    public boolean insertPlayer(Player player) {
        String sql = "INSERT INTO players (username, email, level, score) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, player.getUsername());
            stmt.setString(2, player.getEmail());
            stmt.setInt(3, player.getLevel());
            stmt.setInt(4, player.getScore());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ── UPDATE ────────────────────────────────────────────
    public boolean updatePlayer(Player player) {
        String sql = "UPDATE players SET username=?, email=?, level=?, score=? WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, player.getUsername());
            stmt.setString(2, player.getEmail());
            stmt.setInt(3, player.getLevel());
            stmt.setInt(4, player.getScore());
            stmt.setInt(5, player.getId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ── DELETE ────────────────────────────────────────────
    public boolean deletePlayer(int id) {
        String sql = "DELETE FROM players WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // ── Helper ────────────────────────────────────────────
    private Player mapRow(ResultSet rs) throws SQLException {
        return new Player(
            rs.getInt("id"),
            rs.getString("username"),
            rs.getString("email"),
            rs.getInt("level"),
            rs.getInt("score"),
            rs.getTimestamp("created_at")
        );
    }
}