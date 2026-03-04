pragma Singleton

import Quickshell
import QtQuick

Singleton {
    // Define Rosepine Colors
    readonly property color base: "#191714"
    readonly property color surface: "#1f1d2e"
    readonly property color overlay: "#26233a"
    readonly property color muted: "#6e6a86"
    readonly property color subtle: "#908caa"
    readonly property color text: "#e0def4"
    readonly property color love: "#eb6f92"
    readonly property color gold: "#f6c177"
    readonly property color rose: "#ebbcba"
    readonly property color pine: "#31748f"
    readonly property color foam: "#9ccfd8"
    readonly property color iris: "#c4a7e7"
    readonly property color highlightLow: "#21202e"
    readonly property color highlightMed: "#403d52"
    readonly property color highlightHigh: "#524f67"

    // Define fonts
    FontLoader {
        id: varelaLoader
        source: "/home/nathaniel/.config/quickshell/assets/VarelaRound-Regular.ttf"
    }

    FontLoader {
        id: symbolsLoader
        source: "/home/nathaniel/.config/quickshell/assets/SymbolsNerdFontMono-Regular.ttf"
    }

    readonly property string winky: varelaLoader.name
    readonly property string varela: varelaLoader.name
    readonly property string symbols: symbolsLoader.name
}
