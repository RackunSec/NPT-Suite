#!/usr/bin/env python3
import socket
from sys import argv

def is_remote_port_open(host, port, timeout=1):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(timeout)
    result = s.connect_ex((host, int(port)))
    if result == 0:
        return True
    else:
        return False

if __name__ == "__main__":
    remote_host = argv[1] 
    remote_port = argv[2]
    if is_remote_port_open(remote_host, remote_port):
        print(f"Port {remote_port} on {remote_host} is OPEN.")
    else:
        print(f"Port {remote_port} on {remote_host} is CLOSED or unreachable.")
