import smtplib
import os
from email.mime.text import MIMEText
from dotenv import load_dotenv

def send_email():
    load_dotenv()
    sender   = "name@email.com"
    password = os.getenv("password")
    sender_2 = "name_email@domain.com"
    #sender_2 = "admins@velvetech.dev"

    server = smtplib.SMTP_SSL("domain2.domain1.com", 465)
    server.ehlo()

    try:
        with open("/home/user/sh_scripts/info.log") as file:
            template = file.read()
    except IOError:
        return "The template file doesn't found!"

    with open("/home/user/py_scripts/subject_host.txt", "r") as file:
            SUBJECT = file.read()


    try:
        server.login(sender, password)
        msg = MIMEText(template, "html")
        msg["From"] = sender
        msg["To"] = sender_2
        msg["Subject"] = SUBJECT
        server.sendmail(sender, sender_2, msg.as_string())
        return "Message to mail", sender_2, " was sent successfully !"

    except Exception as _ex:
        return f"{_ex}\nCheck your login or password please !"

def main():

    print(send_email())

    main()
