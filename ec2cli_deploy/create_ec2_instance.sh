#create keypair

aws ec2 create-key-pair --key-name newwebserverkey

aws ec2 create-key-pair --key-name $keypairname --query KeyMaterial --output text > newwebserverkey2.pem

#create security group
aws ec2 create-security-group --group-name Webserver-SG --description "Webserver security group" --vpc-id vpc-068ddc8b50f426770 --tag-specification "ResourceType= security-group,Tags=[{Key=Name,Value= Webserver-SG }]"  --query GroupId --output text

aws ec2 create-security-group --group-name Webserver2CLISC --description "Webserver2CLISC made in the cli" --vpc-id vpc-0c1c1d51b1ab761d5

(sg-05826b1f34c0606b8)

# security group inbound rules

aws ec2 authorize-security-group-ingress --group-id sg-05826b1f34c0606b8 --protocol tcp --port 443 --cidr 0.0.0.0/0 #single port example

aws ec2 authorize-security-group-ingress --group-id sg-05826b1f34c0606b8 --protocol tcp --port 22 --cidr 0.0.0.0/0

aws ec2 authorize-security-group-ingress --group-id sg-05826b1f34c0606b8 --protocol tcp --port 22 ---source-group sg-group-id $groupid

aws ec2 authorize-security-group-ingress --group-id sg-05826b1f34c0606b8 --ip-permissions IpProtocol=tcp,FromPort=22,ToPort=22,IpRanges="[{CidrIp=0.0.0.0/0}]" IpProtocol=tcp,FromPort=80,ToPort=80,IpRanges="[{CidrIp=0.0.0.0/0}]" IpProtocol=tcp,FromPort=443,ToPort=443,IpRanges="[{CidrIp=0.0.0.0/0}]"



#create instance

aws ec2 run-instances --image-id ami-02396cdd13e9a1257 --instance-type t2.micro --key-name newwebserverkey2 --subnet-id subnet-0ee2423dbd790a51d --security-group-id sg-05826b1f34c0606b8 --user-data file://user_data_example--tag-specification "ResourceType= instance,Tags=[{Key=Name,Value=Webserver-from-CLI}]"

#get instance details

aws ec2 describe-instances --instance-id i-014c18c3e60d5a33b
                                                                           #public ip example
aws ec2 describe-instances --instance-ids i-014c18c3e60d5a33b --query Reservations[0].Instances[0].PublicIpAddress --output text