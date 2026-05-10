package ma.ac.esi.gameverseacademy.model;

import java.sql.Timestamp;

public class Player {
    private int id;
    private String username;
    private String email;
    private int level;
    private int score;
    private Timestamp createdAt;

    public Player() {}

    public Player(int id, String username, String email, 
                  int level, int score, Timestamp createdAt) {
        this.id = id;
        this.username = username;
        this.email = email;
        this.level = level;
        this.score = score;
        this.createdAt = createdAt;
    }

    // Getters
    public int getId() { return id; }
    public String getUsername() { return username; }
    public String getEmail() { return email; }
    public int getLevel() { return level; }
    public int getScore() { return score; }
    public Timestamp getCreatedAt() { return createdAt; }

    // Setters
    public void setId(int id) { this.id = id; }
    public void setUsername(String username) { this.username = username; }
    public void setEmail(String email) { this.email = email; }
    public void setLevel(int level) { this.level = level; }
    public void setScore(int score) { this.score = score; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}