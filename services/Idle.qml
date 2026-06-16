pragma Singleton

import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import qs.services

Singleton {
    id: root
    signal idleLock

    property int targetPct
    property int savedPct

    // Dim
    IdleMonitor {
        timeout: 150
        onIsIdleChanged: {
            if (isIdle) {
                root.savedPct = Brightness.brightnessPct
                root.targetPct = Math.round((Brightness.brightnessPct / 2) / 5) * 5
                reduceBrightnessTimer.running = true
            } else {
                console.info(root.savedPct)
                restoreBrightness.running = true;
            }
        }
    }
    
    // Lock
    IdleMonitor {
        timeout: 300
        onIsIdleChanged: {
            if (isIdle) {
                root.idleLock();
            }
        }
    }

    // Sleep
    IdleMonitor {
        timeout: 600
        onIsIdleChanged: {
            if (isIdle) {
                sleepProcess.running = true;
            }
        }
    }

    Timer {
        id: reduceBrightnessTimer
        interval: 30
        running: false 
        repeat: true
        onTriggered: {
            reduceBrightness.running = true
            if (Brightness.brightnessPct <= root.targetPct) {
                this.running = false
            }
        }
    }

    Process {
        id: sleepProcess
        running: false
        command: ["systemctl", "suspend"]
    }

    Process {
        id: reduceBrightness
        running: false
        command: ["brightnessctl", "s", "5%-"]
    }

    Process {
        id: restoreBrightness
        running: false
        command: ["brightnessctl", "s", root.savedPct.toString() + "%"]
    }
}
