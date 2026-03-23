# # Provision any standalone NSGs
# resource "azurerm_network_security_group" "this" {
#   for_each = local.standalone_nsgs

#   name                = each.value.name
#   location            = var.location
#   resource_group_name = var.resource_group_name

#   tags = var.tags
# }

# resource "azurerm_network_security_rule" "this" {
#   for_each = local.standalone_nsg_rules

#   name                         = each.value.name
#   priority                     = each.value.priority
#   direction                    = each.value.direction
#   access                       = each.value.access
#   protocol                     = each.value.protocol
#   source_address_prefix        = each.value.source_address_prefix
#   source_address_prefixes      = each.value.source_address_prefixes
#   source_port_range            = each.value.source_port_range != null ? each.value.source_port_range : null
#   source_port_ranges           = each.value.source_port_ranges != null ? each.value.source_port_ranges : null
#   destination_address_prefix   = each.value.destination_address_prefix
#   destination_address_prefixes = each.value.destination_address_prefixes
#   destination_port_range       = each.value.destination_port_range != null ? each.value.destination_port_range : null
#   destination_port_ranges      = each.value.destination_port_ranges != null ? each.value.destination_port_ranges : null
#   resource_group_name          = var.resource_group_name
#   network_security_group_name  = azurerm_network_security_group.this[each.value.nsg_key].name
# }
