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
                const cpuStats = cpuLine.slice(1).map(Number);
                const totalTime = cpuStats.reduce((a, b) => a + b, 0);
                const idleTime = cpuStats[3];

                if (root.previousCpuStats) {
                    const totalDiff = totalTime - root.previousCpuStats.totalTime;
                    const idleDiff = idleTime - root.previousCpuStats.idleTime;
                    root.cpuUsage = totalDiff > 0 ? 1 - (idleDiff / totalDiff) : 0;
                }

                root.previousCpuStats = {
                    totalTime,
                    idleTime
                };
            }

            // Parse Temperature
            root.tempmC = Number(tempFile.text());

            // Reset Interval
            interval = 5000;
        }
    }

    // Battery Notification
    Timer {
        interval: 90000
        running: true
        repeat: true
        onTriggered: {
            if (root.battery.percentage < .20) {
                veryLowBattery.running = true;
                console.info("yahaha");
                console.info(root.battery.percentage)
            } else if (root.battery.percentage < .10) {
                lowBattery.running = true;
                console.info("yehehe");
            }
        }
    }

    Process {
        id: veryLowBattery
        running: false
        command: ["notify-send", "Low Battery", "Battery is less than 10%, plug in device immediatetly to avoid a shutdown.", "--urgency=critical"]
    }

    Process {
        id: lowBattery
        running: false
        command: ["notify-send", "Low Battery", "Battery is less than 20%, plug in device to avoid a shutdown!", "--urgency=normal"]
    }
}
