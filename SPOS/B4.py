# PRODUCER-CONSUMER PROBLEM USING SEMAPHORES AND MUTEX

import threading
import time
import random
from threading import Semaphore

BUFFER_SIZE = int(input("Enter buffer size: "))
buffer = []

mutex = Semaphore(1)
empty = Semaphore(BUFFER_SIZE)
full = Semaphore(0)

TOTAL_ITEMS = 10

def producer():
    for i in range(1, TOTAL_ITEMS + 1):
        time.sleep(random.uniform(0.3, 1.0))  # simulate production delay

        if empty._value == 0:
            print("[Producer] Buffer FULL — Cannot Produce (waiting...)")

        empty.acquire()      # wait if buffer full
        mutex.acquire()      # enter critical section

        buffer.append('P')
        print(f"[Producer] Produced item {i} | Buffer: {buffer}")

        mutex.release()
        full.release()       # signal that an item is produced

    print("[Producer] Finished producing all items.")

def consumer():
    consumed = 0
    while consumed < TOTAL_ITEMS:
        if full._value == 0:
            print("\n[Consumer] Buffer EMPTY — Cannot Consume (waiting...)\n")

        full.acquire()       # wait if buffer empty
        mutex.acquire()      # enter critical section

        if buffer:
            buffer.pop(0)
            consumed += 1
            print(f"\n[Consumer] Consumed item {consumed} | Buffer: {buffer}\n")

        mutex.release()
        empty.release()      # signal that space is now available

        time.sleep(random.uniform(0.8, 1.5))  # simulate slower consumption

    print("[Consumer] Finished consuming all items.")


def main():
    t1 = threading.Thread(target=producer)
    t2 = threading.Thread(target=consumer)

    t1.start()
    t2.start()

    t1.join()
    t2.join()

    print("\nAll items produced and consumed successfully. Program ended.")

main()
