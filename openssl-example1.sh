#!/bin/bash

# Reference: https://crypto.stackexchange.com/questions/45151/anatomy-of-an-rsa-private-key

openssl genrsa -out private.key 2048
openssl rsa -in private.key -pubout > public.key
openssl rsa -noout -text -inform PEM -in private.key
openssl rsa -noout -text -inform PEM -in public.key -pubin

#cat private.key

cat private.key | grep -v ^- | base64 -d | xxd -c32
cat private.key | grep -v ^- | base64 -d > private.cer
