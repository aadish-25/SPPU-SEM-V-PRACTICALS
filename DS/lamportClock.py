class LamportClock:
    def __init__(self):
        self.timestamp = 0

    def increment(self):
        self.timestamp += 1
        return self.timestamp

    def update(self, received_timestamp):
        self.timestamp = max(self.timestamp, received_timestamp) + 1
        return self.timestamp


class Process:
    def __init__(self, process_id):
        self.process_id = process_id
        self.clock = LamportClock()

    def send_message(self, receiver):
        before = self.clock.timestamp
        sent_time = self.clock.increment()
        print(f"\nEvent: SEND")
        print(f"Process {self.process_id} → Process {receiver.process_id}")
        print(f"Local clock before: {before}")
        print(f"Local clock after : {sent_time}")
        receiver.receive_message(sent_time, self.process_id)

    def receive_message(self, message_timestamp, sender_id):
        before = self.clock.timestamp
        new_time = self.clock.update(message_timestamp)
        print(f"\nEvent: RECEIVE")
        print(f"Process {self.process_id} ← Process {sender_id}")
        print(f"Local clock before: {before}")
        print(f"Local clock after : {new_time}")


def show_all_clocks(processes):
    print("\nCurrent Lamport Clocks:")
    print("------------------------")
    for pid, proc in processes.items():
        print(f"Process {pid}: {proc.clock.timestamp}")
    print("------------------------")


def choose_process(prompt, processes):
    try:
        pid = int(input(prompt))
        if pid in processes:
            return processes[pid]
        print("Invalid process number.")
        return choose_process(prompt, processes)
    except ValueError:
        print("Invalid input. Enter a number.")
        return choose_process(prompt, processes)


def menu():
    print("\n========== MENU ==========")
    print("1. Send a message")
    print("2. Show all process clocks")
    print("3. Exit")
    print("===========================")


def main():
    # Ask user how many processes to simulate
    while True:
        try:
            n = int(input("Enter number of processes to create: "))
            if n > 0:
                break
            print("Enter a positive number.")
        except ValueError:
            print("Invalid input. Please enter a number.")

    processes = {i: Process(i) for i in range(1, n + 1)}
    print(f"{n} processes created successfully.")

    while True:
        menu()
        choice = input("Enter choice: ")

        if choice == '1':
            sender = choose_process("\nSender process ID: ", processes)
            receiver = choose_process("Receiver process ID: ", processes)
            if sender == receiver:
                print("Sender and receiver must be different.")
                continue
            sender.send_message(receiver)

        elif choice == '2':
            show_all_clocks(processes)

        elif choice == '3':
            print("\nExiting simulation.")
            break

        else:
            print("Invalid option. Try again.")


if __name__ == "__main__":
    main()
