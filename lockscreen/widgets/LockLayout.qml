import QtQuick
import qs
import qs.services

Text {
    required property LockPasswordBox passwordBox
    
    text: Niri.shortenedKeyboardLayout.toUpperCase()

    font.pointSize: 11
    font.family: ThemeFonts.font

    color: passwordBox.passwordCharsGreaterThanZero ? ThemeColors.rose : "transparent"
    horizontalAlignment: Text.AlignHCenter
}
