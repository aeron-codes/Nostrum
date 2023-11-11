import QtQuick 2.15
import QtGraphicalEffects 1.12
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4 as Q1
import QtQuick.Controls.Styles 1.4
import SddmComponents 2.0
import "."

Rectangle {
    id: container
    LayoutMirroring.enabled: Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit: true
    property int sessionIndex: session.index

    TextConstants { id: textConstants }

    Connections {
        target: sddm
        function onLoginSucceeded() {
            errorMessage.text = textConstants.loginSucceeded
        }
        function onLoginFailed() {
            password.text = ""
            errorMessage.color = "#f8724f"
            errorMessage.text = textConstants.loginFailed
        }
    }

    color: "#1e1c2c"
    anchors.fill: parent

    Background {
        id: behind
        anchors.fill: parent
        source: config.background
        fillMode: Image.Stretch
        onStatusChanged: {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }
    }

    FastBlur {
        anchors.fill: behind
        source: behind
        radius: 32
    }

    Rectangle {
        id: shroud
        anchors.fill: parent
        color: "#040a0e"
        opacity: 0.4
    }

    Rectangle {
        id: rightblob
        color: "transparent"
        anchors.top: parent.top
        anchors.right: parent.right
        height: parent.height
        width: parent.width / 3

        Column {
            id: inputstack
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            spacing: 6

            Text {
                id: userlabel
                font.family: "Noto Sans"
                font.pixelSize: 11
                text: textConstants.userName
                color: "#f8f8f8"
            }

            Image {
                source: "images/input.svg"
                width: 240
                height :28
                TextField {
                    id: nameinput
                    focus: true
                    font.family: "Noto Sans"
                    anchors.fill: parent
                    text: userModel.lastUser
                    font.pixelSize: 13
                    color: "white"
                    background: Image {
                        id: textback
                        source: "images/inputhi.svg"

                        states: [
                            State {
                                name: "yay"
                                PropertyChanges {target: textback; opacity: 1}
                            },
                            State {
                                name: "nay"
                                PropertyChanges {target: textback; opacity: 0}
                            }
                        ]

                        transitions: [
                            Transition {
                                to: "yay"
                                NumberAnimation { target: textback; property: "opacity"; from: 0; to: 1; duration: 200; }
                            },

                            Transition {
                                to: "nay"
                                NumberAnimation { target: textback; property: "opacity"; from: 1; to: 0; duration: 200; }
                            }
                        ]
                    }

                    KeyNavigation.tab: password
                    KeyNavigation.backtab: session

                    Keys.onPressed: {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            password.focus = true
                        }
                    }

                    onActiveFocusChanged: {
                        if (activeFocus) {
                            textback.state = "yay"
                        } else {
                            textback.state = "nay"
                        }
                    }
                }
            }

            Text {
                id: passwordlabel
                text: textConstants.password
                color: "#f8f8f8"
                font.pixelSize: 11
                font.family: "Noto Sans"
            }

            Image {
                source: "images/input.svg"
                width: 240
                height :28
                TextField {
                    id: password
                    font.family: "Noto Sans"
                    anchors.fill: parent
                    font.pixelSize: 13
                    echoMode: TextInput.Password
                    color: "white"

                    background: Image {
                        id: textback1
                        source: "images/inputhi.svg"

                        states: [
                            State {
                                name: "yay1"
                                PropertyChanges {target: textback1; opacity: 1}
                            },
                            State {
                                name: "nay1"
                                PropertyChanges {target: textback1; opacity: 0}
                            }
                        ]

                        transitions: [
                            Transition {
                                to: "yay1"
                                NumberAnimation { target: textback1; property: "opacity"; from: 0; to: 1; duration: 200; }
                            },

                            Transition {
                                to: "nay1"
                                NumberAnimation { target: textback1; property: "opacity"; from: 1; to: 0; duration: 200; }
                            }
                        ]
                    }

                    KeyNavigation.tab: session
                    KeyNavigation.backtab: nameinput

                    Keys.onPressed: {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            sddm.login(nameinput.text, password.text, sessionIndex)
                            event.accepted = true
                        }
                    }

                    onActiveFocusChanged: {
                        if (activeFocus) {
                            textback1.state = "yay1"
                        } else {
                            textback1.state = "nay1"
                        }
                    }
                }
            }

        }

        Image {
            id: loginButton
            source: "images/buttonup.svg"
            anchors.right: inputstack.right
            anchors.top: inputstack.bottom
            anchors.topMargin: 32
            width: 84
            height: 28

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.source = "images/buttonhover.svg"
                }
                onExited: {
                    parent.source = "images/buttonup.svg"
                }
                onPressed: {
                    parent.source = "images/buttondown.svg"
                    sddm.login(nameinput.text, password.text, sessionIndex)
                }
                onReleased: {
                    parent.source = "images/buttonup.svg"
                }
            }

            Text {
                text: textConstants.login
                anchors.centerIn: parent
                font.family: "Noto Sans"
                font.pixelSize: 10
                color: "white"
            }
        }
    }

    Rectangle {
        id: leftblob
        color: "transparent"
        anchors.top: parent.top
        anchors.left: parent.left
        height: parent.height
        width: parent.width / 3

        Column {
            id: leftstack
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            spacing: 22
            Clock2 {
                id: clock
                anchors.right: parent.right
                color: "white"
                timeFont.family: "Noto Sans"
                dateFont.family: "Noto Sans"
            }
            ComboBox {
                id: session
                anchors.right: parent.right
                color: "#3b3749"
                borderColor: "#575268"
                hoverColor: "#e64f27"
                focusColor: "#f8724f"
                textColor: "#f8f8f8"
                menuColor: "#3b3749"
                arrowColor: "#3b3749"
                borderWidth: 1
                width: 220
                height: 30
                font.pixelSize: 11
                font.family: "Noto Sans"
                arrowIcon: "images/comboarrow.svg"
                model: sessionModel
                index: sessionModel.lastIndex
                KeyNavigation.backtab: password
                KeyNavigation.tab: nameinput
            }
        }
    }

        Image {
            id: shutdownButton
            source: "images/shutdown.svg"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 12
            anchors.bottomMargin: 8
            height: 28
            width: 28

            property string toolTipText1: textConstants.shutdown
            ToolTip.text: toolTipText1
            ToolTip.delay: 500
            ToolTip.visible: toolTipText1 ? ma1.containsMouse: false

            MouseArea {
                id: ma1
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.source = "images/shutdownhover.svg"
                }
                onExited: {
                    parent.source = "images/shutdown.svg"
                }
                onPressed: {
                    parent.source = "images/shutdownpressed.svg"
                    sddm.powerOff()
                }
                onReleased: {
                    parent.source = "images/shutdown.svg"
                }
            }
        }

        Image {
            id: rebootButton
            source: "images/reboot.svg"
            anchors.right: shutdownButton.left
            anchors.bottom: parent.bottom
            anchors.rightMargin: 12
            anchors.bottomMargin: 8
            height: 28
            width: 28

            property string toolTipText2: textConstants.reboot
            ToolTip.text: toolTipText2
            ToolTip.delay: 500
            ToolTip.visible: toolTipText2 ? ma2.containsMouse: false


            MouseArea {
                id: ma2
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    parent.source = "images/reboothover.svg"
                }
                onExited: {
                    parent.source = "images/reboot.svg"
                }
                onPressed: {
                    parent.source = "images/rebootpressed.svg"
                    sddm.reboot()
                }
                onReleased: {
                    parent.source = "images/reboot.svg"
                }
            }
        }

    Rectangle {
        id: titleblob
        color: "transparent"
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height /3
        width: parent.width

        Column {
            id: headingstack
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 7

            Text {
                id: lblSession
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Welcome to Plasma-Desktop"
                // text: textConstants.welcomeText.arg(sddm.hostName)
                font.pixelSize: 26
                font.family: "Noto Sans"
                color: "#f8f8f8"
            }

            Text {
                id: errorMessage
                anchors.horizontalCenter: parent.horizontalCenter
                text: textConstants.prompt
                font.family: "Noto Sans"
                font.pixelSize: 11
                color: "#f8f8f8"
            }
        }
    }

    Component.onCompleted: {
        nameinput.focus = true
        textback1.state = "nay1"  //dunno why both inputs get focused
    }
}
