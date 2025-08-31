```
                             OPERATING SYSTEM (OS)
                                      |
        ---------------------------------------------------------------------------------
        |                |                  |                   |                     |
    PROCESS        MEMORY MANAGEMENT    FILE SYSTEM        I/O & DEVICE        SECURITY & PROTECTION
   MANAGEMENT             |                   |               MANAGEMENT               |
        |                |                   |                   |                     |
    -----------    ----------------    ----------------    ----------------    -------------------
    |    |    |    |       |       |    |       |       |    |       |       |    |       |       |
  Process  Thread  Scheduling     Paging    Segmentation   FAT, NTFS, ext4   Device Drivers  Buffering  Authentication  Access Control  Encryption
  States   (Multithreading)     (Page Table, TLB)  (Logical → Physical)   (Directory, Inode)   (Kernel I/O)  Caching        (Password, Biometric) (ACL, Roles)   (AES, RSA)
  (New,     |          |             |           |             |             |          |          |                     |
  Ready,    |    FCFS, SJF,        Virtual      Page Fault    File Ops      Interrupts  DMA      Firewall     Privilege Rings
  Running,  |    Round Robin,     Memory       Demand Paging   (open, read)   (Polling vs) (Direct Memory Access)   (User vs Kernel Mode)
  Blocked)  |    Priority)        (Swap Space)  (Lazy Loading)                Interrupt-Driven)
            |         |                |           |             |                   |
            |    Multilevel           |        Thrashing       |                   |
            |    Feedback Queue       |    (Fix: Increase RAM)  |                   |
            |                         |                        Hard Links vs Soft Links
            |                         |                        (Same inode vs Path-based)
            |
        SYNCHRONIZATION
            |
    ---------------------
    |         |         |
  Mutex    Semaphore   Monitor
  (Lock)   (Counting,  (High-level
           Binary)     construct)
            |
        DEADLOCK
            |
    ---------------------
    |         |         |
  Mutual   Hold &    No Preemption   Circular Wait
  Exclusion  Wait      (Can't force stop)   (A→B→C→A)
            |
     Prevention / Avoidance / Detection / Recovery
```