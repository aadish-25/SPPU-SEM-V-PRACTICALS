// Write a program to simulate CPU Scheduling Algorithms: FCFS, SJF (Preemptive), Priority (Non-Preemptive) and Round Robin (Preemptive).

#include <bits/stdc++.h>
using namespace std;

struct Process {
    int id = 0;
    int AT = 0;
    int BT = 0;
    int CT = 0;
    int TAT = 0;
    int WT = 0;
    int RT = 0;
    int priority = 0;
};

void reset(Process p[], int n) {
    for(int i = 0; i < n; i++) {
        p[i].CT = 0;
        p[i].TAT = 0;
        p[i].WT = 0;
        p[i].RT = p[i].BT;
    }
}

// bubble sort
void sortByArrival(Process p[], int n) {
    for(int i = 0; i < n - 1; i++) {
        for(int j = 0; j < n - i - 1; j++) {
            if(p[j].AT > p[j + 1].AT) {
                Process temp = p[j];
                p[j] = p[j + 1];
                p[j + 1] = temp;
            }
        }
    }
}

void FCFS(Process p[], int n) {
    sortByArrival(p, n);
    int currentTime = 0;

    for(int i = 0; i < n; i++) {
        if(currentTime < p[i].AT)
            currentTime = p[i].AT;
        p[i].CT = currentTime + p[i].BT;
        p[i].TAT = p[i].CT - p[i].AT;
        p[i].WT = p[i].TAT - p[i].BT;

        currentTime = p[i].CT;
    }

    cout << "\nP#\tAT\tBT\tCT\tTAT\tWT\n";

    for(int i = 0; i < n; i++) {
        cout << p[i].id << "\t" << p[i].AT << "\t" << p[i].BT << "\t"
             << p[i].CT << "\t" << p[i].TAT << "\t" << p[i].WT << "\n";
    }
}

void priorityScheduling(Process p[], int n) {
    int currentTime = 0;
    int completed = 0;

    // while all processes are not done executing
    while(completed < n) {
        int idx = -1;  // process to execute
        int highestPriority = 99999999;

        // find process with highest priority and incomplete
        for(int i = 0; i < n; i++) {
            if(p[i].CT == 0 && p[i].AT <= currentTime) {
                if(p[i].priority < highestPriority) {
                    highestPriority = p[i].priority;
                    idx = i;
                } else if(p[i].priority == highestPriority) {
                    // tie, 2 processes have the same priority
                    // we see arrival time
                    if(p[i].AT < p[idx].AT)
                        // process that arrived first, gets executed first
                        idx = i;
                    else if(p[i].AT == p[idx].AT && p[i].id < p[idx].id)
                        // if both  process arrived at the same, then we go by the order in which they
                        // are present in the ready queue i.e by their id
                        idx = i;
                }
            }
        }

        // No process has arrived yet
        if(idx == -1) {
            // Choose the process with the closest arrival time and not completed
            int nextAT = 9999;
            for(int i = 0; i < n; i++) {
                if(p[i].CT == 0 && p[i].AT < nextAT)
                    nextAT = p[i].AT;
            }
            currentTime = nextAT;
        } else {
            p[idx].CT = currentTime + p[idx].BT;
            p[idx].TAT = p[idx].CT - p[idx].AT;
            p[idx].WT = p[idx].TAT - p[idx].BT;
            currentTime = p[idx].CT;
            completed++;
        }
    }

    cout << "\nP#\tAT\tBT\tPriority\tCT\tTAT\tWT\n";
    for(int i = 0; i < n; i++) {
        cout << p[i].id << "\t" << p[i].AT << "\t" << p[i].BT << "\t"
             << p[i].priority << "\t\t" << p[i].CT << "\t" << p[i].TAT
             << "\t" << p[i].WT << "\n";
    }
}

void SJF(Process p[], int n) {
    int currentTime = 0;
    int completed = 0;

    while(completed < n) {
        int idx = -1;
        int minRT = 99999;
        for(int i = 0; i < n; i++) {
            if(p[i].AT <= currentTime && p[i].RT > 0 && p[i].RT < minRT) {
                idx = i;
                minRT = p[i].RT;
            }
        }
        if(idx == -1)
            currentTime++;
        else {
            // run the process for 1 unit time
            p[idx].RT--;
            currentTime++;

            if(p[idx].RT == 0) {
                // process is finished
                p[idx].CT = currentTime;
                p[idx].TAT = p[idx].CT - p[idx].AT;
                p[idx].WT = p[idx].TAT - p[idx].BT;
                completed++;
            }
        }
    }
    cout << "\nP#\tAT\tBT\tCT\tTAT\tWT\n";
    for(int i = 0; i < n; i++) {
        cout << p[i].id << "\t" << p[i].AT << "\t" << p[i].BT << "\t"
             << p[i].CT << "\t" << p[i].TAT << "\t" << p[i].WT << "\n";
    }
}

