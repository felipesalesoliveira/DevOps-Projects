# 🎮 Deployment do Super Mario no Kubernetes com Terraform

![Super Mario](https://imgur.com/rC4Qe8g.png)

## 📌 Visão Geral

Super Mario é um jogo que nunca vamos esquecer. Neste repositório, realizamos o **deploy do Super Mario no Amazon EKS (Elastic Kubernetes Service)** utilizando **Terraform**, com toda a infraestrutura sendo criada a partir de uma **instância EC2 na AWS**.

O projeto demonstra, de ponta a ponta, como provisionar infraestrutura cloud-native, configurar Kubernetes e publicar uma aplicação real utilizando **Infraestrutura como Código (IaC)**.

---

## 🧱 Arquitetura Utilizada

* AWS EC2 (máquina de controle)
* Amazon EKS (cluster Kubernetes)
* AWS IAM (roles e permissões)
* AWS S3 (backend do Terraform)
* Load Balancer (exposição do serviço)
* Docker (containerização)

---

## 🚀 Tecnologias Utilizadas

* **AWS (EC2, EKS, IAM, S3)**
* **Terraform**
* **Kubernetes**
* **Docker**
* **AWS CLI**
* **kubectl**

---

## 📋 Pré-requisitos

Antes de iniciar, você precisa de:

* Conta ativa na **AWS**
* Conhecimentos básicos de AWS e Linux
* Acesso a uma instância **EC2 (Ubuntu)**

---

## 🧩 Etapas do Projeto

1. Login e configuração inicial da AWS
2. Instalação do Docker, Terraform, AWS CLI e kubectl
3. Criação da IAM Role para EC2
4. Associação da IAM Role à instância EC2
5. Provisionamento da infraestrutura com Terraform
6. Criação do Deployment e Service no EKS
7. Destruição completa da infraestrutura

---

## 🔐 Step 1 → Login e Configuração Básica

* Faça login na AWS como usuário root
* Crie uma instância EC2 permitindo **HTTP** e **HTTPS**
* Configure um **Key Pair**
* Conecte-se à instância via console

Execute:

```bash
sudo su
apt update -y
```

---

## 🧰 Step 2 → Instalação das Ferramentas

### Docker

```bash
apt install docker.io -y
usermod -aG docker $USER
newgrp docker
```

### Terraform

```bash
sudo apt install wget -y
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y
```

### AWS CLI

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt-get install unzip -y
unzip awscliv2.zip
sudo ./aws/install
```

### kubectl

```bash
sudo apt install curl -y
curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

---

## 🔐 Step 3 → Criar IAM Role para EC2

A IAM Role permite que a instância EC2 crie e gerencie recursos da AWS (EKS, S3, etc.) sem armazenar credenciais.

Passos:

* Acesse **IAM → Roles → Create Role**
* Selecione **EC2**
* Permissão: **AdministratorAccess**
* Crie a role

---

## 🔗 Step 4 → Anexar IAM Role à EC2

* Vá até **EC2 → Actions → Security → Modify IAM Role**
* Associe a role criada

---

## 🏗️ Step 5 → Provisionar Infraestrutura com Terraform

Clone o repositório:

```bash
mkdir super_mario && cd super_mario
git clone https://github.com/NotHarshhaa/Deployment-of-super-Mario-on-Kubernetes-using-terraform.git
cd Deployment-of-super-Mario-on-Kubernetes-using-terraform/EKS-TF
```

Edite o backend do Terraform:

```bash
vim backend.tf
```

> ⚠️ Configure corretamente o **bucket S3** e a **região**.

Execute:

```bash
terraform init
terraform validate
terraform plan
terraform apply --auto-approve
```

Tempo médio: **5–10 minutos**

Atualize o kubeconfig:

```bash
aws eks update-kubeconfig --name EKS_CLOUD --region us-east-1
```

---

## 🚀 Step 6 → Deployment e Service no EKS

```bash
cd ..
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl get all
```

Obtenha o Load Balancer:

```bash
kubectl describe service mario-service
```

Copie o **LoadBalancer Ingress**, cole no navegador e jogue 🎮

---

## ⚖️ Load Balancer Ingress

Distribui o tráfego entre múltiplos pods, garantindo disponibilidade, performance e escalabilidade da aplicação.

---

## 🧨 Step 7 → Destruir a Infraestrutura

```bash
kubectl delete service mario-service
kubectl delete deployment mario-deployment
cd EKS-TF
terraform destroy --auto-approve
```

Finalize a instância EC2 no console da AWS.

---

## ⭐ Considerações Finais

Este projeto demonstra um fluxo completo de **IaC + Kubernetes + AWS**, ideal para estudos de **DevOps, Cloud e SRE**.

Se este repositório foi útil, deixe uma ⭐ e compartilhe 🚀

---

## 👤 Autor

Projeto criado por **Harshhaa**
GitHub: [https://github.com/NotHarshhaa](https://github.com/NotHarshhaa)
