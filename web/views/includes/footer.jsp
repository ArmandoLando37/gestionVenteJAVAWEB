<%-- 
    Document   : footer
    Created on : 5 nov. 2025, 13:26:02
    Author     : USER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     </div>
    </main>
    
    <!-- footer -->
    <footer class="bg-gray-800 text-white mt-12">
        <div class="max-w-7xl mx-auto py-6 px-4">
            <div class="text-center">
                <p> 2025 GestionVente - Système de gestion des ventes</p>
                <p class="text-gray-400 text-sm mt-2"> Java EE, Servlet & JSP LEO BE </p>
            </div>
        </div>
    </footer>
    
    <!-- scripts js -->
    <script>
        // script pour les initialisation de page
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    alert.style.opacity = '0';
                    setTimeout(() => alert.remove(), 300);
                }, 5000);
            });
            
            // gestion des menus deroulants
            const dropdowns = document.querySelectorAll('.group');
            dropdowns.forEach(dropdown => {
                dropdown.addEventListener('mouseenter', function() {
                    this.querySelector('.hidden').classList.remove('hidden');
                });
                dropdown.addEventListener('mouseleave', function() {
                    this.querySelector('.block').classList.add('hidden');
                });
            });
        });
        
        // fonction pour confirmer les suppression
        function confirmDelete(message) {
            return confirm(message || 'Êtes-vous sûr de vouloir supprimer cet élément ?');
        }
        
        // calcul du total pour les vente
        function calculateTotal() {
            let total = 0;
            document.querySelectorAll('.produit-row').forEach(row => {
                const select = row.querySelector('.produit-select');
                const input = row.querySelector('.quantite-input');
                
                if (select.value && input.value) {
                    const prix = parseFloat(select.selectedOptions[0].dataset.prix);
                    const quantite = parseInt(input.value);
                    total += prix * quantite;
                }
            });
            
            document.getElementById('totalVente').textContent = total.toFixed(2) + ' ?';
        }
    </script>
</body>
</html>