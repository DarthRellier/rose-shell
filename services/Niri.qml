pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property var workspaces: []
    property var activeWorkspaceId
    property string keyboardLayout
    property string shortenedKeyboardLayout

    Component.onCompleted: {
        eventStream.running = true;
        keyboardProcess.running = true;
    }

    Process {
        id: workspaceProcess
        running: false
        command: ["niri", "msg", "--json", "workspaces"]

        stdout: SplitParser {
            onRead: line => {
                const workspacesData = JSON.parse(line);
                const workspacesList = [];

                // Create workspace entries
                for (const ws of workspacesData) {
                    workspacesList.push({
                        "id": ws.id,
                        "idx": ws.idx,
                        "name": ws.name || "",
                        "output": ws.output || "",
                        "isUrgent": ws.is_urgent === true,
                        "isActive": ws.is_active === true,
                        "isFocused": ws.is_focused === true,
                        "activeWindowId": ws.active_window_id
                    });

                    // Sort entries according to a custom algorithm
                    workspacesList.sort((a, b) => {
                        if (a.output !== b.output) {
                            return a.output.localeCompare(b.output);
                        } else if (a.name !== b.name) {
                            if (a.name) {
                                return -1
                            } else if (b.name) {
                                return 1
                            }
                        }

                        return a.idx - b.idx;
                    });

                    if (ws.is_active === true) {
                        root.activeWorkspaceId = ws.id;
                    }
                }

                root.workspaces = workspacesList;
            }
        }
    }

    Process {
        id: keyboardProcess
        running: false
        command: ["niri", "msg", "--json", "keyboard-layouts"]

        stdout: SplitParser {
            onRead: line => {
                const keyboardData = JSON.parse(line);
                const layoutNames = keyboardData.names;
                const currentIdx = keyboardData.current_idx;
                const currentLayoutName = layoutNames[currentIdx];

                function shortenLayout(name) {
                    switch (name) {
                    case "English (US)":
                        return "us";
                    case "Spanish":
                        return "es";
                    }
                }

                root.keyboardLayout = currentLayoutName;
                root.shortenedKeyboardLayout = shortenLayout(currentLayoutName);
            }
        }
    }

    Process {
        id: keyboardLayoutSwitch
        running: false
        command: ["niri", "msg", "action", "switch-layout", "next"]
    }

    function switchLayout() {
        keyboardLayoutSwitch.running = true
    }

    Process {
        id: eventStream
        running: false
        command: ["niri", "msg", "--json", "event-stream"]

        stdout: SplitParser {
            onRead: data => {
                const event = JSON.parse(data.trim());

                if (event.WorkspacesChanged) {
                    workspaceProcess.running = true;
                } else if (event.WorkspaceActivated) {
                    workspaceProcess.running = true;
                } else if (event.KeyboardLayoutSwitched) {
                    keyboardProcess.running = true;
                }
            }
        }
    }
}
