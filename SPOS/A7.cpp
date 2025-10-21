#include <bits/stdc++.h>
using namespace std;

int LRU(int pages[], int totalPages, int frames[], int totalFrames)
{
    cout << "\nLRU Page Replacement -> " << endl;
    // stores when each of the loaded framess was last used
    int lastUsed[totalFrames];
    int pageFaults = 0;

    for (int i = 0; i < totalFrames; i++)
    {
        frames[i] = -1;
        lastUsed[i] = -1;
    }

    for (int i = 0; i < totalPages; i++)
    {
        // for every page, check if it exists in the current frames or not
        bool found = false;
        for (int j = 0; j < totalFrames; j++)
        {
            if (pages[i] == frames[j])
            {
                // page hit
                lastUsed[j] = i;
                found = true;

                cout << "Frames : ";
                for (int j = 0; j < totalFrames; j++)
                    cout << frames[j] << " ";
                cout << endl;

                break;
            }
        }
        // page fault - current page not found in the frames
        // method 1 - check for empty frames i.e -1
        // method 2 - replace the least recently used frame w the current frame

        // M1
        for (int j = 0; j < totalFrames; j++)
        {
            if (frames[j] == -1)
            {
                frames[j] = pages[i];
                lastUsed[j] = i;
                found = true;
                pageFaults++;

                cout << "Frames : ";
                for (int j = 0; j < totalFrames; j++)
                    cout << frames[j] << " ";
                cout << endl;

                break;
            }
        }
        if (found)
            continue;

        // M2
        int LRUvalue = lastUsed[0];
        int LRUindex = 0;

        for (int j = 1; j < totalFrames; j++)
        {
            if (lastUsed[j] < LRUvalue)
            {
                LRUvalue = lastUsed[j];
                LRUindex = j;
            }
        }
        // LRUindex - holds the index of the frame that is to be replaced by the current page
        frames[LRUindex] = pages[i];
        lastUsed[LRUindex] = i;
        pageFaults++;

        cout << "Frames : ";
        for (int j = 0; j < totalFrames; j++)
            cout << frames[j] << " ";
        cout << endl;
    }
    return pageFaults;
}

int optimal(int pages[], int totalPages, int frames[], int totalFrames)
{
    cout << "\nOptimal Page Replacement -> " << endl;
    int pageFaults = 0;

    for (int i = 0; i < totalFrames; i++)
        frames[i] = -1;

    for (int i = 0; i < totalPages; i++)
    {
        bool found = false;
        for (int j = 0; j < totalFrames; j++)
        {
            if (pages[i] == frames[j])
            {
                // page hit
                found = true;
                cout << "Frames : ";
                for (int j = 0; j < totalFrames; j++)
                    cout << frames[j] << " ";
                cout << endl;

                break;
            }
        }
        // page fault occured
        // method 1 - check for empty frames i.e -1
        // method 2 - replace the page that will be used farthest in the future with the current page

        // M1
        for (int j = 0; j < totalFrames; j++)
        {
            if (frames[j] == -1)
            {
                frames[j] = pages[i];
                found = true;
                pageFaults++;

                cout << "Frames : ";
                for (int j = 0; j < totalFrames; j++)
                    cout << frames[j] << " ";
                cout << endl;

                break;
            }
        }
        if (found)
            continue;

        // M2
        int farthest = -1;
        int indexToReplace = -1;

        for (int j = 0; j < totalFrames; j++)
        {
            int usedAt = -1;
            bool frameUsedAgain = false;
            for (int k = i + 1; k < totalPages; k++)
            {
                if (pages[k] == frames[j])
                {
                    frameUsedAgain = true;
                    usedAt = k;
                    break;
                }
            }
            if (!frameUsedAgain)
            {
                // this frame will never be used again, replace this and break;
                indexToReplace = j;
                break;
            }
            // else replace the frame at pages[usedAt] and replace with current page
            if (usedAt > farthest)
            {
                farthest = usedAt;
                indexToReplace = j;
            }
        }

        frames[indexToReplace] = pages[i];
        pageFaults++;

        cout << "Frames : ";
        for (int j = 0; j < totalFrames; j++)
            cout << frames[j] << " ";
        cout << endl;
    }

    return pageFaults;
}

int main()
{
    int totalPages, totalFrames;

    // Page info
    cout << "Enter number of pages : ";
    cin >> totalPages;

    int pages[totalPages];

    cout << "Enter the page references : ";
    for (int i = 0; i < totalPages; i++)
    {
        cin >> pages[i];
    }

    // Frame info
    cout << "Enter total number of frames : ";
    cin >> totalFrames;

    int frames[totalFrames];

    int LRUpagefaults = LRU(pages, totalPages, frames, totalFrames);
    cout << "LRU - Page faults : " << LRUpagefaults << endl;

    int optimalpagefaults = optimal(pages, totalPages, frames, totalFrames);
    cout << "Optimal - Page faults : " << optimalpagefaults << endl;

    return 0;
}

// ---------- OUTPUT ---------
// Enter number of pages : 13
// Enter the page references : 7 0 1 2 0 3 0 4 2 3 0 3 2
// Enter total number of frames : 3

// LRU Page Replacement ->
// Frames : 7 -1 -1
// Frames : 7 0 -1
// Frames : 7 0 1
// Frames : 2 0 1
// Frames : 2 0 1
// Frames : 2 0 3
// Frames : 2 0 3
// Frames : 4 0 3
// Frames : 4 0 2 
// Frames : 4 3 2
// Frames : 0 3 2
// Frames : 0 3 2
// Frames : 0 3 2
// LRU - Page faults : 9

// Optimal Page Replacement ->
// Frames : 7 -1 -1
// Frames : 7 0 -1
// Frames : 7 0 1
// Frames : 2 0 1
// Frames : 2 0 1
// Frames : 2 0 3
// Frames : 2 0 3
// Frames : 2 4 3
// Frames : 2 4 3
// Frames : 2 4 3
// Frames : 2 0 3
// Frames : 2 0 3
// Frames : 2 0 3 
// Optimal - Page faults : 7
