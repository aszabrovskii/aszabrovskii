import hashlib, hmac, binascii

def hmac_sha256(key, msg):
  return hmac.new(key, msg, hashlib.sha256).digest()

key = b"12345"
msg = b"sample message"

print("MSG: ", msg)
print(binascii.hexlify(hmac_sha256(key, msg)))
