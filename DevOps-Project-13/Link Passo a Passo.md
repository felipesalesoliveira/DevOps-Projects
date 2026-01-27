# 🍽️ Zomato Clone — Secure DevSecOps CI/CD Pipeline

![Zomato Clone](https://miro.medium.com/v2/resize\:fit:1400/format\:webp/1*X_hm5iF0NRjbOZHB6RQIFA.jpeg)

## 📌 Visão Geral

Este repositório demonstra a **implantação segura de uma aplicação de delivery estilo Zomato**, utilizando **práticas de DevSecOps integradas a um pipeline CI/CD completo**.

A solução cobre desde a análise de código e dependências até o build de imagens Docker, push para registry e deploy automatizado, garantindo **segurança, qualidade e eficiência operacional**.

---

## 🎯 Objetivos

* Implementar CI/CD com **DevSecOps by design**
* Integrar **SAST, SCA e Image Scanning**
* Automatizar build, testes, análise e deploy
* Demonstrar ferramentas reais usadas no mercado

---

## 🧱 Arquitetura

* **AWS EC2 (Ubuntu 22.04 – T2 Large)**
* **Jenkins** – Orquestração do pipeline
* **Docker** – Build e execução da aplicação
* **SonarQube** – Qualidade de código e Quality Gate
* **OWASP Dependency-Check** – Scan de dependências
* **Trivy** – Scan de filesystem e imagens
* **Docker Hub** – Registry

---

## 🛠️ Stack Tecnológica

| Categoria      | Ferramentas                              |
| -------------- | ---------------------------------------- |
| CI/CD          | Jenkins                                  |
| Segurança      | SonarQube, Trivy, OWASP Dependency-Check |
| Containers     | Docker                                   |
| Linguagem      | Node.js                                  |
| Infraestrutura | AWS EC2                                  |
| SO             | Ubuntu 22.04                             |

---

## 🧭 Fluxo do Pipeline

1. Provisionamento da EC2
2. Instalação Jenkins, Docker e Trivy
3. SonarQube em container Docker
4. Configuração de plugins Jenkins
5. SAST + Quality Gate
6. SCA (OWASP Dependency Check)
7. Trivy FS Scan
8. Docker Build & Push
9. Trivy Image Scan
10. Deploy da aplicação
11. Encerramento da infraestrutura

---

## 🚀 Pipeline CI/CD (Declarative)

```groovy
pipeline {
    agent any
    tools {
        jdk 'jdk17'
        nodejs 'node16'
    }
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }
    stages {
        stage('Clean Workspace') { steps { cleanWs() } }
        stage('Checkout from Git') {
            steps {
                git branch: 'main', url: 'https://github.com/mudit097/Zomato-Clone.git'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh '''
                    $SCANNER_HOME/bin/sonar-scanner \
                    -Dsonar.projectName=zomato \
                    -Dsonar.projectKey=zomato
                    '''
                }
            }
        }
        stage('Quality Gate') {
            steps {
                waitForQualityGate abortPipeline: false, credentialsId: 'Sonar-token'
            }
        }
        stage('Install Dependencies') {
            steps { sh 'npm install' }
        }
        stage('OWASP FS SCAN') {
            steps {
                dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit',
                odcInstallation: 'DP-Check'
                dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
            }
        }
        stage('TRIVY FS SCAN') {
            steps { sh 'trivy fs . > trivyfs.txt' }
        }
        stage('Docker Build & Push') {
            steps {
                script {
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh 'docker build -t zomato .'
                        sh 'docker tag zomato mudit097/zomato:latest'
                        sh 'docker push mudit097/zomato:latest'
                    }
                }
            }
        }
        stage('TRIVY IMAGE SCAN') {
            steps { sh 'trivy image mudit097/zomato:latest > trivy.txt' }
        }
        stage('Deploy to Container') {
            steps {
                sh 'docker run -d --name zomato -p 3000:3000 mudit097/zomato:latest'
            }
        }
    }
}
```

---

## 🌐 Acesso à Aplicação

```
http://<IP-Público-EC2>:3000
```

---

## 🔐 Controles de Segurança

* ✅ Análise Estática (SonarQube)
* ✅ Quality Gate
* ✅ Scan de Dependências (OWASP)
* ✅ Trivy FS Scan
* ✅ Trivy Image Scan

---

## 🧪 Interface da Aplicação

![UI 1](https://miro.medium.com/v2/resize\:fit:750/format\:webp/1*xVxk3tSbk9yA6hel60t13g.png)
![UI 2](https://miro.medium.com/v2/resize\:fit:750/format\:webp/1*KOwp6K2sOcSmDyk9Axnvhw.png)
![UI 3](https://miro.medium.com/v2/resize\:fit:750/format\:webp/1*t1x_F_qwHI6anvRHS59OxA.png)

---

## 🧹 Cleanup

Após os testes, finalize a instância EC2 para evitar custos desnecessários:

* Stop Instance
* Terminate Instance

---

## 👨‍💻 Autor & Créditos

Projeto original: **Harshhaa**
Documentação e organização DevSecOps.

---

## ⭐ Contribuição

Se este projeto foi útil:

* ⭐ Dê uma estrela
* 🔁 Compartilhe
* 🧩 Pull Requests são bem-vindos

---

🚀 **DevSecOps do código ao deploy, na prática.**
