docker volume create --name creds_Volume --opt type=none --opt device=/Users/nbayle/creds --opt o=bind

DockerCreateTfAviGcp () {
  docker volume create --name tfAviGcp_Volume --opt type=none --opt device=/Users/nbayle/git/tfAviGcp --opt o=bind
  docker run -it --name tfAviGcp_container --mount source=creds_Volume,target=/opt/creds --mount source=tfAviGcp_Volume,target=/opt/tfAviGcp -e GOOGLE_CLOUD_KEYFILE_JSON=/opt/creds/gcp/projectavi-283209-814ec1119668.json -e TF_VAR_avi_username="admin" -e TF_VAR_avi_password=$TF_VAR_avi_password -e TF_VAR_avi_old_password=$TF_VAR_avi_old_password tacobayle/ubuntu-automation1 /bin/bash
}

DockerDestroyTfAviGcp () {
  docker rm -f tfAviGcp_container
  docker volume rm tfAviGcp_Volume
}
