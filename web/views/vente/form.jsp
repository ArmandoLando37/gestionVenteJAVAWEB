<%-- 
    Document   : form
    Created on : 7 nov. 2025, 9:27:01
    Author     : USER
--%>
<%-- 
    Document   : form
    Created on : 7 nov. 2025, 9:27:01
    Author     : USER
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<main class="min-h-screen bg-gradient-to-br from-gray-50 via-blue-50 to-indigo-50 py-8 px-4">
    <div class="max-w-6xl mx-auto">
        <!-- En-tête -->
        <div class="mb-8 animate-fade-in">
            <div class="flex items-center gap-3 mb-2">
                <div class="w-12 h-12 rounded-2xl bg-gradient-to-br from-blue-600 to-indigo-600 flex items-center justify-center shadow-lg">
                    <i class="ri-shopping-cart-2-line text-white text-2xl"></i>
                </div>
                <div>
                    <h1 class="text-2xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-indigo-600">
                        Nouvelle Vente
                    </h1>
                    <p class="text-gray-600 mt-1">Enregistrer une nouvelle transaction</p>
                </div>
            </div>
        </div>

        <!-- Message d'erreur -->
        <c:if test="${not empty param.error}">
            <div class="bg-red-50 border-l-4 border-red-500 rounded-xl p-4 mb-6 shadow-md animate-shake">
                <div class="flex items-center">
                    <div class="flex-shrink-0">
                        <i class="ri-error-warning-line text-red-500 text-2xl"></i>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium text-red-800">
                            Erreur lors de l'enregistrement de la vente
                        </p>
                    </div>
                </div>
            </div>
        </c:if>

        <form method="post" action="${pageContext.request.contextPath}/vente?action=insert" id="venteForm">
            <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                <!-- Colonne Sélection Client -->
                <div class="lg:col-span-1">
                    <div class="bg-white rounded-2xl shadow-lg border border-gray-100 overflow-hidden transform transition-all duration-300 hover:shadow-2xl">
                        <div class="bg-gradient-to-r from-blue-600 to-indigo-600 px-6 py-4">
                            <h2 class="text-xl font-bold text-white flex items-center">
                                <i class="ri-user-line mr-2"></i>
                                Sélection du Client
                            </h2>
                        </div>
                        
                        <div class="p-6">
                            <div class="space-y-4">
                                <div>
                                    <label for="client_id" class="block text-sm font-semibold text-gray-700 mb-2">
                                        Client <span class="text-red-500">*</span>
                                    </label>
                                    <div class="relative">
                                        <select id="client_id" name="client_id" required
                                                class="w-full px-4 py-3 border-2 border-gray-200 rounded-xl shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-300 appearance-none bg-white">
                                            <option value="">Selectionner un client</option>
                                            <c:forEach var="client" items="${clients}">
                                                <option value="${client.id}">${client.nom} ${client.prenom}</option>
                                            </c:forEach>
                                        </select>
                                        <i class="ri-arrow-down-s-line absolute right-4 top-1/2 transform -translate-y-1/2 text-gray-400 pointer-events-none"></i>
                                    </div>
                                </div>
                                
                                <!-- Info client sélectionné -->
                                <div id="clientInfo" class="hidden bg-blue-50 rounded-xl p-4 border border-blue-200">
                                    <div class="flex items-center">
                                        <div class="w-10 h-10 rounded-full bg-blue-600 flex items-center justify-center mr-3">
                                            <i class="ri-user-line text-white"></i>
                                        </div>
                                        <div>
                                            <p class="text-sm font-semibold text-blue-900">Client sélectionné</p>
                                            <p class="text-xs text-blue-700" id="clientName"></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Colonne Produits -->
                <div class="lg:col-span-2">
                    <div class="bg-white rounded-2xl shadow-lg border border-gray-100 overflow-hidden transform transition-all duration-300 hover:shadow-2xl">
                        <div class="bg-gradient-to-r from-green-600 to-emerald-600 px-6 py-4 flex justify-between items-center">
                            <h2 class="text-xl font-bold text-white flex items-center">
                                <i class="ri-box-3-line mr-2"></i>
                                Produits de la Vente
                            </h2>
                            <span id="productCount" class="bg-white/20 px-3 py-1 rounded-full text-sm font-semibold text-white">
                                0 produit(s)
                            </span>
                        </div>

                        <div class="p-6">
                            <!-- Container des produits -->
                            <div id="produitsContainer" class="space-y-4">
                                <!-- Premier produit par défaut -->
                                <div class="produit-row bg-gradient-to-r from-gray-50 to-blue-50 rounded-xl p-4 border-2 border-gray-200 transition-all duration-300">
                                    <div class="grid grid-cols-12 gap-4 items-end">
                                        <div class="col-span-12 sm:col-span-6">
                                            <label class="block text-sm font-semibold text-gray-700 mb-2">
                                                Produit <span class="text-red-500">*</span>
                                            </label>
                                            <div class="relative">
                                                <select name="produit_id" required
                                                        class="produit-select w-full px-4 py-3 border-2 border-gray-300 rounded-xl shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-300 appearance-none bg-white">
                                                    <option value="">Selectionner un produit</option>
                                                    <c:forEach var="produit" items="${produits}">
                                                        <c:if test="${produit.stock > 0}">
                                                            <option value="${produit.id}" 
                                                                    data-prix="${produit.prix}" 
                                                                    data-stock="${produit.stock}"
                                                                    data-nom="${produit.nom}">
                                                                ${produit.nom} - ${produit.prix} Ar )
                                                            </option>
                                                        </c:if>
                                                    </c:forEach>
                                                </select>
                                                <i class="ri-arrow-down-s-line absolute right-4 top-1/2 transform -translate-y-1/2 text-gray-400 pointer-events-none"></i>
                                            </div>
                                        </div>
                                        
                                        <div class="col-span-10 sm:col-span-4">
                                            <label class="block text-sm font-semibold text-gray-700 mb-2">
                                                Quantité <span class="text-red-500">*</span>
                                            </label>
                                            <div class="relative">
                                                <input type="number" name="quantite" min="1" value="" required
                                                       class="quantite-input w-full px-4 py-3 border-2 border-gray-300 rounded-xl shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-300">
                                                <div class="flex items-center gap-2 mt-2">
                                                    <span class="stock-indicator inline-flex items-center px-2 py-1 rounded-lg text-xs font-semibold">
                                                        <i class="ri-store-line mr-1"></i>
                                                        Stock: <span class="stock-display ml-1">0</span>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="col-span-2">
                                            <button type="button" onclick="removeProduit(this)" 
                                                    class="w-full bg-red-500 hover:bg-red-600 text-white p-3 rounded-xl transition-all duration-300 transform hover:scale-105 shadow-md hover:shadow-lg">
                                                <i class="ri-delete-bin-line text-xl"></i>
                                            </button>
                                        </div>
                                    </div>
                                    
                                  
                                </div>
                            </div>

                            <!-- bouton ajouter produit -->
                            <div class="mt-6">
                                <button type="button" onclick="addProduit()" 
                                        class="w-full bg-gradient-to-r from-green-500 to-emerald-600 hover:from-green-600 hover:to-emerald-700 text-white px-6 py-4 rounded-xl font-semibold transition-all duration-300 transform hover:scale-105 shadow-lg hover:shadow-xl flex items-center justify-center">
                                    <i class="ri-add-line text-xl mr-2"></i>
                                    Ajouter un produit
                                </button>
                            </div>

                            <!-- total  -->
                            <div class="mt-8 p-6 bg-gradient-to-r from-blue-50 to-indigo-50 rounded-2xl border-2 border-blue-200">
                                <div class="flex justify-between items-center">
                                    <div>
                                        <p class="text-sm text-gray-600 uppercase tracking-wide font-semibold">Total de la vente</p>
                                        
                                    </div>
                                    <div class="text-right">
                                        <p id="totalVente" class="text-2xl font-extrabold text-transparent bg-clip-text bg-gradient-to-r from-blue-600 to-indigo-600">
                                            0.00 Ar
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Boutons d'action -->
                        <div class="px-6 py-4 bg-gray-50 border-t border-gray-200 flex flex-col sm:flex-row justify-end gap-3">
                            <a href="${pageContext.request.contextPath}/vente?action=list" 
                               class="flex items-center justify-center bg-gray-200 hover:bg-gray-300 text-gray-800 px-6 py-3 rounded-xl font-semibold transition-all duration-300 transform hover:scale-105">
                                <i class="ri-arrow-left-line mr-2"></i>
                                Annuler
                            </a>
                            <button type="submit" 
                                    class="flex items-center justify-center bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 text-white px-8 py-3 rounded-xl font-semibold transition-all duration-300 transform hover:scale-105 shadow-lg hover:shadow-xl">
                                <i class="ri-check-line mr-2 text-xl"></i>
                                Enregistrer la Vente
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</main>

