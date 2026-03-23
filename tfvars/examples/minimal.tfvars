subscription_id     = "ca630ab5-4a89-4ed5-93f7-c6c78e624eb3"
resource_group_name = "rg-component-examples"

vnets = [
  {
    name          = "vnet-ex1-poc-uksouth-001"
    address_space = ["10.0.0.0/24"]

    # dns_servers = ["", "", ""]

    subnets = [
      {
        name             = "snet-ex1-poc-uksouth-001"
        address_prefixes = ["10.0.0.0/28"]

        nsg = {
          name = "nsg-ex1-poc-uksouth-001"
          rules = [
            {
              name                   = "HTTPS"
              priority               = "500"
              direction              = "Inbound"
              access                 = "Allow"
              protocol               = "Tcp"
              source_address_prefix  = "*"
              source_port_range      = "*"
              destination_port_range = "443"
            },
            {
              name                   = "DevVMs_Ansible"
              priority               = "508"
              direction              = "Inbound"
              access                 = "Allow"
              protocol               = "Tcp"
              source_address_prefix  = "*"
              source_port_range      = "*"
              destination_port_range = "5986"
            },
          ]
        },
      },
    ]
  },
  {
    name          = "vnet-ex1-poc-uksouth-002"
    address_space = ["10.0.1.0/24"]

    #dns_servers = [""]

    subnets = [
      {
        name             = "snet-ex1-poc-uksouth-001"
        address_prefixes = ["10.0.1.0/28"]

        nsg = {
          name = "nsg-ex1-poc-uksouth-001"

          rules = [
            {
              name                   = "HTTPS"
              priority               = "500"
              direction              = "Inbound"
              access                 = "Allow"
              protocol               = "Tcp"
              source_address_prefix  = "*"
              source_port_range      = "*"
              destination_port_range = "443"
            },
            {
              name                   = "DevVMs_Ansible"
              priority               = "508"
              direction              = "Inbound"
              access                 = "Allow"
              protocol               = "Tcp"
              source_address_prefix  = "*"
              source_port_range      = "*"
              destination_port_range = "5986"
            },
          ]
        }
      },
    ]
  },
]
