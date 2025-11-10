# ConectaPlus - AEP 2025

Plataforma digital para formação e capacitação de jovens de comunidades de baixa renda, com sistema de gamificação, gestão de cursos, oportunidades profissionais e certificados digitais.

Desenvolvido por Heloísa Sayuri Silva Saito, Maria Eduarda de Castro Lachimia e Matheus Costa E Silva.

## 🏗️ Arquitetura do Projeto

- **Backend:** Java 17 + Spring Boot 3.1.5
- **Frontend:** HTML5 + CSS3 + JavaScript Puro
- **Banco de Dados:** MySQL 8.0
- **Build Tool:** Maven

## 📁 Estrutura

```
capacita_jovem_java/
├── src/
│   ├── main/
│   │   ├── java/com/capacitajovem/
│   │   │   ├── CapacitaJovemApplication.java    # Classe principal
│   │   │   ├── model/                           # Modelos (Entidades JPA)
│   │   │   │   ├── Usuario.java
│   │   │   │   └── Curso.java
│   │   │   ├── repository/                      # Repositórios (Data Access)
│   │   │   │   ├── UsuarioRepository.java
│   │   │   │   └── CursoRepository.java
│   │   │   ├── service/                         # Serviços (Lógica de Negócio)
│   │   │   │   └── CursoService.java
│   │   │   └── controller/                      # Controllers (REST API)
│   │   │       ├── HomeController.java
│   │   │       └── CursoController.java
│   │   ├── resources/
│   │   │   ├── application.properties           # Configurações da aplicação
│   │   │   └── static/                          # Arquivos estáticos (Frontend)
│   │   │       ├── index.html                   # Página principal
│   │   │       ├── css/
│   │   │       │   └── style.css                # Estilos CSS
│   │   │       └── js/
│   │   │           └── main.js                  # Scripts JavaScript
│   └── test/                                    # Testes unitários
├── pom.xml                                      # Configuração Maven
└── README.md                                    # Este arquivo
```

## 🚀 Como Executar?

### Pré-requisitos
- Java 17 ou superior
- Maven 3.6+
- MySQL 8.0+ (Configurar o Banco de Dados)
