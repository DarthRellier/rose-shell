import QtQuick
import qs
import qs.lockscreen

Text {
    required property LockContext context
    
    text: context.showPamFprintAllowed ? "Enter password or\nfingerprint to unlock" : "Enter password\nto unlock"

    font.pointSize: 13
    font.family: ThemeFonts.font

    color: ThemeColors.rose
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
}
