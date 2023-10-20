import QtQuick 2.15
import QtGraphicalEffects 1.12
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4 as Q1
import QtQuick.Controls.Styles 1.4
import SddmComponents 2.0
import "."

Rectangle {
    id : container
    LayoutMirroring.enabled : Qt.locale().textDirection == Qt.RightToLeft
    LayoutMirroring.childrenInherit : true
    property int sessionIndex : session.index

    TextConstants { id : textConstants }

    FontLoader { id : loginfont; source : "fonts/RedHatText-Regular.otf" }
    FontLoader { id : promptfont; source : "fonts/RedHatText-Light.otf" }

    Connections {
        target : sddm
        function onLoginSucceeded() {
            errorMessage.color = "green"
            errorMessage.text = textConstants.loginSucceeded
        }
        function onLoginFailed() {
            password.text = ""
            errorMessage.color = "red"
            errorMessage.text = textConstants.loginFailed
            errorMessage.bold = true
        }
    }

    color : "#1e1c2c"
    anchors.fill : parent

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
            spacing: 7

            Text {
                id: userlabel
                font.family: promptfont.name
                font.pointSize: 10
                text: textConstants.userName
                color: "white"
            }

            TextField {
                id : nameinput
                font.family : loginfont.name
                font.weight: Font.Normal
                width : 280
                height : 32
                text : userModel.lastUser
                font.pointSize : 12
                verticalAlignment: TextInput.AlignBottom
                color : "white"

                background : Image {
                    source : "input.svg"
                }

                KeyNavigation.tab : password

                Keys.onPressed : {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        password.focus = true
                        event.accepted = true
                    }
                }
            }

            Text {
                id : passwordlabel
                text : textConstants.password
                color : "white"
                font.pointSize : 10
                font.family : promptfont.name
            }

            TextField {
                id : password
                font.pointSize : 12
                echoMode : TextInput.Password
                font.family : loginfont.name
                font.italic : true
                color : "white"
                width : 280
                height : 32

                background : Image {
                    source : "input.svg"
                }

                KeyNavigation.backtab : nameinput
                KeyNavigation.tab : loginButton
                focus : true

                Keys.onPressed : {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        sddm.login(name.text, password.text, sessionIndex)
                        event.accepted = true
                    }
                }
            }

        }

        Image {
            id : loginButton
            source : "buttonup.svg"
            anchors.right : inputstack.right
            anchors.top: inputstack.bottom
            anchors.topMargin: 32
            width: 84
            height: 28

            MouseArea {
                anchors.fill : parent
                hoverEnabled : true
                onEntered : {
                    parent.source = "buttonhover.svg"
                }
                onExited : {
                    parent.source = "buttonup.svg"
                }
                onPressed : {
                    parent.source = "buttondown.svg"
                    sddm.login(name.text, password.text, sessionIndex)
                }
                onReleased : {
                    parent.source = "buttonup.svg"
                }
            }

            Text {
                text : textConstants.login
                anchors.centerIn : parent
                font.family : loginfont.name
                font.pointSize : 8
                color : "white"
            }

            KeyNavigation.backtab : password
            KeyNavigation.tab : shutdownButton
        }
    }

    Rectangle {
        id: leftblob
        color: "green"
        anchors.top: parent.top
        anchors.left: parent.left
        height: parent.height
        width: parent.width / 3
    }



    // Rectangle {
    //     anchors.bottom : promptbox.bottom
    //     anchors.horizontalCenter : promptbox.horizontalCenter
    //     width : 598
    //     height : 48
    //     color: "transparent"
    //     // source : "header.svg"
    //     Text {
    //         height : 30
    //         id : lblSession
    //         width : 48
    //         anchors.left : parent.left
    //         anchors.verticalCenter : parent.verticalCenter
    //         anchors.leftMargin : 8
    //         text : textConstants.session
    //         font.pointSize : 9
    //         font.italic : true
    //         font.family : loginfont.name
    //         verticalAlignment : Text.AlignVCenter
    //         color : "#212121"
    //     }
    //
    //     ComboBox {
    //         id : session
    //         anchors.left : parent.left
    //         anchors.verticalCenter : parent.verticalCenter
    //         anchors.leftMargin : 64
    //         color : "#e1e1e1"
    //         borderColor : "#777777"
    //         hoverColor : "#9ebfbf"
    //         focusColor : "#9ebfbf"
    //         textColor : "black"
    //         menuColor : "#e1e1e1"
    //         width : 164
    //         height : 22
    //         font.pointSize : 9
    //         font.italic : true
    //         font.family : loginfont.name
    //         arrowIcon : "comboarrow.svg"
    //         model : sessionModel
    //         index : sessionModel.lastIndex
    //         KeyNavigation.backtab : name
    //         KeyNavigation.tab : password
    //     }
    //     Image {
    //         id : shutdownButton
    //         source : "buttonup.svg"
    //         anchors.right : parent.right
    //         anchors.verticalCenter : parent.verticalCenter
    //         anchors.rightMargin : 8
    //         height : 24
    //         MouseArea {
    //             anchors.fill : parent
    //             hoverEnabled : true
    //             onEntered : {
    //                 parent.source = "buttonhover.svg"
    //             }
    //             onExited : {
    //                 parent.source = "buttonup.svg"
    //             }
    //             onPressed : {
    //                 parent.source = "buttondown.svg"
    //                 sddm.powerOff()
    //             }
    //             onReleased : {
    //                 parent.source = "buttonup.svg"
    //             }
    //         }
    //         Text {
    //             text : textConstants.shutdown
    //             anchors.centerIn : parent
    //             font.family : loginfont.name
    //             font.italic : true
    //             font.pixelSize : 12
    //             color : "#212121"
    //         }
    //         KeyNavigation.backtab : rebootButton
    //         KeyNavigation.tab : shutdownButton
    //     }
    //     Image {
    //         id : rebootButton
    //         source : "buttonup.svg"
    //         anchors.right : parent.right
    //         anchors.verticalCenter : parent.verticalCenter
    //         anchors.rightMargin : 100
    //         height : 24
    //         MouseArea {
    //             anchors.fill : parent
    //             hoverEnabled : true
    //             onEntered : {
    //                 parent.source = "buttonhover.svg"
    //             }
    //             onExited : {
    //                 parent.source = "buttonup.svg"
    //             }
    //             onPressed : {
    //                 parent.source = "buttondown.svg"
    //                 sddm.reboot()
    //             }
    //             onReleased : {
    //                 parent.source = "buttonup.svg"
    //             }
    //         }
    //         Text {
    //             text : textConstants.reboot
    //             anchors.centerIn : parent
    //             font.family : loginfont.name
    //             font.italic : true
    //             font.pixelSize : 12
    //             color : "#212121"
    //         }
    //         KeyNavigation.backtab : password
    //         KeyNavigation.tab : shutdownButton
    //     }
    // }
}
