KEY_ID=$(grep -m 1 'aws_access_key_id' ~/.aws/credentials | cut -d'=' -f2 | tr -d '[:space:]')
SECRET_KEY=$(grep -m 1 'aws_secret_access_key' ~/.aws/credentials | cut -d'=' -f2 | tr -d '[:space:]')
export AWS_ACCESS_KEY_ID=$KEY_ID
export AWS_SECRET_ACCESS_KEY=$SECRET_KEY