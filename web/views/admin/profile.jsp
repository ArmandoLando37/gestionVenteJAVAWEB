<%-- 
    Document   : profile
    Created on : 7 nov. 2025, 9:34:36
    Author     : USER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<main class="max-w-4xl mx-auto py-6 px-4">
    <div class="mb-6">
        <h1 class="text-3xl font-bold text-gray-900">Mon Profil</h1>
        <p class="text-gray-600 mt-2">Gerez vos informations personnelles</p>
    </div>

    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
        <!-- nformation de la profil -->
        <div class="lg:col-span-2">
            <div class="bg-white shadow rounded-lg">
                <div class="px-6 py-4 border-b border-gray-200">
                    <h2 class="text-xl font-semibold text-gray-800">Informations Personnellles</h2>
                </div>
                <div class="p-6">
                    <div class="space-y-4">
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Nom d'utilisateur</label>
                                <p class="text-gray-900 font-medium">${admin.username}</p>
                            </div>
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Nom Complet</label>
                                <p class="text-gray-900 font-medium">${admin.nomComplet}</p>
                            </div>
                        </div>
                        <div>
                            <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
                            <p class="text-gray-900 font-medium">${admin.email}</p>
                        </div>
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium text-gray-700 mb-1">Date de creation</label>
                                <div class="text-sm text-gray-900">
                                    <!-- date creation -->
                                    <div class="flex items-center">
                                        <i class="ri-calendar-2-line text-purple-600 mr-2"></i>
                                        <fmt:formatDate value="${admin.dateCreation}" pattern="dd/MM/yyyy" />
                                    </div>
                                    <!-- heure -->
                                    <div class="flex items-center mt-1 text-xs text-gray-500">
                                        <i class="ri-time-line text-gray-400 mr-2"></i>
                                        <fmt:formatDate value="${admin.dateCreation}" pattern="HH:mm" />
                                    </div>
                                </div>


                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="space-y-6">
            <!-- carte securite -->
            <div class="bg-white shadow rounded-lg p-6">
                <h3 class="text-lg font-semibold text-gray-800 mb-4">Securité</h3>
                <a href="${pageContext.request.contextPath}/admin?action=change-password" 
                   class="w-full bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-md transition duration-300 inline-flex items-center justify-center">
                    <i class="ri-lock-password-line mr-2"></i>
                    Changer le mot de passe
                </a>
            </div>

            <!-- carte statut -->
            <div class="bg-white shadow rounded-lg p-6">
                <h3 class="text-lg font-semibold text-gray-800 mb-4">Statut</h3>
                <div class="space-y-2">
                    <div class="flex justify-between">
                        <span class="text-gray-600">Rôle</span>
                        <span class="font-medium text-gray-800">Administrateur</span>
                    </div>
                    <div class="flex justify-between">
                        <span class="text-gray-600">Statut</span>
                        <span class="inline-flex items-center px-2 py-1 rounded-full text-xs font-medium bg-green-100 text-green-800">
                            Actif
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="../includes/footer.jsp" />