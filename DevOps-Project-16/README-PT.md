# Projeto DevOps em Tempo Real | Deploy no Kubernetes usando Jenkins | Projeto DevOps End to End | CI/CD

## **Visão Geral do Projeto**

![Image description](https://res.cloudinary.com/practicaldev/image/fetch/s--FOFeO317--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_800/https://dev-to-uploads.s3.amazonaws.com/uploads/articles/1u01v021w2q2onpkbt2b.png)

Este projeto demonstra uma **pipeline DevOps completa, de ponta a ponta**, utilizando **Jenkins, Docker, SonarQube, AWS EKS, ArgoCD e GitOps**, desde o build da aplicação até o deploy automatizado no Kubernetes.

---

## 🚀 Vamos começar :)

### **Criar um servidor EC2 – Jenkins Master**

* AMI: Ubuntu (Free Tier)
* Tipo de Instância: t2.micro
* Selecionar ou criar Key Pair
* Armazenamento: 15 GiB

➡️ **Launch Instance**

---

### **Acessar o servidor e instalar o Jenkins**

```bash
cd Downloads
ssh -i [keypair-name].pem ubuntu@[IP_PUBLICO]
sudo apt update && sudo apt upgrade -y
sudo hostnamectl set-hostname Jenkins-Master
bash
sudo apt install openjdk-17-jre -y
java -version

curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins -y
sudo systemctl enable jenkins
sudo systemctl start jenkins
systemctl status jenkins
sudo vi /etc/ssh/sshd_config
```

Descomente as linhas **PasswordAuthentication yes** e **PermitRootLogin yes**.

```bash
sudo service sshd reload
```

No **Security Group**, libere a porta **8080**.

---

## **Criar um servidor EC2 – Jenkins Agent**

* AMI: Ubuntu (Free Tier)
* Tipo: t2.micro
* Armazenamento: 15 GiB

```bash
cd Downloads
ssh -i [keypair-name].pem ubuntu@[IP_PUBLICO]
sudo apt update && sudo apt upgrade -y
sudo hostnamectl set-hostname Jenkins-Agent
bash
sudo apt install openjdk-17-jre -y
java -version
sudo apt install docker.io -y
sudo usermod -aG docker $USER
sudo init 6
```

Após reboot:

```bash
ssh -i [keypair-name].pem ubuntu@[IP_PUBLICO]
sudo vi /etc/ssh/sshd_config
sudo service sshd reload
```

---

## 🔐 **Configurar acesso SSH entre Master e Agent**

### Jenkins Master

```bash
ssh-keygen
cd ~/.ssh
cat id_rsa.pub
```

### Jenkins Agent

```bash
cd ~/.ssh
vi authorized_keys
```

Cole a chave pública do Master.

---

## 🔧 **Configuração Inicial do Jenkins**

Acesse:

```
http://IP_PUBLICO_MASTER:8080
```

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Crie o usuário admin e finalize a instalação.

---

## ⚙️ **Configurar Nodes no Jenkins**

* Disable executor do Built-in Node (Executors = 0)
* Criar Node Permanente: **Jenkins-Agent**
* Método: SSH
* Usuário: ubuntu
* Diretório: /home/ubuntu
* Labels: Jenkins-Agent
* Strategy: Non-verifying

---

## 🧰 **Integrar Maven, JDK e GitHub ao Jenkins**

* Instalar plugins: Maven, Git, Docker, SonarQube
* Maven: `Maven3`
* JDK: `Java17` (Adoptium)
* GitHub Credentials: Username + Token

---

## 🔁 **Criar Job CI (Pipeline)**

Repositório base:
[https://github.com/MSFaizi/register-app](https://github.com/MSFaizi/register-app)

Pipeline:

* Tipo: Pipeline from SCM
* Branch: main
* Discard old builds: 2

---

## 🔍 **Instalar e Configurar SonarQube**

* EC2 t3.medium
* Porta liberada: 9000
* Banco PostgreSQL
* Java 17
* Configurações de kernel e limits

Usuário padrão:

```
admin / admin
```

---

## 🔗 **Integrar SonarQube com Jenkins**

* Criar token no SonarQube
* Adicionar como Secret Text no Jenkins
* Configurar SonarQube Server
* Criar Webhook apontando para Jenkins

---

## 🐳 **Build e Push de Imagem Docker**

* Instalar plugins Docker
* Criar token no DockerHub
* Adicionar credenciais no Jenkins

---

## ☸️ **Criar Cluster Kubernetes com eksctl**

Bootstrap EC2:

```bash
aws configure
kubectl version
eksctl create cluster --name meu-cluster --region ap-south-1 --node-type t2.small --nodes 3
```

---

## 🚢 **Instalar ArgoCD no EKS**

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
```

Login:

```
admin / senha decodificada
```

---

## 🔄 **GitOps com ArgoCD**

Repo GitOps:
[https://github.com/MSFaizi/gitops-register-app](https://github.com/MSFaizi/gitops-register-app)

* Sync automático
* Self Heal
* Prune habilitado

---

## 🚀 **Criar Pipeline CD no Jenkins**

* Job: GitOps-register-app-cd
* Parâmetro: IMAGE_TAG
* Trigger remoto
* SCM GitHub

---

## ✅ **Validação Final**

* Commit no repositório
* Jenkins executa CI
* Docker Image criada
* ArgoCD sincroniza
* App disponível no EKS

---

## 🎉 **Parabéns! Pipeline CI/CD completo implementado com sucesso**

---

## 🛠️ Autor & Comunidade

Projeto criado por **Harshhaa**

* GitHub: [https://github.com/NotHarshhaa](https://github.com/NotHarshhaa)
* Blog: [https://blog.prodevopsguytech.com](https://blog.prodevopsguytech.com)
* Telegram: [https://t.me/prodevopsguy](https://t.me/prodevopsguy)

⭐ Se este projeto te ajudou, deixe uma estrela no repositório e compartilhe!
