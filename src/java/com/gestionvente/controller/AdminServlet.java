/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gestionvente.controller;

import com.gestionvente.dao.AdminDAO;
import com.gestionvente.dao.ClientDAO;
import com.gestionvente.dao.ProduitDAO;
import com.gestionvente.dao.VenteDAO;
import com.gestionvente.model.Admin;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author USER
 */
public class AdminServlet extends HttpServlet {

    private ClientDAO clientDAO;
    private ProduitDAO produitDAO;
    private VenteDAO venteDAO;
    private AdminDAO adminDAO;

    @Override
    public void init() {
        clientDAO = new ClientDAO();
        produitDAO = new ProduitDAO();
        venteDAO = new VenteDAO();
        adminDAO = new AdminDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if (action == null) {
            showDashboard(request, response);
        } else if ("profile".equals(action)) {
            showProfile(request, response);
        } else if ("change-password".equals(action)) {
            showChangePasswordForm(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("admin") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");

        if ("change-password".equals(action)) {
            changePassword(request, response);
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // recuperer les statistiques
        int totalClients = clientDAO.getAllClients().size();
        int totalProduits = produitDAO.getAllProduits().size();
        int totalProduitENRupture = produitDAO.totalProduitENRupture().size();
        int totalVentes = venteDAO.getAllVentes().size();

        request.setAttribute("totalClients", totalClients);
        request.setAttribute("totalProduits", totalProduits);
        request.setAttribute("totalProduitENRupture", totalProduitENRupture);
        request.setAttribute("totalVentes", totalVentes);

        request.getRequestDispatcher("/views/admin/dashboard.jsp").forward(request, response);
    }

    private void showProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/profile.jsp").forward(request, response);
    }

    private void showChangePasswordForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/admin/change-password.jsp").forward(request, response);
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Admin admin = (Admin) session.getAttribute("admin");

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // verifier  mdp actuel
        AdminDAO adminDAO = new AdminDAO();
        Admin verifiedAdmin = adminDAO.authentier(admin.getUsername(), currentPassword);

        if (verifiedAdmin == null) {
            request.setAttribute("error", "Mot de passe actuel incorrect");
            request.getRequestDispatcher("/views/admin/change-password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Les nouveaux mots de passe ne correspondent pas");
            request.getRequestDispatcher("/views/admin/change-password.jsp").forward(request, response);
            return;
        }

        if (newPassword.length() < 6) {
            request.setAttribute("error", "Le mot de passe doit contenir au moins 6 caractères");
            request.getRequestDispatcher("/views/admin/change-password.jsp").forward(request, response);
            return;
        }

        // changer  mdp
        boolean succes = adminDAO.changePassword(admin.getId(), newPassword);

        if (succes) {
            request.setAttribute("succes", "Mot de passe change avec succès");
        } else {
            request.setAttribute("error", "Erreur lors du changement de mot de passe");
        }

        request.getRequestDispatcher("/views/admin/change-password.jsp").forward(request, response);
    }
}
