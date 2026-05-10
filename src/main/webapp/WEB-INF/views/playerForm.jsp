<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ma.ac.esi.gameverseacademy.model.Player" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>GameVerse Academy — Joueur</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #0D1B2A; color: #CDD6F4; }
        .container {
            max-width: 600px; margin: 60px auto;
            background: #1E3A5F; padding: 32px;
            border-radius: 10px;
        }
        h1 { color: #4A90D9; margin-bottom: 24px; }
        label { display: block; margin-top: 16px; font-weight: bold; }
        input {
            width: 100%; padding: 10px; margin-top: 6px;
            background: #0D1B2A; color: #CDD6F4;
            border: 1px solid #4A90D9; border-radius: 6px;
            box-sizing: border-box;
        }
        .btn-submit {
            margin-top: 24px; padding: 12px 28px;
            background: #4A90D9; color: white;
            border: none; border-radius: 6px;
            cursor: pointer; font-size: 15px;
        }
        .btn-cancel {
            margin-top: 24px; margin-left: 10px;
            padding: 12px 28px; background: #e74c3c;
            color: white; border: none; border-radius: 6px;
            cursor: pointer; font-size: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <%
            Player player = (Player) request.getAttribute("player");
            boolean isEdit = (player != null);
            String action = isEdit ? "edit" : "new";
            String title  = isEdit ? "✏️ Modifier le joueur" : "➕ Ajouter un joueur";
        %>

        <h1><%= title %></h1>

        <form action="<%= request.getContextPath() %>/players" method="post">
            <input type="hidden" name="action" value="<%= action %>">
            <% if (isEdit) { %>
            <input type="hidden" name="id" value="<%= player.getId() %>">
            <% } %>

            <label for="username">Username *</label>
            <input type="text" id="username" name="username"
                   value="<%= isEdit ? player.getUsername() : "" %>"
                   placeholder="Ex: GamerPro" required>

            <label for="email">Email *</label>
            <input type="email" id="email" name="email"
                   value="<%= isEdit ? player.getEmail() : "" %>"
                   placeholder="Ex: gamer@gmail.com" required>

            <label for="level">Level</label>
            <input type="number" id="level" name="level" min="1" max="100"
                   value="<%= isEdit ? player.getLevel() : 1 %>">

            <label for="score">Score</label>
            <input type="number" id="score" name="score" min="0"
                   value="<%= isEdit ? player.getScore() : 0 %>">

            <button type="submit" class="btn-submit">
                <%= isEdit ? "💾 Enregistrer" : "➕ Ajouter" %>
            </button>
            <button type="button" class="btn-cancel"
                onclick="window.location.href='<%= request.getContextPath() %>/players?action=list'">
                ❌ Annuler
            </button>
        </form>
    </div>
</body>
</html>