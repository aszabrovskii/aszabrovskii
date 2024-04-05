import hashlib, hmac, binascii

var = b'some msg'
print(var)
mac = hmac.new(b'key', var, hashlib.sha256).digest()

print(binascii.hexlify(mac))
