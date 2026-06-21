import Quickshell
import Quickshell.Wayland
import QtQuick
import qs
import qs.services
import qs.lockscreen

Rectangle {
    id: root

    required property LockContext context

    signal iconAnimFinished

    radius: width / 2
    color: Qt.alpha(ThemeColors.surface, 0.65)

    Text {
        id: lockIcon
        text: ""

        font.pointSize: 55
        font.family: ThemeFonts.symbols

        color: root.context.showPamFprintAllowed ? ThemeColors.text : ThemeColors.gold
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        anchors.centerIn: parent

        SequentialAnimation {
            id: failSequence

            running: false

            NumberAnimation {
                target: lockIcon
                property: "anchors.horizontalCenterOffset"
                to: 10
                duration: 75
            }

            NumberAnimation {
                target: lockIcon
                property: "anchors.horizontalCenterOffset"
                to: -10
                duration: 75
            }

            NumberAnimation {
                target: lockIcon
                property: "anchors.horizontalCenterOffset"
                to: 10
                duration: 75
            }

            NumberAnimation {
                target: lockIcon
                property: "anchors.horizontalCenterOffset"
                to: -10
                duration: 75
            }

            NumberAnimation {
                target: lockIcon
                property: "anchors.horizontalCenterOffset"
                to: 10
                duration: 75
            }

            NumberAnimation {
                target: lockIcon
                property: "anchors.horizontalCenterOffset"
                to: -10
                duration: 75
            }

            NumberAnimation {
                target: lockIcon
                property: "anchors.horizontalCenterOffset"
                to: 0
                duration: 75
            }

            onStarted: () => {
                lockIcon.color = ThemeColors.love;
            }

            onFinished: () => {
                lockIcon.color = root.context.showPamFprintAllowed ? ThemeColors.text : ThemeColors.gold;
            }
        }

        SequentialAnimation {
            id: successSequence

            onStarted: () => {
                lockIcon.color = ThemeColors.rose;
                lockIcon.rotation = 0;
            }

            NumberAnimation {
                target: lockIcon
                property: "rotation"
                to: 360
                duration: 350
            }

            PropertyAction {
                target: lockIcon
                property: "text"
                value: ""
            }

            PauseAnimation {
                duration: 500
            }

            onFinished: () => {
                root.iconAnimFinished();
            }
        }

        Connections {
            target: root.context

            function onFailed() {
                failSequence.start();
            }

            function onFingerprintFailed() {
                failSequence.start();
            }

            function onUnlocked() {
                successSequence.start();
            }
        }

        MouseArea {
            anchors.fill: parent

            focusPolicy: Qt.NoFocus

            enabled: !root.context.unlockInProgress && root.context.currentText !== ""
            onClicked: root.context.tryUnlock()
        }
    }
}
