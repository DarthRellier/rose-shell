pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string parkName: "Missing Name!"
    property bool isLight

    Process {
        id: getParkProcess
        running: true
        command: ["awww", "query"]
        stdout: StdioCollector {
            onStreamFinished: {
                // This means that wallpaper filenames must conform to this format: Display Name-dark/light-version.jpg
                const matches = this.text.match(/.*\/([^\-]*)\-(\w+)\-*.*\.[jpg|png|jpeg]/)
                root.parkName = matches[1].trim()
                root.isLight = matches[2] == "light" ? true : false
            }
        }
    }

    IpcHandler {
        target: "parkLabel"

        function update() {
            getParkProcess.running = true
        }
    }
}
