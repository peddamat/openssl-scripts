#!/bin/sh

cat << EOF > openssl-example2.asn1
# Start with a SEQUENCE
 asn1=SEQUENCE:pubkeyinfo

 # pubkeyinfo contains an algorithm identifier and the public key wrapped
 # in a BIT STRING
 [pubkeyinfo]
 algorithm=SEQUENCE:rsa_alg
 pubkey=BITWRAP,SEQUENCE:rsapubkey

 # algorithm ID for RSA is just an OID and a NULL
 [rsa_alg]
 algorithm=OID:rsaEncryption
 parameter=NULL

 # Actual public key: modulus and exponent
 [rsapubkey]
 n=INTEGER:0xBB6FE79432CC6EA2D8F970675A5A87BFBE1AFF0BE63E879F2AFFB93644D4D2C6D000430DEC66ABF47829E74B8C5108623A1C0EE8BE217B3AD8D36D5EB4FCA1D9

 e=INTEGER:0x010001
EOF

openssl asn1parse -genconf openssl-example2.asn1 -out openssl-example2.der -noout
openssl rsa -in openssl-example2.der -inform der -pubin -out openssl-example2.pem
openssl rsa -pubin -in openssl-example2.pem -text -noout
