import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.1
import SortFilterProxyModel 0.2
import QtQuick.Controls.Material 2.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("SFPM Showcase")

    ContactModel {
        id: contactModel
    }

    SortFilterProxyModel {
        id: proxyModel
        sourceModel: contactModel
        sorters: [
            RoleSorter { roleName: "favorite"; sortOrder: Qt.DescendingOrder },
            StringSorter { roleName: "firstName" },
            StringSorter { roleName: "lastName" }
        ]
        filters: [
            ValueFilter {
                id: favoriteFilter
                roleName: "favorite"
                enabled: searchBar.filterFavorite
                value: true
            },
            AnyOf {
                RegExpFilter {
                    roleName: "firstName"
                    pattern: "^" + searchBar.text
                    caseSensitivity: Qt.CaseInsensitive
                }
                RegExpFilter {
                    roleName: "lastName"
                    pattern: "^" + searchBar.text
                    caseSensitivity: Qt.CaseInsensitive
                }
            }
        ]
        proxyRoles: SwitchRole {
            name: "sectionRole"
            filters: ValueFilter {
                roleName: "favorite"
                value: true
                SwitchRole.value: "*"
            }
            defaultRoleName: "firstName"
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        SearchBar {
            id: searchBar
            Layout.fillWidth: true
            z: 1
        }

        ListView {
            id: listView
            Layout.fillWidth: true
            Layout.fillHeight: true
            //snapMode: ListView.SnapToItem

            model: proxyModel

            delegate: ContactDelegate { }
            section {
                property: "sectionRole"
                criteria: ViewSection.FirstCharacter
                labelPositioning: ViewSection.InlineLabels | ViewSection.CurrentLabelAtStart
                delegate: SectionDelegate { }
            }
            ScrollBar.vertical: SectionScrollBar { }
        }
    }
}
