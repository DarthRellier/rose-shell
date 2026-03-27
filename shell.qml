//@ pragma IconTheme Papirus
//@ pragma UseQApplication

import Quickshell
import Quickshell.Io
import QtQuick
import qs.sidebar
import qs.popups.osd
import qs.popups.notifications
import qs.popups.chords
import qs.popups.activate
import qs.lockscreen

Scope {
    Sidebar {}

    AudioPopup {}

    BrightnessPopup {}

    NotificationList {}

    AppChordList {}

    PowerChordList {}

    Lockscreen {}

    ActivateLinux {}
}
