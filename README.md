
### AWS Inter-Region VPC Peering Using Terraform

Deploying AWS infrastructure across Tokyo and Singapore using Terraform and HCP Terraform Remote Execution.

This lab follows the Infrastructure as Code (IaC) approach, using individual AWS Terraform resources without reusable modules.

### Architecture

| Frontend | Backend |
|---|---|
| Tokyo (`ap-northeast-1`) | Singapore (`ap-southeast-1`) |
| VPC: `10.0.0.0/16` | VPC: `192.168.0.0/16` |
| 3 Public Subnets | 3 Public Subnets |
| 3 Private Subnets | 3 Private Subnets |
| 1 Public EC2 | 1 Public EC2 |
| 3 Private EC2 | 3 Private EC2 |
| Security Groups | Security Groups |
| Internet Gateway | Internet Gateway |
| NAT Gateway | NAT Gateway |

Both VPCs communicate through an Inter-Region VPC Peering Connection using private IP addresses.

### HCP Terraform Workspaces

Created 7 separate workspaces in the `eec_hc_lab` organization.

| Workspace | Purpose |
|---|---|
| `fe-network-ws` | Frontend VPC and networking |
| `be-network-ws` | Backend VPC and networking |
| `fe-security-ws` | Frontend Security Groups |
| `be-security-ws` | Backend Security Groups |
| `fe-compute-ws` | Frontend EC2 and SSH key pair |
| `be-compute-ws` | Backend EC2 and SSH key pair |
| `vpc-peering-ws` | Inter-Region VPC Peering and routes |

Each workspace has its own Terraform state and remote execution configuration.

### Project Structure

```text
aws-vpc-peering-inter/
├── fe-network/
├── be-network/
├── fe-security/
├── be-security/
├── fe-compute/
├── be-compute/
└── fe-be-vpc-peering/
```

Each folder contains its own Terraform configuration and `providers.tf`.

### Terraform Workflow

#### 1. Network

- Created Frontend VPC in Tokyo.
- Created Backend VPC in Singapore.
- Created public and private subnets.
- Configured Internet Gateways.
- Configured public and private route tables.
- Created NAT Gateways for private subnet internet access.
- Verified resources in the AWS Console.

#### 2. Security Groups

- Created separate Public and Private Security Groups.
- Configured SSH and ICMP rules.
- Used `aws_vpc_security_group_ingress_rule` and `aws_vpc_security_group_egress_rule`.
- Used CIDR blocks for inter-region traffic.
- Used AWS data sources to reference existing VPCs from separate workspaces.

#### 3. Compute

- Generated Frontend and Backend SSH key pairs using `tls_private_key`.
- Registered public keys using `aws_key_pair`.
- Created public EC2 instances as Jump Hosts.
- Created three private EC2 instances in each region.
- Used AWS data sources to reference subnet and security group IDs.
- Used `null_resource` with `file` and `remote-exec` provisioners for EC2 configuration.
- Accessed private EC2 instances through SSH ProxyJump.

#### 4. Inter-Region VPC Peering

- Created a VPC Peering Connection between Singapore and Tokyo.
- Configured requester and accepter resources.
- Added routing entries between corresponding private subnets.
- Used AWS data sources to look up existing route tables.
- Verified VPC Peering status was Active.

### Connectivity Testing

Tested communication from Frontend Private Instance 02 in Tokyo to Backend Private Instance 02 in Singapore.

```bash
ping -c 4 192.168.254.209
ssh ubuntu@192.168.254.209
```

- Verified private network connectivity using ping.
- Verified SSH connectivity using the Backend SSH key pair.
- Confirmed traffic passed through Inter-Region VPC Peering.
- Captured successful test results for assignment submission.

### Terraform Commands

Run Terraform commands from the project root using `-chdir`.

```bash
terraform -chdir=fe-network init
terraform -chdir=fe-network fmt
terraform -chdir=fe-network validate
terraform -chdir=fe-network plan
terraform -chdir=fe-network apply -auto-approve
terraform -chdir=fe-network state list
```

Repeat for other workspace directories.

### Remote-Exec Is Not Idempotent

- Terraform provisioners execute commands during resource creation or replacement.
- `remote-exec` does not automatically check whether software is already installed.
- Repeated execution may reinstall packages or repeat commands.
- Added conditional checks before installing software such as `cowsay`, `unzip`, and AWS CLI.
- Used `null_resource` with `timestamp()` to trigger repeated configuration without replacing EC2 instances.
- This approach is for lab practice, not recommended for production.

### Problems and Solutions

#### AWS Credentials Error

**Problem:** HCP Terraform could not find AWS credentials.

**Solution:** Configured `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as HCP Terraform environment variables.

#### Separate Workspace References

**Problem:** Terraform could not reference resources managed by another workspace directly.

**Solution:** Used AWS data sources to retrieve existing VPC, subnet, security group, and route table information.

### Lessons Learned

- How Terraform creates and manages AWS resources using IaC.
- How to separate infrastructure into multiple HCP Terraform workspaces.
- Difference between Terraform resources and data sources.
- How Terraform dependencies work.
- How AWS Security Groups control ingress and egress traffic.
- How Inter-Region VPC Peering enables private communication.
- How SSH ProxyJump works through public and private instances.
- Why Terraform provisioners are not automatically idempotent.
- How Terraform state tracks deployed infrastructure.

### Resource Cleanup

Destroyed Terraform-managed resources after completing the connectivity test to avoid unnecessary AWS charges.

Destroy order:

1. Frontend and Backend Compute
2. VPC Peering and routes
3. Frontend and Backend Security Groups
4. Frontend and Backend Network

```bash
terraform -chdir=fe-compute destroy -auto-approve
terraform -chdir=be-compute destroy -auto-approve

terraform -chdir=fe-be-vpc-peering destroy -auto-approve

terraform -chdir=fe-security destroy -auto-approve
terraform -chdir=be-security destroy -auto-approve

terraform -chdir=fe-network destroy -auto-approve
terraform -chdir=be-network destroy -auto-approve
```

Verify all resources have been destroyed successfully in HCP Terraform and AWS Console.

### Lab Result

Successfully deployed Terraform-managed infrastructure across Tokyo and Singapore, configured Inter-Region VPC Peering, and demonstrated private network connectivity and SSH access between Frontend and Backend EC2 instances.
