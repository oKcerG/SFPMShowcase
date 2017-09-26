import QtQuick 2.0

Item {
    id: root
    height: 0
    default property alias data: contentItem.data
    property ListView _listView: parent.parent
    property Item _adjacentItem: { _listView.contentY; return _listView.itemAt(0, y); }
    property bool _adjacentItemIsLastOfSection: _adjacentItem ? _adjacentItem.ListView.section !== _adjacentItem.ListView.nextSection && _adjacentItem !== _listView.contentItem.children[0] : false

    Item {
        id: contentItem
        y: _adjacentItemIsLastOfSection ? Math.min(_adjacentItem.y - _listView.contentY, 0) : 0
    }
}
