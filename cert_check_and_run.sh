scp vcenter@<LB IP>:/conf/acme/vcenter.crt vcenter.crt.new
sed -i -E ':a;N;$!ba;s/\r{0,1}\n/\\n/g' vcenter.crt.new
diff vcenter.crt vcenter.crt.new && echo "same cert" || ./replace_vcenter.sh
