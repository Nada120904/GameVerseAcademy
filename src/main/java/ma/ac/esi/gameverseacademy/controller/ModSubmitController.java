package ma.ac.esi.gameverseacademy.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import ma.ac.esi.gameverseacademy.model.mod;
import ma.ac.esi.gameverseacademy.service.ModService;
import java.io.IOException;

@WebServlet("/ModSubmitController")
public class ModSubmitController extends HttpServlet {

    private ModService modService = new ModService();

    // Affiche le formulaire
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Vérification session
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/views/submitMod.jsp")
               .forward(request, response);
    }

    // Traite la soumission
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Vérifier que l'utilisateur est connecté
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.html");
            return;
        }

        // 2. Récupérer les paramètres du formulaire
        String title       = request.getParameter("title");
        String category    = request.getParameter("category");
        String author      = request.getParameter("author");
        String description = request.getParameter("description");

        // 3. Construire l'objet Mod
        mod mod = new mod();
        mod.setTitle(title);
        mod.setCategory(category);
        mod.setAuthor(author);
        mod.setDescription(description);

        // 4. Appeler le service
        boolean success = modService.submitMod(mod);

        // 5. Transmettre le résultat à la JSP
        if (success) {
            request.setAttribute("message", "Votre mod a été soumis avec succès !");
        } else {
            request.setAttribute("error", "Erreur lors de la soumission. Vérifiez les champs.");
        }

        request.getRequestDispatcher("/WEB-INF/views/submitMod.jsp")
               .forward(request, response);
    }
}