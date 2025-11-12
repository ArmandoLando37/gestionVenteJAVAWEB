/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gestionvente.dao;

import com.gestionvente.model.Produit;
import com.gestionvente.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author USER
 */
public class ProduitDAO {

    public boolean ajouterProduit(Produit produit) {
        String sql = "INSERT INTO produits (nom, description, prix, stock) VALUES (?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, produit.getNom());
            stmt.setString(2, produit.getDescription());
            stmt.setBigDecimal(3, produit.getPrix());
            stmt.setInt(4, produit.getStock());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Produit> getAllProduits() {
        List<Produit> produits = new ArrayList<>();
        String sql = "SELECT * FROM produits ORDER BY id DESC";

        try (Connection conn = DatabaseConnection.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Produit produit = new Produit();
                produit.setId(rs.getInt("id"));
                produit.setNom(rs.getString("nom"));
                produit.setDescription(rs.getString("description"));
                produit.setPrix(rs.getBigDecimal("prix"));
                produit.setStock(rs.getInt("stock"));
                produits.add(produit);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return produits;
    }

    public List<Produit> totalProduitENRupture() {
        List<Produit> produits = new ArrayList<>();
        String sql = "SELECT * FROM produits WHERE stock=0 ORDER BY id DESC";

        try (Connection conn = DatabaseConnection.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Produit produit = new Produit();
                produit.setId(rs.getInt("id"));
                produit.setNom(rs.getString("nom"));
                produit.setDescription(rs.getString("description"));
                produit.setPrix(rs.getBigDecimal("prix"));
                produit.setStock(rs.getInt("stock"));
                produits.add(produit);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return produits;
    }

    public Produit getProduitById(int id) {
        String sql = "SELECT * FROM produits WHERE id = ?";
        Produit produit = null;

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                produit = new Produit();
                produit.setId(rs.getInt("id"));
                produit.setNom(rs.getString("nom"));
                produit.setDescription(rs.getString("description"));
                produit.setPrix(rs.getBigDecimal("prix"));
                produit.setStock(rs.getInt("stock"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return produit;
    }

    public boolean modifierProduit(Produit produit) {
        String sql = "UPDATE produits SET nom=?, description=?, prix=?, stock=? WHERE id=?";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, produit.getNom());
            stmt.setString(2, produit.getDescription());
            stmt.setBigDecimal(3, produit.getPrix());
            stmt.setInt(4, produit.getStock());
            stmt.setInt(5, produit.getId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean supprimerProduit(int id) {
        String sql = "DELETE FROM produits WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
