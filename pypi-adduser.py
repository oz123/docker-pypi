#!/usr/bin/env python
import os
import getpass
import sys

if len(sys.argv) < 2:
    print("usage: {} FILENAME".format(sys.argv[0]))
    exit(1)

from passlib.apache import HtpasswdFile

secrets = HtpasswdFile(secrets_file, new=os.path.exists(secrets_file))

username = raw_input("User:")
password = getpass.getpass()

if password != getpass.getpass():
    print("The passwords do not match")
    sys.exit(1)

secrets.set_password(username, password)
secrets.save()
