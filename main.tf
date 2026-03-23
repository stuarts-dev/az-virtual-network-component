module "vnet" {
  for_each = local.vnets
  source   = "git::https://github.com/stuarts-dev/az-virtual-network-module.git?ref=v0.1.0"

  resource_group_name = local.resource_group_name
  location            = var.location
  subscription_id     = var.subscription_id


  name          = each.value.name
  address_space = each.value.address_space
  dns_servers   = each.value.dns_servers
  # peerings      = each.value.peerings
  subnets = each.value.subnets

  tags = var.tags

  # depends_on = [
  #   azurerm_network_security_group.this
  # ]
}
