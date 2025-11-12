<%-- 
    Document   : recu
    Created on : 7 nov. 2025, 13:27:10
    Author     : USER
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<main class="max-w-4xl mx-auto py-6 px-4">
    <div class="bg-white shadow-lg rounded-lg overflow-hidden">
        <!-- entete du recu -->
        <div class="bg-blue-600 text-white p-6">
            <div class="flex justify-between items-center">
                <div>
                    <h1 class="text-2xl font-bold">GestionVente</h1>
                    <p class="text-blue-100">Reçu de vente</p>
                </div>
                <div class="text-right">
                    
                    <p class="text-blue-100">
                        <fmt:formatDate value="${vente.dateVente}" pattern="dd/MM/yyyy à HH:mm" />
                    </p>
                </div>
            </div>
        </div>

        <!-- informations client -->
        <div class="p-6 border-b border-gray-200">
            <h2 class="text-lg font-semibold text-gray-800 mb-4">Informations du Client</h2>
            <div class="grid grid-cols-2 gap-4">
                <div>
                    <p class="text-sm text-gray-600">Nom & Prénom</p>
                    <p class="font-medium">${vente.client.nom} ${vente.client.prenom}</p>
                </div>
                <div>
                    <p class="text-sm text-gray-600">Email</p>
                    <p class="font-medium">${vente.client.email}</p>
                </div>
                <div>
                    <p class="text-sm text-gray-600">Téléphone</p>
                    <p class="font-medium">${vente.client.telephone}</p>
                </div>
                <div>
                    <p class="text-sm text-gray-600">Adresse</p>
                    <p class="font-medium">${vente.client.adresse}</p>
                </div>
            </div>
        </div>

        <!-- details du produits -->
        <div class="p-6 border-b border-gray-200">
            <h2 class="text-lg font-semibold text-gray-800 mb-4">Détails de la Commande</h2>
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Produit</th>
                            <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Prix Unitaire</th>
                            <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Quantité</th>
                            <th class="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Sous-total</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                        <c:forEach var="i" begin="0" end="${vente.produits.size() - 1}">
                            <tr>
                                <td class="px-4 py-3 text-sm font-medium text-gray-900">${vente.produits[i].nom}</td>
                                <td class="px-4 py-3 text-sm text-gray-900">${vente.produits[i].prix} Ar</td>
                                <td class="px-4 py-3 text-sm text-gray-900">${vente.quantites[i]}</td>
                                <td class="px-4 py-3 text-sm text-gray-900">
                                    <c:set var="sousTotal" value="${vente.produits[i].prix * vente.quantites[i]}" />
                                    ${sousTotal} Ar
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- total -->
        <div class="p-6">
            <div class="flex justify-between items-center text-lg">
                <span class="font-semibold text-gray-800">Total:</span>
                <span class="text-2xl font-bold text-green-600">${vente.total} Ar</span>
            </div>
        </div>

        <!-- pied de page -->
        <div class="bg-gray-50 p-6 border-t border-gray-200">
            <div class="text-center text-gray-600">
                <p>Merci pour votre achat !</p>
               
            </div>
        </div>
    </div>

    <!-- actions atao-->
    <div class="mt-6 flex justify-center space-x-4">
        <button onclick="window.print()" 
                class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-md transition duration-300">
            <i class="ri-printer-line mr-2"></i>Imprimer
        </button>
        <a href="${pageContext.request.contextPath}/vente?action=new" 
           class="bg-green-600 hover:bg-green-700 text-white px-6 py-2 rounded-md transition duration-300">
            <i class="ri-shopping-cart-2-line mr-2"></i>Nouvelle Vente
        </a>
        <a href="${pageContext.request.contextPath}/vente?action=list" 
           class="bg-gray-600 hover:bg-gray-700 text-white px-6 py-2 rounded-md transition duration-300">
            <i class="ri-list-check mr-2"></i>Historique
        </a>
    </div>
</main>

<style>
    @media print {
        nav, .no-print {
            display: none !important;
        }
        body {
            background: white !important;
        }
        main {
            max-width: none !important;
            padding: 0 !important;
        }
    }
</style>

<jsp:include page="../includes/footer.jsp" />