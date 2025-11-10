-- ========================================
-- 	     			AEP    
-- 	   BANCO DE DADOS: capacitajovem_db
-- ========================================

-- DESENVOLVIDO POR:
-- > NOME: MARIA EDUARDA DE CASTRO LACHIMIA RA: 24055202-2
-- > NOME: HELOISA SAYURI SILVA SAITO RA: 24062631-2
-- > NOME: MATHEUS COSTA E SILVA RA: 24000729-2

-- CRIANDO O BANCO DE DADOS
CREATE DATABASE capacitajovem_db;
USE capacitajovem_db;

-- Tabela USERS (Usuários)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    openId VARCHAR(64) NOT NULL UNIQUE,
    name VARCHAR(255),
    email VARCHAR(320),
    password VARCHAR(255),
    loginMethod VARCHAR(64),
    role ENUM('USER', 'ADMIN', 'STUDENT', 'MENTOR', 'COMPANY') NOT NULL DEFAULT 'STUDENT',
    bio TEXT,
    phone VARCHAR(20),
    points INT NOT NULL DEFAULT 0,
    createdAt DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updatedAt DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    lastSignedIn DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
);

-- Tabela COURSES (Cursos)
CREATE TABLE IF NOT EXISTS courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    category VARCHAR(100) NOT NULL,
    duration INT NOT NULL COMMENT 'Duração em horas',
    level ENUM('BEGINNER', 'INTERMEDIATE', 'ADVANCED') NOT NULL,
    imageUrl TEXT,
    instructorId INT,
    isActive BOOLEAN NOT NULL DEFAULT TRUE,
    createdAt DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updatedAt DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    FOREIGN KEY (instructorId) REFERENCES users(id) ON DELETE SET NULL
);

-- Tabela CONTENTS (Conteúdos dos Cursos)
CREATE TABLE IF NOT EXISTS contents (
    id INT AUTO_INCREMENT PRIMARY KEY,
    courseId INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    contentType ENUM('video', 'text', 'quiz', 'document') NOT NULL,
    contentUrl TEXT,
    contentText TEXT,
    `order` INT NOT NULL COMMENT 'Ordem do conteúdo no curso',
    duration INT COMMENT 'Duração em minutos',
    createdAt DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    FOREIGN KEY (courseId) REFERENCES courses(id) ON DELETE CASCADE
);

-- Tabela ENROLLMENTS (Inscrições em Cursos)
CREATE TABLE IF NOT EXISTS enrollments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    courseId INT NOT NULL,
    status ENUM('active', 'completed', 'dropped') NOT NULL DEFAULT 'active',
    progress INT NOT NULL DEFAULT 0 COMMENT 'Progresso de 0 a 100%',
    enrolledAt DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    completedAt DATETIME(6) NULL DEFAULT NULL,
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (courseId) REFERENCES courses(id) ON DELETE CASCADE
);

-- Tabela PROGRESS (Progresso do Estudante)
CREATE TABLE IF NOT EXISTS progress (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    contentId INT NOT NULL,
    completed BOOLEAN NOT NULL DEFAULT FALSE,
    score INT COMMENT 'Pontuação para quizzes',
    completedAt DATETIME(6) NULL DEFAULT NULL,
    createdAt DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (contentId) REFERENCES contents(id) ON DELETE CASCADE
);

-- Tabela OPPORTUNITIES (Oportunidades)
CREATE TABLE IF NOT EXISTS opportunities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    type ENUM('internship', 'scholarship', 'event', 'job') NOT NULL,
    company VARCHAR(255),
    location VARCHAR(255),
    requirements TEXT,
    benefits TEXT,
    deadline DATETIME(6) NULL DEFAULT NULL,
    isActive BOOLEAN NOT NULL DEFAULT TRUE,
    publisherId INT,
    createdAt DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updatedAt DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    FOREIGN KEY (publisherId) REFERENCES users(id) ON DELETE SET NULL
);

-- Tabela APPLICATIONS (Candidaturas)
CREATE TABLE IF NOT EXISTS applications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    opportunityId INT NOT NULL,
    status ENUM('pending', 'accepted', 'rejected') NOT NULL DEFAULT 'pending',
    coverLetter TEXT,
    appliedAt DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updatedAt DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (opportunityId) REFERENCES opportunities(id) ON DELETE CASCADE
);

-- Tabela CERTIFICATES (Certificados Digitais)
CREATE TABLE IF NOT EXISTS certificates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    courseId INT NOT NULL,
    certificateCode VARCHAR(100) NOT NULL UNIQUE,
    issuedAt DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    certificateUrl TEXT,
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (courseId) REFERENCES courses(id) ON DELETE CASCADE
);

-- Tabela BADGES (Badges de Gamificação)
CREATE TABLE IF NOT EXISTS badges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    iconUrl TEXT,
    pointsRequired INT NOT NULL,
    createdAt DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
);

-- Tabela USERBADGES (Badges Conquistadas pelos Usuários)
CREATE TABLE IF NOT EXISTS userBadges (
    id INT AUTO_INCREMENT PRIMARY KEY,
    userId INT NOT NULL,
    badgeId INT NOT NULL,
    earnedAt DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    FOREIGN KEY (userId) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (badgeId) REFERENCES badges(id) ON DELETE CASCADE
);

