#create keypair

aws ec2 create-key-pair --key-name newwebserverkey

aws ec2 create-key-pair --key-name $keypairname --query KeyMaterial --output text > newwebserverkey2.pem

#create instance

aws ec2 create-instance