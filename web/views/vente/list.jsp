<%-- 
    Document   : list
    Created on : 7 nov. 2025, 13:26:53
    Author     : USER
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<main class="min-h-screen bg-gradient-to-br from-gray-50 via-blue-50 to-indigo-50 py-8 px-4">
    <div class="max-w-7xl mx-auto">
        <!-- entête -->
        <div class="mb-8 animate-fade-in">
            <div class="flex flex-col sm:flex-row sm:justify-between sm:items-center gap-4">
                <div>
                    <div class="flex items-center gap-3 mb-2">
                        <div class="w-12 h-12 rounded-2xl bg-gradient-to-br from-purple-600 to-pink-600 flex items-center justify-center shadow-lg">
                            <i class="ri-shopping-cart-2-line text-white text-2xl"></i>
                        </div>
                        <div>
                            <h1 class="text-2xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-purple-600 to-pink-600">
                                Historique des Ventes
                            </h1>
                            <p class="text-gray-600 mt-1">Consultation de toutes les transactions</p>
                        </div>
                    </div>
                </div>
                
                <!-- bouton new vente -->
                <a href="${pageContext.request.contextPath}/vente?action=new" 
                   class="flex items-center justify-center bg-gradient-to-r from-green-500 to-emerald-600 hover:from-green-600 hover:to-emerald-700 text-white px-6 py-3 rounded-xl font-semibold shadow-lg hover:shadow-xl transition-all duration-300 transform hover:scale-105">
                    <i class="ri-add-circle-line text-xl mr-2"></i>
                    Nouvelle Vente
                </a>
            </div>
        </div>

        <!-- stats rapides -->
        <div class="grid grid-cols-1 sm:grid-cols-3 gap-6 mb-8">
            <div class="bg-white rounded-2xl shadow-lg p-6 border border-gray-100 transform transition-all duration-300 hover:shadow-2xl hover:-translate-y-1">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-semibold text-gray-500 uppercase tracking-wide">Total Ventes</p>
                        <p class="text-3xl font-extrabold text-gray-900 mt-2">
                            <c:out value="${ventes.size()}" default="0"/>
                        </p>
                    </div>
                    <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-purple-100 to-purple-200 flex items-center justify-center">
                        <i class="ri-file-list-3-line text-purple-600 text-2xl"></i>
                    </div>
                </div>
            </div>
            
            <div class="bg-white rounded-2xl shadow-lg p-6 border border-gray-100 transform transition-all duration-300 hover:shadow-2xl hover:-translate-y-1">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-semibold text-gray-500 uppercase tracking-wide">Chiffre d'Affaire</p>
                        <p class="text-xl font-extrabold text-green-600 mt-2">
                            <c:set var="totalCA" value="0" />
                            <c:forEach var="vente" items="${ventes}">
                                <c:set var="totalCA" value="${totalCA + vente.total}" />
                            </c:forEach>
                            <fmt:formatNumber value="${totalCA}" pattern="#,##0.00"/> Ar
                        </p>
                    </div>
                    <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-green-100 to-green-200 flex items-center justify-center">
                        <i class="ri-money-dollar-circle-line text-green-600 text-2xl"></i>
                    </div>
                </div>
            </div>
            
            <div class="bg-white rounded-2xl shadow-lg p-6 border border-gray-100 transform transition-all duration-300 hover:shadow-2xl hover:-translate-y-1">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-semibold text-gray-500 uppercase tracking-wide">Moyenne/Vente</p>
                        <p class="text-xl font-extrabold text-blue-600 mt-2">
                            <c:choose>
                                <c:when test="${ventes.size() > 0}">
                                    <fmt:formatNumber value="${totalCA / ventes.size()}" pattern="#,##0.00"/> Ar
                                </c:when>
                                <c:otherwise>
                                    0.00 Ar
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    <div class="w-14 h-14 rounded-2xl bg-gradient-to-br from-blue-100 to-blue-200 flex items-center justify-center">
                        <i class="ri-bar-chart-box-line text-blue-600 text-2xl"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- tableau de ventes -->
        <div class="bg-white rounded-2xl shadow-lg border border-gray-100 overflow-hidden">
            <!-- heade du tableau -->
            <div class="bg-gradient-to-r from-purple-600 to-pink-600 px-6 py-4">
                <h2 class="text-xl font-bold text-white flex items-center">
                    <i class="ri-list-check-2 mr-2"></i>
                    Liste des Ventes
                </h2>
            </div>

            <!-- barre de recherche et filtre js no mapandeha azy -->
            <div class="px-6 py-4 bg-gray-50 border-b border-gray-200">
                <div class="flex flex-col sm:flex-row gap-4">
                    <div class="flex-1">
                        <div class="relative">
                            <input type="text" id="searchInput" placeholder="Rechercher par client, ID..." 
                                   class="w-full px-4 py-3 pl-12 border-2 border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-purple-500 focus:border-transparent transition-all duration-300">
                            <i class="ri-search-line absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-400 text-xl"></i>
                        </div>
                    </div>
                    <button onclick="window.print()" 
                            class="px-6 py-3 bg-gray-100 hover:bg-gray-200 text-gray-700 rounded-xl font-semibold transition-all duration-300 flex items-center justify-center">
                        <i class="ri-printer-line mr-2"></i>
                        Imprimer
                    </button>
                </div>
            </div>

            <!-- table -->
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-600 uppercase tracking-wider">
                                <div class="flex items-center">
                                    <i class="ri-hashtag mr-2"></i>ID Vente
                                </div>
                            </th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-600 uppercase tracking-wider">
                                <div class="flex items-center">
                                    <i class="ri-user-line mr-2"></i>Client
                                </div>
                            </th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-600 uppercase tracking-wider">
                                <div class="flex items-center">
                                    <i class="ri-calendar-line mr-2"></i>Date
                                </div>
                            </th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-600 uppercase tracking-wider">
                                <div class="flex items-center">
                                    <i class="ri-money-dollar-circle-line mr-2"></i>Total
                                </div>
                            </th>
                            <th class="px-6 py-4 text-left text-xs font-bold text-gray-600 uppercase tracking-wider">
                                <div class="flex items-center">
                                    <i class="ri-settings-3-line mr-2"></i>Actions
                                </div>
                            </th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200" id="ventesTableBody">
                        <c:choose>
                            <c:when test="${empty ventes}">
                                <tr>
                                    <td colspan="5" class="px-6 py-12 text-center">
                                        <div class="flex flex-col items-center">
                                            <div class="w-24 h-24 rounded-full bg-gray-100 flex items-center justify-center mb-4">
                                                <i class="ri-shopping-cart-line text-gray-400 text-4xl"></i>
                                            </div>
                                            <p class="text-gray-500 text-lg font-semibold">Aucune vente enregistrée</p>
                                            <p class="text-gray-400 text-sm mt-2">Commencez par créer le premiere vente</p>
                                            <a href="${pageContext.request.contextPath}/vente?action=new" 
                                               class="mt-4 px-6 py-3 bg-gradient-to-r from-green-500 to-emerald-600 text-white rounded-xl font-semibold hover:shadow-lg transition-all duration-300">
                                                Créer une vente
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="vente" items="${ventes}">
                                    <tr class="hover:bg-gradient-to-r hover:from-purple-50 hover:to-pink-50 transition-all duration-200 search-row">
                                        <td class="px-6 py-4 whitespace-nowrap">
                                                <div class="flex items-center">
                                                    <div class="w-10 h-7 rounded-lg bg-gradient-to-br from-purple-500 to-pink-600 flex items-center justify-center mr-3">
                                                        <span class="text-white font-bold text-sm">#${vente.id}</span>
                                                    </div>
                                                    <span class="text-sm font-semibold text-gray-900">#${vente.id}</span>
                                                </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="flex items-center">
                                                <div>
                                                    <div class="text-sm font-bold text-gray-900">${vente.client.nom} ${vente.client.prenom}</div>
                                                    <div class="text-xs text-gray-500">${vente.client.email}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="text-sm text-gray-900">
                                                <div class="flex items-center">
                                                    <i class="ri-calendar-2-line text-purple-600 mr-2"></i>
                                                    <fmt:formatDate value="${vente.dateVente}" pattern="dd/MM/yyyy" />
                                                </div>
                                                <div class="flex items-center mt-1 text-xs text-gray-500">
                                                    <i class="ri-time-line text-gray-400 mr-2"></i>
                                                    <fmt:formatDate value="${vente.dateVente}" pattern="HH:mm" />
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="inline-flex items-center px-4 py-2 rounded-xl bg-gradient-to-r from-green-100 to-emerald-100 border border-green-200">
                                                <i class="ri-money-dollar-circle-line text-green-600 mr-2"></i>
                                                <span class=" font-extrabold text-green-700">
                                                    <fmt:formatNumber value="${vente.total}" pattern="#,##0.00"/> Ar
                                                </span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                            <div class="flex items-center gap-2">
                                                <a href="${pageContext.request.contextPath}/vente?action=recu&id=${vente.id}" 
                                                   class="inline-flex items-center px-4 py-2 bg-blue-100 hover:bg-blue-200 text-blue-700 rounded-lg transition-all duration-200 transform hover:scale-105 font-semibold">
                                                    <i class="ri-file-text-line text-lg mr-2"></i>
                                                    Reçu
                                                </a>
                                               
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- footer -->
            <div class="px-6 py-4 bg-gray-50 border-t border-gray-200">
                <div class="flex flex-col sm:flex-row justify-between items-center gap-4">
                    <div class="text-sm text-gray-600">
                        Affichage de <span id="nombreDeVente" class="font-bold text-gray-900">${ventes.size()}</span> vente(s)
                    </div>
                  
                </div>
            </div>
        </div>
    </div>
