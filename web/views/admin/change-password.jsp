<%-- 
    Document   : change-password
    Created on : 7 nov. 2025, 9:34:54
    Author     : USER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<main class="max-w-2xl mx-auto py-6 px-4">
    <div class="mb-6">
        <h1 class="text-3xl font-bold text-gray-900">Changer le mot de passe</h1>
        <p class="text-gray-600 mt-2">Mettez a jour votre mot de passe de securité</p>
    </div>

    <!-- messages -->
    <c:if test="${not empty error}">
        <div class="mb-4 bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-lg flex items-center">
            <i class="ri-error-warning-line mr-2"></i>
            ${error}
        </div>
    </c:if>

    <c:if test="${not empty success}">
        <div class="mb-4 bg-green-50 border border-green-200 text-green-600 px-4 py-3 rounded-lg flex items-center">
            <i class="ri-checkbox-circle-line mr-2"></i>
            ${success}
        </div>
    </c:if>

    <div class="bg-white shadow rounded-lg">
        <div class="px-6 py-4 border-b border-gray-200">
            <h2 class="text-xl font-semibold text-gray-800">Sécurité du Compte</h2>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/admin?action=change-password">
            <div class="p-6 space-y-6">
                <!-- mdp actuel -->
                <div>
                    <label for="currentPassword" class="block text-sm font-medium text-gray-700 mb-2">
                        Mot de passe actuel
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="ri-lock-line text-gray-400"></i>
                        </div>
                        <input type="password" id="currentPassword" name="currentPassword" required
                               class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                               placeholder="Entrez votre mot de passe actuel">
                    </div>
                </div>

                <!-- nouveau mdp -->
                <div>
                    <label for="newPassword" class="block text-sm font-medium text-gray-700 mb-2">
                        Nouveau mot de passe
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="ri-lock-password-line text-gray-400"></i>
                        </div>
                        <input type="password" id="newPassword" name="newPassword" required
                               class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                               placeholder="Entrez le nouveau mot de passe">
                    </div>
                    <p class="mt-1 text-sm text-gray-500">Minimum 6 caractères</p>
                </div>

                <!-- confirmation changement -->
                <div>
                    <label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-2">
                        Confirmer le nouveau mot de passe
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="ri-lock-password-line text-gray-400"></i>
                        </div>
                        <input type="password" id="confirmPassword" name="confirmPassword" required
                               class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                               placeholder="Confirmez le nouveau mot de passe">
                    </div>
                </div>
            </div>

            <div class="px-6 py-4 bg-gray-50 border-t border-gray-200 flex justify-end space-x-3">
                <a href="${pageContext.request.contextPath}/admin?action=profile" 
                   class="bg-gray-300 hover:bg-gray-400 text-gray-800 px-4 py-2 rounded-md transition duration-300">
                    <i class="ri-arrow-left-line mr-2"></i>Annuler
                </a>
                <button type="submit" 
                        class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-md transition duration-300">
                    <i class="ri-save-line mr-2"></i>Mettre à jour
                </button>
            </div>
        </form>
    </div>
</main>

<jsp:include page="../includes/footer.jsp" />