pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland

// Based on Quickshell's lockscreen example

Scope {
    id: root

    LockContext {
        id: lockContext

        onUnlocked: {
            lock.locked = false;
        }
    }

    WlSessionLock {
        id: lock

        locked: false

        LockSurface {
            context: lockContext
        }
    }

    IpcHandler {
        target: "lockscreen"

        function lock() {
            lock.locked = true;
            lockContext.startPamFprint()
        }
    }
}
