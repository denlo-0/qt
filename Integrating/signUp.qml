import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import AuthManager 1.0

Item{
    id: signUp
    width: parent.width
    height: parent.height
    visible: true

    AuthManager{
        id:authManagerSignUp
        onRegistererRequestCompleted: {
            if (error==""){
                registerResult.setText("Регистрация выполненна")
                registerResult.setInformativeText("")
            }
            else{
                registerResult.setText("Регистрация не выполнен")
                registerResult.setInformativeText(error)
            }
            registerResult.open()
        }
        onRegisterProcessingChanged: {
            console.log(isRegisterProcessing);
        }
    }

    Text{
        id: titleSignUp
        color: "black"
        text: "Зарегестрироваться"
        font.pixelSize: 30
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

    TextField{
        id:loginSignUp
        width: 250
        font.pixelSize: 16
        placeholderText: "Введите логин"
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: titleSignUp.bottom
    }

    TextField{
        id:passwordSignUp
        echoMode:TextInput.Password
        width: 250
        font.pixelSize: 16
        placeholderText: "Введите пароль"
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: loginSignUp.bottom
    }

    TextField{
        id:passwordCheckSignUp
        echoMode:TextInput.Password
        width: 250
        font.pixelSize: 16
        placeholderText: "Повторите пароль"
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: passwordSignUp.bottom
    }

    TextField{
        id:nickName
        width: 250
        font.pixelSize: 16
        placeholderText: "Введите псевдоним"
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: passwordCheckSignUp.bottom
    }

    Button{
        id: signUpButton
        width: 150
        height: 40
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.topMargin: 10
        anchors.top: nickName.bottom
        text: "Зарегестрироваться"
        enabled: loginSignUp.length > 5 && nickName.length > 5 && passwordSignUp.length > 5 && passwordCheckSignUp.length > 5
        onClicked:{
            if (passwordSignUp.text != passwordCheckSignUp.text){
                passwordWarning.visible = true
            }
            else{
                passwordWarning.visible = false
                authManagerSignUp.registering(loginSignUp.text,passwordSignUp.text)
            }
        }
    }

    Text{
        id: passwordWarning
        text: "Пароли отличаются"
        font.pixelSize: 16
        visible: false
        anchors.top: signUpButton.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        color: "red"
    }

    BusyIndicator{
        id: loadingIndicator
        anchors.top: signUpButton.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        running: authManagerSignUp.isRegisterProcessing
    }

    MessageDialog {
        id:registerResult
        title: "Регистрация"
        onAccepted:
            close()
    }
}