void roundRobin(Process p[], int n, int quantum) {
    int currentTime = 0;
    int completed = 0;
    int front = 0, rear = 0;
    int readyQueue[50];

    sortByArrival(p, n);

    readyQueue[rear++] = 0;

    while(completed < n) {
        if(front == rear) {
            // cpu idle
            int nextArrival = 9999;
            for(int i = 0; i < n; i++) {
                if(p[i].AT < nextArrival && p[i].RT > 0) nextArrival = p[i].AT;
            }
            currentTime = nextArrival;

            for(int i = 0; i < n; i++) {
                if(p[i].AT <= currentTime && p[i].RT > 0) readyQueue[rear++] = i;
            }
        } else {
            int idx = readyQueue[front++];

            // execute the process for min(process.RT, quantum)
            int executionTime = (p[idx].RT > quantum) ? quantum : p[idx].RT;

            p[idx].RT = p[idx].RT - executionTime;
            currentTime = currentTime + executionTime;

            // check for new arrivals whilst the above process executes
            for(int i = 0; i < n; i++) {
                if(p[i].AT <= currentTime && p[i].RT > 0) {
                    bool inQueue = false;
                    for(int j = front; j < rear; j++) {
                        if(readyQueue[j] == i) inQueue = true;
                    }
                    if(!inQueue) readyQueue[rear++] = i;
                }
            }

            // the proceeess which was being executed, finishes executing
            if(p[idx].RT == 0) {
                completed++;
                p[idx].CT = currentTime;
                p[idx].TAT = p[idx].CT - p[idx].AT;
                p[idx].WT = p[idx].TAT - p[idx].BT;
            } else
                readyQueue[rear++] = idx;
        }
    }

    cout << "\nP#\tAT\tBT\tCT\tTAT\tWT\n";
    for(int i = 0; i < n; i++) {
        cout << p[i].id << "\t" << p[i].AT << "\t" << p[i].BT << "\t"
             << p[i].CT << "\t" << p[i].TAT << "\t" << p[i].WT << "\n";
    }
}

int main() {
    int n, quantum;
    cout << "Enter total number of processes : ";
    cin >> n;

    Process p[n];

    for(int i = 0; i < n; i++) {
        cout << "Enter arrival time, burst time and priority for Process " << i << " : ";
        p[i].id = i;
        cin >> p[i].AT >> p[i].BT >> p[i].priority;
        p[i].RT = p[i].BT;
    }

    cout << "Enter the time quantum for Round Robin : ";
    cin >> quantum;

    cout << "\n------FCFS (Non pre-emptive)------";
    FCFS(p, n);
    reset(p, n);

    cout << "\n------Priority Scheduling (Non premptive)------";
    priorityScheduling(p, n);
    reset(p, n);

    cout << "\n------SJF (Premptive)------";
    SJF(p, n);
    reset(p, n);

    cout << "\n------Round Robin (Premptive)------";
    roundRobin(p, n, quantum);
    reset(p, n);

    return 0;
}

// OUTPUT

// Enter total number of processes : 4
// Enter arrival time, burst time and priority for Process 0 : 0 5 5
// Enter arrival time, burst time and priority for Process 1 : 3 4 2
// Enter arrival time, burst time and priority for Process 2 : 4 1 1
// Enter arrival time, burst time and priority for Process 3 : 6 8 4
// Enter the time quantum for Round Robin : 3

// ------FCFS (Non pre-emptive)------
// P#      AT      BT      CT      TAT     WT
// 0       0       5       5       5       0
// 1       3       4       9       6       2
// 2       4       1       10      6       5
// 3       6       8       18      12      4

// ------Priority Scheduling (Non premptive)------
// P#      AT      BT      Priority        CT      TAT     WT
// 0       0       5       5               5       5       0
// 1       3       4       2               10      7       3
// 2       4       1       1               6       2       1
// 3       6       8       4               18      12      4

// ------SJF (Premptive)------
// P#      AT      BT      CT      TAT     WT
// 0       0       5       5       5       0
// 1       3       4       10      7       3
// 2       4       1       6       2       1
// 3       6       8       18      12      4

// ------Round Robin (Premptive)------
// P#      AT      BT      CT      TAT     WT
// 0       0       5       8       8       3
// 1       3       4       13      10      6
// 2       4       1       9       5       4
// 3       6       8       18      12      4



