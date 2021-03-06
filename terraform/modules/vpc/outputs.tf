output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnet_ids" {
  value = concat([aws_subnet.private_subnet.id], [aws_subnet.private_subnet_2.id], [aws_subnet.public_subnet.id])
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}