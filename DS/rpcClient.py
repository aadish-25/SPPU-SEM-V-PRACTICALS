import xmlrpc.client

proxy = xmlrpc.client.ServerProxy("http://192.168.0.114:9000/")
print(proxy.log_connection())

def print_weather(data):
    print("\n--- Weather Report ---")
    print(f"City: {data['city'].title()}")
    print(f"Temperature: {data['temp']}°C")
    print(f"Humidity: {data['humidity']}%")
    print(f"Condition: {data['condition']}")
    print("----------------------\n")

while True:
    print("\n====== Weather RPC Menu ======")
    print("1. Get weather")
    print("2. List cities")
    print("3. Add new city")
    print("4. Update weather")
    print("5. Delete city")
    print("6. Exit")

    choice = input("Enter choice: ").strip()

    if choice == "1":
        city = input("Enter city: ").strip()
        result = proxy.get_weather(city)
        print_weather(result)

    elif choice == "2":
        cities = proxy.list_cities()
        print("\nAvailable Cities:")
        for c in cities:
            print(" -", c.title())
        print()

    elif choice == "3":
        city = input("City name: ").strip()
        temp = int(input("Temperature: ").strip())
        humidity = int(input("Humidity: ").strip())
        condition = input("Condition: ").strip()
        print(proxy.add_city(city, temp, humidity, condition), "\n")

    elif choice == "4":
        city = input("City name: ").strip()
        temp = int(input("Temperature: ").strip())
        humidity = int(input("Humidity: ").strip())
        condition = input("Condition: ").strip()
        print(proxy.update_weather(city, temp, humidity, condition), "\n")

    elif choice == "5":
        city = input("City name: ").strip()
        print(proxy.delete_city(city), "\n")

    elif choice == "6":
        print("Exiting Weather Client.")
        break

    else:
        print("Invalid choice. Try again.\n")
