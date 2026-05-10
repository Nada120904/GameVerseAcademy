package ma.ac.esi.gameverseacademy.controller;

import ma.ac.esi.gameverseacademy.model.Player;
import ma.ac.esi.gameverseacademy.service.PlayerService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/players")
public class PlayerController extends HttpServlet {

    private PlayerService playerService = new PlayerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérification session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        // Anti-cache
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {

            // ── AFFICHER LISTE ────────────────────────────
            case "list":
                List<Player> players = playerService.getAllPlayers();
                request.setAttribute("players", players);
                request.getRequestDispatcher("/WEB-INF/views/players.jsp")
                       .forward(request, response);
                break;

            // ── FORMULAIRE AJOUT ──────────────────────────
            case "new":
                request.getRequestDispatcher("/WEB-INF/views/playerForm.jsp")
                       .forward(request, response);
                break;

            // ── FORMULAIRE MODIFICATION ───────────────────
            case "edit":
                int editId = Integer.parseInt(request.getParameter("id"));
                Player player = playerService.getPlayerById(editId);
                request.setAttribute("player", player);
                request.getRequestDispatcher("/WEB-INF/views/playerForm.jsp")
                       .forward(request, response);
                break;

            // ── SUPPRESSION ───────────────────────────────
            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                playerService.deletePlayer(deleteId);
                response.sendRedirect(request.getContextPath() + "/players?action=list");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérification session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        String action = request.getParameter("action");

        // Récupérer les paramètres du formulaire
        String username = request.getParameter("username");
        String email    = request.getParameter("email");
        int level       = Integer.parseInt(request.getParameter("level"));
        int score       = Integer.parseInt(request.getParameter("score"));

        Player player = new Player();
        player.setUsername(username);
        player.setEmail(email);
        player.setLevel(level);
        player.setScore(score);

        if ("new".equals(action)) {
            // ── AJOUTER ───────────────────────────────────
            playerService.addPlayer(player);
        } else if ("edit".equals(action)) {
            // ── MODIFIER ──────────────────────────────────
            int id = Integer.parseInt(request.getParameter("id"));
            player.setId(id);
            playerService.updatePlayer(player);
        }

        response.sendRedirect(request.getContextPath() + "/players?action=list");
    }
}