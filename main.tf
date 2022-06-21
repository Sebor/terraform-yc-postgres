resource "yandex_mdb_postgresql_cluster" "this" {
  name        = var.cluster_name
  description = var.cluster_description
  environment = var.cluster_environment
  folder_id   = var.cluster_folder_id

  network_id         = var.cluster_vpc_id
  security_group_ids = var.cluster_security_group_ids

  deletion_protection = var.cluster_deletion_protection

  config {
    version           = var.cluster_version
    postgresql_config = var.postgresql_config
    autofailover      = var.cluster_autofailover

    resources {
      disk_size          = lookup(var.cluster_resources, "disk_size")
      disk_type_id       = lookup(var.cluster_resources, "disk_type_id")
      resource_preset_id = lookup(var.cluster_resources, "resource_preset_id")
    }

    dynamic "pooler_config" {
      for_each = var.pooler_config != null ? [1] : []

      content {
        pool_discard = lookup(var.pooler_config, "pool_discard", null)
        pooling_mode = lookup(var.pooler_config, "pooling_mode", null)
      }
    }

    dynamic "access" {
      for_each = var.access_config != null ? [1] : []

      content {
        web_sql    = lookup(var.access_config, "web_sql", null)
        data_lens  = lookup(var.access_config, "data_lens", null)
        serverless = lookup(var.access_config, "serverless", null)
      }
    }

    backup_retain_period_days = var.backup_config != null ? lookup(var.backup_config, "backup_retain_period_days", null) : null
    dynamic "backup_window_start" {
      for_each = var.backup_config != null ? [1] : []

      content {
        hours   = lookup(var.backup_config, "start_hours", null)
        minutes = lookup(var.backup_config, "start_minutes", null)
      }
    }

    dynamic "performance_diagnostics" {
      for_each = var.performance_diagnostics_config != null ? [1] : []

      content {
        enabled                      = lookup(var.performance_diagnostics_config, "enabled", null)
        sessions_sampling_interval   = lookup(var.performance_diagnostics_config, "sessions_sampling_interval", null)
        statements_sampling_interval = lookup(var.performance_diagnostics_config, "statements_sampling_interval", null)
      }
    }
  }

  dynamic "host" {
    for_each = var.cluster_hosts

    content {
      zone             = host.value.zone
      subnet_id        = host.value.subnet_id
      assign_public_ip = var.cluster_assign_public_ip
    }
  }

  dynamic "database" {
    for_each = var.cluster_databases

    content {
      name       = database.value.name
      owner      = database.value.owner
      lc_collate = contains(keys(database.value), "lc_collate") ? database.value["lc_collate"] : null
      lc_type    = contains(keys(database.value), "lc_type") ? database.value["lc_type"] : null

    }
  }

  dynamic "user" {
    for_each = var.cluster_users

    content {
      name       = user.key
      password   = user.value["password"]
      grants     = contains(keys(user.value), "grants") ? user.value["grants"] : null
      login      = contains(keys(user.value), "login") ? user.value["login"] : null
      conn_limit = contains(keys(user.value), "conn_limit") ? user.value["conn_limit"] : null
      dynamic "permission" {
        for_each = try(user.value["permissions"], [])

        content {
          database_name = permission.value.database_name
        }
      }
    }
  }

  dynamic "maintenance_window" {
    for_each = var.cluster_maintenance_windows != null ? [1] : []

    content {
      type = lookup(maintenance_window, "type", "WEEKLY")
      day  = lookup(maintenance_window, "day", null)
      hour = lookup(maintenance_window, "hour", null)
    }
  }

  labels = var.labels
}

resource "yandex_dns_recordset" "this" {
  count = var.cluster_postgres_cname != null && var.internal_dns_zone_id != null && var.internal_dns_zone_name != null ? length(var.cluster_hosts) : 0

  zone_id = var.internal_dns_zone_id
  name    = "${var.cluster_postgres_cname}-${count.index}.${var.internal_dns_zone_name}."
  type    = "CNAME"
  ttl     = 360
  data    = [yandex_mdb_postgresql_cluster.this.host[count.index].fqdn]
}
