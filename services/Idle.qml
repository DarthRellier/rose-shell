pragma Singleton

import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import qs.services

Singleton {
    id: root
    signal idleLock

    property int savedPct

    // Dim
    IdleMonitor {
        timeout: 240
        onIsIdleChanged: {
            if (isIdle) {
                root.savedPct = Brightness.brightnessPct
                reduceBrightnessTimer.running = true
            } else {
                console.info(root.savedPct)
                restoreBrightnessTimer.running = true;
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
        interval: 5
        running: false 
        repeat: true
        onTriggered: {
            reduceBrightness.running = true
            if (Brightness.brightnessPct <= 30) {
                this.running = false
            }
        }
    }

    Timer {
        id: restoreBrightnessTimer
        interval: 5
        running: false 
        repeat: true
        onTriggered: {
            if (Brightness.brightnessPct >= root.savedPct) {
                this.running = false
            }
            restoreBrightness.running = true
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
        command: ["brightnessctl", "s", "+5%"]
    }
}
