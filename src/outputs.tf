output "delegations" {
  description = "Map of service principals to account IDs"
  value = {
    for k, v in local.delegations :
    v.principal => v.account_id
  }
}
