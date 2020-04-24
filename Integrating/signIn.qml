import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Dialogs 1.1
import AuthManager 1.0

Item{
    id:signIn
    width: parent.width
    height: parent.height
    visible: true

    AuthManager{
        id:authManagerSignIn
        onAuthenticateRequestCompleted: {
            if (error==""){
                loginResult.setText("Вход выполнен")
                registerResult.setInformativeText("")
                console.log(token)
            }
            else{
                loginResult.setText("Вход не выполнен")
                loginResult.setInformativeText(error)
            }
            loginResult.open()
        }
        onLoginProcessingChanged: {
            console.log(isLoginProcessing);
        }
    }

    Text{
        id: titleSignIn
        color: "black"
        text: "Войти в систему"
        font.pixelSize: 30
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
    }

    TextField{
        id:loginSignIn
        width: 250
        font.pixelSize: 16
        placeholderText: "Логин"
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: titleSignIn.bottom
    }

    TextField{
        id:passwordSignIn
        echoMode:TextInput.Password
        width: 250
        font.pixelSize: 16
        placeholderText: "Пароль"
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: loginSignIn.bottom
    }

    Button{
        id: signInButton
        text: "Войти"
        width: 100
        height: 40
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: passwordSignIn.bottom
        anchors.topMargin: 10
        enabled:loginSignIn.length > 5 && passwordSignIn.length > 5
        onClicked:{
            authManagerSignIn.authenticate(loginSignIn.text,passwordSignIn.text)
        }
    }

    BusyIndicator{
        id: loadingIndicator
        anchors.top: signInButton.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        running: authManagerSignIn.isLoginProcessing
    }

    MessageDialog {
        id:loginResult
        title: "Вход"
        onAccepted:
            close()
    }
}
