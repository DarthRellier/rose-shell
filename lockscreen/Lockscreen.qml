pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import qs.services

// Based on Quickshell's lockscreen example

Scope {
    id: root

    function lockScreen() {
        lock.locked = true;
        lockContext.pamFprintOriginated = false;
        lockContext.currentText = "";
        delayPam.restart();
        // lockContext.startPamFprint()
    }

    function unlockScreen() {
        lock.locked = false;
    }

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

    // Lock Screen Manually
    IpcHandler {
        target: "lockscreen"

        function lock() {
            root.lockScreen()
        }

        function unlock() {
            root.unlockScreen()
        }
    }

    // Lock Screen on Idle Timeout
    Connections {
        target: Idle
        function onIdleLock() {
            root.lockScreen()
        }
    }

    //Lock Screen on Suspend
    Process {
        running: true
        command: ["dbus-monitor", "--system", "type='signal',interface='org.freedesktop.login1.Manager',member='PrepareForSleep'"]

        stdout: SplitParser {
            onRead: line => {
                if (line.includes("boolean true")) {
                    root.lockScreen()
                }
            }
        }
    }
    
    Timer {
        id: delayPam

        // Delay Start of Touch ID to prevent it from starting before suspend
        interval: 750
        running: false

        onTriggered: () => {
            lockContext.startPamFprint();
            lockContext.pamFprintOriginated = true;
        }
    }
}
