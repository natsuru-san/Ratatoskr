# Certificate Generating

The app supports three types of certificates - RSA, Ed25519 and Prime. The better choice is Prime. To generating certificates you should make a choice and rely on markers in the instruction for creating your wanted keystore. Note, if you chose for example the RSA all your commands should be performed with them.

Make an *openssl.cnf* file and write the text beneath:

```
[ ca ]
default_ca = CA_default

[ CA_default ]
dir = certs
certs = $dir/certs
crl_dir = $dir/crl
database = $dir/index.txt
new_certs_dir = $dir/newcerts
certificate = $certs/ca.crt
private_key = $dir/private/ca_key.pem
serial = $dir/serial
crlnumber = $dir/crlnumber
crl = $dir/crl/crl.pem
RANDFILE = $dir/private/.rand
x509_extensions = usr_cert
name_opt = ca_default
cert_opt = ca_default
crl_extensions = crl_ext
default_days = 365
default_crl_days= 30
default_md = sha256
preserve = no
policy = policy_match

[ policy_match ]
countryName = match
stateOrProvinceName = match
organizationName = match
organizationalUnitName = optional
commonName = supplied
emailAddress = optional

[ req ]
default_bits = 2048
x509_extensions = v3_ca
string_mask = utf8only

[ v3_ca ]
subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid:always
basicConstraints = critical,CA:true
keyUsage = critical,digitalSignature,nonRepudiation,keyEncipherment,dataEncipherment,keyAgreement,keyCertSign,cRLSign,encipherOnly,decipherOnly

[ crl_ext ]
keyUsage = critical,digitalSignature,nonRepudiation,keyEncipherment,dataEncipherment,keyAgreement,keyCertSign,cRLSign,encipherOnly,decipherOnly
authorityKeyIdentifier=keyid:always

[ intermediate ]
basicConstraints=critical,CA:TRUE, pathlen:0
nsCertType = client,server,email,objsign,reserved,sslCA,emailCA,objCA
keyUsage = critical,digitalSignature,nonRepudiation,keyEncipherment,dataEncipherment,keyAgreement,keyCertSign,cRLSign,encipherOnly,decipherOnly
subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid:always
```

Using the commands generate the root and intermediate authorities. Adjust the `-days` argument to restrict the certificate time life. The commands will ask questions.

```
mkdir certs
```
Generate RootCA:

Ed25519:
```
openssl genpkey -algorithm ed25519 -out certs/ca.key
```
RSA 4096:
```
openssl genrsa -out certs/ca.key 4096
```
Prime 384:
```
openssl genpkey -algorithm EC -pkeyopt ec_paramgen_curve:secp384r1 -out certs/ca.key
```

Generate IntermediateCA:

```
openssl req -new -x509 -days 7300 -key certs/ca.key -out certs/ca.pem
```
Ed25519:
```
openssl genpkey -algorithm ed25519 -out certs/im.key
```
RSA 4096:
```
openssl genrsa -out certs/im.key 4096
```
Prime 384:
```
openssl genpkey -algorithm EC -pkeyopt ec_paramgen_curve:secp384r1 -out certs/im.key
```

Sign the IntermediateCA by RootCA

```
openssl req -new -key certs/im.key -config openssl.cnf -out certs/im.csr
openssl x509 -req -days 3650 -CA certs/ca.pem -CAkey certs/ca.key -extfile openssl.cnf -extensions intermediate -in certs/im.csr -out certs/im.pem
touch certs/ca_full.pem
cat certs/im.pem certs/ca.pem > certs/ca_full.pem
```

After that add a record to *openssl.cnf* for a certificate which are being to go to use in a route. The block beneath is an example! Note the `subjectAltName` field for a server must be equals your domain name or IP otherwise your browser or a tool is terminating connection "thinking" that a MITM-attack is happening.

```
[ example_server ]
basicConstraints=critical, CA:false, pathlen:0
nsCertType = server
keyUsage = critical, digitalSignature
extendedKeyUsage = serverAuth, clientAuth
subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid:always
subjectAltName=DNS:example.com,IP:127.0.0.1

[ example_client ]
basicConstraints=critical, CA:FALSE, pathlen:0
nsCertType = client
keyUsage = critical, digitalSignature
extendedKeyUsage = critical, clientAuth
subjectKeyIdentifier=hash
authorityKeyIdentifier=keyid:always
```

Ed25519:
```
openssl genpkey -algorithm ed25519 -out certs/example_server.key
```
RSA 4096:
```
openssl genrsa -out certs/example_server.key 4096
```
Prime 384:
```
openssl genpkey -algorithm EC -pkeyopt ec_paramgen_curve:secp384r1 -out certs/example_server.key
```

Create PKCS12 keystore:

```
openssl req -new -key certs/example_server.key -config openssl.cnf -out certs/example_server.csr
openssl x509 -req -days 730 -CA certs/im.pem -CAkey certs/im.key -extfile openssl.cnf -extensions example_server -in certs/example_server.csr -out certs/example_server.pem
openssl pkcs12 -export -out certs/example_server.p12 -inkey certs/example_server.key -in certs/example_server.pem -certfile certs/ca_full.pem
keytool -importcert -keystore certs/example_server.p12 -storetype PKCS12 -alias root_ca -file certs/ca.pem
keytool -importcert -keystore certs/example_server.p12 -storetype PKCS12 -alias im_ca -file certs/im.pem
```

Congratulations! Now you have the PKCS-keystore with your type of certificate chain and key for establishing encrypted route connections