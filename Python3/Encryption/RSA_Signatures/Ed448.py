from ecpy.curves import Curve
from ecpy.keys import ECPrivateKey
from ecpy.eddsa import EDDSA
import secrets, hashlib, binascii
#pip install ecpy

curve = Curve.get_curve('Ed448')
signer = EDDSA(hashlib.shake_256, hash_len=114)
privKey = ECPrivateKey(secrets.randbits(57*8), curve)
pubKey = signer.get_public_key(privKey, hashlib.shake_256, hash_len=114)
print("Private key (57 bytes):", privKey)
print("Public key (compressed, 57 bytes): ",
      binascii.hexlify(curve.encode_point(pubKey.W)))
print("Public key (point): ", pubKey)

msg = b'Message for Ed448 signing'
signature = signer.sign(msg, privKey)
print("Signature (114 bytes):", binascii.hexlify(signature))

valid = signer.verify(msg, signature, pubKey)
print("Valid signature?", valid)
