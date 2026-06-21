import QtQuick
import qs
import qs.services

Text {
    required property LockPasswordBox passwordBox
    
    text: Niri.shortenedKeyboardLayout.toUpperCase()

    font.pointSize: 11
    font.family: Theme.font

    color: passwordBox.passwordCharsGreaterThanZero ? Theme.rose : "transparent"
    horizontalAlignment: Text.AlignHCenter
}
