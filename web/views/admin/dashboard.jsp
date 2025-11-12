<%-- 
    Document   : dashboard
    Created on : 7 nov. 2025, 9:34:07
    Author     : USER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />
<!-- fontawesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/fontAwesome/css/all.min.css">
<main class="max-w-7xl mx-auto py-6 px-4">
    <!-- entete du dashboard -->
    <div class="mb-8">
        <div class="flex justify-between items-center">
            <div>
                <h1 class="text-3xl font-bold text-gray-900">Tableau de Bord</h1>
                <p class="text-gray-600 mt-2">Bienvenue, ${admin.nomComplet}</p>
            </div>

        </div>
    </div>

    <!--stats -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <!--client -->
        <div class="stats-client  bg-white  rounded-xl shadow-sm  p-6">
            <div class="flex items-center">
                <div class="p-3 rounded-full bg-blue-100 text-blue-600 mr-4">
                    <i class="ri-user-line text-2xl"></i>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-600">Total Clients</p>
                    <p class="text-3xl font-bold text-gray-900">${totalClients}</p>
                </div>
            </div>
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/client?action=list" 
                   class="text-blue-600 hover:text-blue-700 text-sm font-medium inline-flex items-center">
                    Voir tous les clients
                    <i class="ri-arrow-right-line ml-1"></i>
                </a>
            </div>
        </div>

        <!-- produits -->
        <div class=" stats-produits bg-white rounded-xl shadow-sm border border-gray-200 p-6">
            <div class="flex items-center">
                <div class="p-3 rounded-full bg-green-100 text-green-600 mr-4">
                    <i class="ri-box-3-line text-2xl"></i>
                </div>

                <!-- stock total -->
                <div>
                    <p class="text-sm font-medium text-gray-600">Total Produits</p>

                    <p class="text-3xl font-bold text-gray-900">${totalProduits}</p>

                    <p class=" text-gray-400"> dont <span class="text-red-500 font-bold" >${totalProduitENRupture}</span> sont en rupture</p>
                </div>
                <!-- stock rn rubture -->

            </div>
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/produit?action=list" 
                   class="text-green-600 hover:text-green-700 text-sm font-medium inline-flex items-center">
                    Gérer les produits
                    <i class="ri-arrow-right-line ml-1"></i>
                </a>
            </div>
        </div>

        <!-- vente -->
        <div class="stats-vente bg-white rounded-xl shadow-sm border border-gray-200 p-6">
            <div class="flex items-center">
                <div class="p-3 rounded-full bg-purple-100 text-purple-600 mr-4">
                    <i class="ri-shopping-cart-2-line text-2xl"></i>
                </div>
                <div>
                    <p class="text-sm font-medium text-gray-600">Total Ventes</p>
                    <p class="text-3xl font-bold text-gray-900">${totalVentes}</p>
                </div>
            </div>
            <div class="mt-4">
                <a href="${pageContext.request.contextPath}/vente?action=list" 
                   class="text-purple-600 hover:text-purple-700 text-sm font-medium inline-flex items-center">
                    Voir l'historique
                    <i class="ri-arrow-right-line ml-1"></i>
                </a>
            </div>
        </div>
    </div>

    <!-- action rapides -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <a href="${pageContext.request.contextPath}/vente?action=new" 
           class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 hover:shadow-md transition duration-300 group">
            <div class="flex items-center">
                <div class="p-3 rounded-full bg-blue-50 text-blue-600 group-hover:bg-blue-100 transition duration-300 mr-4">
                    <i class="ri-add-circle-line text-xl"></i>
                </div>
                <div>
                    <h3 class="font-semibold text-gray-800">Nouvelle Vente</h3>
                    <p class="text-sm text-gray-600">Créer une vente</p>
                </div>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/client?action=new" 
           class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 hover:shadow-md transition duration-300 group">
            <div class="flex items-center">
                <div class="p-3 rounded-full bg-green-50 text-green-600 group-hover:bg-green-100 transition duration-300 mr-4">
                    <i class="ri-user-add-line text-xl"></i>
                </div>
                <div>
                    <h3 class="font-semibold text-gray-800">Nouveau Client</h3>
                    <p class="text-sm text-gray-600">Ajouter un client</p>
                </div>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/produit?action=new" 
           class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 hover:shadow-md transition duration-300 group">
            <div class="flex items-center">
                <div class="p-3 rounded-full bg-orange-50 text-orange-600 group-hover:bg-orange-100 transition duration-300 mr-4">
                    <i class="ri-add-box-line text-xl"></i>
                </div>
                <div>
                    <h3 class="font-semibold text-gray-800">Nouveau Produit</h3>
                    <p class="text-sm text-gray-600">Ajouter un produit</p>
                </div>
            </div>
        </a>

        <a href="${pageContext.request.contextPath}/admin?action=profile" 
           class="bg-white rounded-lg shadow-sm border border-gray-200 p-6 hover:shadow-md transition duration-300 group">
            <div class="flex items-center">
                <div class="p-3 rounded-full bg-purple-50 text-purple-600 group-hover:bg-purple-100 transition duration-300 mr-4">
                    <i class="ri-user-settings-line text-xl"></i>
                </div>
                <div>
                    <h3 class="font-semibold text-gray-800">Mon Profil</h3>
                    <p class="text-sm text-gray-600">Paramètres</p>
                </div>
            </div>
        </a>
    </div>

</main>
<style>
    .stats-client{
        border-width:0 0 0 5px;
        border-color: blue;
    }
    .stats-produits{
        border-width:0 0 0 5px;
        border-color: greenyellow;
    }
    .stats-vente{
        border-width:0 0 0 5px;
        border-color: purple;
    }

</style>

<jsp:include page="../includes/footer.jsp" />