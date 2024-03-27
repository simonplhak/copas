openssl rand -base64 24 >/etc/secret_token.txt && export SECRET_KEY=$(cat /etc/secret_token.txt)
openssl rand -base64 24 >/etc/password.txt && export PASSWORD=$(cat /etc/password.txt)
exec supervisord -c /etc/supervisord.conf
