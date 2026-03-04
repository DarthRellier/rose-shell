pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    property SystemClock clock: SystemClock {
        precision: SystemClock.Minutes
    }

}
