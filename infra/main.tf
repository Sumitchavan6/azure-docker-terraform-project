############################################
# RESOURCE GROUP (EXISTING)
############################################
data "azurerm_resource_group" "rg" {
  name = "myRG"
}

############################################
# VIRTUAL NETWORK
############################################
resource "azurerm_virtual_network" "vnet" {
  name                = "project-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

############################################
# SUBNETS
############################################
resource "azurerm_subnet" "frontend" {
  name                 = "frontend-subnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "backend" {
  name                 = "backend-subnet"
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

############################################
# NETWORK SECURITY GROUP (NSG)
############################################
resource "azurerm_network_security_group" "nsg" {
  name                = "frontend-nsg"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_network_security_rule" "allow_http" {
  name                        = "Allow-HTTP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

############################################
# ASSOCIATE NSG TO SUBNET
############################################
resource "azurerm_subnet_network_security_group_association" "assoc" {
  subnet_id                 = azurerm_subnet.frontend.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

############################################
# EXISTING ACR
############################################
data "azurerm_container_registry" "acr" {
  name                = "myacr12311sam52"
  resource_group_name = "myRG"
}

############################################
# STORAGE ACCOUNT
############################################
resource "azurerm_storage_account" "storage" {
  name                     = "mystorage12345demosumit"
  resource_group_name      = data.azurerm_resource_group.rg.name
  location                 = data.azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

############################################
# AZURE CONTAINER INSTANCE (ACI)
############################################
resource "azurerm_container_group" "app" {
  name                = "my-container-app"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  os_type             = "Linux"

  dns_name_label  = "myappdemo12"
  ip_address_type = "Public"

  container {
    name   = "myapp"
    image  = "myacr12311sam52.azurecr.io/myapp:v1"
    cpu    = "1"
    memory = "1.5"

    ports {
      port     = 80
      protocol = "TCP"
    }
  }

  image_registry_credential {
    server   = data.azurerm_container_registry.acr.login_server
    username = data.azurerm_container_registry.acr.admin_username
    password = data.azurerm_container_registry.acr.admin_password
  }
}