-- ========================================
--                 DADOS
-- ========================================

-- Cursos
INSERT INTO courses (title, description, category, duration, level, imageUrl, isActive, createdAt, updatedAt) VALUES
('Introdução à Programação com Python', 'Aprenda os fundamentos da programação utilizando Python, uma das linguagens mais populares do mercado.', 'Tecnologia', 40, 'BEGINNER', 'https://images.unsplash.com/photo-1526379095098-d400fd0bf935?w=400', TRUE, NOW(6), NOW(6)),
('Marketing Digital para Iniciantes', 'Domine as estratégias de marketing digital e aprenda a promover produtos e serviços online.', 'Marketing', 30, 'BEGINNER', 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=400', TRUE, NOW(6), NOW(6)),
('Desenvolvimento Web Full Stack', 'Aprenda a criar aplicações web completas, do frontend ao backend, utilizando tecnologias modernas.', 'Tecnologia', 80, 'INTERMEDIATE', 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?w=400', TRUE, NOW(6), NOW(6)),
('Gestão de Projetos Ágeis', 'Aprenda metodologias ágeis como Scrum e Kanban para gerenciar projetos de forma eficiente.', 'Gestão', 25, 'INTERMEDIATE', 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?w=400', TRUE, NOW(6), NOW(6)),
('Design Gráfico com Canva', 'Crie designs profissionais para redes sociais, apresentações e materiais de marketing.', 'Design', 20, 'BEGINNER', 'https://images.unsplash.com/photo-1561070791-2526d30994b5?w=400', TRUE, NOW(6), NOW(6)),
('Excel Avançado para Negócios', 'Domine fórmulas, tabelas dinâmicas e automação para análise de dados empresariais.', 'Negócios', 35, 'ADVANCED', 'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=400', TRUE, NOW(6), NOW(6));

-- Conteúdos
INSERT INTO contents (courseId, title, description, contentType, contentUrl, `order`, duration, createdAt) VALUES
(1, 'Introdução ao Python', 'Conheça a linguagem Python e configure seu ambiente de desenvolvimento', 'video', 'https://example.com/video1.mp4', 1, 30, NOW(6)),
(1, 'Variáveis e Tipos de Dados', 'Aprenda sobre variáveis, strings, números e outros tipos de dados', 'video', 'https://example.com/video2.mp4', 2, 45, NOW(6)),
(1, 'Estruturas de Controle', 'Entenda if, else, loops e como controlar o fluxo do programa', 'video', 'https://example.com/video3.mp4', 3, 50, NOW(6)),
(1, 'Quiz: Fundamentos de Python', 'Teste seus conhecimentos sobre os conceitos básicos', 'quiz', NULL, 4, 15, NOW(6));

-- Oportunidades
INSERT INTO opportunities (title, description, type, company, location, requirements, benefits, deadline, isActive, createdAt, updatedAt) VALUES
('Estágio em Desenvolvimento Web', 'Oportunidade de estágio em empresa de tecnologia para desenvolvedores web iniciantes.', 'internship', 'TechStart Solutions', 'São Paulo, SP', 'Conhecimentos básicos em HTML, CSS e JavaScript', 'Bolsa auxílio de R$ 1.200,00 + Vale transporte', '2025-12-31 23:59:59', TRUE, NOW(6), NOW(6)),
('Bolsa de Estudos em Marketing Digital', 'Bolsa integral para curso avançado de marketing digital com certificação internacional.', 'scholarship', 'Instituto de Marketing Digital', 'Online', 'Ter concluído curso básico de marketing', 'Curso completo + Certificação + Mentoria', '2025-11-30 23:59:59', TRUE, NOW(6), NOW(6)),
('Hackathon de Inovação Social', 'Evento de 48 horas para desenvolver soluções tecnológicas para problemas sociais.', 'event', 'ONG Inovação para Todos', 'Rio de Janeiro, RJ', 'Interesse em tecnologia e impacto social', 'Premiação de R$ 10.000,00 + Networking', '2025-10-15 23:59:59', TRUE, NOW(6), NOW(6)),
('Desenvolvedor Junior - React', 'Vaga para desenvolvedor frontend com foco em React e TypeScript.', 'job', 'Digital Innovations', 'Remoto', '6 meses de experiência com React', 'CLT + Plano de saúde + Home office', '2025-12-01 23:59:59', TRUE, NOW(6), NOW(6));

-- Badges
INSERT INTO badges (name, description, pointsRequired, createdAt) VALUES
('Primeiro Passo', 'Complete seu primeiro curso', 0, NOW(6)),
('Estudante Dedicado', 'Acumule 100 pontos', 100, NOW(6)),
('Mestre do Conhecimento', 'Complete 5 cursos', 0, NOW(6)),
('Networking Expert', 'Candidate-se a 10 oportunidades', 0, NOW(6)),
('Campeão', 'Acumule 500 pontos', 500, NOW(6));


USE capacitajovem_db;
SELECT * FROM users;