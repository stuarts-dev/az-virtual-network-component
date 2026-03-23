subscription_id = "" # Development
resource_group_name = "rg-net-ppdesign"

vnets = [
  {
    name          = "vnet-iac-dev-uksouth-001"
    address_space = [""]

    dns_servers = [""]

    subnets = [
      {
        name             = "snet-iac-dev-uksouth-001"
        address_prefixes = [""]

        nsg = {
          name = "nsg-iac-dev-uksouth-001"
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
        },
      },
    ]
  },
  {
    name          = "vnet-iac-dev-uksouth-002"
    address_space = [""]

    dns_servers = [""]

    subnets = [
      {
        name             = "snet-iac-dev-uksouth-001"
        address_prefixes = [""]

        nsg = {
          name = "nsg-iac-dev-uksouth-001"

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

standalone_nsgs = [
  # OnCall Base
  {
    name                   = "nsg-oncall-base-ppdesign-uksouth-001"
    default_address_prefix = "192.168.128.0/21"
    rules = [
      {
        name                    = "HTTPS"
        priority                = "500"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_ranges = ["443", "1443"]
      },
      {
        name                    = "OnCall_License"
        priority                = "501"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_ranges = [""]
      },
      {
        name                    = "Jenkins"
        priority                = "502"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_ranges = [""]
      },
      {
        name                    = "RabbitMQ"
        priority                = "503"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_ranges = [""]
      },
      {
        name                    = "Web_API"
        priority                = "505"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_ranges = [""]
      },
      {
        name                    = "HTTP"
        priority                = "506"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "80"
      },
      {
        name                   = "SSH"
        priority               = "508"
        direction              = "Inbound"
        access                 = "Allow"
        protocol               = "Tcp"
        source_address_prefix  = ""
        source_port_range      = "*"
        destination_port_range = "22"
      },
      {
        name                    = "SSIS"
        priority                = "509"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "*"
        source_address_prefix   = ""
        source_port_range       = "*"
        destination_port_ranges = [""]
      },
    ]
  },
  # OnCall Function Apps
  {
    name                   = "nsg-oncall-fa-ppdesign-uksouth-001"
    default_address_prefix = "192.168.136.0/26"
    rules = [
      {
        name                   = "TestVMs"
        priority               = "500"
        direction              = "Inbound"
        access                 = "Allow"
        protocol               = "Tcp"
        source_address_prefix  = ""
        source_port_range      = "*"
        destination_port_range = "443"
      },
      {
        name                    = "Jenkins"
        priority                = "501"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_ranges = [""]
      },
      {
        name                    = "RabbitMQ"
        priority                = "502"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_ranges = [""]
      },
      {
        name                    = "Wiremock"
        priority                = "503"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "8089"
      },
    ]
  },
  # OnCall Function Apps Private Link
  {
    name                   = "nsg-oncall-faprvtlink-ppdesign-uksouth-001"
    default_address_prefix = ""
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
        name                    = "ServiceBus"
        priority                = "501"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "7280"
      },
      {
        name                    = "RabbitMQ"
        priority                = "502"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "15671"
      },
      {
        name                    = "MetIP"
        priority                = "503"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "8445"
      },
      {
        name                    = "FunctionApps"
        priority                = "504"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "8443"
      },
      {
        name                    = "Integrations"
        priority                = "505"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "8340"
      },
      {
        name                    = "SMB"
        priority                = "506"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "445"
      },
      {
        name                    = "Test_VMs"
        priority                = "507"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "443"
      },
      {
        name                    = "ASB"
        priority                = "509"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "5671-5672"
      },
      {
        name                    = "Wiremock"
        priority                = "510"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "8089"
      },
    ]
  },
  # OnCall App Gateway
  {
    name                   = "nsg-oncall-agw-ppdesign-uksouth-001"
    default_address_prefix = "192.168.137.0/24"
    rules = [
      {
        name                    = "AppGW_1"
        priority                = "400"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_ranges = [""]
      },
      # TODO: Can only create this rule after App Gateway deployment
      # {
      #   name                         = "AppGW_2"
      #   priority                     = "401"
      #   direction                    = "Inbound"
      #   access                       = "Allow"
      #   protocol                     = "Tcp"
      #   source_address_prefixes      = ["10.0.0.0/8", "172.27.0.0/16", "172.28.0.0/16", "192.168.64.0/18"]
      #   source_port_range            = "*"
      #   destination_address_prefixes = [] <App Gw Public and Private IPs - only known after agw deployment>
      #   destination_port_ranges      = ["80", "443", "7129", "7280", "8340", "8443", "8445", "15671"]
      # },
      {
        name                       = "AppGW_3"
        priority                   = "402"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_address_prefix      = "GatewayManager"
        source_port_range          = "*"
        destination_address_prefix = "*"
        destination_port_range     = "65200-65535"
      },
      {
        name                       = "AGW_Healthprobe"
        priority                   = "403"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_address_prefix      = "*"
        source_port_range          = "*"
        destination_address_prefix = "*"
        destination_port_range     = "65200-65535"
      },
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
        name                    = "ServiceBus"
        priority                = "501"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "7280"
      },
      {
        name                    = "RabbitMQ"
        priority                = "502"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "15671"
      },
      {
        name                    = "MetIP"
        priority                = "503"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "8445"
      },
      {
        name                    = "FunctionApps"
        priority                = "504"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "8443"
      },
      {
        name                    = "Integrations"
        priority                = "505"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "8340"
      },
      {
        name                    = "SMB"
        priority                = "506"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "445"
      },
      {
        name                    = "POLE"
        priority                = "507"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "8449"
      },
      {
        name                    = "PNC"
        priority                = "508"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "8447"
      },
      {
        name                    = "CAD"
        priority                = "509"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "7129"
      },
      {
        name                    = "APLS"
        priority                = "510"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "8451"
      },
      {
        name                    = "TestVMs"
        priority                = "511"
        direction               = "Inbound"
        access                  = "Allow"
        protocol                = "Tcp"
        source_address_prefixes = [""]
        source_port_range       = "*"
        destination_port_range  = "443"
      },
    ]
  },
]

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
    protocol               = "Tcp"
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
    name                   = "Ansible_Linux"
    priority               = "994"
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_address_prefix  = "" # App Gateway
    source_port_range      = "*"
    destination_port_range = "22"
  },
  {
    name                   = "Ansible_Windows"
    priority               = "995"
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_address_prefix  = "" # App Gateway
    source_port_range      = "*"
    destination_port_range = "5986"
  },
  {
    name                   = "Sophos"
    priority               = "996"
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_address_prefix  = "" # Security Central
    source_port_range      = "*"
    destination_port_range = "8190-8191"
  },
  {
    name                   = "Rapid7"
    priority               = "997"
    direction              = "Inbound"
    access                 = "Allow"
    protocol               = "Tcp"
    source_address_prefix  = "" # Security Central
    source_port_range      = "*"
    destination_port_range = "21047"
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
    WorkloadName       = "ppdesign"
  }
  optional = {}
  additional = {
    BusinessCriticality = "High"
    ResourceType        = "VirtualNetwork"
  }
}
