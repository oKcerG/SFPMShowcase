import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.1

Rectangle {
    id: root
    property ScrollBar scrollBar: parent
    property ListView listView: parent.parent
    readonly property Item _topDelegate: {listView.contentItem.children; return listView.itemAt(0, listView.contentY);}
    readonly property string section: _topDelegate ? _topDelegate.ListView.section : ""
    property alias text: label.text
    visible: scrollBar.pressed
    color: Material.primary
    width: 96
    height: width
    radius: width/2
    x: -width - 16
    y: Math.max(scrollBar.position * scrollBar.height - height + scrollBar.contentItem.height/2, 8)
    Rectangle {
        width: parent.width/2
        height: parent.height/2
        x: width
        y: height
        color: root.color
    }
    Label {
        id: label
        anchors.centerIn: parent
        color: "white"
        font.bold: true
        font.pixelSize: 40
        text: section
    }
}
