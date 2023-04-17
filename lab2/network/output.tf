output vpc_id {
  value = aws_vpc.vpc.id
}


output vpc_cidr{
  value = aws_vpc.vpc.cidr_block
}


output pub-sub1-id {
    value = aws_subnet.pub-sub1.id
}

output pub-sub2-id {
    value =  aws_subnet.pub-sub2.id
}

output private-sub1-id {
    value = aws_subnet.private-sub1.id
}

output private-sub2-id {
    value =  aws_subnet.private-sub2.id
}
