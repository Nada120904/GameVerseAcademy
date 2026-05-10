package ma.ac.esi.gameverseacademy.controller;

import ma.ac.esi.gameverseacademy.model.mod;

import ma.ac.esi.gameverseacademy.service.ModService;
import javax.servlet.ServletException;           // ligne 5
import javax.servlet.annotation.WebServlet;      // ligne 6
import javax.servlet.http.HttpServlet;           // ligne 7
import javax.servlet.http.HttpServletRequest;    // ligne 8
import javax.servlet.http.HttpServletResponse;   // ligne 9
import java.io.IOException;
import java.util.List;
import javax.servlet.http.HttpSession;

@WebServlet("/mods")
public class ModController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	//  Vérification de session
        HttpSession session = request.getSession(false);//On veut vérifier si une session existe, pas en créer une. getSession(false) retourne null si pas de session → on redirige vers login. getSession() aurait créé une session vide inutilement.
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;  //La servlet continue d'exécuter le code après le redirect ! Elle essaierait d'accéder aux mods alors que l'utilisateur est déjà redirigé → erreur IllegalStateException car on ne peut pas écrire deux réponses.
        }
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

        request.setAttribute("mods", mods);
        request.setAttribute("category", category);

        request.getRequestDispatcher("/mods.jsp").forward(request, response);
    }
}