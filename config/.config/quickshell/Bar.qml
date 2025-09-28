pragma ComponentBehavior: Bound
import Quickshell // for PanelWindow
import QtQuick // for Text
import Quickshell.Io

Scope {
    id: root

    Variants {
        model: Quickshell.screens

        PanelWindow {
            required property var modelData
            screen: modelData
            anchors {
                top: true
                left: true
                right: true
            }


            
            implicitHeight: 30

            ClockWidget {
                // center the bar in its parent component (the window)
                anchors.verticalCenter: parent.verticalCenter
                                anchors.margins: 10
                anchors.right: parent.right
            }

        }
    }
}
