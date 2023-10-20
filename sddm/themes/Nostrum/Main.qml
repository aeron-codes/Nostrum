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
            errorMessage.text = textConstants.loginSucceeded
        }
        function onLoginFailed() {
            password.text = ""
            errorMessage.color = "#f8724f"
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
                font.pointSize : 10
                // verticalAlignment: TextInput.AlignCenter
                color : "white"

                background : Image {
                    source : "images/input.svg"
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
                font.pointSize : 10
                echoMode : TextInput.Password
                font.family : loginfont.name
                color : "white"
                width : 280
                height : 32

                background : Image {
                    source : "images/input.svg"
                }

                KeyNavigation.backtab : nameinput
                KeyNavigation.tab : loginButton
                focus : true

                Keys.onPressed : {
                    if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                        sddm.login(nameinput.text, password.text, sessionIndex)
                        event.accepted = true
                    }
                }
            }

        }

        Image {
            id : loginButton
            source : "images/buttonup.svg"
            anchors.right : inputstack.right
            anchors.top: inputstack.bottom
            anchors.topMargin: 32
            width: 84
            height: 28

            MouseArea {
                anchors.fill : parent
                hoverEnabled : true
                onEntered : {
                    parent.source = "images/buttonhover.svg"
                }
                onExited : {
                    parent.source = "images/buttonup.svg"
                }
                onPressed : {
                    parent.source = "images/buttondown.svg"
                    sddm.login(nameinput.text, password.text, sessionIndex)
                }
                onReleased : {
                    parent.source = "images/buttonup.svg"
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
        color: "transparent"
        anchors.top: parent.top
        anchors.left: parent.left
        height: parent.height
        width: parent.width / 3

        Column {
            id: leftstack
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            spacing: 16
            Clock2 {
                id: clock
                anchors.right: parent.right
                color: "white"
                timeFont.family: promptfont.name
                dateFont.family: loginfont.name
            }
            ComboBox {
                id : session
                anchors.right : parent.right
                color : "#3b3749"
                borderColor : "#353242"
                hoverColor : "#f8724f"
                focusColor : "#f8724f"
                textColor : "#f8f8f8"
                menuColor : "#3b3749"
                width : 180
                height : 30
                font.pointSize : 10
                font.family : loginfont.name
                arrowIcon : "images/comboarrow.svg"
                model : sessionModel
                index : sessionModel.lastIndex
                KeyNavigation.backtab : nameinput
                KeyNavigation.tab : password
            }
        }
    }

        Image {
            id : shutdownButton
            source : "images/shutdown.svg"
            anchors.right : parent.right
            anchors.bottom : parent.bottom
            anchors.rightMargin : 12
            anchors.bottomMargin: 8

            MouseArea {
                anchors.fill : parent
                hoverEnabled : true
                onEntered : {
                    parent.source = "images/shutdownhover.svg"
                }
                onExited : {
                    parent.source = "images/shutdown.svg"
                }
                onPressed : {
                    parent.source = "images/shutdownpressed.svg"
                    sddm.powerOff()
                }
                onReleased : {
                    parent.source = "images/shutdown.svg"
                }
            }

            KeyNavigation.backtab : rebootButton
            KeyNavigation.tab : rebootButton
        }

        Image {
            id : rebootButton
            source : "images/reboot.svg"
            anchors.right : shutdownButton.left
            anchors.bottom : parent.bottom
            anchors.rightMargin : 12
            anchors.bottomMargin: 8

            MouseArea {
                anchors.fill : parent
                hoverEnabled : true
                onEntered : {
                    parent.source = "images/reboothover.svg"
                }
                onExited : {
                    parent.source = "images/reboot.svg"
                }
                onPressed : {
                    parent.source = "images/rebootpressed.svg"
                    sddm.reboot()
                }
                onReleased : {
                    parent.source = "images/reboot.svg"
                }
            }

            KeyNavigation.backtab : shutdownButton
            KeyNavigation.tab : shutdownButton
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
                id : lblSession
                anchors.horizontalCenter : parent.horizontalCenter
                text : textConstants.welcomeText.arg(sddm.hostName)
                font.pointSize : 24
                font.family : loginfont.name
                color : "#f8f8f8"
            }

            Text {
                id: errorMessage
                anchors.horizontalCenter: parent.horizontalCenter
                text: textConstants.prompt
                font.family : loginfont.name
                font.pointSize: 10
                color : "#f8f8f8"
            }
        }
    }
}
