#!/usr/bin/env python
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend
from binascii import hexlify as hexa
from os import urandom
BLOCKLEN = 16
# функция blocks() разбивает строку данных на блоки, разделенные пробелами
def blocks(data):
    split = [hexa(data[i:i+BLOCKLEN]) for i in range(0, len(data), BLOCKLEN)]
     return ‘ ‘.join(split)
k = urandom(16)
print “k = %s” % hexa(k)
# выбрать случайное начальное значение IV
iv = urandom(16)
print “iv = %s” % hexa(iv)
# создать экземпляр AES в режиме CBC
aes = Cipher(algorithms.AES(k), modes.CBC(iv), backend=default_backend()).encryptor()
p = ‘\x00’*BLOCKLEN*2
c = aes.update(p) + aes.finalize()
print “enc(%s) = %s” % (blocks(p), blocks(c))
# теперь с другим IV и тем же самым ключом
iv = urandom(16)
print “iv = %s” % hexa(iv)
aes = Cipher(algorithms.AES(k), modes.CBC(iv), backend=default_backend()).encryptor()
c = aes.update(p) + aes.finalize()
print “enc(%s) = %s” % (blocks(p), blocks(c))
