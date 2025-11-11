import Quickshell
import QtQuick
import Quickshell.Io
// import your widgets module if needed

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            color: Colors.base
            required property var modelData
            screen: modelData
            anchors {
                top: true
                left: true
                right: true
            }

            implicitHeight: 30

            // Your MediaControl widget
            MediaControlWidget {
                id: mediaControls
                // style properties if needed
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.margins: 10
                // maybe specify width / height or let widget intrinsic size
            }

            // Existing Clock
            ClockWidget {
                color: Colors.text
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.margins: 10
            }
        }
    }
}

