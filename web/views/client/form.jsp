<%-- 
    Document   : form
    Created on : 6 nov. 2025, 13:26:19
    Author     : USER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../includes/header.jsp" />
<jsp:include page="../includes/navbar.jsp" />

<main class="max-w-4xl mx-auto py-6 px-4">
    <div class="mb-6">
        <h1 class="text-3xl font-bold text-gray-900">
            <c:choose>
                <c:when test="${not empty client}">
                    <i class="ri-user-settings-line mr-2"></i>Modifier le Client
                </c:when>
                <c:otherwise>
                    <i class="ri-user-add-line mr-2"></i>Nouveau Client
                </c:otherwise>
            </c:choose>
        </h1>
    </div>

    <div class="bg-white shadow rounded-lg">
        <div class="px-6 py-4 border-b border-gray-200">
            <h2 class="text-xl font-semibold text-gray-800">
                <c:choose>
                    <c:when test="${not empty client}">Modifier les informations du client</c:when>
                    <c:otherwise>Ajouter un nouveau client</c:otherwise>
                </c:choose>
                <h6 class="text-red-600 py-2" >les champs avec * sont obligatoire</h6>
        </div>

        <form method="post" 
              action="${pageContext.request.contextPath}/client?action=${not empty client ? 'update' : 'insert'}"
              id="clientForm"
              onsubmit="return validateForm()">

            <c:if test="${not empty client}">
                <input type="hidden" name="id" value="${client.id}">
            </c:if>

            <div class="p-6 space-y-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- nom -->
                    <div>
                        <label for="nom" class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="ri-user-line mr-1"></i>Nom *
                        </label>
                        <input type="text" id="nom" name="nom" required
                               value="${client.nom}"
                               class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                    </div>

                    <!-- prenom -->
                    <div>
                        <label for="prenom" class="block text-sm font-medium text-gray-700 mb-2">
                            <i class="ri-user-line mr-1"></i>Prénom *
                        </label>
                        <input type="text" id="prenom" name="prenom" required
                               value="${client.prenom}"
                               class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">
                    </div>
                </div>

                <!-- email -->
                <div>
                    <label for="email" class="block text-sm font-medium text-gray-700 mb-2">
                        <i class="ri-mail-line mr-1"></i>Email *
                    </label>
                    <input type="email" id="email" name="email" required
                           value="${client.email}"
                           class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                           placeholder="exemple@gmail.com">
                    <div class="text-xs text-gray-500 mt-1">
                        Formats acceptés: gmail.com, yahoo.com, outlook.com, hotmail.com, orange.mg, etc.
                    </div>
                    <div id="emailError" class="text-red-500 text-sm mt-1 hidden"></div>
                </div>

                <!-- phone -->
                <div>
                    <label for="telephone" class="block text-sm font-medium text-gray-700 mb-2">
                        <i class="ri-phone-line mr-1"></i>Téléphone *
                    </label>
                    <input type="tel" id="telephone" name="telephone" required
                           value="${client.telephone}"
                           class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500"
                           placeholder="+261321234567">
                    <div class="text-xs text-gray-500 mt-1">
                        Format: +261 suivi de 9 chiffres (operateurs: 32, 33, 34, 38)
                    </div>
                    <div id="phoneError" class="text-red-500 text-sm mt-1 hidden"></div>
                </div>

                <!-- adresse -->
                <div>
                    <label for="adresse" class="block text-sm font-medium text-gray-700 mb-2">
                        <i class="ri-map-pin-line mr-1"></i>Adresse *
                    </label>
                    <textarea id="adresse" name="adresse" required rows="3"
                              class="w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500">${client.adresse}</textarea>
                </div>
            </div>

            <div class="px-6 py-4 bg-gray-50 border-t border-gray-200 flex justify-end space-x-3">
                <a href="${pageContext.request.contextPath}/client?action=list" 
                   class="bg-gray-300 hover:bg-gray-400 border-red-500 border text-gray-800 px-4 py-2 rounded-md transition duration-300">
                    <i class="ri-arrow-left-line mr-2"></i>Annuler
                </a>
                <button type="submit" 
                        class="bg-blue-600 hover:bg-blue-700 text-white px-6 py-2 rounded-md transition duration-300">
                    <i class="ri-save-line mr-2"></i>
                    <c:choose>
                        <c:when test="${not empty client}">Modifier</c:when>
                        <c:otherwise>Enregistrer</c:otherwise>
                    </c:choose>
                </button>
            </div>
        </form>
    </div>
</main>

<script>
    // validation en temps reel pour l'email
    document.getElementById('email').addEventListener('blur', function () {
        validateEmail();
    });

    //validation en temps reell pour le phone
    document.getElementById('telephone').addEventListener('blur', function () {
        validatePhone();
    });

    function validateEmail() {
        const email = document.getElementById('email').value;
        const emailError = document.getElementById('emailError');

        // regex  emails et validation de domaine fampiase matetika
        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

        // liste  domaines fampiasa matetika
        const commonDomains = ['gmail.com', 'yahoo.com', 'outlook.com', 'hotmail.com',
            'icloud.com', 'orange.mg', 'blueline.mg', 'telma.mg',
            'aol.com', 'protonmail.com'];

        if (!email) {
            emailError.textContent = 'l\'email est requis';
            emailError.classList.remove('hidden');
            return false;
        }

        if (!emailRegex.test(email)) {
            emailError.textContent = 'format email invalide. Ex: exemple@gmail.com';
            emailError.classList.remove('hidden');
            return false;
        }

        // Vérification optionnelle du domaine
        const domain = email.split('@')[1];
        if (domain && !commonDomains.some(d => domain.includes(d))) {
            // Si le domaine n'est pas dans la liste, on accepte quand même mais on peut afficher un avertissement
            emailError.textContent = 'domaine non reconnu. Verifiez l\'orthographe.';
            emailError.classList.remove('hidden');
            return false;
        }

        emailError.classList.add('hidden');
        return true;
    }

    function validatePhone() {
        const phone = document.getElementById('telephone').value;
        const phoneError = document.getElementById('phoneError');

        // regex pour le num malagasy
        const phoneRegex = /^\+261(?:32|33|34|38)\d{7}$/;

        if (!phone) {
            phoneError.textContent = 'Le téléphone est requis';
            phoneError.classList.remove('hidden');
            return false;
        }

        if (!phoneRegex.test(phone)) {
            phoneError.textContent = 'format teléphone invalide. Ex: +261321234567 (Operateurs: 32,33,34,38)';
            phoneError.classList.remove('hidden');
            return false;
        }

        phoneError.classList.add('hidden');
        return true;
    }

    function validateForm() {
        const isEmailValid = validateEmail();
        const isPhoneValid = validatePhone();

        if (!isEmailValid) {
            document.getElementById('email').focus();
            return false;
        }

        if (!isPhoneValid) {
            document.getElementById('telephone').focus();
            return false;
        }

        return true;
    }

    // validation initiale si le form contient de valeurs, pour le modification
    document.addEventListener('DOMContentLoaded', function () {
        if (document.getElementById('email').value) {
            validateEmail();
        }
        if (document.getElementById('telephone').value) {
            validatePhone();
        }
    });
</script>

<jsp:include page="../includes/footer.jsp" />