# Project Name: ASVS Compliance for DETI Memorabilia Online Shop

## Overview
This project aims to demonstrate compliance with the Application Security Verification Standard (ASVS) Level 1 requirements. The ASVS is a comprehensive checklist defining essential security measures for various stakeholders involved in building secure applications, especially for modern web and mobile apps.

We've extended our previous project, the DETI Memorabilia Online Shop (Project 1), to align with specific ASVS Level 1 security requirements. This README provides an overview of our assessment, the modifications made to meet ASVS criteria, key insights, and integration decisions for additional software features.

## Contributors

- [Diogo Falcao](https://github.com/falcaodiogo)
- [João Carlos](https://github.com/JotaCLS)
- [Matilde Teixeira](https://github.com/matildetex)
- [Bernardo Pinto](https://github.com/beernardoc)

## Grade

12.89

## ASVS Compliance Measures Implemented
The following ASVS Level 1 security requirements have been addressed in this project:

### Data Handling (6.1, 6.2.2, 8.3.2, 8.3.3/8.3.4)
- User-related data encryption
- Use of industry-proven encryption algorithms
- Account deletion functionality for user data control
- User consent for data collection and usage

### Authentication and Password Policies (2.1.1 - 2.1.12)
- Password length and character requirements
- Password strength evaluation
- Checking against breached passwords
- No restrictions on password composition or periodic rotation
- Support for password managers and paste functionality

### Input Validation and Security Controls (5.2.1, 5.2.2, 12.1.1, 12.3.4, 14.2.1, 14.2.2, 14.4.3, 14.4.4, 14.4.7)
- Proper sanitization of untrusted HTML inputs
- Sanitization of unstructured data
- File upload security measures
- Protection against Reflective File Download (RFD)
- Dependency and feature cleanup
- Implementation of Content Security Policy (CSP) and X-Content-Type-Options

## Autores 

 * Bernardo Pinto - 105926
 * Diogo Falcão – 108712
 * João Santos – 110555
 * Matilde Teixeira – 108193

 
## How to Run

Ante de correr o projeto, verificar se o MySQL está a ativo. Se o MySQL estiver ativo, parar o servico usando o seguinte comando:

```shell
sudo service mysql stop
```

A seguir, navegar para a pasta "app" ou "app_sec", onde irá estar um documento docker-compose. Em seguida usar o seguinte comando:

```shell
docker-compose up
```

Em seguida abre o seu navegador em: 
[http://localhost:8080/shopping-cart](http://localhost:8080/shopping-cart).

Para correr o projeto usando NGINX (proxy com headers implementados), executar docker compose mas abrir o navegador em:
[http://localhost/shopping-cart](http://localhost/shopping-cart).




## Credits

This project is an extension of the [shashirajraja/shopping-cart](https://github.com/shashirajraja/shopping-cart) repository, and we would like to give credit to the original developers. The original developer of the base project is [shashirajraja](https://github.com/shashirajraja).
