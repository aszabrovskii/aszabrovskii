import pyscrypt

#pip install pyscrypt

salt = b'aa1f2d3f4d23ac44e9c5a6c3d8f9ee8c'

passwd = b'p@$Sw0rD~7'
print(passwd)
key = pyscrypt.hash(passwd, salt, 2048, 8, 1, 32)
print("Derived key:", key.hex())
