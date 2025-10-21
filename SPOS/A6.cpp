// Write a program to simulate Memory placement strategies – best fit, first fit, next fit and worst fit

#include <bits/stdc++.h>
using namespace std;

struct Process
{
    int id;
    int size;
    int blockId;
};

struct Block
{
    int id;
    int size;
    bool allocated;
};

void resetBlockAndProcess(Block blocks[], Process processes[], int n, int m)
{
    for (int i = 0; i < n; i++)
        blocks[i].allocated = false;
    for (int i = 0; i < m; i++)
        processes[i].blockId = -1;
}
void printAllocation(Process processes[], int m)
{
    cout << "\nProcess No.\tProcess Size\tBlock No.\n";
    for (int i = 0; i < m; i++)
    {
        cout << processes[i].id << "\t\t"
             << processes[i].size << "\t\t";
        if (processes[i].blockId != -1)
            cout << processes[i].blockId;
        else
            cout << "Not Allocated";
        cout << endl;
    }
}

void firstFit(Block blocks[], Process processes[], int n, int m)
{
    for (int i = 0; i < m; i++)
    {
        for (int j = 0; j < n; j++)
        {
            if (processes[i].size <= blocks[j].size && processes[i].blockId == -1 && blocks[j].allocated == false)
            {
                processes[i].blockId = blocks[j].id;
                blocks[j].allocated = true;
                break;
            }
        }
    }
    cout << "\nFirst Fit : ";
    printAllocation(processes, m);
}

void nextFit(Block blocks[], Process processes[], int n, int m)
{
    int lastIndex = 0;
    for (int i = 0; i < m; i++)
    {
        for (int k = 0; k < n; k++)
        {
            int j = (k + lastIndex) % n;
            if (processes[i].size <= blocks[j].size && processes[i].blockId == -1 && blocks[j].allocated == false)
            {
                processes[i].blockId = blocks[j].id;
                blocks[j].allocated = true;
                lastIndex = j;
                break;
            }
        }
    }
    cout << "\nNext Fit : ";
    printAllocation(processes, m);
}

void bestFit(Block blocks[], Process processes[], int n, int m)
{
    for (int i = 0; i < m; i++)
    {
        int bestIndex = -1;
        for (int j = 0; j < n; j++)
        {
            if (processes[i].size <= blocks[j].size && processes[i].blockId == -1 && blocks[j].allocated == false)
            {
                if (bestIndex == -1 || blocks[j].size < blocks[bestIndex].size)
                {
                    bestIndex = j;
                }
            }
        }

        if (bestIndex != -1)
        {
            processes[i].blockId = blocks[bestIndex].id;
            blocks[bestIndex].allocated = true;
        }
    }
    cout << "\nBest Fit : ";
    printAllocation(processes, m);
}

void worstFit(Block blocks[], Process processes[], int n, int m)
{
    for (int i = 0; i < m; i++)
    {
        int worstIndex = -1;
        for (int j = 0; j < n; j++)
        {
            if (processes[i].size <= blocks[j].size && processes[i].blockId == -1 && blocks[j].allocated == false)
            {
                if (worstIndex == -1 || blocks[j].size > blocks[worstIndex].size)
                {
                    worstIndex = j;
                }
            }
        }

        if (worstIndex != -1)
        {
            processes[i].blockId = blocks[worstIndex].id;
            blocks[worstIndex].allocated = true;
        }
    }
    cout << "\nWorst Fit : ";
    printAllocation(processes, m);
}

int main()
{
    int n, m;
    cout << "Enter number of memory blocks : ";
    cin >> n;
    cout << "Enter number of processes : ";
    cin >> m;

    Block blocks[50];
    Process processes[50];

    cout << "Enter the size of each block : " << endl;
    for (int i = 0; i < n; i++)
    {
        cin >> blocks[i].size;
        blocks[i].id = i + 1;
        blocks[i].allocated = false;
    }

    cout << "Enter the size of each process : " << endl;
    for (int i = 0; i < m; i++)
    {
        cin >> processes[i].size;
        processes[i].id = i + 1;
        processes[i].blockId = -1;
    }

    firstFit(blocks, processes, n, m);
    resetBlockAndProcess(blocks, processes, n, m);
    bestFit(blocks, processes, n, m);
    resetBlockAndProcess(blocks, processes, n, m);
    worstFit(blocks, processes, n, m);
    resetBlockAndProcess(blocks, processes, n, m);
    nextFit(blocks, processes, n, m);
    resetBlockAndProcess(blocks, processes, n, m);

    return 0;
}
