provider "aws" {
  region = "us-east-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  # Requester's credentials.
}

provider "aws" {
  alias  = "peer"
  region = "us-west-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  # Accepter's credentials.
}




# Requester's side of the connection.
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = module.vpc.vpc_A_id
  peer_vpc_id   = module.vpc_2.vpc_B_id
  peer_owner_id = var.peer_owner_id
  peer_region   = "us-west-1"
  auto_accept   = false

  tags = {
    Side = "Requester"
  }
}

# Accepter's side of the connection.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = aws.peer
  vpc_peering_connection_id = aws_vpc_peering_connection.peer.id
  auto_accept               = true

  tags = {
    Side = "Accepter"
  }
}

output "peer_id" {
  value = aws_vpc_peering_connection.peer.id
}