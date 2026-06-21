pragma Singleton

import Quickshell
import QtQuick

Singleton {
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
}
