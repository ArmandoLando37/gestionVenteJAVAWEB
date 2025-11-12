<%-- 
    Document   : navbar
    Created on : 5 nov. 2025, 13:25:53
    Author     : USER
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="bg-blue-300/80 backdrop-blur-xl shadow-lg sticky top-0 z-50 border-b border-gray-200">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-20">
            <!-- logo et nom du app -->
            <div class="flex items-center space-x-3 group">
                <div class="relative">
                    <div class="absolute inset-0 bg-gradient-to-r from-blue-600 to-indigo-600 rounded-2xl blur opacity-50 group-hover:opacity-75 transition-opacity duration-300"></div>
                    <div class="relative flex items-center justify-center w-12 h-12 bg-gradient-to-br from-blue-600 to-indigo-600 rounded-2xl shadow-lg transform group-hover:scale-110 group-hover:rotate-6 transition-all duration-300">
                        <i class="ri-store-2-line text-white text-2xl"></i>
                    </div>
                </div>
                <div class="hidden sm:block">
                    <span class="text-2xl font-extrabold bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent">
                        GestionVente
                    </span>
                    <p class="text-xs text-gray-500 font-medium">Système de gestion</p>
                </div>
            </div>

            <!-- menu grand ecran (cache sur mobile) -->
            <div class="hidden md:flex items-center space-x-2">
                <c:choose>
                    <c:when test="${not empty admin}">
                        <!-- pour admin  -->
                        <a href="${pageContext.request.contextPath}/admin/dashboard" 
                           class="relative px-4 py-2.5 rounded-xl text-gray-700 hover:text-blue-600 font-medium transition-all duration-300 group overflow-hidden">
                            <span class="absolute inset-0 bg-gradient-to-r from-blue-50 to-indigo-50 opacity-0 group-hover:opacity-100 transition-opacity duration-300 rounded-xl"></span>
                            <span class="relative flex items-center">
                                <i class="ri-dashboard-line mr-2 group-hover:scale-110 transition-transform"></i>
                                <span>Tableau de bord</span>
                            </span>
                        </a>

                        <a href="${pageContext.request.contextPath}/client?action=list" 
                           class="relative px-4 py-2.5 rounded-xl text-gray-700 hover:text-blue-600 font-medium transition-all duration-300 group overflow-hidden">
                            <span class="absolute inset-0 bg-gradient-to-r from-blue-50 to-indigo-50 opacity-0 group-hover:opacity-100 transition-opacity duration-300 rounded-xl"></span>
                            <span class="relative flex items-center">
                                <i class="ri-user-line mr-2 group-hover:scale-110 transition-transform"></i>
                                <span>Clients</span>
                            </span>
                        </a>

                        <a href="${pageContext.request.contextPath}/produit?action=list" 
                           class="relative px-4 py-2.5 rounded-xl text-gray-700 hover:text-blue-600 font-medium transition-all duration-300 group overflow-hidden">
                            <span class="absolute inset-0 bg-gradient-to-r from-blue-50 to-indigo-50 opacity-0 group-hover:opacity-100 transition-opacity duration-300 rounded-xl"></span>
                            <span class="relative flex items-center">
                                <i class="ri-box-3-line mr-2 group-hover:scale-110 transition-transform"></i>
                                <span>Produits</span>
                            </span>
                        </a>

                        <a href="${pageContext.request.contextPath}/vente?action=list" 
                           class="relative px-4 py-2.5 rounded-xl text-gray-700 hover:text-blue-600 font-medium transition-all duration-300 group overflow-hidden">
                            <span class="absolute inset-0 bg-gradient-to-r from-blue-50 to-indigo-50 opacity-0 group-hover:opacity-100 transition-opacity duration-300 rounded-xl"></span>
                            <span class="relative flex items-center">
                                <i class="ri-shopping-cart-2-line mr-2 group-hover:scale-110 transition-transform"></i>
                                <span>Ventes</span>
                            </span>
                        </a>

                        <!-- bouton new vente -->
                        <a href="${pageContext.request.contextPath}/vente?action=new" 
                           class="relative ml-2 px-5 py-2.5 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-xl font-semibold shadow-lg hover:shadow-xl transition-all duration-300 flex items-center group overflow-hidden transform hover:scale-105">
                            <span class="absolute inset-0 bg-gradient-to-r from-indigo-600 to-blue-600 opacity-0 group-hover:opacity-100 transition-opacity duration-300"></span>
                            <span class="relative flex items-center">
                                <i class="ri-add-circle-line mr-2 text-lg"></i>
                                <span>Nouvelle Vente</span>
                            </span>
                        </a>

                        <!-- menu deroulante -->
                        <div class="relative group ml-3">
                            <button class="flex items-center space-x-3 px-4 py-2.5 rounded-xl hover:bg-gray-50 transition-all duration-300 border border-gray-200">
                                <div class="relative">
                                    <div class="w-10 h-10 rounded-full bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center shadow-md">
                                        <span class="text-white font-bold text-sm">${admin.nomComplet.substring(0, 2).toUpperCase()}</span>
                                    </div>
                                    <span class="absolute -bottom-0.5 -right-0.5 w-3.5 h-3.5 bg-green-500 border-2 border-white rounded-full"></span>
                                </div>
                                <div class="hidden lg:block text-left">
                                    <p class="text-sm font-semibold text-gray-900 max-w-32 truncate">${admin.nomComplet}</p>
                                    <p class="text-xs text-gray-500">Administrateur</p>
                                </div>
                                <i class="ri-arrow-down-s-line text-gray-500 group-hover:rotate-180 transition-transform duration-300"></i>
                            </button>

                            <!-- dropdown menu -->
                            <div class="absolute right-0 mt-3 w-72 bg-white rounded-2xl shadow-2xl border border-gray-100 py-2 opacity-0 invisible group-hover:opacity-100 group-hover:visible group-hover:mt-2 transition-all duration-300 transform origin-top-right">
                                <!-- header  dropdown -->
                                <div class="px-4 py-3 border-b border-gray-100 bg-gradient-to-r from-blue-50 to-indigo-50 rounded-t-2xl">
                                    <div class="flex items-center space-x-3">
                                        <div class="w-12 h-12 rounded-full bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center shadow-md">
                                            <span class="text-white font-bold">${admin.nomComplet.substring(0, 2).toUpperCase()}</span>
                                        </div>
                                        <div>
                                            <p class="text-sm font-bold text-gray-900 truncate">${admin.nomComplet}</p>
                                            <p class="text-xs text-gray-600 flex items-center">
                                                <span class="w-2 h-2 bg-green-500 rounded-full mr-1.5"></span>
                                                En ligne
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <!-- menu item -->
                                <div class="py-2">
                                    <a href="${pageContext.request.contextPath}/admin?action=profile" 
                                       class="flex items-center px-4 py-3 text-sm font-medium text-gray-700 hover:bg-blue-50 hover:text-blue-600 transition-all duration-200 group">
                                        <div class="w-8 h-8 rounded-lg bg-blue-100 flex items-center justify-center mr-3 group-hover:scale-110 transition-transform">
                                            <i class="ri-user-settings-line text-blue-600"></i>
                                        </div>
                                        <div>
                                            <p class="font-semibold">Mon Profil</p>
                                            <p class="text-xs text-gray-500">Gérer vos informations</p>
                                        </div>
                                    </a>

                                    <a href="${pageContext.request.contextPath}/admin?action=change-password" 
                                       class="flex items-center px-4 py-3 text-sm font-medium text-gray-700 hover:bg-blue-50 hover:text-blue-600 transition-all duration-200 group">
                                        <div class="w-8 h-8 rounded-lg bg-purple-100 flex items-center justify-center mr-3 group-hover:scale-110 transition-transform">
                                            <i class="ri-lock-password-line text-purple-600"></i>
                                        </div>
                                        <div>
                                            <p class="font-semibold">Sécurité</p>
                                            <p class="text-xs text-gray-500">Changer mot de passe</p>
                                        </div>
                                    </a>
                                </div>

                                <div class="border-t border-gray-100 mt-2 pt-2">
                                    <a href="${pageContext.request.contextPath}/login?action=logout" 
                                       class="flex items-center px-4 py-3 text-sm font-medium text-red-600 hover:bg-red-50 transition-all duration-200 group rounded-lg mx-2">
                                        <div class="w-8 h-8 rounded-lg bg-red-100 flex items-center justify-center mr-3 group-hover:scale-110 transition-transform">
                                            <i class="ri-logout-box-r-line"></i>
                                        </div>
                                        <span class="font-semibold">Deconnexion</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:when>

                </c:choose>
            </div>

            <!-- bouton hamburger moderne (visible  sur mobile) -->
            <div class="md:hidden flex items-center">
                <button id="mobile-menu-button" class="p-2.5 rounded-xl hover:bg-gray-100 transition-all duration-300 group">
                    <div class="w-6 h-5 flex flex-col justify-between">
                        <span class="w-full h-0.5 bg-gray-700 rounded-full transform transition-all duration-300 group-hover:bg-blue-600"></span>
                        <span class="w-full h-0.5 bg-gray-700 rounded-full transform transition-all duration-300 group-hover:bg-blue-600"></span>
                        <span class="w-full h-0.5 bg-gray-700 rounded-full transform transition-all duration-300 group-hover:bg-blue-600"></span>
                    </div>
                </button>
            </div>
        </div>

        <!-- Menu mobile moderne -->
        <div id="mobile-menu" class="md:hidden hidden">
            <div class="pb-4 pt-2">
                <c:choose>
                    <c:when test="${not empty admin}">
                        <!-- header mobile avec profil -->
                        <div class="mb-4 p-4 bg-gradient-to-r from-blue-50 to-indigo-50 rounded-2xl">
                            <div class="flex items-center space-x-3">
                                <div class="relative">
                                    <div class="w-14 h-14 rounded-full bg-gradient-to-br from-blue-500 to-indigo-600 flex items-center justify-center shadow-lg">
                                        <span class="text-white font-bold text-lg">${admin.nomComplet.substring(0, 2).toUpperCase()}</span>
                                    </div>
                                    <span class="absolute bottom-0 right-0 w-4 h-4 bg-green-500 border-2 border-white rounded-full"></span>
                                </div>
                                <div>
                                    <p class="text-sm font-bold text-gray-900">${admin.nomComplet}</p>
                                    <p class="text-xs text-gray-600 flex items-center mt-0.5">
                                        <span class="w-1.5 h-1.5 bg-green-500 rounded-full mr-1.5"></span>
                                        Administrateur
                                    </p>
                                </div>
                            </div>
                        </div>

                        <!-- navig mobile -->
                        <div class="space-y-1.5">
                            <a href="${pageContext.request.contextPath}/admin/dashboard" 
                               class="flex items-center px-4 py-3.5 text-gray-700 rounded-xl hover:bg-gradient-to-r hover:from-blue-50 hover:to-indigo-50 hover:text-blue-600 transition-all duration-200 font-medium group">
                                <div class="w-10 h-10 rounded-xl bg-blue-100 flex items-center justify-center mr-3 group-hover:scale-110 transition-transform">
                                    <i class="ri-dashboard-line text-blue-600 text-lg"></i>
                                </div>
                                <span>Dashboard</span>
                            </a>

                            <a href="${pageContext.request.contextPath}/client?action=list" 
                               class="flex items-center px-4 py-3.5 text-gray-700 rounded-xl hover:bg-gradient-to-r hover:from-blue-50 hover:to-indigo-50 hover:text-blue-600 transition-all duration-200 font-medium group">
                                <div class="w-10 h-10 rounded-xl bg-green-100 flex items-center justify-center mr-3 group-hover:scale-110 transition-transform">
                                    <i class="ri-user-line text-green-600 text-lg"></i>
                                </div>
                                <span>Clients</span>
                            </a>

                            <a href="${pageContext.request.contextPath}/produit?action=list" 
                               class="flex items-center px-4 py-3.5 text-gray-700 rounded-xl hover:bg-gradient-to-r hover:from-blue-50 hover:to-indigo-50 hover:text-blue-600 transition-all duration-200 font-medium group">
                                <div class="w-10 h-10 rounded-xl bg-orange-100 flex items-center justify-center mr-3 group-hover:scale-110 transition-transform">
                                    <i class="ri-box-3-line text-orange-600 text-lg"></i>
                                </div>
                                <span>Produits</span>
                            </a>

                            <a href="${pageContext.request.contextPath}/vente?action=list" 
                               class="flex items-center px-4 py-3.5 text-gray-700 rounded-xl hover:bg-gradient-to-r hover:from-blue-50 hover:to-indigo-50 hover:text-blue-600 transition-all duration-200 font-medium group">
                                <div class="w-10 h-10 rounded-xl bg-purple-100 flex items-center justify-center mr-3 group-hover:scale-110 transition-transform">
                                    <i class="ri-shopping-cart-2-line text-purple-600 text-lg"></i>
                                </div>
                                <span>Ventes</span>
                            </a>

                            <!-- new vente mobile -->
                            <a href="${pageContext.request.contextPath}/vente?action=new" 
                               class="flex items-center px-4 py-4 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-xl font-bold shadow-lg mt-3 transform hover:scale-105 transition-all duration-300">
                                <div class="w-10 h-10 rounded-xl bg-white/20 flex items-center justify-center mr-3">
                                    <i class="ri-add-circle-line text-xl"></i>
                                </div>
                                <span>Nouvelle Vente</span>
                            </a>
                        </div>

                        <!-- lign separateur -->
                        <div class="border-t border-gray-200 my-4"></div>

                        <!-- parametre et deconnexion -->
                        <div class="space-y-1.5">
                            <a href="${pageContext.request.contextPath}/admin?action=profile" 
                               class="flex items-center px-4 py-3 text-gray-700 rounded-xl hover:bg-blue-50 transition-all duration-200 font-medium">
                                <i class="ri-user-settings-line text-blue-600 text-xl mr-3"></i>
                                <span>Mon Profil</span>
                            </a>

                            <a href="${pageContext.request.contextPath}/admin?action=change-password" 
                               class="flex items-center px-4 py-3 text-gray-700 rounded-xl hover:bg-blue-50 transition-all duration-200 font-medium">
                                <i class="ri-lock-password-line text-purple-600 text-xl mr-3"></i>
                                <span>Changer Mot de Passe</span>
                            </a>

                            <a href="${pageContext.request.contextPath}/login?action=logout" 
                               class="flex items-center px-4 py-3 text-red-600 rounded-xl hover:bg-red-50 transition-all duration-200 font-medium">
                                <i class="ri-logout-box-r-line text-xl mr-3"></i>
                                <span>Déconnexion</span>
                            </a>
                        </div>
                    </c:when>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<script>
    // gestion du menu hamburger 
    document.addEventListener('DOMContentLoaded', function () {
        const mobileMenuButton = document.getElementById('mobile-menu-button');
        const mobileMenu = document.getElementById('mobile-menu');

        mobileMenuButton.addEventListener('click', function (e) {
            e.stopPropagation();

            // toggle menu
            if (mobileMenu.classList.contains('hidden')) {
                mobileMenu.classList.remove('hidden');
                // anim d'apparition
                setTimeout(() => {
                    mobileMenu.style.opacity = '1';
                    mobileMenu.style.transform = 'translateY(0)';
                }, 10);
            } else {
                mobileMenu.style.opacity = '0';
                mobileMenu.style.transform = 'translateY(-10px)';
                setTimeout(() => {
                    mobileMenu.classList.add('hidden');
                }, 300);
            }

            // anime le bouton hamburger
            const spans = mobileMenuButton.querySelectorAll('span');
            if (!mobileMenu.classList.contains('hidden')) {
                spans[0].style.transform = 'rotate(45deg) translateY(8px)';
                spans[1].style.opacity = '0';
                spans[2].style.transform = 'rotate(-45deg) translateY(-8px)';
            } else {
                spans[0].style.transform = 'rotate(0) translateY(0)';
                spans[1].style.opacity = '1';
                spans[2].style.transform = 'rotate(0) translateY(0)';
            }
        });

        // fermer menu mobile en cliquant hors du nav
        document.addEventListener('click', function (event) {
            if (!mobileMenu.contains(event.target) && !mobileMenuButton.contains(event.target)) {
                if (!mobileMenu.classList.contains('hidden')) {
                    mobileMenu.style.opacity = '0';
                    mobileMenu.style.transform = 'translateY(-10px)';
                    setTimeout(() => {
                        mobileMenu.classList.add('hidden');
                    }, 300);

                    // reset hamburger 
                    const spans = mobileMenuButton.querySelectorAll('span');
                    spans[0].style.transform = 'rotate(0) translateY(0)';
                    spans[1].style.opacity = '1';
                    spans[2].style.transform = 'rotate(0) translateY(0)';
                }
            }
        });

        // style initial pour l'anim
        mobileMenu.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
        mobileMenu.style.opacity = '0';
        mobileMenu.style.transform = 'translateY(-10px)';
    });
</script>

<style>
    /* anim pour le backdrop blur */
    nav {
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
    }

    /* smooth transition pour toute elements*/
    * {
        transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);
    }
</style>