openssl rand -base64 24 >/tmp/secret_token.txt && export SECRET_KEY=$(cat /tmp/secret_token.txt) && echo "SECRET_TOKEN=$SECRET_TOKEN" >>$BASH_ENV
openssl rand -base64 24 >/tmp/password.txt && export PASSWORD=$(cat /tmp/password.txt) && echo "PASSWORD=$PASSWORD" >>$BASH_ENV
exec supervisord -c /etc/supervisord.conf
