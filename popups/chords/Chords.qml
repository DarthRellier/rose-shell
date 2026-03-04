pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property var appChords: [
        {"chord": Qt.Key_W, "chordName": "w", "command": "firefox", "description": "Open Firefox"},
        {"chord": Qt.Key_T, "chordName": "t", "command": "thunderbird", "description": "Open Thunderbird"},
        {"chord": Qt.Key_L, "chordName": "l", "command": "libreoffice", "description": "Open LibreOffice"},
        {"chord": Qt.Key_E, "chordName": "e", "command": "thunar", "description": "Open Thunar"},
        {"chord": Qt.Key_O, "chordName": "o", "command": "obsidian --enable-features=UseOzonePlatform --ozone-platform=wayland", "description": "Open Obsidian"},
        {"chord": Qt.Key_G, "chordName": "g", "command": "gimp", "description": "Open GIMP"},
        {"chord": Qt.Key_B, "chordName": "b", "command": "kitty -e btop", "description": "Open BTOP++"},
        {"chord": Qt.Key_F, "chordName": "f", "command": "kitty --app-id=float-term -e fish-file-explorer", "description": "Fzf File Explorer"},
        {"chord": Qt.Key_S, "chordName": "s", "command": "kitty --app-id=float-term -e fish-window-switcher", "description": "Fzf Window Switcher"},
        {"chord": Qt.Key_D, "chordName": "d", "command": "kitty --app-id=float-term -e fish-debate-file-explorer", "description": "Fzf Debate Files"},
        {"chord": Qt.Key_Return, "chordName": "⏎", "command": "kitty --app-id=float-term -e sway-launcher-desktop.sh", "description": "Open Launcher"}
    ]

    readonly property var powerChords: [
        {"chord": Qt.Key_L, "chordName": "l", "command": "~/scripts/swaylock/lock.fish", "description": "Lock"},
        {"chord": Qt.Key_S, "chordName": "s", "command": "systemctl suspend", "description": "Sleep"},
        {"chord": Qt.Key_E, "chordName": "e", "command": "niri msg action quit", "description": "Exit Niri", "modifiers": Qt.ControlModifier | Qt.AltModifier},
        {"chord": Qt.Key_R, "chordName": "r", "command": "reboot", "description": "Reboot", "modifiers": Qt.ControlModifier | Qt.AltModifier},
        {"chord": Qt.Key_P, "chordName": "p", "command": "poweroff", "description": "Shut Down", "modifiers": Qt.ControlModifier | Qt.AltModifier}
        
    ]
}
