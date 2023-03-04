import locks
import tables

var
  threads: array[4, Thread[void]]
  lock: Lock
  globalData = {"1": "one"}.toTable
  globalPtr = addr(globalData)

proc threadFunc() {.thread.} =
    acquire(lock) # lock stdout

    let data = cast[ptr Table[string,string]](globalPtr)[]
    echo data["1"]

    release(lock)

initLock(lock)

for i in 0..high(threads):
  createThread(threads[i], threadFunc)

joinThreads(threads)