#!/bin/bash

apt-get update
apt-get install gnupg curl awscli

curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor

echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

apt-get update
apt-get install -y mongodb-org

systemctl start mongod
systemctl enable mongod

sleep 5

echo 'db.createUser({user:"${MONGODB_USER}", pwd:"${MONGODB_PASS}", roles:[]})' | mongosh

echo "security.authorization : enabled" >> /etc/mongod.conf

systemctl restart mongod

