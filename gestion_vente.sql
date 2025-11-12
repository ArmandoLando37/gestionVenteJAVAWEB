-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 10 nov. 2025 à 14:11
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `gestion_vente`
--

-- --------------------------------------------------------

--
-- Structure de la table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `nom_complet` varchar(100) DEFAULT NULL,
  `date_creation` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_login` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `email`, `nom_complet`, `date_creation`, `last_login`) VALUES
(1, 'admin', 'admin', 'admin@gestionvente.com', 'Administrateur Principal', '2025-11-07 11:53:31', '2025-11-09 13:21:27');

-- --------------------------------------------------------

--
-- Structure de la table `clients`
--

CREATE TABLE `clients` (
  `id` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `telephone` varchar(20) DEFAULT NULL,
  `adresse` text DEFAULT NULL,
  `date_creation` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `clients`
--

INSERT INTO `clients` (`id`, `nom`, `prenom`, `email`, `telephone`, `adresse`, `date_creation`) VALUES
(3, 'mirado', 'mahay', 'mirado@gmail.com', '0336120918', 'ivohitra antsirabe 2', '2025-11-07 12:05:27'),
(4, 'joary', 'VALIMBAVAKA', 'joary@gmail.com', '0384854253', 'Andranonahoatra', '2025-11-07 16:40:02'),
(5, 'Tsiky', 'Ny Antsa', 'tsiky@gmail.com', '+261321234567', 'betafo', '2025-11-08 08:11:09'),
(7, 'sedra', 'kely', 'sedra@yahoo.com', '+261384854253', 'killllll', '2025-11-08 12:34:55'),
(10, 'Arinosy', 'Namby', 'nosy@gmail.com', '+261323232332', 'Andranonahoatra Antsirabe 1', '2025-11-09 10:37:01'),
(11, 'petera', 'RAMAMONJY', 'pet@gmail.com', '+261322211551', 'soniazo', '2025-11-09 14:41:52'),
(12, 'vanella', 'Maroantsetra', 'vanel@gmail.com', '+261381212312', 'Sapanan\'charbon mandaniresaka, vavahady menamena', '2025-11-10 08:39:43');

-- --------------------------------------------------------

--
-- Structure de la table `ligne_vente`
--

CREATE TABLE `ligne_vente` (
  `id` int(11) NOT NULL,
  `vente_id` int(11) NOT NULL,
  `produit_id` int(11) NOT NULL,
  `quantite` int(11) NOT NULL,
  `prix_unitaire` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ligne_vente`
--

INSERT INTO `ligne_vente` (`id`, `vente_id`, `produit_id`, `quantite`, `prix_unitaire`) VALUES
(1, 1, 5, 24, 250000.00),
(2, 2, 5, 5, 250000.00),
(3, 3, 5, 1, 250000.00),
(4, 4, 5, 1, 250000.00),
(5, 5, 5, 1, 250000.00),
(6, 6, 5, 1, 250000.00),
(7, 7, 5, 1, 250000.00),
(8, 8, 5, 1, 250000.00),
(9, 9, 5, 1, 250000.00),
(10, 10, 2, 50, 29.99),
(12, 11, 5, 3, 250000.00),
(17, 15, 5, 10, 250000.00),
(19, 16, 1, 2, 799.99),
(20, 17, 3, 1, 89.99),
(21, 18, 2, 1, 29.99),
(22, 18, 2, 1, 29.99),
(23, 19, 3, 23, 89.99),
(24, 19, 3, 1, 89.99),
(25, 20, 5, 1, 250000.00),
(29, 23, 5, 1, 250000.00),
(30, 23, 3, 1, 89.99),
(31, 23, 2, 1, 29.99),
(32, 24, 2, 1, 29.99),
(33, 24, 3, 1, 89.99),
(34, 25, 3, 1, 89.99),
(36, 26, 2, 1, 29.99),
(37, 27, 2, 1, 29.99),
(39, 28, 5, 1, 250000.00),
(40, 28, 3, 1, 89.99),
(41, 28, 2, 1, 29.99),
(43, 29, 3, 16, 89.99),
(44, 29, 2, 7, 29.99),
(45, 29, 1, 13, 799.99),
(46, 30, 5, 1, 250000.00),
(47, 30, 2, 1, 29.99);

