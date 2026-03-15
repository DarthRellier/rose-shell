pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick

// Based on Quickshell's lockscreen example

Scope {
    id: root

    LockContext {
        id: lockContext
    }

    WlSessionLock {
        id: lock

        locked: false

        LockSurface {
            context: lockContext

            onUnlockAnimFinished: () => {
                lock.locked = false;
            }
        }
    }

    IpcHandler {
        target: "lockscreen"

        function lock() {
            lock.locked = true;
            lockContext.pamFprintOriginated = false;
            delayPam.restart();
        // lockContext.startPamFprint()
        }
    }

    Timer {
        id: delayPam

        interval: 750
        running: false

        onTriggered: () => {
            lockContext.startPamFprint();
            lockContext.pamFprintOriginated = true;
        }
    }
}
