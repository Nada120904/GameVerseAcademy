package ma.ac.esi.gameverseacademy.controller;

import ma.ac.esi.gameverseacademy.model.mod;
import ma.ac.esi.gameverseacademy.model.Player;
import ma.ac.esi.gameverseacademy.service.ModService;
import ma.ac.esi.gameverseacademy.service.PlayerService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/mods")
public class ModController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérification de session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        // Anti-cache
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        ModService modService = new ModService();
        String category = request.getParameter("category");
        List<mod> mods;

        if (category != null && !category.trim().isEmpty()) {
            mods = modService.getModsByCategory(category);
        } else {
            mods = modService.getAllMods();
        }

        // ── Statistiques ──────────────────────────────────
        // Total mods
        request.setAttribute("totalMods", mods.size());

        // Total joueurs
        PlayerService playerService = new PlayerService();
        List<Player> players = playerService.getAllPlayers();
        request.setAttribute("totalPlayers", players.size());

        // Total téléchargements
        int totalDownloads = 0;
        for (mod m : mods) {
            totalDownloads += m.getDownloads();
        }
        request.setAttribute("totalDownloads", totalDownloads);

        request.setAttribute("mods", mods);
        request.setAttribute("category", category);
        request.getRequestDispatcher("/mods.jsp").forward(request, response);
    }
}