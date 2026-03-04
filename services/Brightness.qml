pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    signal brightnessChanged()
    
    readonly property int brightnessRaw: rawFile.text()
    readonly property int brightnessMax: maxFile.text()
    readonly property real brightnessPct: Math.round((brightnessRaw / brightnessMax) * 100)

    FileView {
        id: rawFile
        
        path: "/sys/class/backlight/amdgpu_bl1/brightness"
        watchChanges: true
        onFileChanged: {
            root.brightnessChanged()
            this.reload()
        }
    }

    FileView {
        id: maxFile
        path: "/sys/class/backlight/amdgpu_bl1/max_brightness"
        watchChanges: true
        onFileChanged: {
            root.brightnessChanged()
            this.reload()
        }
    }
}
