import QtQuick 2.0

Text{
    id: clickableText
    color: "black"
    font.pixelSize: 20
    height: 30
    signal clicked()

    MouseArea {
        anchors.fill:parent
        cursorShape: Qt.PointingHandCursor
        onClicked:{
            clickableText.clicked()
        }
    }
}
