pragma Singleton

import Quickshell
import Quickshell.Wayland
import Quickshell.Io

Singleton {
    id: root
    signal idleLock()
       
    IdleMonitor {
        timeout: 600
        onIsIdleChanged: {
            if (isIdle) {
                root.idleLock()
            }
        }
    }
    
    IdleMonitor {
        timeout: 900
        onIsIdleChanged: {
            if (isIdle) {
                sleepProcess.running = true
            }
        }
    }

    Process {
        id: sleepProcess
        running: false
        command: ["systemctl", "suspend"]
    }
}
