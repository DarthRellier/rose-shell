pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.Pam

Scope {
    id: root

    signal unlocked
    signal failed
    signal fingerprintFailed

    property string currentText: ""
    property ListModel currentTextModel: ListModel {
        id: passwordTextListModel
    }
    property bool unlockInProgress: false
    property bool pamFprintAllowed: pamFprint.fails < 2
    property bool showPamFprintAllowed: pamFprint.fails < 3 && pamFprintOriginated
    property bool pamFprintOriginated

    onCurrentTextChanged: {
        while (currentTextModel.count < currentText.length) {
            currentTextModel.append({});
        }

        while (currentTextModel.count > currentText.length) {
            currentTextModel.remove(currentTextModel.count - 1);
        }
    }

    function tryUnlock() {
        if (currentText == "") {
            return;
        }

        root.unlockInProgress = true;
        pam.start();
    }

    function startPamFprint() {
        console.info("starting pam fprint");
        pamFprint.started();
    }

    PamContext {
        id: pam

        configDirectory: "pam"
        config: "quickshell_password.conf"

        onPamMessage: {
            if (this.responseRequired) {
                this.respond(root.currentText);
            }
        }

        onCompleted: result => {
            root.unlockInProgress = false;
            root.currentText = "";

            if (result == PamResult.Success) {
                root.unlocked();
            } else {
                root.failed();
            }
        }

        Component.onCompleted: {
            root.unlocked.connect(() => {
                pam.abort();
            });
        }
    }

    PamContext {
        id: pamFprint

        signal started

        property int fails: 0

        configDirectory: "pam"
        config: "quickshell_fprint.conf"

        onCompleted: result => {
            if (result == PamResult.Success) {
                root.unlocked();
            } else {
                if (root.pamFprintAllowed) {
                    pamFprint.start();
                    console.info("Pam Fprint Failed. Fails: " + (fails + 1) + ".");
                } else {
                    console.info("Pam Fprint Failed. Fails: " + (fails + 1) + ". No More Attempts.")
                }
                pamFprint.fails += 1;
                root.fingerprintFailed();
            }
        }

        Component.onCompleted: {
            pamFprint.started.connect(() => {
                pamFprint.fails = 0;
                pamFprint.start();
            });
            root.unlocked.connect(() => {
                pamFprint.abort();
            });
        }
    }
}
