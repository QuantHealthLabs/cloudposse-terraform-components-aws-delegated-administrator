locals {
  enabled = module.this.enabled

  # Resolve account name to ID using account_map, or keep key as-is if already an ID
  resolved_account_ids = {
    for k, _ in var.delegated_administrators :
      k => try(module.account_map.outputs.account_info_map[k].id, k)
  }

  # Flatten: [{account, principal}, ...] and dedupe principals per account
  delegation_items = flatten([
    for account, principals in var.delegated_administrators : [
      for p in distinct(principals) : {
        account   = account
        principal = p
      }
    ]
  ])

  # Build map for for_each: "<account_id>-<principal>" => { account_id, principal }
  delegations = {
    for item in local.delegation_items :
    "${item.account}-${item.principal}" => {
      account_id = lookup(local.resolved_account_ids, item.account)
      principal  = item.principal
    }
  }
}

resource "aws_organizations_delegated_administrator" "this" {
  for_each          = local.enabled ? local.delegations : {}
  account_id        = each.value.account_id
  service_principal = each.value.principal
}
