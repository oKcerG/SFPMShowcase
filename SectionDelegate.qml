import QtQuick 2.7
import QtQuick.Controls 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls.Material 2.0

AdjacentSection {
    property bool favoriteSection: section === "*"
    Item {
        width: 48
        height: listView.contentHeight / listView.count
        Label {
            visible: !favoriteSection
            anchors.centerIn: parent
            text: section
        }
        ColorImage {
            visible: favoriteSection
            anchors.centerIn: parent
            source: "star.svg"
            color: Material.color(Material.Amber)
        }
    }
}
