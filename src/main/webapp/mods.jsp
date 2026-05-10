<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ma.ac.esi.gameverseacademy.model.mod" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>GameVerse Academy — Mods</title>
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
        .btn-nouveau   { background: #4A90D9; color: white; }
        .btn-tendances { background: transparent; color: #aaa; border: 1px solid #333; }
        .btn-populaire { background: transparent; color: #aaa; border: 1px solid #333; }
        .btn-soumettre { background: #27ae60; color: white; }
        .btn-accueil   { background: #8e44ad; color: white; }
        .search-box {
            background: #2a2a4a; border: 1px solid #3a3a6a; border-radius: 20px;
            padding: 8px 16px; color: #aaa; font-size: 14px; width: 220px;
        }

        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .cards-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }

        .card { background: #1a1a2e; border-radius: 10px; overflow: hidden; border: 1px solid #2a2a4a; }
        .card-img {
            width: 100%; height: 180px;
            background: linear-gradient(135deg, #2a2a4a, #3a3a6a);
            display: flex; align-items: center; justify-content: center; font-size: 48px;
        }
        .card-body { padding: 14px; }
        .card-category {
            display: inline-block; padding: 4px 10px; border-radius: 12px;
            font-size: 12px; font-weight: bold; margin-bottom: 8px;
            background: #2a6496; color: white;
        }
        .card-title { font-size: 16px; font-weight: bold; margin-bottom: 8px; }
        .card-author { display: flex; align-items: center; gap: 8px; font-size: 13px; color: #aaa; margin-bottom: 6px; }
        .author-avatar {
            width: 22px; height: 22px; border-radius: 50%;
            background: #4A90D9; display: flex; align-items: center;
            justify-content: center; font-size: 11px; font-weight: bold; color: white;
        }
        .btn-players { background: #8e44ad; color: white; }
        .card-info { font-size: 12px; color: #888; margin-bottom: 6px; }
        .card-description {
            font-size: 13px; color: #bbb; margin-bottom: 12px;
            display: -webkit-box; -webkit-line-clamp: 3;
            -webkit-box-orient: vertical; overflow: hidden;
        }
        .card-footer {
            display: flex; justify-content: space-between; align-items: center;
            border-top: 1px solid #2a2a4a; padding-top: 10px; margin-top: 6px;
        }
        .downloads { font-size: 13px; color: #aaa; }
        .metacritic { padding: 4px 10px; border-radius: 6px; font-size: 13px; font-weight: bold; color: white; }
        .mc-green  { background: #4CAF50; }
        .mc-orange { background: #FF9800; }
        .mc-red    { background: #F44336; }
    </style>
</head>
<body>

    <!-- UNE SEULE NAVBAR -->
    <div class="navbar">
        <div class="nav-left">
            <button class="nav-btn btn-nouveau"
                onclick="window.location.href='<%= request.getContextPath() %>/mods'">
                ⭐ Nouveau
            </button>
            <button class="nav-btn btn-tendances">🔥 Tendances</button>
            <button class="nav-btn btn-populaire">⭐ Populaire</button>
            <button class="nav-btn btn-players"
    onclick="window.location.href='<%= request.getContextPath() %>/players?action=list'">
    🎮 Joueurs
</button>
            <button class="nav-btn btn-soumettre"
                onclick="window.location.href='<%= request.getContextPath() %>/ModSubmitController'">
                ➕ Soumettre un mod
            </button>
            <button class="nav-btn btn-accueil"
                onclick="window.location.href='<%= request.getContextPath() %>/index.html'">
                🏠 Accueil
            </button>
            <!-- Utilisateur connecté + Déconnexion -->
        <div style="display:flex; align-items:center; gap:10px; margin-left:20px;">
            <span style="color:#4A90D9; font-weight:bold;">
                👤 <%= session.getAttribute("user") != null 
                    ? session.getAttribute("user") : "Visiteur" %>
            </span>
            <form action="<%= request.getContextPath() %>/LogoutController" 
                  method="post" style="margin:0;">
                <button type="submit" class="nav-btn" 
                    style="background:#e74c3c; color:white;">
                    🚪 Déconnexion
                </button>
            </form>
        </div>
        </div>
        <input class="search-box" type="text" placeholder="🔍 Rechercher...">
    </div>

    <!-- CARTES -->
    <div class="container">
        <div class="cards-grid">
        <%
            List<mod> mods = (List<mod>) request.getAttribute("mods");
            if (mods != null) {
                for (mod mod : mods) {
                    String mcClass = "mc-green";
                    if (mod.getMetacritic() < 60) mcClass = "mc-red";
                    else if (mod.getMetacritic() < 75) mcClass = "mc-orange";
                    String initiale = mod.getAuthor() != null && !mod.getAuthor().isEmpty()
                        ? String.valueOf(mod.getAuthor().charAt(0)).toUpperCase() : "?";
        %>
            <div class="card">
                <div class="card-img">🎮</div>
                <div class="card-body">
                    <span class="card-category"><%= mod.getCategory() %></span>
                    <div class="card-title"><%= mod.getTitle() %></div>
                    <div class="card-author">
                        <div class="author-avatar"><%= initiale %></div>
                        <%= mod.getAuthor() %>
                    </div>
                    <% if (mod.getReleaseDate() != null) { %>
                    <div class="card-info">📅 <%= mod.getReleaseDate() %>
                        <% if (mod.getPlatform() != null) { %> 🖥 <%= mod.getPlatform() %> <% } %>
                    </div>
                    <% } %>
                    <div class="card-description"><%= mod.getDescription() %></div>
                    <div class="card-footer">
                        <span class="downloads">↓ <%= mod.getDownloads() %></span>
                        <span class="metacritic <%= mcClass %>">MC <%= mod.getMetacritic() %></span>
                    </div>
                </div>
            </div>
        <%
                }
            }
        %>
        </div>
    </div>

</body>
</html>