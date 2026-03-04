pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick

Singleton {
    id: root

    // Battery Property
    readonly property UPowerDevice battery: UPower.displayDevice

    // Memory Properties
    property real memTotal
    property real memAvailable
    property real memUsed: memTotal - memAvailable
    property real memUsedPct: memUsed / memTotal

    // CPU Properties
    property real cpuUsage
    property var previousCpuStats

    // Temp Properties
    property real tempmC
    property real tempC: tempmC / 1000

    FileView {
        id: memFile
        path: "/proc/meminfo"
    }
    FileView {
        id: cpuFile
        path: "/proc/stat"
    }
    FileView {
        id: tempFile
        path: "/sys/class/thermal/thermal_zone0/temp"
    }

    Timer {
        interval: 1
        running: true
        repeat: true

        onTriggered: {
            memFile.reload();
            cpuFile.reload();
            tempFile.reload();

            // Parse Memory
            const memText = memFile.text();
            root.memTotal = Number(memText.match(/MemTotal: *(\d+)/)?.[1] ?? 1);
            root.memAvailable = Number(memText.match(/MemAvailable: *(\d+)/)?.[1] ?? 1);

            // Parse CPU
            const cpuText = cpuFile.text();
            const cpuLine = cpuText.match(/cpu\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/);
            if (cpuLine) {
                const cpuStats = cpuLine.slice(1).map(Number)
                const totalTime = cpuStats.reduce((a, b) => a + b, 0)
                const idleTime = cpuStats[3]

                if (root.previousCpuStats) {
                    const totalDiff = totalTime - root.previousCpuStats.totalTime
                    const idleDiff = idleTime - root.previousCpuStats.idleTime
                    root.cpuUsage = totalDiff > 0 ? 1 - (idleDiff / totalDiff) : 0
                }

                root.previousCpuStats = { totalTime, idleTime }
            }

            // Parse Temperature
            root.tempmC = Number(tempFile.text())

            // Reset Interval
            interval = 5000
        }
    }
}
