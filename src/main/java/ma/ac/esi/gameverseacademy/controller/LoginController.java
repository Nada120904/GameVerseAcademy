package ma.ac.esi.gameverseacademy.controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import ma.ac.esi.gameverseacademy.service.UserService;

@WebServlet("/LoginController")
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String login    = request.getParameter("email");
        String password = request.getParameter("password");

        UserService userService = new UserService();

        if (userService.authenticateUser(login, password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", login);
            response.sendRedirect(request.getContextPath() + "/mods");
        } else {
            // Affiche les valeurs reçues pour déboguer
            System.out.println("LOGIN RECU: " + login);
            System.out.println("PASSWORD RECU: " + password);
            System.out.println("AUTH RESULT: false");
            response.sendRedirect(request.getContextPath() + "/error.html");
        }
    }
}