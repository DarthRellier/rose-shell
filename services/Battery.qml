pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.UPower
import QtQuick

Singleton {
    id: root
    readonly property UPowerDevice battery: UPower.displayDevice

    Timer {
        interval: 90000
        running: true
        repeat: true
        onTriggered: {
            if (root.battery.state == UPowerDeviceState.Discharging) {
                if (root.battery.percentage < .10) {
                    veryLowBattery.running = true;
                } else if (root.battery.percentage < .20) {
                    lowBattery.running = true;
                }
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
