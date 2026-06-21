pragma Singleton

import Quickshell
import QtQuick

Singleton {
    // Define Rosepine Colors:
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

    // Define fonts:
    FontLoader {
        id: fontLoader
        source: "assets/fonts/Commissioner-Medium.ttf"
    }

    FontLoader {
        id: boldLoader
        source: "assets/fonts/Commissioner-SemiBold.ttf"
    }

    FontLoader {
        id: symbolsLoader
        source: "assets/fonts/SymbolsNerdFontMono-Regular.ttf"
    }

    readonly property string font: fontLoader.name
    readonly property string boldFont: boldLoader.name
    readonly property string symbols: symbolsLoader.name

    // Define Spacing Values:

    // General
    readonly property real generalPadding: 20
    readonly property real largeSpacing: 20
    readonly property real generalSpacing: 10
    readonly property real smallSpacing: 5

    readonly property real generalBorder: 3

    // Sidebar
    readonly property real fullSidebarWidth: 60
    readonly property real sidebarCurveSize: 20
    readonly property real sidebarCurveRadius: 20
    
    readonly property real sidebarPillWidth: 27.5
    readonly property real sidebarPadding: 20

    readonly property real workspaceButtonHeightActive: 37.5
    readonly property real workspaceButtonHeightInactive: 18.75

    // Chords
    readonly property real chordListWidth: 250
    readonly property real chordListPadding: 10
    readonly property real chordListVSpacing: 15
    readonly property real chordListLeftMargin: 25
    readonly property real chordListGapSize: 35
    
    // OSD Popups
    readonly property real osdPopupWidth: 200
    readonly property real osdPopupHeight: 40
    readonly property real osdPopupBottomPadding: 10

    readonly property real osdProgressBarWidth: 150
    readonly property real osdProgressBarHeight: 10
    
    // Notifications
    readonly property real notifPaddingSize: 8
    readonly property real notifWidth: 300
    readonly property real notifRadius: 8
    readonly property real notifIconSize: 50
    readonly property real notifRightMargin: 16
    readonly property real notifMaxLines: 4

    // Systray
    readonly property real systrayIconSize: 24
    
}
