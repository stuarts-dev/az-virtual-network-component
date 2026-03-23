locals {

  resource_group_name = var.resource_group_name

  vnets = { for vnet in var.vnets :
    "${vnet.name != null ? vnet.name : vnet.name_suffix}" => {
      name          = vnet.name
      address_space = vnet.address_space
      dns_servers   = vnet.dns_servers
      location      = vnet.location

      # peerings = [for peering in vnet.peerings :
      #   {
      #     name = try(peering.name, null)

      #     remote_virtual_network = {
      #       id                  = try(peering.remote_virtual_network.id, null)
      #       name                = try(peering.remote_virtual_network.name, null)
      #       resource_group_name = try(peering.remote_virtual_network.resource_group_name, null)
      #       subscription_id     = try(peering.remote_virtual_network.subscription_shortname, null) != null ? module.common.subscriptions[peering.remote_virtual_network.subscription_shortname] : null
      #     }

      #     source_to_remote_config = try(peering.source_to_remote_config, null)
      #     remote_to_source_config = try(peering.remote_to_source_config, null)
      #   }
      # ]

      subnets = [for subnet in vnet.subnets :
        {
          name              = subnet.name
          address_prefixes  = subnet.address_prefixes
          service_endpoints = subnet.service_endpoints

          # If an NSG has been defined within the subnet, redefine this to concatenate the common rules with the NSG's own rules - otherwise, set to null
          nsg = (
            (try(subnet.nsg, null) != null) ?
            {
              name  = subnet.nsg.name,
              # rules = concat(var.common_nsg_rules, subnet.nsg.rules)
              rules = subnet.nsg.rules
            } :
            null
          )
          nsg_id = try(subnet.nsg_id, null)

          route_table    = try(subnet.route_table, null)
          route_table_id = try(subnet.route_table_id, null)
        }
      ]
    }
  }

  # For each standalone NSG, concatenate the common rules with the NSG's own rules
  # standalone_nsgs = { for nsg in(var.standalone_nsgs != null ? var.standalone_nsgs : []) :
  #   "${nsg.name != null ? nsg.name : nsg.name_suffix}" => {
  #     name                   = nsg.name # != null ? nsg.name : "${module.common.network_security_group_name}-${nsg.name_suffix}"
  #     default_address_prefix = nsg.default_address_prefix
  #     rules                  = concat(var.common_nsg_rules, nsg.rules)
  #   }
  # }

  # standalone_nsg_rules = merge([for nsg_key, nsg in local.standalone_nsgs :
  #   {
  #     for rule in nsg.rules :
  #     "${nsg.name}_${rule.name}" => {
  #       nsg_key                      = nsg_key
  #       nsg_name                     = nsg.name
  #       name                         = rule.name
  #       priority                     = rule.priority
  #       direction                    = rule.direction
  #       access                       = rule.access
  #       protocol                     = rule.protocol
  #       source_port_range            = rule.source_port_range
  #       source_port_ranges           = rule.source_port_ranges
  #       destination_port_range       = rule.destination_port_range
  #       destination_port_ranges      = rule.destination_port_ranges
  #       source_address_prefix        = try(rule.source_address_prefix, null) != null ? rule.source_address_prefix : try(rule.source_address_prefixes, null) != null ? null : "${nsg.default_address_prefix}"
  #       source_address_prefixes      = try(rule.source_address_prefixes, null) != null ? rule.source_address_prefixes : null
  #       destination_address_prefix   = try(rule.destination_address_prefix, null) != null ? rule.destination_address_prefix : try(rule.destination_address_prefixes, null) != null ? null : "${nsg.default_address_prefix}"
  #       destination_address_prefixes = try(rule.destination_address_prefixes, null) != null ? rule.destination_address_prefixes : null
  #     }
  #   }
  # ]...)

}
