/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gestionvente.model;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author USER
 */
public class Vente {

    private int id;
    private Client client;
    private Date dateVente;
    private BigDecimal total;
    private List<Produit> produits;
    private List<Integer> quantites;

    // constructeur
    public Vente() {
        this.produits = new ArrayList<>();
        this.quantites = new ArrayList<>();
        this.total = BigDecimal.ZERO;
    }

    public Vente(Client client, List<Produit> produits, List<Integer> quantites) {
        this.client = client;
        this.produits = produits;
        this.quantites = quantites;
        this.dateVente = new Date();
        calculerTotal();
    }

    // Getters et Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public Date getDateVente() {
        return dateVente;
    }

    public void setDateVente(Date dateVente) {
        this.dateVente = dateVente;
    }

    public BigDecimal getTotal() {
        return total;
    }

    public void setTotal(BigDecimal total) {
        this.total = total;
    }

    public List<Produit> getProduits() {
        return produits;
    }

    public void setProduits(List<Produit> produits) {
        this.produits = produits;
    }

    public List<Integer> getQuantites() {
        return quantites;
    }

    public void setQuantites(List<Integer> quantites) {
        this.quantites = quantites;
    }

    // methodes utilitaire
    public void ajouterProduit(Produit produit, int quantite) {
        this.produits.add(produit);
        this.quantites.add(quantite);
        calculerTotal();
    }

    public void calculerTotal() {
        this.total = BigDecimal.ZERO;
        for (int i = 0; i < produits.size(); i++) {
            BigDecimal prix = produits.get(i).getPrix();
            int quantite = quantites.get(i);
            this.total = this.total.add(prix.multiply(new BigDecimal(quantite)));
        }
    }

}
