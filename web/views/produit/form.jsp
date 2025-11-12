<%-- 
    Document   : form
    Created on : 6 nov. 2025, 11:26:44
    Author     : USER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<main class="max-w-4xl mx-auto py-6 px-4">
    <div class="mb-6">
        <h1 class="text-3xl font-bold text-gray-900">
            <c:choose>
                <c:when test="${not empty produit}">Modifier le Produit</c:when>
                <c:otherwise>Nouveau Produit</c:otherwise>
            </c:choose>
        </h1>
    </div>

    <div class="bg-white shadow rounded-lg">
        <div class="px-6 py-4 border-b border-gray-200">
            <h2 class="text-xl font-semibold text-gray-800">
                <c:choose>
                    <c:when test="${not empty produit}">Modifier les informations du produit</c:when>
                    <c:otherwise>Ajouter un nouveau produit</c:otherwise>
                </c:choose>
            </h2>
            <h6 class="text-red-600 py-2" >les champs avec * sont obligatoire</h6>
        </div>

        <form method="post" 
              action="${pageContext.request.contextPath}/produit?action=${not empty produit ? 'update' : 'insert'}">
            
            <c:if test="${not empty produit}">
                <input type="hidden" name="id" value="${produit.id}">
            </c:if>

            <div class="p-6 space-y-6">
                <!-- nom -->
                <div>
                    <label for="nom" class="block text-sm font-medium text-gray-700 mb-2">Nom du produit *</label>
                    <input type="text" id="nom" name="nom" required
                           value="${produit.nom}"
                           class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                </div>

                <!-- description -->
                <div>
                    <label for="description" class="block text-sm font-medium text-gray-700 mb-2">Description</label>
                    <textarea id="description" name="description" rows="3"
                              class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">${produit.description}</textarea>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- prix -->
                    <div>
                        <label for="prix" class="block text-sm font-medium text-gray-700 mb-2">Prix (Ar) *</label>
                        <input type="number" id="prix" name="prix" step="0.01" min="0" required
                               value="${produit.prix}"
                               class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                    </div>

                    <!-- stock -->
                    <div>
                        <label for="stock" class="block text-sm font-medium text-gray-700 mb-2">Stock *</label>
                        <input type="number" id="stock" name="stock" min="1" required
                               value="${produit.stock}"
                               class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                    </div>
                </div>
            </div>

            <div class="px-6 py-4 bg-gray-50 border-t border-gray-200 flex justify-end space-x-3">
                <a href="${pageContext.request.contextPath}/produit?action=list" 
                   class="bg-gray-300 hover:bg-gray-400 text-gray-800 px-4 py-2 rounded-md transition duration-300">
                    <i class="ri-arrow-left-line mr-2"></i>Retour
                </a>
                <button type="submit" 
                        class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-md transition duration-300">
                    <i class="ri-save-line mr-2"></i>
                    <c:choose>
                        <c:when test="${not empty produit}">Modifier</c:when>
                        <c:otherwise>Enregistrer</c:otherwise>
                    </c:choose>
                </button>
            </div>
        </form>
    </div>
</main>

<jsp:include page="../includes/footer.jsp" />