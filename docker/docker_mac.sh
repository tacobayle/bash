docker volume create --name creds_Volume --opt type=none --opt device=/Users/nbayle/creds --opt o=bind

DockerCreateTfAviGcp () {
  docker volume create --name tfAviGcp_Volume --opt type=none --opt device=/Users/nbayle/git/tfAviGcp --opt o=bind
  docker run -it --name tfAviGcp_container --mount source=creds_Volume,target=/opt/creds --mount source=tfAviGcp_Volume,target=/opt/tfAviGcp -e GOOGLE_CLOUD_KEYFILE_JSON=/opt/creds/gcp/projectavi-283209-814ec1119668.json -e TF_VAR_avi_username="admin" -e TF_VAR_avi_password=$TF_VAR_avi_password -e TF_VAR_avi_old_password=$TF_VAR_avi_old_password tacobayle/ubuntu-automation1 /bin/bash
}

DockerDestroyTfAviGcp () {
  docker rm -f tfAviGcp_container
  docker volume rm tfAviGcp_Volume
}

DockerCreate04_aws () {
  docker volume create --name 04_aws_Volume --opt type=none --opt device=/Users/nbayle/git/aviArchitectureWorkshop/day1/04_aws --opt o=bind
  docker run -it --name 04_aws_container --mount source=04_aws_Volume,target=/opt/04_aws -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION tacobayle/ubuntu-automation1 /bin/bash
}

DockerDestroy04_aws () {
  docker rm -f 04_aws_container
  docker volume rm 04_aws_Volume
}