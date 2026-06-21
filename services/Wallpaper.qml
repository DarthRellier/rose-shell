pragma Singleton

import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property string paperFileName
    property string paperLabel: "Missing Name!"
    property bool labelIsLight

    Process {
        id: getPaperProcess
        running: true
        command: ["awww", "query"]
        stdout: StdioCollector {
            onStreamFinished: {
                // This means that wallpaper filenames must conform to this format: Display Name-dark/light-version.jpg
                const labelMatches = this.text.match(/.*\/([^\-]*)\-(\w+)\-*.*\.(jpg|png|jpeg)/)
                const paperMatch = this.text.match(/.*\/([^\.]*)(\.\w+)/)

                if (!labelMatches || !paperMatch) {
                    console.error("could not match wallaper names to regex")
                }
                
                root.paperLabel = labelMatches[1].trim()
                root.labelIsLight = labelMatches[2] == "light" ? true : false
                root.paperFileName = paperMatch[1] + paperMatch[2]

                console.info(paperMatch[1] + paperMatch[2])
            }
        }
    }

    IpcHandler {
        target: "parkLabel"

        function update() {
            getPaperProcess.running = true
        }
    }
}
