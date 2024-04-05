import pyotp
# pip install pyotp

base32secret = pyotp.random_base32()
print('Secret:', base32secret)

totp_uri = pyotp.totp.TOTP(base32secret).provisioning_uri(
    "alice@google.com",
    issuer_name="Secure App")
print(totp_uri)
