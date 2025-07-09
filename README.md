

#  Multi-Region Disaster Recovery on AWS using Terraform
=
---

## **Objective**

To design and implement a **multi-region disaster recovery (DR) architecture** using AWS services, where infrastructure is deployed in **two AWS regions**: one as **Primary (active)** and the other as **Disaster Recovery (standby)**. The infrastructure will ensure:

* High availability and scalability,
* Cross-region data replication,
* Automatic failover and failback,
* Infrastructure as Code using Terraform for consistency and repeatability.

---

## **Architecture Overview**

```
                    +---------------------------+
                    |     Route 53 (Failover)   |
                    +---------------------------+
                            /           \
                     Primary (us-east-1)     DR (us-west-1)
                    --------------------     ------------------
                    |  ALB (Active)     |     | ALB (Passive)  |
                    |  Auto Scaling     |     | Auto Scaling   |
                    |  EC2 - Static Web |     | EC2 - Static   |
                    |  S3 w/ CRR        | --> | S3 Bucket      |
                    |  RDS (Primary)    | --> | RDS (Replica)  |
                    --------------------     ------------------





```
  ![image](https://github.com/user-attachments/assets/f0c3ca65-a11d-4d64-9de7-c33608a4480d)


It is designed to provide high availability and disaster recovery for a web application by distributing its components across two separate AWS region .It ensures that if the primary region becomes unavailable, traffic can be automatically failed over to a secondary region with minimal data loss and downtime .
---

## **AWS Services Used**

| Service                | Purpose                                                   |
| ---------------------- | --------------------------------------------------------- |
| **VPC**                | Network isolation in each region (public/private subnets) |
| **EC2**                | Host static web content from S3 via user\_data            |
| **ALB**                | Load traffic across EC2 instances                         |
| **Auto Scaling Group** | Ensure high availability and scaling                      |
| **S3**                 | Static content and cross-region replication               |
| **RDS (MySQL)**        | Primary DB in Region 1, replica in Region 2               |
| **Route 53**           | DNS-based failover to redirect traffic to DR region       |
| **IAM**                | Permissions for EC2, S3 replication, etc.                 |
| **Terraform**          | Infrastructure as Code (IaC) for automation               |

---

##  **Implementation Steps**

###  Phase 1: VPC and Networking (in Both Regions)

1. Create custom VPCs in **us-east-1** and **us-west-1**.
2. Define public and private subnets.
3. Configure route tables, internet gateways (for public access).
4. Create NAT gateways for internet access from private subnets (optional for RDS).

---

### Phase 2: S3 Buckets

1. Create **S3 Bucket in Primary Region (us-east-1)** for hosting static files.
2. Create **S3 Bucket in DR Region (us-west-1)** for replication.
   
---

###  Phase 3: Compute Layer – EC2, ALB, ASG

1. Create **Launch Templates** with `user_data` to pull static site from S3.
2. Create **Auto Scaling Groups (ASG)** in both regions using Launch Templates.
3. Deploy **Application Load Balancers (ALB)** in both regions, attach ASG targets.
4. Output ALB DNS names for use in Route 53 failover.

---

###  Phase 4: Database – RDS with Cross-Region Read Replica (Optional)

1. Deploy **RDS MySQL in private subnets** in the primary region.
2. Create **RDS Cross-Region Read Replica** in DR region.
3. Ensure correct **security groups**, **subnet groups**, and **parameter groups**.

---

### Phase 5: DNS and Failover with Route 53

1. Buy/register domain (e.g., `myfab.space`).
2. Create **Route 53 Hosted Zone** for the domain.
3. Add two records for the same domain:

   * Primary (ALB in us-east-1) – **Set as Primary Failover**
   * Secondary (ALB in us-west-1) – **Set as Secondary Failover**
4. Health checks monitor the ALB in the primary region.
5. Upon failure, Route 53 routes traffic to the DR ALB automatically.

---

### Phase 6: Terraform Structure and Deployment

**Organize Terraform into modules/files:**

* `providers.tf`: AWS provider blocks for both regions.
* `main.tf`: Core infrastructure (VPC, EC2, ASG, ALB, etc.).
* `variables.tf`: All configurable variables.
* `outputs.tf`: Important outputs like ALB DNS, S3 bucket names, etc.
* `s3.tf`: Bucket creation and replication config.

**Deploy using:**

```bash
terraform init
terraform plan
terraform apply
```

---

## **Expected Outcome**

* Static web application is served via EC2 (content from S3).
* ALB handles external traffic and balances across instances.
* Auto Scaling ensures availability and recovery in both regions.
* S3 replicates static content
* Route 53 redirects traffic to the DR region in case of a primary region failure.

---

## **Security Considerations**

* Use **IAM roles with least privilege** for EC2 and replication.
* EC2 security groups should only allow traffic via ALB.
* RDS should only be accessible within private subnets.
* Enable **S3 versioning and server-side encryption**.

---
