<%-- 
    Document   : header
    Created on : 5 nov. 2025, 13:25:45
    Author     : USER
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion de Ventes</title>
    <!--  <link href="https://cdn.jsdelivr.net/npm/remixicon@3.5.0/fonts/remixicon.css" rel="stylesheet"> -->
      <link href="${pageContext.request.contextPath}/css/RemixIcon_Fonts_v4.7.0/fonts/remixicon.css" rel="stylesheet">
    <!-- fontawesome,icone -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontAwesome/css/all.min.css">
    
    <!-- tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
     <script src="${pageContext.request.contextPath}/scripts/tailwind.js"></script>
    <script src="${pageContext.request.contextPath}/scripts/tailwindConfig.js"></script>
   <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    
    <style>
        /* styles fananmpiny*/
        .alert {
            transition: opacity 0.3s ease-in-out;
        }
        .sidebar {
            transition: all 0.3s ease;
        }
        .dropdown:hover .dropdown-menu {
            display: block;
        }
    </style>
</head>
<body class="bg-gray-50">