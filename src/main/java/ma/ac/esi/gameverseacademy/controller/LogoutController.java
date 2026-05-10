package ma.ac.esi.gameverseacademy.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/LogoutController")
public class LogoutController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Récupérer la session sans en créer une nouvelle
        HttpSession session = request.getSession(false);

        // Invalider la session si elle existe
        if (session != null) {
            session.invalidate();
        }

        // Rediriger vers la page de connexion
        response.sendRedirect(request.getContextPath() + "/index.html");
    }
}