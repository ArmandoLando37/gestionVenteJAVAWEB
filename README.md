# Gestion de ventes Java Web

Application web académique de gestion de clients, de produits et de ventes. Le projet propose une interface d'administration permettant d'enregistrer les données commerciales, de suivre le stock et de générer un reçu PDF pour une vente.

## Contexte

Ce projet a été réalisé dans un cadre pédagogique pour mettre en pratique le développement d'une application Java Web classique. Il est organisé autour de servlets, de pages JSP, d'une couche DAO et d'une base de données MySQL/MariaDB.

## Fonctionnalités

- Authentification d'un administrateur.
- Gestion des clients : ajout, consultation, modification et suppression.
- Gestion des produits et du stock.
- Création et consultation des ventes.
- Association d'une vente à un client et de plusieurs produits à une vente.
- Génération d'un reçu PDF.
- Protection des routes d'administration par filtre d'authentification.
- Encodage UTF-8 des requêtes et des réponses.

## Technologies utilisées

- Java Web avec Servlets et JSP
- Apache Ant et NetBeans
- MySQL ou MariaDB
- JDBC avec MySQL Connector/J
- JSTL
- iText 5 pour les reçus PDF
- Apache Tomcat ou un serveur compatible Servlet 4.0
- Tailwind CSS via CDN

## Structure principale

```text
src/java/com/gestionvente/
├── controller/   Servlets de traitement des requêtes
├── dao/          Accès aux données
├── model/        Entités métier
├── filter/       Contrôle d'accès
└── util/         Connexion à la base, encodage et génération PDF

web/
├── views/        Pages JSP
├── css/          Feuilles de style et icônes
└── WEB-INF/      Configuration de l'application

gestion_vente.sql Script de création et d'initialisation de la base
build.xml         Configuration Apache Ant
```

## Prérequis

Avant de lancer l'application, installer :

1. JDK 8 ou version compatible avec la configuration du projet.
2. Apache NetBeans avec le support Java Web, ou Apache Ant en ligne de commande.
3. MySQL ou MariaDB.
4. Apache Tomcat compatible avec Servlet 4.0.

## Installation de la base de données

Créer la base puis importer le script fourni :

```sql
CREATE DATABASE gestion_vente CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```

Avec le client MySQL/MariaDB :

```bash
mysql -u root -p gestion_vente < gestion_vente.sql
```

Le projet utilise actuellement la configuration suivante dans `DatabaseConnection.java` :

```text
Hôte     : localhost
Port     : 3306
Base     : gestion_vente
Utilisateur : root
Mot de passe : vide par défaut
```

Pour un environnement différent, modifier cette configuration avant le lancement. En production, utiliser des variables de configuration sécurisées plutôt que de conserver les identifiants dans le code.

## Lancement avec NetBeans

1. Ouvrir le dossier dans NetBeans.
2. Configurer le JDK et le serveur Tomcat dans les propriétés du projet.
3. Vérifier la connexion à MySQL/MariaDB.
4. Cliquer sur **Run Project**.
5. Ouvrir l'URL affichée par NetBeans. La page d'accueil redirige vers `/login`.

## Construction avec Apache Ant

Depuis la racine du projet :

```bash
ant clean
ant dist
```

Le fichier WAR généré se trouve généralement dans `dist/`. Déployer ensuite ce fichier dans Tomcat, puis démarrer le serveur.

## Connexion de démonstration

Les données d'exemple du script SQL contiennent un compte administrateur initial. Vérifier les identifiants directement dans `gestion_vente.sql` et les modifier immédiatement pour toute utilisation réelle.

## Remarques

- Il s'agit d'un projet académique simple.
- Le mot de passe administrateur présent dans les données d'exemple n'est pas adapté à la production.
- Les identifiants de base de données sont actuellement définis dans le code source.
- Avant un déploiement public, ajouter un stockage sécurisé des secrets, un hachage robuste des mots de passe et une configuration HTTPS.

## Licence

Aucune licence open source n'est actuellement déclarée. Contactez l'auteur avant toute réutilisation ou redistribution.
