import socket
import time
import struct

PORT = 8080

def handle_client(client_socket):
    # Receive the client's t1 (time request sent)
    raw_data = client_socket.recv(8)
    t1 = struct.unpack("!q", raw_data)[0]

    t2 = int(time.time() * 1000)  # Time when server received request
    time.sleep(5)                 # Simulate small processing delay
    t3 = int(time.time() * 1000)  # Time when server sends reply

    print(f"\nClient request received:")
    print(f"  t1 (client sent): {t1}")
    print(f"  t2 (server received): {t2}")
    print(f"  t3 (server reply): {t3}")

    # Send back the server timestamps
    response = struct.pack("!qqq", t2, t3, t3)
    client_socket.send(response)
    client_socket.close()
    print("Response sent to client.")

def start_server():
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind(('0.0.0.0', PORT))
    server_socket.listen(5)
    print(f"Server started on port {PORT}. Waiting for clients...")

    while True:
        client_socket, addr = server_socket.accept()
        print(f"\nConnected to client {addr}")
        handle_client(client_socket)

start_server()
