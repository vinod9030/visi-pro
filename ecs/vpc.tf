# network.tf

resource "aws_vpc" "test-vpc" {
  cidr_block = "10.0.0.0/24"
}

# Fetch AZs in the current region
data "aws_availability_zones" "available" {
}


# Create var.az_count private subnets, each in a different AZ
resource "aws_subnet" "private" {
  count             = var.az_count
  cidr_block        = cidrsubnet(aws_vpc.test-vpc.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.test-vpc.vpc-0e4ba9e87082d56aa
}

# Create var.az_count public subnets, each in a different AZ
resource "aws_subnet" "public" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.test-vpc.cidr_block, 8, var.az_count + count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.test-vpc.vpc-0e4ba9e87082d56aa
  map_public_ip_on_launch = true
}

# Internet Gateway for the public subnet
resource "aws_internet_gateway" "visi-pro-igw" {
  vpc_id = aws_vpc.test-vpc.vpc-0e4ba9e87082d56aa
}

# Route the public subnet traffic through the IGW
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.test-vpc.main_route_table_rtb-03a0af9d32807b10f
  destination_cidr_block = "10.0.0.0/24"
  gateway_id             = aws_internet_gateway.test-igw.igw-0d60856dcdbe4bc5f
}

# Create a NAT gateway with an Elastic IP for each private subnet to get internet connectivity
resource "aws_eip" "visi-pro-eip" {
  count      = var.az_count
  vpc        = true
  depends_on = [aws_internet_gateway.test-igw-0d60856dcdbe4bc5f]
}

resource "aws_nat_gateway" "visi-pro-natgw" {
  count         = var.az_count
  subnet_id     = element(aws_subnet.public.subnet-04ed3aeb3e95cdd42, count.index)
  allocation_id = element(aws_eip.test-eip.eipalloc-08f57de18ff4c9bdb, count.index)
}

# Create a new route table for the private subnets, make it route non-local traffic through the NAT gateway to the internet
resource "aws_route_table" "private" {
  count  = var.az_count
  vpc_id = aws_vpc.test-vpc.vpc-0e4ba9e87082d56aa

  route {
    cidr_block     = "10.0.0.0/24"
    nat_gateway_id = element(aws_nat_gateway.test-natgw.igw-0d60856dcdbe4bc5f, count.index)
  }
}

# Explicitly associate the newly created route tables to the private subnets (so they don't default to the main route table)
resource "aws_route_table_association" "private" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.private.subnet-04ed3aeb3e95cdd42, count.index)
  route_table_id = element(aws_route_table.private.rtb-03a0af9d32807b10f, count.index)
}
