/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gestionvente.controller;

import com.gestionvente.dao.ClientDAO;
import com.gestionvente.dao.ProduitDAO;
import com.gestionvente.dao.VenteDAO;
import com.gestionvente.model.Client;
import com.gestionvente.model.Produit;
import com.gestionvente.model.Vente;
import com.gestionvente.util.PDFGenerator;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author USER
 */
public class VenteServlet extends HttpServlet {

    private VenteDAO venteDAO;
    private ClientDAO clientDAO;
    private ProduitDAO produitDAO;

    @Override
    public void init() {
        venteDAO = new VenteDAO();
        clientDAO = new ClientDAO();
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
            case "recu":
                generateRecu(request, response);
                break;
            default:
                listVentes(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("insert".equals(action)) {
            insertVente(request, response);
        }
    }

    private void listVentes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("ventes", venteDAO.getAllVentes());
        request.getRequestDispatcher("/views/vente/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("clients", clientDAO.getAllClients());
        request.setAttribute("produits", produitDAO.getAllProduits());
        //   Produit produit = produitDAO.getProduitById(produitId);
        //  request.setAttribute("stockProduit", produit.getStock());
        request.getRequestDispatcher("/views/vente/form.jsp").forward(request, response);
    }

    private void insertVente(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            Vente vente = new Vente();

            // client
            int clientId = Integer.parseInt(request.getParameter("client_id"));
            Client client = clientDAO.getClientById(clientId);
            vente.setClient(client);

            // produits et quantites
            String[] produitIds = request.getParameterValues("produit_id");
            String[] quantites = request.getParameterValues("quantite");

            List<Produit> produits = new ArrayList<>();
            List<Integer> quantitesList = new ArrayList<>();
            BigDecimal total = BigDecimal.ZERO;

            for (int i = 0; i < produitIds.length; i++) {
                int produitId = Integer.parseInt(produitIds[i]);
                int quantite = Integer.parseInt(quantites[i]);

                Produit produit = produitDAO.getProduitById(produitId);
                produits.add(produit);
                quantitesList.add(quantite);

                BigDecimal sousTotal = produit.getPrix().multiply(new BigDecimal(quantite));
                total = total.add(sousTotal);
            }

            vente.setProduits(produits);
            vente.setQuantites(quantitesList);
            vente.setTotal(total);

            boolean success = venteDAO.enregistrerVente(vente);

            if (success) {
                request.setAttribute("vente", vente);
                request.getRequestDispatcher("/views/vente/recu.jsp").forward(request, response);
            } else {
                response.sendRedirect("vente?action=new&error=1");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("vente?action=new&error=1");
        }
    }

    private void generateRecu(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int venteId = Integer.parseInt(request.getParameter("id"));
        Vente vente = venteDAO.getVenteByID(venteId);
        List<Integer> quantites = vente.getQuantites();
        System.out.println("quantites ======== ! " + quantites);

        System.out.println("vente pdfff ::: " + vente.getProduits());
        Client client = vente.getClient();

        // generation PDF
        PDFGenerator.generateRecu(vente, client, response);
    }
}
