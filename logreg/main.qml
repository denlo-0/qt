import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Авторизация")

    property string loaderForm : "up"

    Loader{
        id:mainLoader
        anchors.fill: parent
        anchors.bottom: mainRow.bottom
        source: (loaderForm=="in")
            ? ("signIn.qml")
            : ("signUp.qml")
    }

    Row{
        id: mainRow
        spacing: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.margins: 10


        ClickableText{
            font.underline: loaderForm=="in"
            id: signInChoice
            text: qsTr("Вход")
            onClicked:{
                loaderForm="in"
                console.log("signIn")
            }
        }

        Text{
            id: slash
            text: qsTr(" / ")
            color: "black"
            width: 20
            height: 30
            font.pixelSize: 20
        }

        ClickableText{
            font.underline: loaderForm=="up"
            width: 100
            id: signUpChoice
            text: qsTr("Регистрация")
            onClicked:{
                loaderForm="up"
                console.log("signUp")
            }
        }
    }
}