-- --------------------------------------------------------

--
-- Structure de la table `produits`
--

CREATE TABLE `produits` (
  `id` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `prix` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `date_creation` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `produits`
--

INSERT INTO `produits` (`id`, `nom`, `description`, `prix`, `stock`, `date_creation`) VALUES
(1, 'Ordinateur Portable', 'PC portable 15 pouces, 8GB RAM, 256GB SSD', 799.99, 5, '2025-11-07 11:53:31'),
(2, 'Souris Sans Fil', 'Souris ergonomique sans fil', 29.99, 19, '2025-11-07 11:53:31'),
(3, 'Clavier Mécanique', 'Clavier gaming mécanique RGB', 89.99, 0, '2025-11-07 11:53:31'),
(5, 'ordinateur hp2', 'sdq', 250000.00, 4, '2025-11-07 12:54:50'),
(6, 'Samsung Galaxy A15 128Go', '\nAppareil photo : 13 MP\nEnregistrement vidéo : 1080p @ 30 fps\nStockage : 128 G', 250000.00, 6, '2025-11-10 10:56:54');

-- --------------------------------------------------------

--
-- Structure de la table `ventes`
--

CREATE TABLE `ventes` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `date_vente` timestamp NOT NULL DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `ventes`
--

INSERT INTO `ventes` (`id`, `client_id`, `date_vente`, `total`) VALUES
(1, 4, '2025-11-07 16:42:21', 200.00),
(2, 3, '2025-11-07 16:47:36', 200.00),
(3, 3, '2025-11-07 16:49:23', 200.00),
(4, 3, '2025-11-07 16:49:37', 200.00),
(5, 3, '2025-11-07 16:49:48', 200.00),
(6, 3, '2025-11-07 16:54:21', 200.00),
(7, 3, '2025-11-08 07:14:20', 200.00),
(8, 5, '2025-11-08 09:50:57', 200.00),
(9, 5, '2025-11-08 09:56:54', 200.00),
(10, 5, '2025-11-08 10:50:14', 200.00),
(11, 3, '2025-11-08 10:51:29', 200.00),
(15, 7, '2025-11-08 13:20:34', 200.00),
(16, 7, '2025-11-08 16:04:18', 200.00),
(17, 7, '2025-11-09 07:42:44', 200.00),
(18, 4, '2025-11-09 08:27:08', 200.00),
(19, 3, '2025-11-09 09:30:52', 200.00),
(20, 5, '2025-11-09 09:33:27', 200.00),
(23, 10, '2025-11-09 10:37:55', 200.00),
(24, 10, '2025-11-09 12:18:22', 119.98),
(25, 4, '2025-11-09 12:19:48', 89.99),
(26, 7, '2025-11-09 12:20:46', 229.98),
(27, 5, '2025-11-09 12:25:49', 229.98),
(28, 10, '2025-11-09 12:33:36', 250119.98),
(29, 4, '2025-11-09 12:38:01', 12249.63),
(30, 12, '2025-11-10 08:40:23', 250029.99);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Index pour la table `clients`
--
ALTER TABLE `clients`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Index pour la table `ligne_vente`
--
ALTER TABLE `ligne_vente`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vente_id` (`vente_id`),
  ADD KEY `produit_id` (`produit_id`);

--
-- Index pour la table `produits`
--
ALTER TABLE `produits`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ventes`
--
ALTER TABLE `ventes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `clients`
--
ALTER TABLE `clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `ligne_vente`
--
ALTER TABLE `ligne_vente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT pour la table `produits`
--
ALTER TABLE `produits`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `ventes`
--
ALTER TABLE `ventes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `ligne_vente`
--
ALTER TABLE `ligne_vente`
  ADD CONSTRAINT `ligne_vente_ibfk_1` FOREIGN KEY (`vente_id`) REFERENCES `ventes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ligne_vente_ibfk_2` FOREIGN KEY (`produit_id`) REFERENCES `produits` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `ventes`
--
ALTER TABLE `ventes`
  ADD CONSTRAINT `ventes_ibfk_1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
