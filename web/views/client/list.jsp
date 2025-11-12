<%-- 
    Document   : list
    Created on : 6 nov. 2025, 13:26:12
    Author     : USER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />


<main class="max-w-7xl mx-auto py-6 px-4">
    <div class="mb-6">
        <h1 class="text-3xl font-bold text-gray-900">
            <i class="ri-user-line mr-2"></i>Gestion des Clients
        </h1>
        <p class="text-gray-600 mt-2">Liste de tous les clients enregistrés</p>
    </div>

    <!-- success message -->
    <c:if test="${not empty param.success}">
        <div class="alert bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
            <i class="ri-checkbox-circle-line mr-2"></i>
            Opération effectuée avec succès
        </div>
    </c:if>

    <div class="bg-white shadow rounded-lg">
        <div class="px-6 py-4 border-b border-gray-200">
            <div class="flex justify-between items-center">
                <h2 class="text-xl font-semibold text-gray-800">
                    <i class="ri-list-check mr-2"></i>Liste des Clients
                </h2>
                <a href="${pageContext.request.contextPath}/client?action=new" 
                   class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md transition duration-300">
                    <i class="ri-user-add-line mr-2"></i>Nouveau Client
                </a>
            </div>
        </div>
        <!-- manomboka eto  -->
        <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-4 text-left text-xs font-bold text-gray-600 uppercase tracking-wide">
                            <i class="ri-id-card-line mr-1"></i>ID
                        </th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            <i class="ri-user-line mr-1"></i>Nom & Prénom
                        </th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            <i class="ri-mail-line mr-1"></i>Email
                        </th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            <i class="ri-phone-line mr-1"></i>Téléphone
                        </th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            <i class="ri-map-pin-line mr-1"></i>Adresse
                        </th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                            <i class="ri-settings-3-line mr-1"></i>Actions
                        </th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <!-- RAHA TSISY CLIENT -->
                    <c:choose>
                        <c:when test="${empty clients}">
                            <tr>
                                <td colspan="5" class="px-6 py-12 text-center">
                                    <div class="flex flex-col items-center">
                                        <div class="w-24 h-24 rounded-full bg-gray-100 flex items-center justify-center mb-4">
                                            <i class="ri-shopping-cart-line text-gray-400 text-4xl"></i>
                                        </div>
                                        <p class="text-gray-500 text-lg font-semibold">Aucune clients enregistrée</p>
                                        <p class="text-gray-400 text-sm mt-2">Commencez par l'ajout de nouveau client</p>
                                        <a href="${pageContext.request.contextPath}/client?action=new" 
                                           class="mt-4 px-6 py-3 bg-gradient-to-r from-green-500 to-emerald-600 text-white rounded-xl font-semibold hover:shadow-lg transition-all duration-300">
                                            Nouveau Client
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="client" items="${clients}">
                                <tr class="hover:bg-gradient-to-r hover:from-zinc-100 hover:to-pink-100 transition-all duration-200">
                                    <td class="px-6 py-4 whitespace-nowrap"> 
                                        <div class="flex items-center">
                                            <div class="px-2 w-full h-7 rounded bg-gradient-to-br from-green-500 to-blue-600 flex items-center justify-center mr-3">
                                                <span class="text-white font-bold text-sm">C-00${client.id}-80-25</span>
                                            </div>

                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="flex items-center">
                                            <div > 
                                                <div class="text-sm font-bold text-gray-700">${client.nom} ${client.prenom}</div>

                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        <div class="text-sm font-bold text-gray-700">
                                            <i class="ri-mail-line  text-blue-400 mr-1"></i>${client.email}
                                        </div>

                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">

                                        <div class="text-sm font-bold text-gray-700">
                                            <i class="ri-phone-line text-green-500 mr-1"></i>${client.telephone}
                                        </div>

                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
                                        <div class="text-sm font-bold text-gray-700">
                                            <i class="ri-map-pin-line text-gray-400 mr-1"></i>${client.adresse}
                                        </div>

                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                        <div class="flex space-x-2">
                                            <a href="${pageContext.request.contextPath}/client?action=edit&id=${client.id}" 
                                               class="inline-flex items-center px-4 py-2 bg-blue-100 hover:bg-blue-200 text-blue-700 rounded-lg transition-all duration-200 transform hover:scale-105 font-semibold"
                                               title="Modifier">
                                                <i class="ri-edit-line text-lg"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/client?action=delete&id=${client.id}" 
                                               class="inline-flex items-center px-4 py-2 bg-red-100 hover:bg-red-300 text-blue-700 rounded-lg transition-all duration-200 transform hover:scale-105 font-semibold"
                                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce client ?')"
                                               title="Supprimer">
                                                <i class="ri-delete-bin-line text-red-700 text-lg"></i>
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

        <!-- eto ny farany -->
    </div>
</main>

<jsp:include page="../includes/footer.jsp" />