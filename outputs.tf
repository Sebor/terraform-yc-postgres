output "cluster_name" {
  value       = yandex_mdb_postgresql_cluster.this.name
  description = "Postgre cluster name"
}

output "cluster_id" {
  value       = yandex_mdb_postgresql_cluster.this.id
  description = "Postgres cluster ID"
}

output "cluster_vpc_id" {
  value       = yandex_mdb_postgresql_cluster.this.network_id
  description = "Postgres network ID"
}

output "cluster_hosts" {
  value = [
    for host in yandex_mdb_postgresql_cluster.this.host : {
      fqdn      = host.fqdn
      zone      = host.zone
      subnet_id = host.subnet_id
    }
  ]
  description = "A set of Postgres hosts"
}

output "cluster_databases" {
  value = [
    for db in yandex_mdb_postgresql_cluster.this.database : {
      name  = db.name
      owner = db.owner
    }
  ]
  description = "A set of cluster databases"
}

output "cluster_users" {
  value       = yandex_mdb_postgresql_cluster.this.user.*.name
  description = "A list of cluster users"
}

output "cluster_postgres_cname_hosts" {
  value = [
    for host in yandex_dns_recordset.this.*.name :
    trimsuffix(host, ".")
  ]
  description = "A list of Postgres CNAME hosts"
}