<style>
@keyframes fade-in {
    from { opacity: 0; transform: translateY(-10px); }
    to { opacity: 1; transform: translateY(0); }
}

@keyframes shake {
    0%, 100% { transform: translateX(0); }
    10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
    20%, 40%, 60%, 80% { transform: translateX(5px); }
}

.animate-fade-in {
    animation: fade-in 0.6s ease-out;
}

.animate-shake {
    animation: shake 0.5s ease-out;
}

/* Styles pour les indicateurs de stock */
.stock-indicator {
    transition: all 0.3s ease;
}

.stock-high {
    background-color: #dcfce7;
    color: #166534;
    border: 1px solid #86efac;
}

.stock-medium {
    background-color: #fef3c7;
    color: #92400e;
    border: 1px solid #fcd34d;
}

.stock-low {
    background-color: #fee2e2;
    color: #991b1b;
    border: 1px solid #fca5a5;
}

.stock-empty {
    background-color: #f3f4f6;
    color: #6b7280;
    border: 1px solid #d1d5db;
}

/* Animation pour les lignes de produit */
.produit-row {
    animation: slideIn 0.3s ease-out;
}

@keyframes slideIn {
    from {
        opacity: 0;
        transform: translateX(-20px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

/* Style pour input invalide */
.quantite-input.invalid {
    border-color: #ef4444;
    background-color: #fef2f2;
}

.quantite-input.valid {
    border-color: #22c55e;
}
</style>

<script>
    // Fonction pour ajouter un nouveau produit
    function addProduit() {
        const container = document.getElementById('produitsContainer');
        const newRow = document.createElement('div');
        newRow.className = 'produit-row bg-gradient-to-r from-gray-50 to-blue-50 rounded-xl p-4 border-2 border-gray-200 transition-all duration-300';
        newRow.innerHTML = `
            <div class="grid grid-cols-12 gap-4 items-end">
                <div class="col-span-12 sm:col-span-6">
                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                        Produit <span class="text-red-500">*</span>
                    </label>
                    <div class="relative">
                        <select name="produit_id" required
                                class="produit-select w-full px-4 py-3 border-2 border-gray-300 rounded-xl shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-300 appearance-none bg-white">
                            <option value="">Selectionner un produit</option>
                            <c:forEach var="produit" items="${produits}">
                                <c:if test="${produit.stock > 0}">
                                    <option value="${produit.id}" 
                                            data-prix="${produit.prix}" 
                                            data-stock="${produit.stock}"
                                            data-nom="${produit.nom}">
                                        ${produit.nom} - ${produit.prix} Ar 
                                    </option>
                                </c:if>
                            </c:forEach>
                        </select>
                        <i class="ri-arrow-down-s-line absolute right-4 top-1/2 transform -translate-y-1/2 text-gray-400 pointer-events-none"></i>
                    </div>
                </div>
                
                <div class="col-span-10 sm:col-span-4">
                    <label class="block text-sm font-semibold text-gray-700 mb-2">
                        Quantité <span class="text-red-500">*</span>
                    </label>
                    <div class="relative">
                        <input type="number" name="quantite" min="1" value="" required
                               class="quantite-input w-full px-4 py-3 border-2 border-gray-300 rounded-xl shadow-sm focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent transition-all duration-300">
                        <div class="flex items-center gap-2 mt-2">
                            <span class="stock-indicator inline-flex items-center px-2 py-1 rounded-lg text-xs font-semibold">
                                <i class="ri-store-line mr-1"></i>
                                Stock: <span class="stock-display ml-1">0</span>
                            </span>
                        </div>
                    </div>
                </div>
                
                <div class="col-span-2">
                    <button type="button" onclick="removeProduit(this)" 
                            class="w-full bg-red-500 hover:bg-red-600 text-white p-3 rounded-xl transition-all duration-300 transform hover:scale-105 shadow-md hover:shadow-lg">
                        <i class="ri-delete-bin-line text-xl"></i>
                    </button>
                </div>
            </div>
           
        `;
        container.appendChild(newRow);
        
        // Ajouter les événements
        const select = newRow.querySelector('.produit-select');
        const input = newRow.querySelector('.quantite-input');
        
        select.addEventListener('change', function() {
            updateStockForAllRows();
            calculateTotal();
        });
        
        input.addEventListener('input', function() {
            validateQuantity(this);
            updateStockForAllRows();
            calculateTotal();
        });
        
        updateStockForAllRows();
        calculateTotal();
        updateProductCount();
    }

    // Fonction pour enlever un produit
    function removeProduit(button) {
        const rows = document.querySelectorAll('.produit-row');
        if (rows.length > 1) {
            const row = button.closest('.produit-row');
            row.style.animation = 'slideOut 0.3s ease-out';
            setTimeout(() => {
                row.remove();
                updateStockForAllRows();
                calculateTotal();
                updateProductCount();
            }, 300);
        } else {
            showNotification('Il faut au moins un produit dans la vente', 'warning');
        }
    }

    // Valider la quantité en temps réel
    function validateQuantity(input) {
        const row = input.closest('.produit-row');
        const stockDisplay = row.querySelector('.stock-display');
        const stockDisponible = parseInt(stockDisplay.textContent);
        const quantite = parseInt(input.value) || 0;
        
        input.classList.remove('invalid', 'valid');
        
        if (quantite > stockDisponible) {
            input.classList.add('invalid');
            input.value = stockDisponible;
        } else if (quantite > 0) {
            input.classList.add('valid');
        }
    }

    // Mettre à jour les stocks pour toutes les lignes
    function updateStockForAllRows() {
        const quantitesParProduit = {};
        
        // Compter les quantités par produit
        document.querySelectorAll('.produit-row').forEach(row => {
            const select = row.querySelector('.produit-select');
            const input = row.querySelector('.quantite-input');
            
            if (select.value) {
                const produitId = select.value;
                const quantite = parseInt(input.value) || 0;
                
                if (!quantitesParProduit[produitId]) {
                    quantitesParProduit[produitId] = 0;
                }
                quantitesParProduit[produitId] += quantite;
            }
        });
        
        // Mettre à jour chaque ligne
        document.querySelectorAll('.produit-row').forEach(row => {
            const select = row.querySelector('.produit-select');
            const input = row.querySelector('.quantite-input');
            const stockDisplay = row.querySelector('.stock-display');
            const stockIndicator = row.querySelector('.stock-indicator');
            
            if (select.value) {
                const produitId = select.value;
                const stockInitial = parseInt(select.selectedOptions[0].dataset.stock);
                const quantiteDansCetteLigne = parseInt(input.value) || 0;
                const quantiteTotalePourCeProduit = quantitesParProduit[produitId] || 0;
                
                const stockDisponible = stockInitial - (quantiteTotalePourCeProduit - quantiteDansCetteLigne);
                
                stockDisplay.textContent = stockDisponible;
                input.setAttribute('max', Math.max(0, stockDisponible));
                
                // Appliquer les styles selon le stock
                stockIndicator.classList.remove('stock-high', 'stock-medium', 'stock-low', 'stock-empty');
                if (stockDisponible === 0) {
                    stockIndicator.classList.add('stock-empty');
                } else if (stockDisponible <= 5) {
                    stockIndicator.classList.add('stock-low');
                } else if (stockDisponible <= 20) {
                    stockIndicator.classList.add('stock-medium');
                } else {
                    stockIndicator.classList.add('stock-high');
                }
                
                // Ajuster si nécessaire
                if (quantiteDansCetteLigne > stockDisponible) {
                    input.value = Math.max(1, stockDisponible);
                }
            } else {
                stockDisplay.textContent = '0';
                stockIndicator.classList.remove('stock-high', 'stock-medium', 'stock-low');
                stockIndicator.classList.add('stock-empty');
            }
        });
    }

    // Calculer le total
    function calculateTotal() {
        let total = 0;
        
        document.querySelectorAll('.produit-row').forEach(row => {
            const select = row.querySelector('.produit-select');
            const input = row.querySelector('.quantite-input');
            
            
            if (select.value && input.value) {
                const prix = parseFloat(select.selectedOptions[0].dataset.prix);
                const quantite = parseInt(input.value);
                const sousTotal = prix * quantite;
                
            } else {
                ligneTotal.textContent = '0.00 Ar';
            }
        });
        
        document.getElementById('totalVente').textContent = total + ' Ar';
    }

    // Mettre à jour le compteur de produits
    function updateProductCount() {
        const count = document.querySelectorAll('.produit-row').length;
        document.getElementById('productCount').textContent = count + ' produit(s)';
    }

    // Afficher une notification
    function showNotification(message, type = 'info') {
        const colors = {
            info: 'bg-blue-500',
            warning: 'bg-yellow-500',
            error: 'bg-red-500',
            success: 'bg-green-500'
        };
        
        const notification = document.createElement('div');
        notification.className = `fixed top-4 right-4 ${colors[type]} text-white px-6 py-3 rounded-xl shadow-lg z-50 animate-fade-in`;
        notification.innerHTML = `<i class="ri-information-line mr-2"></i>${message}`;
        document.body.appendChild(notification);
        
        setTimeout(() => {
            notification.remove();
        }, 3000);
    }

    // Validation avant soumission
    document.getElementById('venteForm').addEventListener('submit', function(e) {
        let hasError = false;
        let errorMessages = [];
        
        // Vérifier le client
        const clientId = document.getElementById('client_id').value;
        if (!clientId) {
            hasError = true;
            errorMessages.push('Veuillezt selectionner un client');
        }
        
        // Vérifier les stocks
        updateStockForAllRows();
        
        document.querySelectorAll('.produit-row').forEach((row, index) => {
            const select = row.querySelector('.produit-select');
            const input = row.querySelector('.quantite-input');
            const stockDisplay = row.querySelector('.stock-display');
            
            if (!select.value) {
                hasError = true;
                errorMessages.push(`Ligne ${index + 1}: Veuillezds selectionner un produit`);
            } else {
                const quantite = parseInt(input.value);
                const stockDisponible = parseInt(stockDisplay.textContent);
                
                if (quantite > stockDisponible) {
                    hasError = true;
                    errorMessages.push(`Ligne ${index + 1}: Quantité (${quantite}) > Stock disponible (${stockDisponible})`);
                }
                
                if (quantite < 1) {
                    hasError = true;
                    errorMessages.push(`Ligne ${index + 1}: La quantite doit être au moins 1`);
                }
            }
        });
        
        if (hasError) {
            e.preventDefault();
            showNotification(errorMessages.join(' ? '), 'error');
        }
    });

    // Afficher les infos du client sélectionné
    document.getElementById('client_id').addEventListener('change', function() {
        const clientInfo = document.getElementById('clientInfo');
        const clientName = document.getElementById('clientName');
        
        if (this.value) {
            clientName.textContent = this.options[this.selectedIndex].text;
            clientInfo.classList.remove('hidden');
        } else {
            clientInfo.classList.add('hidden');
        }
    });

    // Initialisation
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.produit-row').forEach(row => {
            const select = row.querySelector('.produit-select');
            const input = row.querySelector('.quantite-input');
            
            select.addEventListener('change', function() {
                updateStockForAllRows();
                calculateTotal();
            });
            
            input.addEventListener('input', function() {
                validateQuantity(this);
                updateStockForAllRows();
                calculateTotal();
            });
        });
        
        updateStockForAllRows();
        calculateTotal();
        updateProductCount();
    });
</script>

<style>
@keyframes slideOut {
    from {
        opacity: 1;
        transform: translateX(0);
    }
    to {
        opacity: 0;
        transform: translateX(20px);
    }
}
</style>

<jsp:include page="../includes/footer.jsp" />