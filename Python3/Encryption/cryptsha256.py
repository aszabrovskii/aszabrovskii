import hashlib, binascii

sha256hash = hashlib.sha256(b'hello').digest()
print("SHA-256('hello') = ", binascii.hexlify(sha256hash))
