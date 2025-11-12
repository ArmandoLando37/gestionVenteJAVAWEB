/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.gestionvente.controller;

import com.gestionvente.dao.ClientDAO;
import com.gestionvente.model.Client;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author USER
 */
public class ClientServlet extends HttpServlet {

    private ClientDAO clientDAO;

    @Override
    public void init() {
        clientDAO = new ClientDAO();
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
                deleteClient(request, response);
                break;
            default:
                listClients(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("insert".equals(action)) {
            insertClient(request, response);
        } else if ("update".equals(action)) {
            updateClient(request, response);
        }
    }

    private void listClients(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("clients", clientDAO.getAllClients());
        request.getRequestDispatcher("/views/client/list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/client/form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Client client = clientDAO.getClientById(id);
        request.setAttribute("client", client);
        request.getRequestDispatcher("/views/client/form.jsp").forward(request, response);
    }

    private void insertClient(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Client client = new Client();
        client.setNom(request.getParameter("nom"));
        client.setPrenom(request.getParameter("prenom"));
        client.setEmail(request.getParameter("email"));
        client.setTelephone(request.getParameter("telephone"));
        client.setAdresse(request.getParameter("adresse"));

        clientDAO.ajouterClient(client);
        response.sendRedirect("client?action=list");
    }

    private void updateClient(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        Client client = new Client();
        client.setId(Integer.parseInt(request.getParameter("id")));
        client.setNom(request.getParameter("nom"));
        client.setPrenom(request.getParameter("prenom"));
        client.setEmail(request.getParameter("email"));
        client.setTelephone(request.getParameter("telephone"));
        client.setAdresse(request.getParameter("adresse"));

        clientDAO.modifierClient(client);
        response.sendRedirect("client?action=list");
    }

    private void deleteClient(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        clientDAO.supprimerClient(id);
        response.sendRedirect("client?action=list");
    }
}
