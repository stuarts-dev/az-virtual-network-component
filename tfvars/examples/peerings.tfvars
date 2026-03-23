subscription_id     = ""
resource_group_name = "rg-net-ppsaopr1"

vnets = [
  {
    name          = "vnet-opr-ppsa1-uksouth-001"
    address_space = [""]

    dns_servers = [""]

    peerings = [
      {
        remote_virtual_network = {
          name                   = "vnet--uksouth-001"
          resource_group_name    = "rg-net-sd"
          subscription_shortname = ""
        }

        source_to_remote_config = {
          allow_virtual_network_access = true
          allow_forwarded_traffic      = true
        }

        remote_to_source_config = {
          allow_virtual_network_access = true
        }
      },
      {
        remote_virtual_network = {
          name                   = "vnet-2"
          resource_group_name    = "rg-"
          subscription_shortname = "n"
        }

        source_to_remote_config = {
          use_remote_gateways = true
        }

        remote_to_source_config = {
          allow_virtual_network_access = true
          allow_gateway_transit        = true
        }
      },
    ]

    subnets = [
      {
        name              = "snetuksouth-001"
        address_prefixes  = [""]
        service_endpoints = ["Microsoft.Storage"]

        nsg = {
          name = "nsg-oprsouth-001"

          rules = [
            {
              name                    = "HTTPS"
              priority                = "500"
              direction               = "Inbound"
              access                  = "Allow"
              protocol                = "Tcp"
              source_address_prefixes = [""]
              source_port_range       = "*"
              destination_port_range  = "443"
            },
            {
              name                    = "OPR_Client"
              priority                = "501"
              direction               = "Inbound"
              access                  = "Allow"
              protocol                = "Tcp"
              source_address_prefixes = [""]
              source_port_range       = "*"
              destination_port_range  = "808"
            },
            {
              name                    = "License"
              priority                = "502"
              direction               = "Inbound"
              access                  = "Allow"
              protocol                = "Tcp"
              source_address_prefixes = [""]
              source_port_range       = "*"
              destination_port_range  = "5053-5054"
            },
            {
              name                    = "SQL_TCP"
              priority                = "503"
              direction               = "Inbound"
              access                  = "Allow"
              protocol                = "Tcp"
              source_address_prefixes = [""]
              source_port_range       = "*"
              destination_port_ranges = ["1433", "5022", "7022"]
            },
            {
              name                    = "SQL_UDP"
              priority                = "504"
              direction               = "Inbound"
              access                  = "Allow"
              protocol                = "Udp"
              source_address_prefixes = [""]
              source_port_range       = "*"
              destination_port_range  = "1433"
            },
            {
              name                    = "DevVMs_Ansible"
              priority                = "508"
              direction               = "Inbound"
              access                  = "Allow"
              protocol                = "Tcp"
              source_address_prefixes = [""]
              source_port_range       = "*"
              destination_port_range  = "5986"
            },
          ]
        }
      },
    ]
  },
]

standalone_nsgs = []

common_nsg_rules = [
  {
    name                    = "PatchManagerPlus"
    priority                = "900"
    direction               = "Inbound"
    access                  = "Allow"
    protocol                = "*"
    source_address_prefix   = ""
    source_port_range       = "*"
    destination_port_ranges = ["445", "8027", "8383", "8384"]
  },
  {
    name                   = "Internal_Subnet"
    priority               = "901"
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "*"
    source_port_range      = "*"
    destination_port_range = "*"
  },
  {
    name                   = "AzureLoadBalancer"
    priority               = "992"
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_address_prefix  = "AzureLoadBalancer"
    source_port_range      = "*"
    destination_port_range = "*"
  },
  {
    name                   = "Bastion_Host"
    priority               = "993"
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_address_prefix  = "" # Bastion Host
    source_port_range      = "*"
    destination_port_range = "3389"
  },
  {
    name                    = "Ansible_Linux"
    priority                = "994"
    direction               = "Inbound"
    access                  = "Allow"
    protocol                = "Tcp"
    source_address_prefixes = [""] # NPR MGMT domsvc & pipeline (Green Jenkins) snet
    source_port_range       = "*"
    destination_port_range  = "22"
  },
  {
    name                    = "Ansible_Windows"
    priority                = "995"
    direction               = "Inbound"
    access                  = "Allow"
    protocol                = "Tcp"
    source_address_prefixes = [""] # NPR MGMT domsvc & pipeline (Green Jenkins) snet
    source_port_range       = "*"
    destination_port_range  = "5986"
  },
  {
    name                    = "Snare_UDP"
    priority                = "998"
    direction               = "Inbound"
    access                  = "Allow"
    protocol                = "Udp"
    source_address_prefix   = "" # MPS-Provided IP
    source_port_range       = "*"
    destination_port_ranges = ["6161", "6262"]
  },
  {
    name                    = "Snare_TCP"
    priority                = "999"
    direction               = "Inbound"
    access                  = "Allow"
    protocol                = "Tcp"
    source_address_prefix   = "" # MPS-Provided IP
    source_port_range       = "*"
    destination_port_ranges = ["6161", "6262"]
  },
  {
    name                       = "DenyAllInbound"
    priority                   = "1000"
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_address_prefix      = "*"
    source_port_range          = "*"
    destination_address_prefix = "*"
    destination_port_range     = "*"
  },
]

tags = {
  mandatory = {
    BusinessUnit       = "MPSCC"
    Criticality        = "Business-Critical"
    DataClassification = "0"
    Environment        = "Non-Production"
    OpsCommitment      = "Platform Operations"
    OpsTeam            = "Environments"
    WorkloadName       = "ppsaopr1"
  }
  optional = {}
  additional = {
    BusinessCriticality = "High"
    ResourceType        = "VirtualNetwork"
  }
}
