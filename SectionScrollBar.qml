import QtQuick 2.0
import QtQuick.Controls 2.2

ScrollBar {
    snapMode: ScrollBar.SnapAlways
    property ListView listView: parent
    stepSize: (1 / listView.count) / (1 - size)
    SectionScrollIndicator {
        property bool favoriteSection: section === "*"
        text: favoriteSection ? "" : section
        ColorImage {
            visible: parent.favoriteSection
            anchors.centerIn: parent
            sourceSize: Qt.size(40, 40)
            color: "white"
            source: "star.svg"
        }
    }
}
