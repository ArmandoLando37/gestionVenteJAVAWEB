/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gestionvente.dao;

import com.gestionvente.model.Client;
import com.gestionvente.model.Produit;
import com.gestionvente.model.Vente;
import com.gestionvente.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author USER
 */
public class VenteDAO {

    public boolean enregistrerVente(Vente vente) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);

            // insertion de la vente
            String sqlVente = "INSERT INTO ventes (client_id, date_vente, total) VALUES (?, NOW(), ?)";
            PreparedStatement stmtVente = conn.prepareStatement(sqlVente, Statement.RETURN_GENERATED_KEYS);
            stmtVente.setInt(1, vente.getClient().getId());
            stmtVente.setBigDecimal(2, vente.getTotal());
            stmtVente.executeUpdate();

            // recuperation de l'ID de la vente
            ResultSet valiny = stmtVente.getGeneratedKeys();
            int venteId = 0;
            if (valiny.next()) {
                venteId = valiny.getInt(1);
            }

            // verification du stock avant insertion
            for (int i = 0; i < vente.getProduits().size(); i++) {
                Produit produit = vente.getProduits().get(i);
                int quantite = vente.getQuantites().get(i);

                if (quantite > produit.getStock()) {
                    throw new SQLException("Stock insuffisant pour: " + produit.getNom());
                }
            }

            // insertion des ligne de vente
            String sqlLigne = "INSERT INTO ligne_vente (vente_id, produit_id, quantite, prix_unitaire) VALUES (?, ?, ?, ?)";
            PreparedStatement stmtLigne = conn.prepareStatement(sqlLigne);

            for (int i = 0; i < vente.getProduits().size(); i++) {
                Produit produit = vente.getProduits().get(i);
                int quantite = vente.getQuantites().get(i);

                stmtLigne.setInt(1, venteId);
                stmtLigne.setInt(2, produit.getId());
                stmtLigne.setInt(3, quantite);
                stmtLigne.setBigDecimal(4, produit.getPrix());
                stmtLigne.addBatch();

                // MAJ du stock
                updateStock(conn, produit.getId(), quantite);
            }

            stmtLigne.executeBatch();
            conn.commit();
            return true;

        } catch (SQLException e) {
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private void updateStock(Connection conn, int produitId, int quantite) throws SQLException {
        String sql = "UPDATE produits SET stock = stock - ? WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, quantite);
        stmt.setInt(2, produitId);
        stmt.executeUpdate();
    }

    public List<Vente> getAllVentes() {
        List<Vente> ventes = new ArrayList<>();
        String sql = "SELECT v.*, c.nom, c.prenom, c.email FROM ventes v "
                + "JOIN clients c ON v.client_id = c.id "
                + "ORDER BY v.date_vente DESC";

        try (Connection conn = DatabaseConnection.getConnection(); Statement stmt = conn.createStatement(); ResultSet valiny = stmt.executeQuery(sql)) {

            while (valiny.next()) {
                Vente vente = new Vente();
                vente.setId(valiny.getInt("id"));

                Client client = new Client();
                client.setId(valiny.getInt("client_id"));
                client.setNom(valiny.getString("nom"));
                client.setPrenom(valiny.getString("prenom"));
                client.setEmail(valiny.getString("email"));
                vente.setClient(client);

                vente.setDateVente(valiny.getTimestamp("date_vente"));
                vente.setTotal(valiny.getBigDecimal("total"));
                ventes.add(vente);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ventes;
    }

    /**
     * recupere une vente avec tous se detail (client + produits + quantites)
     */
    public Vente getVenteByID(int id) {
        Vente vente = null;

        // requete pour recuperer la vente et le client
        String sqlVente = "SELECT v.*, c.nom, c.prenom, c.email, c.telephone, c.adresse "
                + "FROM ventes v "
                + "JOIN clients c ON v.client_id = c.id "
                + "WHERE v.id = ?";

        try (Connection conn = DatabaseConnection.getConnection()) {

            // 1) recuperer les information de la vente et du client
            PreparedStatement stmtVente = conn.prepareStatement(sqlVente);
            stmtVente.setInt(1, id);
            ResultSet rsVente = stmtVente.executeQuery();

            if (rsVente.next()) {
                vente = new Vente();
                vente.setId(rsVente.getInt("id"));
                vente.setDateVente(rsVente.getTimestamp("date_vente"));
                vente.setTotal(rsVente.getBigDecimal("total"));

                // creer le client
                Client client = new Client();
                client.setId(rsVente.getInt("client_id"));
                client.setNom(rsVente.getString("nom"));
                client.setPrenom(rsVente.getString("prenom"));
                client.setEmail(rsVente.getString("email"));
                client.setTelephone(rsVente.getString("telephone"));
                client.setAdresse(rsVente.getString("adresse"));
                vente.setClient(client);

                // 2. recuperer les ligne de vente (produit et quantite)
                String sqlLignes = "SELECT lv.*, p.nom, p.description, p.prix "
                        + "FROM ligne_vente lv "
                        + "JOIN produits p ON lv.produit_id = p.id "
                        + "WHERE lv.vente_id = ? "
                        + "ORDER BY lv.id";

                PreparedStatement stmtLignes = conn.prepareStatement(sqlLignes);
                stmtLignes.setInt(1, id);
                ResultSet rsLignes = stmtLignes.executeQuery();

                List<Produit> produits = new ArrayList<>();
                List<Integer> quantites = new ArrayList<>();

                while (rsLignes.next()) {
                    // creer le produit
                    Produit produit = new Produit();
                    produit.setId(rsLignes.getInt("produit_id"));
                    produit.setNom(rsLignes.getString("nom"));
                    produit.setDescription(rsLignes.getString("description"));
                    produit.setPrix(rsLignes.getBigDecimal("prix_unitaire")); // Prix au moment de la vente

                    produits.add(produit);
                    quantites.add(rsLignes.getInt("quantite"));
                }

                // assigner les produit et quantite a la vente
                vente.setProduits(produits);
                vente.setQuantites(quantites);

                rsLignes.close();
                stmtLignes.close();
            }

            rsVente.close();
            stmtVente.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return vente;
    }

    /**
     * Recupere toutes les quantites (peut-etre pas necessaire)
     */
    public List<Integer> getAllQuantite() {
        List<Integer> quantites = new ArrayList<>();
        String sql = "SELECT quantite FROM ligne_vente ORDER BY id DESC";

        try (Connection conn = DatabaseConnection.getConnection(); Statement stmt = conn.createStatement(); ResultSet valiny = stmt.executeQuery(sql)) {

            while (valiny.next()) {
                quantites.add(valiny.getInt("quantite"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return quantites;
    }

    /**
     * MeTHODE BONUS : Recupere les lignes de vente pour une vente specifique
     */
    public List<Produit> getProduitsVente(int venteId) {
        List<Produit> produits = new ArrayList<>();
        String sql = "SELECT p.*, lv.quantite, lv.prix_unitaire "
                + "FROM ligne_vente lv "
                + "JOIN produits p ON lv.produit_id = p.id "
                + "WHERE lv.vente_id = ?";

        try (Connection conn = DatabaseConnection.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, venteId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Produit produit = new Produit();
                produit.setId(rs.getInt("id"));
                produit.setNom(rs.getString("nom"));
                produit.setDescription(rs.getString("description"));
                produit.setPrix(rs.getBigDecimal("prix_unitaire"));
                produit.setStock(rs.getInt("stock"));

                produits.add(produit);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return produits;
    }

    /**
     * MeTHODE BONUS : Recupere les quantites pour une vente specifique
     */
    public List<Integer> getQuantitesVente(int venteId) {
        List<Integer> quantites = new ArrayList<>();
        String sql = "SELECT quantite FROM ligne_vente WHERE vente_id = ? ORDER BY id";

        try (Connection conn = DatabaseConnection.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, venteId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                quantites.add(rs.getInt("quantite"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return quantites;
    }
}
