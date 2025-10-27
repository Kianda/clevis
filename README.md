# clevis
Clevis runtime inside a Alpine Linux Docker image

### Examples

Encrypt a password into a file using a Tang server.

```
docker run --rm -it \
  --network host \
  -v $(pwd):/data \
  -e ENC_FILE=output.enc \
  -e TANG_SERVER_ADDRESS=http://127.0.0.1 \
  -e HOST_UID=$(id -u) \
  -e HOST_GID=$(id -g) \
  --entrypoint sh \
  kianda/clevis:latest \
  -c '
    read -s -p "Enter your super secret passphrase: " SECRET && echo &&
    echo -n "$SECRET" | clevis encrypt tang "{\"url\":\"$TANG_SERVER_ADDRESS\"}" > /data/$ENC_FILE &&
    chown $HOST_UID:$HOST_GID /data/$ENC_FILE &&
    echo "Successfully encrypted the passphrase into: $ENC_FILE"
  '
```
---

Get back the password using the encrypted file and the same Tang server.

_The tang server address is inside the .enc file (generate a new .enc file if you change the Tang server)_
```
docker run --rm -i --network host kianda/clevis:latest decrypt < output.enc | jq -Rs .
# or
docker run --rm -i --network host kianda/clevis:latest decrypt < output.enc
```
