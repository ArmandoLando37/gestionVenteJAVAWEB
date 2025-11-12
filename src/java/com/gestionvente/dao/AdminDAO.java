/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gestionvente.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import com.gestionvente.model.Admin;
import com.gestionvente.util.DatabaseConnection;

/**
 *
 * @author USER
 */
public class AdminDAO {

    public Admin authentier(String username, String password) {
        String sql = "SELECT * FROM admin WHERE username = ? AND password = ?";
        Admin admin = null;

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                admin = new Admin();
                admin.setId(rs.getInt("id"));
                admin.setUsername(rs.getString("username"));
                admin.setEmail(rs.getString("email"));
                admin.setNomComplet(rs.getString("nom_complet"));
                admin.setDateCreation(rs.getTimestamp("date_creation"));

            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return admin;
    }

    public boolean changePassword(int adminId, String newPassword) {
        String sql = "UPDATE admin SET password = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newPassword);
            stmt.setInt(2, adminId);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
