gen_data(){
cat <<EOF
        {
                "cert" : "$CERTDATA",
                "key" : "$KEYDATA"
        }
EOF

}

gen_cert_chain(){
cat <<EOF
{"cert_chain":
        {
                "cert_chain": [
                        "$X1",
                        "$R3"
                        ]
        }
}
EOF
}



echo "Get New Chain"

curl https://letsencrypt.org/certs/isrgrootx1.pem | sed -E ':a;N;$!ba;s/\r{0,1}\n/\\n/g' > X1.pem
X1=`cat X1.pem`
echo $X1
curl https://letsencrypt.org/certs/lets-encrypt-r3.pem | sed -E ':a;N;$!ba;s/\r{0,1}\n/\\n/g' > R3.pem
R3=`cat R3.pem`
echo $R3

skey=`curl --insecure -X POST https://<vcenter>/api/session -H 'authorization: Basic <BASIC AUTH>'| tr -d \"`
echo $skey

scp <username>@<LB IP>:/conf/acme/vcenter.crt vcenter.crt
scp <username>@<LB IP>:/conf/acme/vcenter.key vcenter.key

sed -i -E ':a;N;$!ba;s/\r{0,1}\n/\\n/g' vcenter.crt
sed -i -E ':a;N;$!ba;s/\r{0,1}\n/\\n/g' vcenter.key

CERTDATA=`cat vcenter.crt`
KEYDATA=`cat vcenter.key`


echo "CHAIN"
echo "$(gen_cert_chain)" > X1.json

echo "CERT"
echo "$(gen_data)" > cert.json

echo "Set CHAIN"
curl --insecure -X POST https://<vcenter>/api/vcenter/certificate-management/vcenter/trusted-root-chains -H "vmware-api-session-id: $skey" -H "Content-Type: application/json" -d @X1.json

echo "Set CERT"
curl --insecure -X PUT https://<vcenter>/api/vcenter/certificate-management/vcenter/tls -H "vmware-api-session-id: $skey" -H "Content-Type: application/json" -d @cert.json

