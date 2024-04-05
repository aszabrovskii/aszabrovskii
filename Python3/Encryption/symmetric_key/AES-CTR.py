import pyaes, pbkdf2, binascii, os, secrets

# Derive a 256-bit AES encryption key from the password
password = "s3cr3t*c0d3"
print("Password :", password)
passwordSalt = os.urandom(16)
print("Salt", passwordSalt)
key = pbkdf2.PBKDF2(password, passwordSalt).read(32)
print("Key: ", key)
print('AES encryption key:', binascii.hexlify(key))
