echo "========================================================================"
echo " You can now connect to this ShadowSocks server:"
echo ""
echo " server: $SS_SERVER_ADDR  port: $SS_SERVER_PORT password: $SS_PASSWORD  "
echo " timeout: $SS_TIMEOUT  encryption method: $SS_METHOD "
echo ""
echo " Please remember the password!"
echo "========================================================================"

ssserver -s 0.0.0.0 -p 8388 -k $SS_PASSWORD -m aes-256-cfb -t 300 &