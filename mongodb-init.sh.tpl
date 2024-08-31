#!/bin/bash

apt update
apt install gnupg curl

curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

apt update
apt install -y mongodb-org awscli

systemctl enable mongod
systemctl start mongod

sleep 5
echo 'db.createUser({user:"${MONGODB_USER}", pwd:"${MONGODB_PASS}", roles:[{role:"root",db:"admin"}]})' | mongosh admin
sleep 5

echo "security.authorization : enabled" >> /etc/mongod.conf
sed -i 's/127\.0\.0\.1/0\.0\.0\.0/' /etc/mongod.conf

systemctl restart mongod

echo 'uri: mongodb://${MONGODB_USER}:${MONGODB_PASS}@localhost/?ssl=false&authSource=admin' > /root/mongodump.conf

cat > /etc/cron.hourly/mongodb-backup << _EOF_
#!/bin/sh

TIME="\$(/bin/date +%Y%m%d-%H%M)"

# Backup directory
DEST=/tmp/\$${TIME}-mongodb-backup
/bin/mkdir -p \$${DEST}

# TGZ file of backup directory
TGZ=/tmp/\$${TIME}-mongodb-backup.tgz

# Dump from mongodb host into backup directory
/usr/bin/mongodump --config=mongodump.conf -o \$${DEST}

# Create tgz of backup directory
/bin/tar zcf \$${TGZ} -C \$${DEST} .

# Upload tar to s3
/usr/bin/aws s3 cp \$${TGZ} s3://wiz-mongodb-s3-backup-bucket/

# Remove tgz file
/bin/rm -f \$${TGZ}

# Remove backup directory
/bin/rm -rf \$${DEST}
_EOF_

chmod 755 /etc/cron.hourly/mongodb-backup
