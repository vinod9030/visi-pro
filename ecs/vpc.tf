# network.tf

resource "aws_vpc" "test-vpc" {
  cidr_block = "172.31.0.0/16"
}

# Fetch AZs in the current region
data "aws_availability_zones" "available" {
}


# Create var.az_count private subnets, each in a different AZ
resource "aws_subnet" "private" {
  count             = var.az_count
  cidr_block        = cidrsubnet(aws_vpc.test-vpc.172.31.48.0/20, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.test-vpc.vpc-0382f51c959645e99
}

# Create var.az_count public subnets, each in a different AZ
resource "aws_subnet" "public" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.test-vpc.172.31.80.0/20, 8, var.az_count + count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.test-vpc.vpc-0382f51c959645e99
  map_public_ip_on_launch = true
}

# Internet Gateway for the public subnet
resource "aws_internet_gateway" "visi-pro-igw" {
  vpc_id = aws_vpc.test-vpc.vpc-0382f51c959645e99
}

# Route the public subnet traffic through the IGW
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.test-vpc.main_route_table_rtb-07d1bd9f86996008e
  destination_cidr_block = "172.31.0.0/16"
  gateway_id             = aws_internet_gateway.test-igw.igw-0d99675bb66becd2c
}

# Create a NAT gateway with an Elastic IP for each private subnet to get internet connectivity
resource "aws_eip" "visi-pro-eip" {
  count      = var.az_count
  vpc        = true
  depends_on = [aws_internet_gateway.test-igw-0d99675bb66becd2c]
}

resource "aws_nat_gateway" "visi-pro-natgw" {
  count         = var.az_count
  subnet_id     = element(aws_subnet.public.subnet-06d9db5a1de59d5c7, count.index)
  allocation_id = element(aws_eip.test-eip.eipalloc-08f57de18ff4c9bdb, count.index)
}

# Create a new route table for the private subnets, make it route non-local traffic through the NAT gateway to the internet
resource "aws_route_table" "private" {
  count  = var.az_count
  vpc_id = aws_vpc.test-vpc.vpc-0382f51c959645e99

  route {
    cidr_block     = "172.31.0.0/16"
    nat_gateway_id = element(igw-0d99675bb66becd2c, count.index)
  }
}

# Explicitly associate the newly created route tables to the private subnets (so they don't default to the main route table)
resource "aws_route_table_association" "private" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.private.subnet-054d60902fc47a8b3, count.index)
  route_table_id = element(aws_route_table.private.rtb-07d1bd9f86996008e, count.index)
}
