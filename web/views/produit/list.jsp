<%-- 
    Document   : list
    Created on : 6 nov. 2025, 13:26:36
    Author     : USER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<main class="max-w-7xl mx-auto py-6 px-4">
    <div class="mb-6">
        <h1 class="text-3xl font-bold text-gray-900">Gestion des Produits</h1>
        <p class="text-gray-600 mt-2">Liste de tous les produits en stock</p>
    </div>

    <!-- succes Message -->
    <c:if test="${not empty param.success}">
        <div class="alert bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
            <i class="ri-checkbox-circle-line mr-2"></i>
            Operation effectuée avec succés
        </div>
    </c:if>

    <div class="bg-white shadow rounded-lg">
        <div class="px-6 py-4 border-b border-gray-200">
            <div class="flex justify-between items-center">
                <h2 class="text-xl font-semibold text-gray-800">Liste des Produits</h2>
                <a href="${pageContext.request.contextPath}/produit?action=new" 
                   class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md transition duration-300">
                    <i class="ri-add-circle-line mr-2"></i>Nouveau Produit
                </a>
            </div>
        </div>

        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nom</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Description</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Prix</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Stock</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <c:forEach var="produit" items="${produits}">
                        <tr class="hover:bg-gray-50 transition duration-150">
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                 <div class="flex items-center">
                                            <div class="px-2 w-full h-7 rounded bg-gradient-to-br from-green-400 to-green-700 flex items-center justify-center mr-3">
                                                <span class="text-white font-bold text-sm">P-00${produit.id}-80-25</span>
                                            </div>

                                        </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap max-w-40">
                                <div class="text-sm font-medium text-gray-900">${produit.nom}</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${produit.description}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                <span class="font-semibold">${produit.prix} Ar</span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium 
                                    ${produit.stock > 10 ? 'bg-green-100 text-green-800' : 
                                      produit.stock > 0 ? 'bg-yellow-100 text-yellow-800' : 
                                      'bg-red-100 text-red-800'}">
                                    ${produit.stock} unités
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                <div class="flex space-x-2">
                                    <a href="${pageContext.request.contextPath}/produit?action=edit&id=${produit.id}" 
                                       class="text-blue-600 hover:text-blue-900 transition duration-150">
                                        <i class="ri-edit-line text-lg"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/produit?action=delete&id=${produit.id}" 
                                       class="text-red-600 hover:text-red-900 transition duration-150"
                                       onclick="return confirm('Etes-vous sûr de vouloir supprimer ce produit ?')">
                                        <i class="ri-delete-bin-line text-lg"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</main>

<jsp:include page="../includes/footer.jsp" />