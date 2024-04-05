from Crypto.Cipher import AES
from base64 import b64decode

ciphertext = b64decode("0AO5xapH5mJmMROu37A=")
nc = ciphertext[:8]
data = ciphertext[8:]

keySize = 32
pwd = b'a'*32
key = kdf(pwd, keySize) 
aes = AES.new(key=key, mode=AES.MODE_CTR, nonce=nc, initial_value=0) 
res = aes.decrypt(data)

print(res) # b'secret'
