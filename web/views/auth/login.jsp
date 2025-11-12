<%-- 
    Document   : login
    Created on : 5 nov. 2025, 10:33:10
    Author     : USER
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../includes/header.jsp" />

<!-- tsy atranga ny navbar sur la page de login -->
<style>
    nav { display: none !important; }
    footer { display: none !important; }
</style>

<main class="min-h-screen bg-gradient-to-br from-blue-600 to-blue-800 flex items-center justify-center py-12 px-4">
    <div class="max-w-md w-full space-y-8">
        <div class="bg-white rounded-2xl shadow-xl p-8">
            
            <div class="text-center mb-8">
                <div class="mx-auto h-16 w-16 bg-blue-600 rounded-full flex items-center justify-center mb-4">
                    <i class="fas fa-lock text-2xl text-white"></i>
                </div>
                <h2 class="text-3xl font-bold text-gray-900">Connexion Admin</h2>
                <p class="mt-2 text-sm text-gray-600">
                    Connectez-vous pour accedez à votre tableau de bord
                </p>
            </div>

            <!-- messages  -->
            <c:if test="${not empty error}">
                <div class="mb-4 bg-red-50 border border-red-200 text-red-600 px-4 py-3 rounded-lg flex items-center">
                    <i class="fas fa-exclamation-triangle mr-2"></i>
                    ${error}
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="mb-4 bg-green-50 border border-green-200 text-green-600 px-4 py-3 rounded-lg flex items-center">
                    <i class="fas fa-check-circle mr-2"></i>
                    ${success}
                </div>
            </c:if>

            <!-- formulaire  -->
            <form class="space-y-6" method="POST" action="${pageContext.request.contextPath}/login?action=login">
                <div>
                    <label for="username" class="block text-sm font-medium text-gray-700 mb-2">
                        Nom d'utilisateur
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-user text-gray-400"></i>
                        </div>
                        <input id="username" name="username" type="text" required
                               class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                               placeholder="Entrez votre nom d'utilisateur"
                               value="${param.username}">
                    </div>
                </div>

                <div>
                    <label for="password" class="block text-sm font-medium text-gray-700 mb-2">
                        Mot de passe
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                            <i class="fas fa-key text-gray-400"></i>
                        </div>
                        <input id="password" name="password" type="password" required
                               class="block w-full pl-10 pr-3 py-3 border border-gray-300 rounded-lg placeholder-gray-400 focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                               placeholder="Entrez votre mot de passe">
                    </div>
                </div>

                <div>
                    <button type="submit"
                            class="group relative w-full flex justify-center py-3 px-4 border border-transparent text-sm font-medium rounded-lg text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition duration-200">
                        <span class="absolute left-0 inset-y-0 flex items-center pl-3">
                            <i class="fas fa-sign-in-alt text-white"></i>
                        </span>
                        Se connecter
                    </button>
                </div>
            </form>

          
        </div>

        <!-- footer -->
        <div class="text-center">
            <p class="text-white text-sm">
                GestionVente. projet java web
            </p>
        </div>
    </div>
</main>

<jsp:include page="../includes/footer.jsp" />