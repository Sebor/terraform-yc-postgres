variable "cluster_name" {
  type        = string
  description = "Postgres cluster name and name prefix for cluster resources"
}

variable "cluster_description" {
  type        = string
  default     = "Postgres cluster managed by terraform"
  description = "A description of the Postgres cluster"
}

variable "cluster_folder_id" {
  type        = string
  default     = null
  description = "The ID of the folder that the Postgres cluster belongs to"
}

variable "cluster_environment" {
  type        = string
  default     = "PRODUCTION"
  description = <<EOF
  Deployment environment of the Postgres cluster.
  Can be either PRESTABLE or PRODUCTION. The default is PRODUCTION
  EOF

  validation {
    condition     = contains(["PRODUCTION", "PRESTABLE"], var.cluster_environment)
    error_message = "Environment must be 'PRODUCTION' or 'PRESTABLE'."
  }
}

variable "cluster_vpc_id" {
  type        = string
  description = "ID of the network, to which the Postgres cluster belongs"
}

variable "cluster_version" {
  type        = string
  description = "Version of the Postgres cluster"

  validation {
    condition     = contains(["10", "10-1c", "11", "11-1c", "12", "12-1c", "13"], var.cluster_version)
    error_message = "Allowed cluster versions are: 10, 10-1c, 11, 11-1c, 12, 12-1c, 13."
  }
}

variable "cluster_assign_public_ip" {
  type        = bool
  default     = null
  description = "Determines whether each host will be assigned a public IP address"
}

variable "cluster_deletion_protection" {
  type        = bool
  default     = null
  description = "Inhibits deletion of the cluster"
}

variable "cluster_autofailover" {
  type        = bool
  default     = null
  description = "Configuration setting which enables/disables autofailover in cluster"
}

variable "cluster_security_group_ids" {
  type        = list(string)
  default     = []
  description = "List of security group IDs to be assigned to cluster"
}

variable "cluster_maintenance_windows" {
  type        = map(any)
  default     = null
  description = <<EOF
  Maintenance policy of the Postgres cluster
  Example:
  ```
  cluster_maintenance_windows = {
      type = "WEEKLY"
      day  = "MON
      hour = "17"
  }
  ```
  EOF
}

variable "cluster_resources" {
  type = object({
    disk_size          = number
    disk_type_id       = string
    resource_preset_id = string
  })
  description = <<EOF
  Rsources of the Postgres cluster.
  Example:
  ```
  cluster_resources = {
    disk_size          = 20
    disk_type_id       = "network-ssd"
    resource_preset_id = "s2.micro"
  }
  ```
  EOF
}

variable "postgresql_config" {
  type        = map(any)
  default     = null
  description = <<EOF
  Configuration of the Postgres subcluster.
  Example:
  ```
  postgresql_config = {
    max_connections = 100
  }
  ```
  EOF
}

variable "pooler_config" {
  type        = map(any)
  default     = null
  description = <<EOF
  Configuration of the Postgres pooler subcluster.
  Example:
  ```
  pooler_config = {
    pool_discard = true
  }
  ```
  EOF
}

variable "access_config" {
  type        = map(any)
  default     = null
  description = <<EOF
  Configuration of the Postgres access subcluster.
  Example:
  ```
  access_config = {
    web_sql = true
  }
  ```
  EOF
}

variable "performance_diagnostics_config" {
  type = object({
    enabled                      = bool
    sessions_sampling_interval   = number
    statements_sampling_interval = number
  })
  default     = null
  description = <<EOF
  Configuration of the Postgres performance diagnostics subcluster.
  Example:
  ```
  performance_diagnostics_config = {
    enabled = true
  }
  ```
  EOF
}

variable "cluster_hosts" {
  type        = any
  description = <<EOF
  A list of Postgres hosts.
  Example:
  ```
  cluster_hosts = [
    {
      zone      = "ru-central1-a"
      subnet_id = "dfsdfdfsfsd343434"
    },
    {
      zone      = "ru-central1-b"
      subnet_id = "1fs567hfsd343434"
    }
  ]
  ```
  EOF
}

variable "cluster_users" {
  type        = any
  description = <<EOF
  A set of Postgres users.
  Example:
  ```
  cluster_users = {
    user1 = {
      password = passwordone
      permissions = [
        {
          database_name = "db1"
        }
      ]
    },
    user2 = {
      password = passwordtwo
      permissions = [
        {
          database_name = "db2"
        },
        {
          database_name = "db1"
        }
      ]
    }
  }
  ```
  EOF
}

variable "cluster_databases" {
  type        = any
  description = <<EOF
  A list of Postgres databases.
  Example:
  ```
  cluster_databases = [
    {
      name       = "db1"
      owner      = "petya"
      lc_collate = "en_US.UTF-8"
      lc_type    = "en_US.UTF-8"
    },
    {
      name  = "db2"
      owner = "vasya"
    }
  ]
  ```
  EOF
}

variable "backup_config" {
  type        = map(any)
  default     = null
  description = <<EOF
  Cluster backup configuration.
  Exam[le:
  ```
  backup_config = {
    backup_retain_period_days = 7
    start_hours               = 7
    start_minutes             = 7
  }
  ```
  EOF
}

variable "cluster_postgres_cname" {
  type        = string
  default     = null
  description = "Internal CNAME for Postgres hosts"
}

variable "internal_dns_zone_id" {
  type        = string
  default     = null
  description = "Internal DNS zone ID for Postgres hosts"
}

variable "internal_dns_zone_name" {
  type        = string
  default     = null
  description = "Internal DNS zone name for Postgres hosts"
}

variable "labels" {
  type        = map(any)
  default     = {}
  description = "A set of key/value label pairs to assign to the Kubernetes cluster resources"
}
