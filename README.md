# Postgres

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.0 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | >= 0.74 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | >= 0.74 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_dns_recordset.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/dns_recordset) | resource |
| [yandex_mdb_postgresql_cluster.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_postgresql_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_config"></a> [access\_config](#input\_access\_config) | Configuration of the Postgres access subcluster.<br>  Example:<pre>access_config = {<br>    web_sql = true<br>  }</pre> | `map(any)` | `null` | no |
| <a name="input_backup_config"></a> [backup\_config](#input\_backup\_config) | Cluster backup configuration.<br>  Exam[le:<pre>backup_config = {<br>    backup_retain_period_days = 7<br>    start_hours               = 7<br>    start_minutes             = 7<br>  }</pre> | `map(any)` | `null` | no |
| <a name="input_cluster_assign_public_ip"></a> [cluster\_assign\_public\_ip](#input\_cluster\_assign\_public\_ip) | Determines whether each host will be assigned a public IP address | `bool` | `null` | no |
| <a name="input_cluster_autofailover"></a> [cluster\_autofailover](#input\_cluster\_autofailover) | Configuration setting which enables/disables autofailover in cluster | `bool` | `null` | no |
| <a name="input_cluster_databases"></a> [cluster\_databases](#input\_cluster\_databases) | A list of Postgres databases.<br>  Example:<pre>cluster_databases = [<br>    {<br>      name       = "db1"<br>      owner      = "petya"<br>      lc_collate = "en_US.UTF-8"<br>      lc_type    = "en_US.UTF-8"<br>    },<br>    {<br>      name  = "db2"<br>      owner = "vasya"<br>    }<br>  ]</pre> | `any` | n/a | yes |
| <a name="input_cluster_deletion_protection"></a> [cluster\_deletion\_protection](#input\_cluster\_deletion\_protection) | Inhibits deletion of the cluster | `bool` | `null` | no |
| <a name="input_cluster_description"></a> [cluster\_description](#input\_cluster\_description) | A description of the Postgres cluster | `string` | `"Postgres cluster managed by terraform"` | no |
| <a name="input_cluster_environment"></a> [cluster\_environment](#input\_cluster\_environment) | Deployment environment of the Postgres cluster.<br>  Can be either PRESTABLE or PRODUCTION. The default is PRODUCTION | `string` | `"PRODUCTION"` | no |
| <a name="input_cluster_folder_id"></a> [cluster\_folder\_id](#input\_cluster\_folder\_id) | The ID of the folder that the Postgres cluster belongs to | `string` | `null` | no |
| <a name="input_cluster_hosts"></a> [cluster\_hosts](#input\_cluster\_hosts) | A list of Postgres hosts.<br>  Example:<pre>cluster_hosts = [<br>    {<br>      zone      = "ru-central1-a"<br>      subnet_id = "dfsdfdfsfsd343434"<br>    },<br>    {<br>      zone      = "ru-central1-b"<br>      subnet_id = "1fs567hfsd343434"<br>    }<br>  ]</pre> | `any` | n/a | yes |
| <a name="input_cluster_maintenance_windows"></a> [cluster\_maintenance\_windows](#input\_cluster\_maintenance\_windows) | Maintenance policy of the Postgres cluster<br>  Example:<pre>cluster_maintenance_windows = {<br>      type = "WEEKLY"<br>      day  = "MON<br>      hour = "17"<br>  }</pre> | `map(any)` | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Postgres cluster name and name prefix for cluster resources | `string` | n/a | yes |
| <a name="input_cluster_postgres_cname"></a> [cluster\_postgres\_cname](#input\_cluster\_postgres\_cname) | Internal CNAME for Postgres hosts | `string` | `null` | no |
| <a name="input_cluster_resources"></a> [cluster\_resources](#input\_cluster\_resources) | Rsources of the Postgres cluster.<br>  Example:<pre>cluster_resources = {<br>    disk_size          = 20<br>    disk_type_id       = "network-ssd"<br>    resource_preset_id = "s2.micro"<br>  }</pre> | <pre>object({<br>    disk_size          = number<br>    disk_type_id       = string<br>    resource_preset_id = string<br>  })</pre> | n/a | yes |
| <a name="input_cluster_security_group_ids"></a> [cluster\_security\_group\_ids](#input\_cluster\_security\_group\_ids) | List of security group IDs to be assigned to cluster | `list(string)` | `[]` | no |
| <a name="input_cluster_users"></a> [cluster\_users](#input\_cluster\_users) | A set of Postgres users.<br>  Example:<pre>cluster_users = {<br>    user1 = {<br>      password = passwordone<br>      permissions = [<br>        {<br>          database_name = "db1"<br>        }<br>      ]<br>    },<br>    user2 = {<br>      password = passwordtwo<br>      permissions = [<br>        {<br>          database_name = "db2"<br>        },<br>        {<br>          database_name = "db1"<br>        }<br>      ]<br>    }<br>  }</pre> | `any` | n/a | yes |
| <a name="input_cluster_version"></a> [cluster\_version](#input\_cluster\_version) | Version of the Postgres cluster | `string` | n/a | yes |
| <a name="input_cluster_vpc_id"></a> [cluster\_vpc\_id](#input\_cluster\_vpc\_id) | ID of the network, to which the Postgres cluster belongs | `string` | n/a | yes |
| <a name="input_internal_dns_zone_id"></a> [internal\_dns\_zone\_id](#input\_internal\_dns\_zone\_id) | Internal DNS zone ID for Postgres hosts | `string` | `null` | no |
| <a name="input_internal_dns_zone_name"></a> [internal\_dns\_zone\_name](#input\_internal\_dns\_zone\_name) | Internal DNS zone name for Postgres hosts | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the Kubernetes cluster resources | `map(any)` | `{}` | no |
| <a name="input_performance_diagnostics_config"></a> [performance\_diagnostics\_config](#input\_performance\_diagnostics\_config) | Configuration of the Postgres performance diagnostics subcluster.<br>  Example:<pre>performance_diagnostics_config = {<br>    enabled = true<br>  }</pre> | <pre>object({<br>    enabled                      = bool<br>    sessions_sampling_interval   = number<br>    statements_sampling_interval = number<br>  })</pre> | `null` | no |
| <a name="input_pooler_config"></a> [pooler\_config](#input\_pooler\_config) | Configuration of the Postgres pooler subcluster.<br>  Example:<pre>pooler_config = {<br>    pool_discard = true<br>  }</pre> | `map(any)` | `null` | no |
| <a name="input_postgresql_config"></a> [postgresql\_config](#input\_postgresql\_config) | Configuration of the Postgres subcluster.<br>  Example:<pre>postgresql_config = {<br>    max_connections = 100<br>  }</pre> | `map(any)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_databases"></a> [cluster\_databases](#output\_cluster\_databases) | A set of cluster databases |
| <a name="output_cluster_hosts"></a> [cluster\_hosts](#output\_cluster\_hosts) | A set of Postgres hosts |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | Postgres cluster ID |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Postgre cluster name |
| <a name="output_cluster_postgres_cname_hosts"></a> [cluster\_postgres\_cname\_hosts](#output\_cluster\_postgres\_cname\_hosts) | A list of Postgres CNAME hosts |
| <a name="output_cluster_users"></a> [cluster\_users](#output\_cluster\_users) | A list of cluster users |
| <a name="output_cluster_vpc_id"></a> [cluster\_vpc\_id](#output\_cluster\_vpc\_id) | Postgres network ID |
<!-- END_TF_DOCS -->

## TODO

[Migrate](<https://github.com/yandex-cloud/terraform-provider-yandex/releases/tag/v0.75.0>) to separate `yandex_mdb_postgresql_user` and `yandex_mdb_postgresql_database` resources.
