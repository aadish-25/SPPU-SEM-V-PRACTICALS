import socket
import time
import struct

SERVER_ADDR = '127.0.0.1'
PORT = 8080

def calculate_time_offset(t1, t2, t3, t4):
    # Network delay (D) and clock offset (O)
    D = (t4 - t1) - (t3 - t2)
    O = ((t2 - t1) + (t3 - t4)) / 2

    print(f"\n--- Time Calculation ---")
    print(f"Network delay (D): {D:.2f} ms")
    print(f"Clock offset (O): {O:.2f} ms")
    print("------------------------")

def start_client():
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    client_socket.connect((SERVER_ADDR, PORT))

    print(f"Connected to server at {SERVER_ADDR}:{PORT}")

    # t1 = client sends request
    t1 = int(time.time() * 1000)
    client_socket.send(struct.pack("!q", t1))
    print(f"\nRequest sent at t1: {t1}")

    # Receive t2 (server received) and t3 (server sent)
    response = client_socket.recv(24)
    t2, t3, _ = struct.unpack("!qqq", response)

    # t4 = client receives reply
    t4 = int(time.time() * 1000)
    print(f"Response received at t4: {t4}")

    print(f"\nTimestamps summary:")
    print(f"  t1 (client sent): {t1}")
    print(f"  t2 (server received): {t2}")
    print(f"  t3 (server replied): {t3}")
    print(f"  t4 (client received): {t4}")

    calculate_time_offset(t1, t2, t3, t4)
    client_socket.close()

start_client()
