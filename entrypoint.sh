if [ ! -f /etc/secret_token.txt ]; then
  openssl rand -base64 24 >/etc/secret_token.txt && export SECRET_KEY=$(cat /etc/secret_token.txt)
fi
if [ ! -f /etc/password.txt ]; then
  openssl rand -base64 24 >/etc/password.txt && export PASSWORD=$(cat /etc/password.txt)
fi
exec supervisord -c /etc/supervisord.conf
