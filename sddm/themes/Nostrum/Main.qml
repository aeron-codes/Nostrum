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
    TextConstants {
        id : textConstants
    }
    FontLoader {
        id : loginfont
        source : "fonts/RedHatText-Regular.otf"
    }
    FontLoader {
        id : promptfont
        source : "fonts/RedHatText-Light.otf"
    }
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
    color : "#4c719e"
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
        color: "#1e1c2c"
        opacity: 0.5
    }

    Rectangle {
        color: "transparent"
        anchors.top: parent.top
        anchors.right: parent.right
        height: parent.height
        width: parent.width / 3

        Column {
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            spacing: 8

            Text {
                // anchors.left: parent.left
                // anchors.verticalCenter: parent.verticalCenter
                font.family: promptfont.name
                font.weight: Font.Light
                font.pointSize: 10
                text: textConstants.userName
                color: "#f8f6fc"
            }
            TextField {
                id : nameinput
                font.family : loginfont.name
                // font.italic : true
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
                // background: Rectangle {
                //     color: "#1e1c2c"
                //     height: 32
                //     width: 280
                //     opacity: 0.6
                // }
                KeyNavigation.tab : password
                Keys.onPressed : {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        password.focus = true
                        event.accepted = true
                    }
                }
            }
        }
    }


    
//     Image {
//         anchors.centerIn : parent
//         id : promptbox
//         source : "promptbox.svg"
//         width : 640
//         height : 360
//
//         Rectangle {
//                 anchors.top : promptbox.top
//                 anchors.horizontalCenter : promptbox.horizontalCenter
//                 width : 598
//                 height : 48
//                 color: "transparent"
//             Clock2 {
//                 id : clock
//                 color : "black"
//                 timeFont.family : loginfont.name
//                 anchors.left: parent.left
//                 anchors.verticalCenter: parent.verticalCenter
//             }
//         }
//
//         Column {
//             id : entryColumn
//             anchors.horizontalCenter : parent.horizontalCenter
//             anchors.verticalCenter : parent.verticalCenter
//             spacing : 4
//             Text {
//                 color : "#1717e7"
//                 text : textConstants.welcomeText.arg(sddm.hostName)
//                 font.family : loginfont.name
//                 font.italic : true
//                 font.pointSize : 15
//                 bottomPadding : 9
//             }
//             Text {
//                 id : errorMessage
//                 text : textConstants.prompt
//                 font.pointSize : 7
//                 color : "#212121"
//                 font.family : loginfont.name
//                 font.italic : true
//                 bottomPadding : 7
//             }
//             Row {
//                 spacing : 32
//                 Text {
//                     id : lblLoginName
//                     height : 32
//                     width : 72
//                     text : textConstants.userName
//                     font.pointSize : 9
//                     font.italic : true
//                     verticalAlignment : Text.AlignVCenter
//                     color : "#212121"
//                     font.family : loginfont.name
//                 }
//                 TextField {
//                     id : name
//                     font.family : loginfont.name
//                     font.italic : true
//                     width : 292
//                     height : 28
//                     text : userModel.lastUser
//                     font.pointSize : 10
//                     color : "#2f2424"
//                     background : Image {
//                         source : "input.svg"
//                     }
//                     KeyNavigation.tab : password
//                     Keys.onPressed : {
//                         if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
//                             password.focus = true
//                             event.accepted = true
//                         }
//                     }
//                 }
//             }
//             Row {
//                 spacing : 32
//                 Text {
//                     id : lblLoginPassword
//                     height : 32
//                     width : 72
//                     text : textConstants.password
//                     verticalAlignment : Text.AlignVCenter
//                     color : "#212121"
//                     font.pointSize : 9
//                     font.italic : true
//                     font.family : loginfont.name
//                 }
//                 TextField {
//                     id : password
//                     font.pointSize : 10
//                     echoMode : TextInput.Password
//                     font.family : loginfont.name
//                     font.italic : true
//                     color : "#2f2424"
//                     width : 292
//                     height : 28
//                     background : Image {
//                         source : "input.svg"
//                     }
//                     KeyNavigation.backtab : name
//                     KeyNavigation.tab : loginButton
//                     focus : true
//                     Keys.onPressed : {
//                         if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
//                             sddm.login(name.text, password.text, sessionIndex)
//                             event.accepted = true
//                         }
//                     }
//                 }
//             }
//             Image {
//                 id : loginButton
//                 source : "buttonup.svg"
//                 anchors.right : parent.right
//                 MouseArea {
//                     anchors.fill : parent
//                     hoverEnabled : true
//                     onEntered : {
//                         parent.source = "buttonhover.svg"
//                     }
//                     onExited : {
//                         parent.source = "buttonup.svg"
//                     }
//                     onPressed : {
//                         parent.source = "buttondown.svg"
//                         sddm.login(name.text, password.text, sessionIndex)
//                     }
//                     onReleased : {
//                         parent.source = "buttonup.svg"
//                     }
//                 }
//                 Text {
//                     text : textConstants.login
//                     anchors.centerIn : parent
//                     font.family : loginfont.name
//                     font.italic : true
//                     font.pointSize : 9
//                     color : "#404040"
//                 }
//                 KeyNavigation.backtab : password
//                 KeyNavigation.tab : shutdownButton
//             }
//
//         }
//     }
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
