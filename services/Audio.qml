pragma Singleton

import Quickshell
import Quickshell.Services.Pipewire
import QtQuick

Singleton {
    id: root
    property PwNode sink: Pipewire.defaultAudioSink
    property real volume: sink.audio.volume
    property bool muted: sink.audio.muted

    PwObjectTracker {
        objects: [ root.sink ]
    }
}
