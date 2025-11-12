/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.gestionvente.util;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.gestionvente.model.Vente;
import com.gestionvente.model.Client;
import com.gestionvente.model.Produit;
import com.itextpdf.text.pdf.draw.LineSeparator;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 *
 * @author USER
 */
public class PDFGenerator {

    private static Font titleFont;
    private static Font subtitleFont;
    private static Font normalFont;
    private static Font boldFont;
    private static Font smallFont;
    private static Font largeFont;

    // couleur personnalisee
    private static final BaseColor PRIMARY_COLOR = new BaseColor(37, 99, 235); // Bleu
    private static final BaseColor SECONDARY_COLOR = new BaseColor(79, 70, 229); // Indigo
    private static final BaseColor SUCCESS_COLOR = new BaseColor(34, 197, 94); // Vert
    private static final BaseColor GRAY_DARK = new BaseColor(55, 65, 81);
    private static final BaseColor GRAY_LIGHT = new BaseColor(243, 244, 246);
    private static final BaseColor GRAY_MEDIUM = new BaseColor(156, 163, 175);

    static {
        try {
            BaseFont baseFont = BaseFont.createFont(
                    BaseFont.HELVETICA,
                    BaseFont.CP1252,
                    BaseFont.EMBEDDED
            );

            BaseFont boldBaseFont = BaseFont.createFont(
                    BaseFont.HELVETICA_BOLD,
                    BaseFont.CP1252,
                    BaseFont.EMBEDDED
            );

            titleFont = new Font(boldBaseFont, 24, Font.BOLD, PRIMARY_COLOR);
            subtitleFont = new Font(boldBaseFont, 14, Font.BOLD, GRAY_DARK);
            normalFont = new Font(baseFont, 10, Font.NORMAL, GRAY_DARK);
            boldFont = new Font(boldBaseFont, 10, Font.BOLD, GRAY_DARK);
            smallFont = new Font(baseFont, 8, Font.NORMAL, GRAY_MEDIUM);
            largeFont = new Font(boldBaseFont, 16, Font.BOLD, SUCCESS_COLOR);

        } catch (Exception e) {
            // fallback aux polices par defaut
            titleFont = new Font(Font.FontFamily.HELVETICA, 24, Font.BOLD, PRIMARY_COLOR);
            subtitleFont = new Font(Font.FontFamily.HELVETICA, 14, Font.BOLD, GRAY_DARK);
            normalFont = new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL, GRAY_DARK);
            boldFont = new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD, GRAY_DARK);
            smallFont = new Font(Font.FontFamily.HELVETICA, 8, Font.NORMAL, GRAY_MEDIUM);
            largeFont = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD, SUCCESS_COLOR);
        }
    }

    public static void generateRecu(Vente vente, Client client, HttpServletResponse response) {
        Document document = new Document(PageSize.A4, 40, 40, 50, 50);
        OutputStream out = null;

        try {
            out = response.getOutputStream();
            PdfWriter writer = PdfWriter.getInstance(document, out);

            // ajouter un evenement pour l'en-tete et le pied de page
            HeaderFooterPageEvent event = new HeaderFooterPageEvent();
            writer.setPageEvent(event);

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition",
                    "inline; filename=\"recu_vente_" + vente.getId() + ".pdf\"");

            document.open();
            addMetaData(document, vente);
            addHeader(document, vente);
            addDivider(document);
            addClientInfo(document, client);
            addDivider(document);
            addProductsTable(document, vente);

            addTotalSection(document, vente);
            addFooterContent(document);

        } catch (Exception e) {
            e.printStackTrace();
            throw new RuntimeException("Erreur lors de la generation du PDF", e);
        } finally {
            if (document != null && document.isOpen()) {
                document.close();
            }
            try {
                if (out != null) {
                    out.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private static void addMetaData(Document document, Vente vente) {
        document.addTitle("Reçu de vente #" + vente.getId());
        document.addSubject("Reçu de transaction");
        document.addKeywords("vente, reçu, facture, GestionVente");
        document.addAuthor("GestionVente");
        document.addCreator("GestionVente Application");
    }

    private static void addHeader(Document document, Vente vente) throws DocumentException {
        // creer une table pour l'en-tete ::(2 colonne)
        PdfPTable headerTable = new PdfPTable(2);
        headerTable.setWidthPercentage(100);
        headerTable.setWidths(new float[]{1.5f, 1f});
        headerTable.setSpacingAfter(20f);

        // colonne gauche - logo et niom
        PdfPCell leftCell = new PdfPCell();
        leftCell.setBorder(Rectangle.NO_BORDER);

        Paragraph nomDuSysteme = new Paragraph("TechStore", titleFont);
        nomDuSysteme.setSpacingAfter(5f);
        leftCell.addElement(nomDuSysteme);

        Paragraph companyInfo = new Paragraph();
        companyInfo.add(new Chunk("Systeme de Gestion des Ventes\n", normalFont));
        companyInfo.add(new Chunk("Antsirabe, Madagascar\n", smallFont));
        companyInfo.add(new Chunk("techstore@gmail.com", smallFont));
        leftCell.addElement(companyInfo);

        headerTable.addCell(leftCell);

        // colonne droite - information du recu
        PdfPCell colDroite = new PdfPCell();
        colDroite.setBorder(Rectangle.NO_BORDER);
        colDroite.setHorizontalAlignment(Element.ALIGN_RIGHT);

        // badge "REÇU"
        Paragraph recuBadge = new Paragraph("REÇU DE VENTE", subtitleFont);
        recuBadge.setAlignment(Element.ALIGN_RIGHT);
        recuBadge.setSpacingAfter(10f);
        colDroite.addElement(recuBadge);

        // numero de vente avec formatage
        Paragraph venteNum = new Paragraph();
        venteNum.setAlignment(Element.ALIGN_RIGHT);
        venteNum.add(new Chunk("N° ", normalFont));
        venteNum.add(new Chunk("V-00" + vente.getId() + "-80-25",
                new Font(boldFont.getBaseFont(), 12, Font.BOLD, PRIMARY_COLOR)));
        venteNum.setSpacingAfter(5f);
        colDroite.addElement(venteNum);

        // date formatee
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM yyyy");
        SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");

        Paragraph dateInfo = new Paragraph();
        dateInfo.setAlignment(Element.ALIGN_RIGHT);
        dateInfo.add(new Chunk("Date: ", boldFont));
        dateInfo.add(new Chunk(dateFormat.format(vente.getDateVente()) + "\n", normalFont));
        dateInfo.add(new Chunk("Heure: ", boldFont));
        dateInfo.add(new Chunk(timeFormat.format(vente.getDateVente()), normalFont));
        colDroite.addElement(dateInfo);

        headerTable.addCell(colDroite);

        document.add(headerTable);
    }

    private static void addDivider(Document document) throws DocumentException {
        LineSeparator separator = new LineSeparator();
        separator.setLineColor(GRAY_LIGHT);
        separator.setLineWidth(2f);
        document.add(new Chunk(separator));
        document.add(new Paragraph(" ")); // espace
    }

    private static void addClientInfo(Document document, Client client) throws DocumentException {
        // titre de la section
        Paragraph clientTitle = new Paragraph("INFORMATIONS CLIENT", subtitleFont);
        clientTitle.setSpacingAfter(15f);
        document.add(clientTitle);

        // creer une table pour les informations client
        PdfPTable clientTable = new PdfPTable(2);
        clientTable.setWidthPercentage(60);
        clientTable.setHorizontalAlignment(Element.ALIGN_LEFT);
        clientTable.setSpacingAfter(20f);

        // styles pour les partie
        PdfPCell labelCell, valueCell;

        // nom complet
        labelCell = createInfoCell("Nom complet :", true);
        valueCell = createInfoCell(client.getNom() + " " + client.getPrenom(), false);
        clientTable.addCell(labelCell);
        clientTable.addCell(valueCell);

        // ID client
        labelCell = createInfoCell("ID Client :", true);
        valueCell = createInfoCell("C-00" + client.getId() + "-80-25", false);
        clientTable.addCell(labelCell);
        clientTable.addCell(valueCell);

        // email (si disponible)
        if (client.getEmail() != null && !client.getEmail().isEmpty()) {
            labelCell = createInfoCell("Email:", true);
            valueCell = createInfoCell(client.getEmail(), false);
            clientTable.addCell(labelCell);
            clientTable.addCell(valueCell);
        }

        // telephone (si disponible)
        if (client.getTelephone() != null && !client.getTelephone().isEmpty()) {
            labelCell = createInfoCell("Telephone : ", true);
            valueCell = createInfoCell(client.getTelephone(), false);
            clientTable.addCell(labelCell);
            clientTable.addCell(valueCell);
        }

        // adresse (si disponible)
        if (client.getAdresse() != null && !client.getAdresse().isEmpty()) {
            labelCell = createInfoCell("Adresse : ", true);
            valueCell = createInfoCell(client.getAdresse(), false);
            clientTable.addCell(labelCell);
            clientTable.addCell(valueCell);
        }

        document.add(clientTable);
    }

    private static PdfPCell createInfoCell(String content, boolean isLabel) {
        PdfPCell cell = new PdfPCell();
        cell.setBorder(Rectangle.NO_BORDER);
        cell.setPadding(5f);

        if (isLabel) {
            cell.setPhrase(new Phrase(content, boldFont));
            cell.setBackgroundColor(GRAY_LIGHT);
        } else {
            cell.setPhrase(new Phrase(content, normalFont));
        }

        return cell;
    }

    private static void addProductsTable(Document document, Vente vente) throws DocumentException {
        // titre de la section
        System.out.println("addProductsTable");
        Paragraph productsTitle = new Paragraph("DETAILs DE LA VENTE", subtitleFont);
        productsTitle.setSpacingAfter(15f);
        document.add(productsTitle);

        // creer la table des produits
        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{1.5f, 2.5f, 1f, 1f, 1.5f});
        table.setSpacingBefore(10f);
        table.setSpacingAfter(20f);

        // en-tete du tableau avec style
        addModernTableHeader(table, "ID");
        addModernTableHeader(table, "Produit");
        addModernTableHeader(table, "Prix Unit.");
        addModernTableHeader(table, "Qte");
        addModernTableHeader(table, "Sous-Total");

        // donnees des produits
        List<Produit> produits = vente.getProduits();
        List<Integer> quantites = vente.getQuantites();

        System.out.println("produits ::: " + produits.size());
        System.out.println("quantites ::: " + quantites.size());

        for (int i = 0; i < produits.size(); i++) {
            if (i < quantites.size()) {

                System.out.println("i :: == " + i);

                Produit produit = produits.get(i);
                System.out.println("produit[" + i + "] ==> " + produit.getNom() + ' ' + produit.getPrix());
                int quantite = quantites.get(i);
                BigDecimal total = produit.getPrix().multiply(new BigDecimal(quantite));

                // numero de ligne
         //        addModernTableCell(table, String.valueOf(i + 1), Element.ALIGN_CENTER, false);
                addModernTableCell(table,"P-00"+produit.getId()+"-80-25", Element.ALIGN_CENTER, false);

                // nom du produit
                addModernTableCell(table, produit.getNom(), Element.ALIGN_LEFT, false);

                // prix unitaire
                addModernTableCell(table, String.format("%,.2f Ar", produit.getPrix()),
                        Element.ALIGN_RIGHT, false);

                // quantite
                addModernTableCell(table, String.valueOf(quantite), Element.ALIGN_CENTER, false);

                // total
                addModernTableCell(table, String.format("%,.2f Ar", total),
                        Element.ALIGN_RIGHT, true);
            }
        }

        document.add(table);
        System.out.println(" fin addProductsTable");

    }

    private static void addModernTableHeader(PdfPTable table, String header) {
        PdfPCell cell = new PdfPCell();
        cell.setBackgroundColor(PRIMARY_COLOR);
        cell.setBorderWidth(0);
        cell.setPhrase(new Phrase(header, new Font(boldFont.getBaseFont(), 10, Font.BOLD, BaseColor.WHITE)));
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setPadding(10f);
        table.addCell(cell);
    }

    private static void addModernTableCell(PdfPTable table, String content,
            int alignment, boolean isBold) {
        PdfPCell cell = new PdfPCell();
        cell.setBorder(Rectangle.BOTTOM);
        cell.setBorderColor(GRAY_LIGHT);
        cell.setBorderWidth(1f);
        cell.setPhrase(new Phrase(content, isBold ? boldFont : normalFont));
        cell.setHorizontalAlignment(alignment);
        cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
        cell.setPadding(8f);
        table.addCell(cell);
    }

    private static void addTotalSection(Document document, Vente vente) throws DocumentException {
        // creer une table pour le total (justifier a droite)
        PdfPTable totalTable = new PdfPTable(2);
        totalTable.setWidthPercentage(40);
        totalTable.setHorizontalAlignment(Element.ALIGN_RIGHT);
        totalTable.setSpacingBefore(10f);
        totalTable.setSpacingAfter(30f);

        // total
        BigDecimal total = vente.getTotal();
        // addTotalRow(totalTable, "Sous-total:", String.format("%,.2f Ar", total), false);

        document.add(totalTable);

        // ajouter un bordure pour le total
        PdfPTable totalBox = new PdfPTable(1);
        totalBox.setWidthPercentage(100);
        totalBox.setSpacingAfter(20f);

        PdfPCell boxCell = new PdfPCell();
        boxCell.setBackgroundColor(new BaseColor(240, 253, 244)); // Vert très clair
        boxCell.setBorderColor(SUCCESS_COLOR);
        boxCell.setBorderWidth(2f);
        boxCell.setPadding(15f);

        Paragraph totalText = new Paragraph();
        totalText.setAlignment(Element.ALIGN_CENTER);
        totalText.add(new Chunk("Montant Total \n", subtitleFont));
        totalText.add(new Chunk(String.format("%,.2f Ar", total), largeFont));

        boxCell.addElement(totalText);
        totalBox.addCell(boxCell);

        document.add(totalBox);
    }

    private static void addTotalRow(PdfPTable table, String label, String value, boolean isTotal) {
        // partie label
        PdfPCell labelCell = new PdfPCell();
        labelCell.setBorder(isTotal ? Rectangle.TOP : Rectangle.NO_BORDER);
        labelCell.setBorderWidth(isTotal ? 2f : 0);
        labelCell.setBorderColor(GRAY_MEDIUM);
        labelCell.setPadding(8f);
        labelCell.setPhrase(new Phrase(label, isTotal ? subtitleFont : boldFont));

        // partie valeur
        PdfPCell valueCell = new PdfPCell();
        valueCell.setBorder(isTotal ? Rectangle.TOP : Rectangle.NO_BORDER);
        valueCell.setBorderWidth(isTotal ? 2f : 0);
        valueCell.setBorderColor(GRAY_MEDIUM);
        valueCell.setPadding(8f);
        valueCell.setHorizontalAlignment(Element.ALIGN_RIGHT);

        if (isTotal) {
            valueCell.setPhrase(new Phrase(value, new Font(boldFont.getBaseFont(), 14, Font.BOLD, SUCCESS_COLOR)));
        } else {
            valueCell.setPhrase(new Phrase(value, normalFont));
        }

        table.addCell(labelCell);
        table.addCell(valueCell);
    }

    private static void addFooterContent(Document document) throws DocumentException {
        // message de remerciement
        Paragraph thanks = new Paragraph();
        thanks.setAlignment(Element.ALIGN_CENTER);
        thanks.add(new Chunk("Misaotra anao najifa tato aminay . (::-::)!\n", subtitleFont));
        thanks.setSpacingAfter(10f);
        document.add(thanks);

        // information complementaire
        Paragraph footer = new Paragraph();
        footer.setAlignment(Element.ALIGN_CENTER);
        footer.add(new Chunk("Ce reçu fait office de facture.\n", smallFont));
        footer.add(new Chunk("Pour la reclamation, veuillez contacter notre service client.\n", smallFont));
        footer.add(new Chunk("Tel: +261 38 48 542 53 | Email: tsarafara.37@gmail.com", smallFont));
        footer.setSpacingBefore(10f);
        document.add(footer);

        // code-barres ou QR code (simulation)
        Paragraph barcode = new Paragraph();
        barcode.setAlignment(Element.ALIGN_CENTER);
        barcode.setSpacingBefore(20f);
        barcode.add(new Chunk("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n", smallFont));
        barcode.add(new Chunk("ARMANDO LANDO - L2 - GENIE LOGICIEL", smallFont));
         barcode.add(new Chunk("2025", normalFont));
        document.add(barcode);
    }

    // classe interne pour gerer l'en-tete et le pied de page sur chaque page
    static class HeaderFooterPageEvent extends PdfPageEventHelper {

        @Override
        public void onEndPage(PdfWriter writer, Document document) {
            PdfContentByte cb = writer.getDirectContent();

            // numero de page
            Phrase pageNum = new Phrase(
                    "Page " + writer.getPageNumber(),
                    smallFont
            );

            ColumnText.showTextAligned(
                    cb,
                    Element.ALIGN_CENTER,
                    pageNum,
                    (document.right() - document.left()) / 2 + document.leftMargin(),
                    document.bottom() - 10,
                    0
            );
        }
    }
}
