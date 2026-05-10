<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ma.ac.esi.gameverseacademy.model.Player" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>GameVerse Academy — Players</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #0f0f1a; color: #fff; }
        .navbar {
            display: flex; align-items: center; justify-content: space-between;
            background: #1a1a2e; padding: 12px 24px; border-bottom: 1px solid #2a2a4a;
        }
        .nav-left { display: flex; gap: 10px; }
        .nav-btn {
            padding: 8px 18px; border-radius: 20px; border: none;
            cursor: pointer; font-size: 14px; font-weight: bold;
        }
        .btn-mods    { background: #4A90D9; color: white; }
        .btn-add     { background: #27ae60; color: white; }
        .btn-logout  { background: #e74c3c; color: white; }
        .container { max-width: 1100px; margin: 40px auto; padding: 0 20px; }
        h1 { color: #4A90D9; margin-bottom: 24px; }
        table { width: 100%; border-collapse: collapse; background: #fff; color: #333; border-radius: 8px; overflow: hidden; }
        th { background: #1E3A5F; color: white; padding: 12px; text-align: left; }
        td { padding: 10px 12px; border-bottom: 1px solid #ddd; }
        tr:nth-child(even) { background: #EEF4FB; }
        tr:hover { background: #D6E8F7; }
        .btn-edit   { background: #f39c12; color: white; padding: 6px 12px; border-radius: 6px; text-decoration: none; font-size: 13px; }
        .btn-delete { background: #e74c3c; color: white; padding: 6px 12px; border-radius: 6px; text-decoration: none; font-size: 13px; margin-left: 6px; }
        .message { background: #1B5E20; padding: 12px; border-radius: 6px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="navbar">
        <div class="nav-left">
            <button class="nav-btn btn-mods"
                onclick="window.location.href='<%= request.getContextPath() %>/mods'">
                🎮 Mods
            </button>
            <button class="nav-btn btn-add"
                onclick="window.location.href='<%= request.getContextPath() %>/players?action=new'">
                ➕ Ajouter un joueur
            </button>
        </div>
        <div style="display:flex; align-items:center; gap:10px;">
            <span style="color:#4A90D9; font-weight:bold;">
                👤 <%= session.getAttribute("user") %>
            </span>
            <form action="<%= request.getContextPath() %>/LogoutController" method="post" style="margin:0;">
                <button type="submit" class="nav-btn btn-logout">🚪 Déconnexion</button>
            </form>
        </div>
    </div>

    <div class="container">
        <h1>🎮 Liste des Joueurs</h1>

        <%
            List<Player> players = (List<Player>) request.getAttribute("players");
            if (players == null || players.isEmpty()) {
        %>
            <p>Aucun joueur disponible.</p>
        <%
            } else {
        %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Email</th>
                    <th>Level</th>
                    <th>Score</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <% for (Player player : players) { %>
                <tr>
                    <td><%= player.getId() %></td>
                    <td><%= player.getUsername() %></td>
                    <td><%= player.getEmail() %></td>
                    <td><%= player.getLevel() %></td>
                    <td><%= player.getScore() %></td>
                    <td>
                        <a class="btn-edit"
                           href="<%= request.getContextPath() %>/players?action=edit&id=<%= player.getId() %>">
                           ✏️ Modifier
                        </a>
                        <a class="btn-delete"
                           href="<%= request.getContextPath() %>/players?action=delete&id=<%= player.getId() %>"
                           onclick="return confirm('Supprimer ce joueur ?')">
                           🗑️ Supprimer
                        </a>
                    </td>
                </tr>
            <% } %>
            </tbody>
        </table>
        <% } %>
    </div>
</body>
</html>