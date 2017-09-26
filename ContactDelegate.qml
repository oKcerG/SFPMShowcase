import QtQuick 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

ItemDelegate {
    id: delegate

    text: model.firstName + " " + model.lastName

    property var materialColors: ["Red","Pink","Purple","DeepPurple","Indigo","Blue","LightBlue","Cyan","Teal","Green","LightGreen","Lime","Yellow","Amber","Orange","DeepOrange","Brown","Grey","BlueGrey"]
    function randomColor() {
        var colorName = materialColors[Math.floor(Math.random()*materialColors.length)];
        return Qt.darker(Material.color(Material[colorName]), 1.1);
    }

    width: parent ? parent.width : 0
    leftPadding: 48
    rightPadding: 0
    contentItem: RowLayout {
        spacing: 16
        Rectangle {
            id: initialCircle
            height: delegate.height
            width: height
            radius: height/2
            color: randomColor()
            Label {
                color: Qt.rgba(1, 1, 1, 0.5)
                anchors.centerIn: parent
                text: model.firstName[0]
                font.pixelSize: 20
            }
        }
        Label {
            id: label
            Layout.fillWidth: true
            text: delegate.text
        }
    }
    onClicked: model.favorite = !model.favorite
}
