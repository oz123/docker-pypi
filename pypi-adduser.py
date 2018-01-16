#!/usr/bin/env python

import os
import getpass
import sys

from passlib.apache import HtpasswdFile

if len(sys.argv) < 2:
    print("usage: {} FILENAME".format(sys.argv[0]))
    exit(1)

secrets_file = sys.argv[1]

if os.path.exists(secrets_file):
    try:
        append = True if sys.argv[2] == '-a' else False
    except IndexError:
        append = False
else:
    with open(secrets_file, mode='w') as f:
        append = False

secrets = HtpasswdFile(sys.argv[1], new=append)

username = raw_input("User:")
password = getpass.getpass()

if password != getpass.getpass():
    print("The passwords do not match")
    sys.exit(1)

secrets.set_password(username, password)
secrets.save()
