// MediaControlWidget.qml

import QtQuick
import QtQuick.Layouts

// Quickshell modules
import Quickshell.Services.Mpris
import Quickshell.Widgets
import Quickshell
import QtQuick.Controls

Item {
    id: root
    // size may be set by parent, or you can specify defaults
    width: 300
    height: 80

    // Access the MPRIS player service; singleton exposing playbackState, metadata etc.
    // According to docs, Quickshell.Services.Mpris is available. :contentReference[oaicite:0]{index=0}
    property var player: Mpris.Player  // or appropriate type

    // Background / container
    WrapperRectangle {
        id: background
        anchors.fill: parent
        color: root.palette.background  // or a theme color
        radius: 6
        opacity: 0.9
    }

    RowLayout {
        id: mainRow
        anchors.fill: parent
        anchors.margins: 8
        spacing: 12

        // Album Art (if available)
        Image {
            id: albumArt
            source: player.metadata["mpris:artUrl"]  // or use property exposed by MPRIS
            width: 64
            height: 64
            fillMode: Image.PreserveAspectFit
            visible: source !== "" && source !== null
            // fallback to default icon if no album art
        }

        ColumnLayout {
            id: infoCol
            Layout.fillWidth: true
            spacing: 4

            // Track title
            Text {
                id: titleText
                text: player.metadata["xesam:title"] || "Unknown Title"
                font.pixelSize: 14
                elide: Text.ElideRight
                color: root.palette.text
            }

            // Artist / Album
            Text {
                id: artistText
                text: player.metadata["xesam:artist"] ? player.metadata["xesam:artist"].join(", ") : "Unknown Artist"
                font.pixelSize: 12
                elide: Text.ElideRight
                color: root.palette.textDimmed
            }

            // Playback Controls + Volume
            RowLayout {
                id: controlRow
                spacing: 8

                // Previous
                WrapperMouseArea {
                    onClicked: {
                        if (player.canGoPrevious) player.previous()
                    }
                    IconImage {
                        source: "qrc:/icons/media-previous.svg"
                        width: 24; height: 24
                        // maybe change appearance disabled/enabled
                        opacity: player.canGoPrevious ? 1.0 : 0.4
                    }
                }

                // Play / Pause toggle
                WrapperMouseArea {
                    onClicked: {
                        if (player.playbackState === Mpris.PlaybackState.Playing) {
                            player.pause()
                        } else {
                            player.play()
                        }
                    }
                    IconImage {
                        source: player.playbackState === Mpris.PlaybackState.Playing
                                ? "qrc:/icons/media-pause.svg"
                                : "qrc:/icons/media-play.svg"
                        width: 24; height: 24
                    }
                }

                // Next
                WrapperMouseArea {
                    onClicked: {
                        if (player.canGoNext) player.next()
                    }
                    IconImage {
                        source: "qrc:/icons/media-next.svg"
                        width: 24; height: 24
                        opacity: player.canGoNext ? 1.0 : 0.4
                    }
                }

                // Spacer
                Item {
                    Layout.fillWidth: true
                }

                // Volume / Mute
                WrapperMouseArea {
                    onClicked: {
                        player.muted = !player.muted
                    }
                    IconImage {
                        source: player.muted
                                ? "qrc:/icons/volume-mute.svg"
                                : (player.volume > 0.7
                                   ? "qrc:/icons/volume-high.svg"
                                   : player.volume > 0.3
                                     ? "qrc:/icons/volume-medium.svg"
                                     : "qrc:/icons/volume-low.svg")
                        width: 24; height: 24
                    }
                }

                Slider {
                    id: volSlider
                    width: 80
                    from: 0.0
                    to: 1.0
                    stepSize: 0.01
                    value: player.volume
                    enabled: player.volumeSupported
                    onMoved: {
                        player.volume = value
                        if (player.muted && value > 0) {
                            player.muted = false
                        }
                    }
                }
            }
        }
    }

    // React to changes
    Connections {
        target: player
        onPlaybackStateChanged: {
            // maybe update UI or animations
        }
        onMetadataChanged: {
            // updates title/artist/album art
        }
        onVolumeChanged: {
            volSlider.value = player.volume
        }
        onMutedChanged: {
            // update mute icon etc
        }
    }

    // Handle case no player / no media
    Item {
        id: noMediaOverlay
        anchors.fill: parent
        visible: player.playbackState === Mpris.PlaybackState.Stopped
                 && (!player.metadata || Object.keys(player.metadata).length === 0)
        Rectangle {
            anchors.centerIn: parent
            color: "transparent"
            Text {
                text: "No media playing"
                color: root.palette.text
                font.pixelSize: 14
            }
        }
    }
}

