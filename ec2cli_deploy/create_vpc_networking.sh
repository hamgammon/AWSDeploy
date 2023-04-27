#create VPC network

#aws ec2 create-vpc --cidr-block 10.0.0.0/16 --tag-specification ResourceType=vpc,Tags=[{Key=Name,Value=myCustomVPC}]

#aws ec2 create-vpc --cidr-block 10.0.0.0/16 --tag-specification ResourceType=vpc,Tags=[{Key=Name,Value=myCustomVPC}] --query Vpc.VpcId --output text

#create subnets

aws ec2 create-subnet --vpc-id $vpcid --cidr-block 10.0.1.0/24

aws ec2 create-subnet --vpc-id vpc-0c1c1d51b1ab761d5 --cidr-block 10.0.2.0/24

aws ec2 create-subnet --vpc-id vpc-0c1c1d51b1ab761d5 --cidr-block 10.0.1.0/24 --availability-zone us-east-1a --tag-specification "ResourceType=subnet,Tags=[{Key=Name,Value=myPublicSubnet}]" --query Subnet.SubnetId --output text
aws ec2 create-subnet --vpc-id vpc-0c1c1d51b1ab761d5 --cidr-block 10.0.2.0/24 --availability-zone us-east-1a --tag-specification "ResourceType=subnet,Tags=[{Key=Name,Value=myPrivateSubnet}]" --query Subnet.SubnetId --output text


#enable public ip 
subnet-0ee2423dbd790a51d

aws ec2 modify-subnet-attribute --subnet-id $subnetid --map-public-ip-on-launch 

#create internet gateway 

aws ec2 create-internet-gateway --query InternetGateway.InternetGatewayId --output text

aws ec2 create-internet-gateway --query InternetGateway.InternetGatewayId --tag-specification "ResourceType= internet-gateway,Tags=[{Key=Name,Value=myIGW}]"  --output text 

igw-0e49f9fbb64421b64


#attach internet gateway to vpc

aws ec2 attach-internet-gateway --vpc-id $vpcid --internet-gateway-id $InternetGatewayId

aws ec2 attach-internet-gateway --vpc-id vpc-0c1c1d51b1ab761d5 --internet-gateway-id igw-0e49f9fbb64421b64

#create new route table
aws ec2 create-route-table --vpc-id $vpcid --tag-specification "ResourceType=route-table,Tags=[{Key=Name,Value=myPublicRT}]"  --output text 

aws ec2 create-route-table --vpc-id vpc-0c1c1d51b1ab761d5 --tag-specification "ResourceType=route-table,Tags=[{Key=Name,Value=myPublicRT}]"  --output text 

aws ec2 create-route-table --vpc-id vpc-0c1c1d51b1ab761d5 --tag-specification "ResourceType=route-table,Tags=[{Key=Name,Value=myPublicRT}]" --query routetable.routetableid --output text 

rtb-044ee67653a9c5c44

#create route 

aws ec2 create-route --route-table-id rtb-044ee67653a9c5c44 --destination-cidr-block 0.0.0.0/0 --gateway-id igw-0e49f9fbb64421b64

#assoite the route table with subnet 

aws ec2 associate-route-table --route-table-id rtb-044ee67653a9c5c44 --subnet-id subnet-0ee2423dbd790a51d

#create elastic ip

aws ec2 allocate-address --query AllocationId --output text

eipalloc-090894a19f1f7754a

#create NAT gateway
#mind use the public subnet id

aws ec2 create-nat-gateway --subnet-id subnet-0ee2423dbd790a51d --allocation-id eipalloc-090894a19f1f7754a --tag-specification "ResourceType=natgateway,Tags=[{Key=Name,Value=myNATgateway}]"  --output text 

# create route in private subnet
                    #private subnet route table id                                                              #NAT gatewayid
aws ec2 create-route --route-table-id rtb-070373a3a1294c18f --destination-cidr-block 0.0.0.0/0 --gateway-id nat-0adbc6ce35eaf1386