</main>

<style>
@keyframes fade-in {
    from { opacity: 0; transform: translateY(-10px); }
    to { opacity: 1; transform: translateY(0); }
}

.animate-fade-in {
    animation: fade-in 0.6s ease-out;
}

@media print {
    .no-print {
        display: none !important;
    }
}
</style>

<script>
    // fonction de recherche en temps reel
    const nombreDeVente=document.getElementById("nombreDeVente");
    document.getElementById('searchInput').addEventListener('input', function(e) {
        const searchTerm = e.target.value.toLowerCase();
        const rows = document.querySelectorAll('.search-row');
        
        
        rows.forEach(row => {
            const text = row.textContent.toLowerCase();
            if (text.includes(searchTerm)) {
               // document
                row.style.display = '';
                console.table(rows.length)
              //  nombreDeVente.textContent=row;
            } else {
                row.style.display = 'none';
            }
        });
    });

    // Fonction pour afficher les détails (à implémenter selon vos besoins)
    function showDetails(venteId) {
        alert('Affichage des détails de la vente #' + venteId);
        // Vous pouvez implémenter une modal ou rediriger vers une page de détails
    }

    // Animation au chargement
    document.addEventListener('DOMContentLoaded', function() {
        const rows = document.querySelectorAll('.search-row');
        rows.forEach((row, index) => {
            row.style.opacity = '0';
            row.style.transform = 'translateY(10px)';
            setTimeout(() => {
                row.style.transition = 'all 0.3s ease-out';
                row.style.opacity = '1';
                row.style.transform = 'translateY(0)';
            }, index * 50);
        });
    });
</script>

<jsp:include page="../includes/footer.jsp" />