pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string parkName: "deez"

    Process {
        id: getParkProcess
        running: true
        command: ["awww", "query"]
        stdout: StdioCollector {
            onStreamFinished: {
                const matches = this.text.match(/.*\/(.*)\.jpg/)
                root.parkName = matches[1]
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
