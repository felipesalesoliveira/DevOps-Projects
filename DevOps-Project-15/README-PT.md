# 🚀 Deploy de Aplicação E-Commerce Three-Tier no AWS EKS com Helm

Este repositório demonstra como **implantar uma aplicação E-Commerce em arquitetura Three-Tier** utilizando **Amazon EKS**, **Helm**, **AWS Load Balancer Controller**, **EBS CSI Driver** e **Ingress com ALB**.

A aplicação utilizada é o **RobotShop**, amplamente adotada para estudos de microsserviços e Kubernetes.

---

## 📐 Arquitetura

![](https://miro.medium.com/v2/resize\:fit:736/1*Ld1z5tAB6SP3Toq64MpExQ.png)

### 🔹 Three-Tier

* **Presentation Layer**: Interface do usuário exposta via Ingress + ALB
* **Application Layer**: Microsserviços com lógica de negócio
* **Data Layer**: Persistência com volumes EBS via CSI Driver

---

## 🎯 Benefícios

* Escalabilidade independente por camada
* Manutenibilidade elevada
* Evolução tecnológica facilitada
* Arquitetura resiliente e cloud-native

---

## 🧰 Pré-requisitos

* Conta AWS ativa
* kubectl — [https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html](https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html)
* eksctl — [https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html](https://docs.aws.amazon.com/eks/latest/userguide/eksctl.html)
* AWS CLI — [https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

Configuração da AWS CLI:

```bash
aws configure
```

---

## 🛠️ Stack Tecnológica

* Amazon EKS
* Kubernetes
* Helm
* AWS Load Balancer Controller (ALB)
* Amazon EBS CSI Driver
* IAM + OIDC
* Ingress
* RobotShop

---

## 🚧 Passo a Passo

### 1️⃣ Criar Cluster EKS

```bash
eksctl create cluster \
  --name your-cluster-name \
  --region your-region \
  --nodegroup-name your-nodegroup-name \
  --node-type t3.small \
  --nodes 2 \
  --nodes-min 1 \
  --nodes-max 3
```

### 2️⃣ Configurar OIDC Provider

```bash
export cluster_name=<CLUSTER-NAME>
oidc_id=$(aws eks describe-cluster \
  --name $cluster_name \
  --query "cluster.identity.oidc.issuer" \
  --output text | cut -d '/' -f 5)
```

```bash
aws iam list-open-id-connect-providers | grep $oidc_id
```

```bash
eksctl utils associate-iam-oidc-provider \
  --cluster $cluster_name \
  --approve
```

### 3️⃣ AWS Load Balancer Controller

```bash
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json
```

```bash
aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://iam_policy.json
```

```bash
eksctl create iamserviceaccount \
  --cluster <CLUSTER-NAME> \
  --namespace kube-system \
  --name aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn arn:aws:iam::<ACCOUNT-ID>:policy/AWSLoadBalancerControllerIAMPolicy \
  --approve
```

### 4️⃣ Instalar ALB Controller

```bash
helm repo add eks https://aws.github.io/eks-charts
helm repo update
```

```bash
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=<CLUSTER-NAME> \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=<REGION> \
  --set vpcId=<VPC-ID>
```

### 5️⃣ EBS CSI Driver

```bash
eksctl create iamserviceaccount \
  --name ebs-csi-controller-sa \
  --namespace kube-system \
  --cluster <CLUSTER-NAME> \
  --role-name AmazonEKS_EBS_CSI_DriverRole \
  --role-only \
  --attach-policy-arn arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy \
  --approve
```

```bash
eksctl create addon \
  --name aws-ebs-csi-driver \
  --cluster <CLUSTER-NAME> \
  --service-account-role-arn arn:aws:iam::<ACCOUNT-ID>:role/AmazonEKS_EBS_CSI_DriverRole \
  --force
```

### 6️⃣ Deploy da Aplicação

```bash
git clone https://github.com/uniquesreedhar/RobotShop-Project.git
cd RobotShop-Project/EKS/helm
```

```bash
kubectl create ns robot-shop
helm install robot-shop --namespace robot-shop .
```

### 7️⃣ Ingress

```bash
kubectl apply -f ingress.yaml
```

Acesse a aplicação via **DNS do ALB** criado automaticamente.

---

## 📁 Estrutura

```bash
.
├── README.md
├── EKS
│   └── helm
│       ├── Chart.yaml
│       ├── values.yaml
│       ├── templates/
│       └── ingress.yaml
```

---

## 🛠️ Autor & Comunidade

**Harshhaa**

* GitHub: [https://github.com/NotHarshhaa](https://github.com/NotHarshhaa)
* Blog: [https://blog.prodevopsguytech.com](https://blog.prodevopsguytech.com)
* Telegram: [https://t.me/prodevopsguy](https://t.me/prodevopsguy)

---

## ⭐ Contribuição

Se este projeto foi útil:

* ⭐ Dê uma estrela
* 🍴 Faça um fork
* 🚀 Compartilhe

---

## 📌 Próximos Passos

* Observabilidade com Prometheus + Grafana
* Logs com Loki / ELK
* CI/CD com GitHub Actions ou Jenkins
* HPA e Auto Scaling
* Segurança com IRSA e Network Policies
