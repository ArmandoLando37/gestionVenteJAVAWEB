/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gestionvente.controller;

import com.gestionvente.dao.ProduitDAO;
import com.gestionvente.model.Produit;
import java.io.IOException;
import java.math.BigDecimal;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author USER
 */
public class ProduitServlet extends HttpServlet {

    private ProduitDAO produitDAO;

    @Override
    public void init() {
        produitDAO = new ProduitDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "new":
                showNewForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteProduit(request, response);
                break;
            default:
                listProduits(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("insert".equals(action)) {
            insertProduit(request, response);
        } else if ("update".equals(action)) {
            updateProduit(request, response);
        }
    }

    private void listProduits(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("produits", produitDAO.getAllProduits());
        request.getRequestDispatcher("/views/produit/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/produit/form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Produit produit = produitDAO.getProduitById(id);
        request.setAttribute("produit", produit);
        request.getRequestDispatcher("/views/produit/form.jsp").forward(request, response);
    }

    private void insertProduit(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Produit produit = new Produit();
        produit.setNom(request.getParameter("nom"));
        produit.setDescription(request.getParameter("description"));
        produit.setPrix(new BigDecimal(request.getParameter("prix")));
        produit.setStock(Integer.parseInt(request.getParameter("stock")));

        produitDAO.ajouterProduit(produit);
        response.sendRedirect("produit?action=list");
    }

    private void updateProduit(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Produit produit = new Produit();
        produit.setId(Integer.parseInt(request.getParameter("id")));
        produit.setNom(request.getParameter("nom"));
        produit.setDescription(request.getParameter("description"));
        produit.setPrix(new BigDecimal(request.getParameter("prix")));
        produit.setStock(Integer.parseInt(request.getParameter("stock")));

        produitDAO.modifierProduit(produit);
        response.sendRedirect("produit?action=list");
    }

    private void deleteProduit(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        produitDAO.supprimerProduit(id);
        response.sendRedirect("produit?action=list");
    }
}
