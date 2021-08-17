#!/usr/bin/python

import socket

buffer = ""

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(('192.168.56.106', 9999))
s.send('string' + buffer)