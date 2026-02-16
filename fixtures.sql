-- =====================================================
-- Fixtures pour Cinescope
-- Mot de passe pour tous les users : password
-- =====================================================

-- Suppression des tables existantes (dans l'ordre des dépendances)
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS film_platforme;
DROP TABLE IF EXISTS film;
DROP TABLE IF EXISTS platforme;
DROP TABLE IF EXISTS user;
SET FOREIGN_KEY_CHECKS = 1;

-- =====================================================
-- Création des tables
-- =====================================================
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(180) NOT NULL UNIQUE,
    roles JSON NOT NULL,
    password VARCHAR(255) NOT NULL,
    avatar VARCHAR(255) NULL
);

CREATE TABLE platforme (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL,
    logo VARCHAR(255) NULL
);

CREATE TABLE film (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    synopsis TEXT NULL,
    release_year INT NOT NULL
);

CREATE TABLE film_platforme (
    film_id INT NOT NULL,
    platforme_id INT NOT NULL,
    PRIMARY KEY (film_id, platforme_id),
    FOREIGN KEY (film_id) REFERENCES film(id) ON DELETE CASCADE,
    FOREIGN KEY (platforme_id) REFERENCES platforme(id) ON DELETE CASCADE
);

-- =====================================================
-- USERS
-- Hash bcrypt 2y pour "password"
-- =====================================================
INSERT INTO user (id, email, roles, password, avatar) VALUES
(1, 'admin@cinescope.fr', '["ROLE_ADMIN"]', '$2y$13$igJtNm9qJBhfX/7LbTDvzu9t/hSX1hQs65Zp5g4.r63fjOoTejLNO', 'avatar_admin.png'),
(2, 'john.doe@email.com', '["ROLE_USER"]', '$2y$13$igJtNm9qJBhfX/7LbTDvzu9t/hSX1hQs65Zp5g4.r63fjOoTejLNO', 'avatar_john.png'),
(3, 'jane.smith@email.com', '["ROLE_USER"]', '$2y$13$igJtNm9qJBhfX/7LbTDvzu9t/hSX1hQs65Zp5g4.r63fjOoTejLNO', NULL),
(4, 'pierre.dupont@email.com', '["ROLE_USER"]', '$2y$13$igJtNm9qJBhfX/7LbTDvzu9t/hSX1hQs65Zp5g4.r63fjOoTejLNO', 'avatar_pierre.png'),
(5, 'marie.martin@email.com', '["ROLE_USER"]', '$2y$13$igJtNm9qJBhfX/7LbTDvzu9t/hSX1hQs65Zp5g4.r63fjOoTejLNO', NULL);

-- =====================================================
-- PLATFORMES
-- name utilise l'enum TypeMedia (valeurs: Netflix, Disney, Amazon, Canal, Ocs, Apple, Hbo, Youtube, Mytf1, Salto)
-- =====================================================
INSERT INTO platforme (id, name, url, logo) VALUES
(1, 'Netflix', 'https://www.netflix.com', 'netflix_logo.png'),
(2, 'Disney', 'https://www.disneyplus.com', 'disney_logo.png'),
(3, 'Amazon', 'https://www.primevideo.com', 'amazon_logo.png'),
(4, 'Canal', 'https://www.canalplus.com', 'canal_logo.png'),
(5, 'Ocs', 'https://www.ocs.fr', 'ocs_logo.png'),
(6, 'Apple', 'https://tv.apple.com', 'apple_logo.png'),
(7, 'Hbo', 'https://www.hbo.com', 'hbo_logo.png'),
(8, 'Youtube', 'https://www.youtube.com', 'youtube_logo.png');

-- =====================================================
-- FILMS
-- =====================================================
INSERT INTO film (id, title, synopsis, release_year) VALUES
(1, 'Inception', 'Un voleur qui s''infiltre dans les rêves des autres pour voler leurs secrets se voit offrir une chance de rédemption.', 2010),
(2, 'The Dark Knight', 'Batman affronte le Joker, un criminel anarchiste qui plonge Gotham dans le chaos.', 2008),
(3, 'Interstellar', 'Une équipe d''explorateurs voyage à travers un trou de ver dans l''espace pour assurer la survie de l''humanité.', 2014),
(4, 'Pulp Fiction', 'Les vies de deux tueurs à gages, d''un boxeur et d''un gangster s''entremêlent dans quatre histoires de violence et de rédemption.', 1994),
(5, 'The Matrix', 'Un hacker découvre que la réalité telle qu''il la connaît est une simulation créée par des machines.', 1999),
(6, 'Forrest Gump', 'L''histoire d''un homme simple qui se retrouve au cœur des moments clés de l''histoire américaine.', 1994),
(7, 'Le Seigneur des Anneaux: La Communauté de l''Anneau', 'Un jeune hobbit entreprend un voyage épique pour détruire un anneau maléfique.', 2001),
(8, 'Gladiator', 'Un général romain trahi est réduit en esclavage et devient gladiateur pour se venger de l''empereur.', 2000),
(9, 'Avatar', 'Un marine paraplégique est envoyé sur la lune Pandora où il se lie avec les Na''vi.', 2009),
(10, 'Titanic', 'Une histoire d''amour tragique à bord du paquebot Titanic lors de son voyage inaugural.', 1997),
(11, 'The Shawshank Redemption', 'Un banquier condamné à tort se lie d''amitié avec un autre détenu tout en planifiant son évasion.', 1994),
(12, 'Fight Club', 'Un employé de bureau insomniaque forme un club de combat clandestin avec un vendeur de savon charismatique.', 1999),
(13, 'Parasite', 'Une famille pauvre s''infiltre dans la vie d''une famille riche avec des conséquences dramatiques.', 2019),
(14, 'Joker', 'L''histoire des origines du célèbre méchant de Batman dans un Gotham City en déclin.', 2019),
(15, 'Dune', 'Paul Atréides doit voyager vers la planète la plus dangereuse de l''univers pour assurer l''avenir de sa famille.', 2021);

-- =====================================================
-- FILM_PLATFORME (table de liaison ManyToMany)
-- =====================================================
INSERT INTO film_platforme (film_id, platforme_id) VALUES
-- Inception sur Netflix et Amazon
(1, 1), (1, 3),
-- The Dark Knight sur Netflix, Amazon et Canal
(2, 1), (2, 3), (2, 4),
-- Interstellar sur Amazon et Apple
(3, 3), (3, 6),
-- Pulp Fiction sur Netflix et OCS
(4, 1), (4, 5),
-- The Matrix sur Netflix, Amazon et HBO
(5, 1), (5, 3), (5, 7),
-- Forrest Gump sur Amazon et Disney
(6, 3), (6, 2),
-- Le Seigneur des Anneaux sur Canal et OCS
(7, 4), (7, 5),
-- Gladiator sur Amazon et Canal
(8, 3), (8, 4),
-- Avatar sur Disney et Canal
(9, 2), (9, 4),
-- Titanic sur Disney et Netflix
(10, 2), (10, 1),
-- The Shawshank Redemption sur Netflix et Amazon
(11, 1), (11, 3),
-- Fight Club sur Amazon et OCS
(12, 3), (12, 5),
-- Parasite sur Netflix et Canal
(13, 1), (13, 4),
-- Joker sur HBO et OCS
(14, 7), (14, 5),
-- Dune sur HBO et Amazon
(15, 7), (15, 3);
