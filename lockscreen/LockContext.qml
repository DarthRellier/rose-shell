pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.Pam

Scope {
    id: root

    signal unlocked
    signal failed

    property string currentText: ""
    property bool unlockInProgress: false
    property bool showErrorMsg: false

    onCurrentTextChanged: root.showErrorMsg = false

    function tryUnlock() {
        if (currentText == "") {
            return;
        }

        root.unlockInProgress = true;
        pam.start()
    }

    function startPamFprint() {
        console.info("starting pam fprint")
        pamFprint.started()
    }

    PamContext {
        id: pam

        configDirectory: "pam"
        config: "quickshell_password.conf"

        onPamMessage: {
            if (this.responseRequired) {
                this.respond(root.currentText)
            }
        }

        onCompleted: result => {
            root.unlockInProgress = false;
            root.currentText = ""

            if (result == PamResult.Success) {
                root.unlocked()
            } else {
                root.showErrorMsg = true;
                root.failed();
            }
        }

        Component.onCompleted: {
            root.unlocked.connect(() => {
                pam.abort()
            })
        }
    }

    PamContext {
        id: pamFprint

        signal started()

        property int fails: 0;

        configDirectory: "pam"
        config: "quickshell_fprint.conf"

        onCompleted: result => {
            if (result == PamResult.Success) {
                root.unlocked()
            } else {
                if (pamFprint.fails < 3) {
                    pamFprint.start()
                } else {
                    console.info("no more fprint")
                }
                pamFprint.fails += 1
                console.info("fprint fail")
            }
        }

        Component.onCompleted: {
            pamFprint.started.connect(() => {
                pamFprint.fails = 0
                pamFprint.start()    
            });
            root.unlocked.connect(() => {
                pamFprint.abort()
            });
        }
    }
}
