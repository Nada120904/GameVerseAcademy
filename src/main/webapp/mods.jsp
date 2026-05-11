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

        /* ── NAVBAR ─────────────────────────────────────── */
        .navbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: #1a1a2e;
            padding: 12px 24px;
            border-bottom: 1px solid #2a2a4a;
        }
        .nav-left { display: flex; gap: 10px; }
        .nav-btn {
            padding: 8px 18px;
            border-radius: 20px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
        }

        /* ── BOUTONS NAVBAR ──────────────────────────────── */
        .btn-nouveau   { background: #4A90D9; color: white; }
        .btn-tendances { background: transparent; color: #aaa; border: 1px solid #333; }
        .btn-populaire { background: transparent; color: #aaa; border: 1px solid #333; }
        .btn-players   { background: #8e44ad; color: white; }
        .btn-soumettre { background: #27ae60; color: white; }
        .btn-accueil   { background: #8e44ad; color: white; }

        /* ── BARRE DE RECHERCHE ──────────────────────────── */
        .search-box {
            background: #2a2a4a;
            border: 1px solid #3a3a6a;
            border-radius: 20px;
            padding: 8px 16px;
            color: #aaa;
            font-size: 14px;
            width: 220px;
        }

        /* ── GRILLE DE CARTES ────────────────────────────── */
        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }
        .cards-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }

        /* ── CARTE ───────────────────────────────────────── */
        .card {
            background: #1a1a2e;
            border-radius: 10px;
            overflow: hidden;
            border: 1px solid #2a2a4a;
        }
        .card-img {
            width: 100%;
            height: 180px;
            background: linear-gradient(135deg, #2a2a4a, #3a3a6a);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
        }
        .card-body { padding: 14px; }
        .card-category {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
            margin-bottom: 8px;
            background: #2a6496;
            color: white;
        }
        .card-title { font-size: 16px; font-weight: bold; margin-bottom: 8px; }
        .card-author {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 13px;
            color: #aaa;
            margin-bottom: 6px;
        }
        .author-avatar {
            width: 22px;
            height: 22px;
            border-radius: 50%;
            background: #4A90D9;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
            font-weight: bold;
            color: white;
        }
        .card-info { font-size: 12px; color: #888; margin-bottom: 6px; }
        .card-description {
            font-size: 13px;
            color: #bbb;
            margin-bottom: 12px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .card-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid #2a2a4a;
            padding-top: 10px;
            margin-top: 6px;
        }
        .downloads { font-size: 13px; color: #aaa; }
        .metacritic {
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 13px;
            font-weight: bold;
            color: white;
        }

        /* ── COULEURS METACRITIC ─────────────────────────── */
        .mc-green  { background: #4CAF50; }
        .mc-orange { background: #FF9800; }
        .mc-red    { background: #F44336; }
    </style>
</head>
<body>

    <%-- ══════════════════════════════════════════════════ --%>
    <%-- NAVBAR                                            --%>
    <%-- ══════════════════════════════════════════════════ --%>
    <div class="navbar">
        <div class="nav-left">

            <%-- Bouton Nouveau : recharge la liste complète --%>
            <button class="nav-btn btn-nouveau"
                onclick="window.location.href='<%= request.getContextPath() %>/mods'">
                ⭐ Nouveau
            </button>

            <%-- Boutons décoratifs (non fonctionnels) --%>
            <button class="nav-btn btn-tendances">🔥 Tendances</button>
            <button class="nav-btn btn-populaire">⭐ Populaire</button>

            <%-- Bouton vers la liste des joueurs --%>
            <button class="nav-btn btn-players"
                onclick="window.location.href='<%= request.getContextPath() %>/players?action=list'">
                🎮 Joueurs
            </button>

            <%-- Bouton vers le formulaire de soumission de mod --%>
            <button class="nav-btn btn-soumettre"
                onclick="window.location.href='<%= request.getContextPath() %>/ModSubmitController'">
                ➕ Soumettre un mod
            </button>

            <%-- Bouton retour à l'accueil --%>
            <button class="nav-btn btn-accueil"
                onclick="window.location.href='<%= request.getContextPath() %>/index.html'">
                🏠 Accueil
            </button>

            <%-- Affichage de l'utilisateur connecté + bouton déconnexion --%>
            <div style="display:flex; align-items:center; gap:10px; margin-left:20px;">
                <span style="color:#4A90D9; font-weight:bold;">
                    <%-- Récupère le login depuis la session --%>
                    👤 <%= session.getAttribute("user") != null
                        ? session.getAttribute("user") : "Visiteur" %>
                </span>
                <%-- Formulaire POST pour invalider la session --%>
                <form action="<%= request.getContextPath() %>/LogoutController"
                      method="post" style="margin:0;">
                    <button type="submit" class="nav-btn"
                        style="background:#e74c3c; color:white;">
                        🚪 Déconnexion
                    </button>
                </form>
            </div>

        </div>

        <%-- Barre de recherche en temps réel --%>
        <input class="search-box" type="text" id="searchInput"
               placeholder="🔍 Rechercher..."
               onkeyup="searchMods()">
    </div>

    <%-- ══════════════════════════════════════════════════ --%>
    <%-- STATISTIQUES                                      --%>
    <%-- Affiche le total des mods, joueurs et downloads   --%>
    <%-- ══════════════════════════════════════════════════ --%>
    <div style="max-width:1200px; margin:20px auto; padding:0 20px; display:flex; gap:20px;">

        <%-- Carte statistique : Total Mods --%>
        <div style="flex:1; background:#1a1a2e; border-radius:10px;
                    padding:20px; text-align:center; border:1px solid #4A90D9;">
            <div style="font-size:36px; font-weight:bold; color:#4A90D9;">
                <%= request.getAttribute("totalMods") %>
            </div>
            <div style="color:#aaa; margin-top:8px;">🎮 Mods disponibles</div>
        </div>

        <%-- Carte statistique : Total Joueurs --%>
        <div style="flex:1; background:#1a1a2e; border-radius:10px;
                    padding:20px; text-align:center; border:1px solid #27ae60;">
            <div style="font-size:36px; font-weight:bold; color:#27ae60;">
                <%= request.getAttribute("totalPlayers") %>
            </div>
            <div style="color:#aaa; margin-top:8px;">👤 Joueurs inscrits</div>
        </div>

        <%-- Carte statistique : Total Téléchargements --%>
        <div style="flex:1; background:#1a1a2e; border-radius:10px;
                    padding:20px; text-align:center; border:1px solid #e74c3c;">
            <div style="font-size:36px; font-weight:bold; color:#e74c3c;">
                <%= request.getAttribute("totalDownloads") %>
            </div>
            <div style="color:#aaa; margin-top:8px;">⬇️ Téléchargements totaux</div>
        </div>

    </div>

    <%-- ══════════════════════════════════════════════════ --%>
    <%-- GRILLE DE CARTES                                  --%>
    <%-- Affiche dynamiquement chaque mod depuis la BDD    --%>
    <%-- ══════════════════════════════════════════════════ --%>
    <div class="container">
        <div class="cards-grid">

            <%-- Message affiché si aucun mod ne correspond à la recherche --%>
            <div id="noResult" style="display:none; color:#4A90D9;
                 font-size:18px; text-align:center; margin-top:40px; grid-column:1/-1;">
                🔍 Aucun mod trouvé pour cette recherche.
            </div>

            <%
                // Récupération de la liste des mods depuis les attributs de la requête
                List<mod> mods = (List<mod>) request.getAttribute("mods");
                if (mods != null) {
                    for (mod mod : mods) {

                        // Détermination de la couleur du score Metacritic
                        String mcClass = "mc-green";
                        if (mod.getMetacritic() < 60) mcClass = "mc-red";
                        else if (mod.getMetacritic() < 75) mcClass = "mc-orange";

                        // Initiale de l'auteur pour l'avatar
                        String initiale = mod.getAuthor() != null && !mod.getAuthor().isEmpty()
                            ? String.valueOf(mod.getAuthor().charAt(0)).toUpperCase() : "?";
            %>
                <div class="card">
                    <%-- Image placeholder du mod --%>
                    <div class="card-img">🎮</div>

                    <div class="card-body">
                        <%-- Catégorie du mod --%>
                        <span class="card-category"><%= mod.getCategory() %></span>

                        <%-- Titre du mod --%>
                        <div class="card-title"><%= mod.getTitle() %></div>

                        <%-- Auteur avec avatar initiale --%>
                        <div class="card-author">
                            <div class="author-avatar"><%= initiale %></div>
                            <%= mod.getAuthor() %>
                        </div>

                        <%-- Date et plateforme (si disponibles) --%>
                        <% if (mod.getReleaseDate() != null) { %>
                        <div class="card-info">
                            📅 <%= mod.getReleaseDate() %>
                            <% if (mod.getPlatform() != null) { %>
                                🖥 <%= mod.getPlatform() %>
                            <% } %>
                        </div>
                        <% } %>

                        <%-- Description du mod --%>
                        <div class="card-description"><%= mod.getDescription() %></div>

                        <%-- Pied de carte : téléchargements + score Metacritic --%>
                        <div class="card-footer">
                            <span class="downloads">↓ <%= mod.getDownloads() %></span>
                            <span class="metacritic <%= mcClass %>">MC <%= mod.getMetacritic() %></span>
                        </div>
                    </div>
                </div>

            <%
                    } // fin boucle for
                }     // fin if mods != null
            %>
        </div>
    </div>

    <%-- ══════════════════════════════════════════════════ --%>
    <%-- JAVASCRIPT : Recherche en temps réel              --%>
    <%-- Filtre les cartes selon le texte saisi            --%>
    <%-- ══════════════════════════════════════════════════ --%>
    <script>
        function searchMods() {
            const input = document.getElementById("searchInput").value.toLowerCase();
            const cards = document.querySelectorAll(".card");

            cards.forEach(card => {
                // Lecture du titre, catégorie et auteur de chaque carte
                const title    = card.querySelector(".card-title").textContent.toLowerCase();
                const category = card.querySelector(".card-category").textContent.toLowerCase();
                const author   = card.querySelector(".card-author").textContent.toLowerCase();

                // Affiche ou masque la carte selon la correspondance
                if (title.includes(input) || category.includes(input) || author.includes(input)) {
                    card.style.display = "block";
                } else {
                    card.style.display = "none";
                }
            });

            // Affiche un message si aucune carte n'est visible
            const visibleCards = document.querySelectorAll(".card[style='display: block;']");
            const noResult = document.getElementById("noResult");
            if (visibleCards.length === 0) {
                noResult.style.display = "block";
            } else {
                noResult.style.display = "none";
            }
        }
    </script>

</body>
</html>