from xmlrpc.server import SimpleXMLRPCServer
import random
import socket
from datetime import datetime

server_ip = socket.gethostbyname(socket.gethostname())
server = SimpleXMLRPCServer((server_ip, 9000), logRequests=False)
print(f"Weather RPC Server running on {server_ip}:9000\n")

weather_data = {
    "mumbai": {"temp": 32, "humidity": 70, "condition": "Sunny"},
    "delhi": {"temp": 28, "humidity": 55, "condition": "Cloudy"},
    "bangalore": {"temp": 25, "humidity": 65, "condition": "Rainy"},
}

def log(message):
    time = datetime.now().strftime("%H:%M:%S")
    print(f"[{time}] {message}")

def log_connection():
    client_ip = socket.gethostbyname(socket.gethostname())
    log(f"Client connected from {client_ip}")
    return "Connection acknowledged."

def get_weather(city):
    log(f"Request: get_weather('{city}')")
    city = city.lower()
    if city in weather_data:
        data = weather_data[city]
    else:
        data = {
            "temp": random.randint(20, 35),
            "humidity": random.randint(40, 80),
            "condition": random.choice(["Sunny", "Cloudy", "Rainy", "Windy", "Clear"])
        }
        weather_data[city] = data
        log(f"New city '{city}' auto-added with random weather.")
    return {"city": city, **data}

def add_city(city, temp, humidity, condition):
    log(f"Request: add_city('{city}', {temp}, {humidity}, '{condition}')")
    city = city.lower()
    if city in weather_data:
        return f"'{city}' already exists."
    weather_data[city] = {"temp": temp, "humidity": humidity, "condition": condition}
    return f"City '{city}' added successfully."

def update_weather(city, temp, humidity, condition):
    log(f"Request: update_weather('{city}', {temp}, {humidity}, '{condition}')")
    city = city.lower()
    weather_data[city] = {"temp": temp, "humidity": humidity, "condition": condition}
    return f"Weather for '{city}' updated."

def delete_city(city):
    log(f"Request: delete_city('{city}')")
    city = city.lower()
    if city in weather_data:
        del weather_data[city]
        return f"City '{city}' deleted successfully."
    return f"City '{city}' not found."

def list_cities():
    log("Request: list_cities()")
    return list(weather_data.keys())

server.register_function(log_connection, "log_connection")
server.register_function(get_weather, "get_weather")
server.register_function(add_city, "add_city")
server.register_function(update_weather, "update_weather")
server.register_function(delete_city, "delete_city")
server.register_function(list_cities, "list_cities")

server.serve_forever()
