# SFPMShowcase
This project is a sample app showcasing the [SortFilterProxyModel QML library](https://github.com/oKcerG/SortFilterProxyModel/)

It shows the sorting, filtering and custom role features of the above library.
All the logic code is contained in [`main.qml`](main.qml), the other qml files are just here to make the sample app pretty and experiment a bit with some silly ideas.

This sample app features a list of person that you can filter by their name by typing in the top search bar.
You can also toggle the star button in the bar to display only the favorited persons.

By cliking on a person, you toggle its favorite state.

Favorited persons are displayed at the top of the list, and then persons are sorted by their firstname and lastname.

## Preview
![SFPMShowcase preview](https://i.imgur.com/aM5m63o.gif)

## Explanation
### Source model
```qml
SortFilterProxyModel {
    id: proxyModel
    sourceModel: contactModel
    ...
}
```
The [`SortFilterProxyModel`](https://okcerg.github.io/SortFilterProxyModel/qml-sortfilterproxymodel.html) needs a [`sourceModel`](https://okcerg.github.io/SortFilterProxyModel/qml-sortfilterproxymodel.html#sourceModel-prop) to get its data from, in our case the source model is `contactModel` and is defined in [`ContactModel.qml`](ContactModel.qml).

This source model has 3 roles: 2 string roles named `firstName` and `lastName`, and 1 boolean role named `favorite`.

### Sorting
```qml
sorters: [
    RoleSorter { roleName: "favorite"; sortOrder: Qt.DescendingOrder },
    StringSorter { roleName: "firstName" },
    StringSorter { roleName: "lastName" }
]
```
This sorts the source model using 3 ordered criteria.

The [`SortFilterProxyModel`](https://okcerg.github.io/SortFilterProxyModel/qml-sortfilterproxymodel.html) will first sort the rows by their `favorite` role, and if 2 rows have the same `favorite` role it will sort by the `firstName` role. If those 2 criteria are not enough to differentiate a pair of rows, it will finally sort them by the `lastName` role.

### Filtering
```qml
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
```
To accept a row from the source model in the proxy model, all the top level `filters` must accept that row.
Here we have 2 top level filters : [`ValueFilter`](https://okcerg.github.io/SortFilterProxyModel/qml-valuefilter.html) and [`AnyOf`](https://okcerg.github.io/SortFilterProxyModel/qml-anyof.html).

The [`ValueFilter`](https://okcerg.github.io/SortFilterProxyModel/qml-valuefilter.html) will only accept rows with a `favorite` role set to `true`.

The [`AnyOf`](https://okcerg.github.io/SortFilterProxyModel/qml-anyof.html) is a filter container, it will accept a row if it's accepted by any of its child filters.
The [`RegExpFilter`](https://okcerg.github.io/SortFilterProxyModel/qml-regexpfilter.html)s will accept a row if its data from the matching role (respectively `firstName` and `lastName`) starts with the text typed in the `searchBar`.

### Custom Role
```qml
proxyRoles: SwitchRole {
    name: "sectionRole"
    filters: ValueFilter {
        roleName: "favorite"
        value: true
        SwitchRole.value: "*"
    }
    defaultRoleName: "firstName"
}
```
A [`ProxyRole`](https://okcerg.github.io/SortFilterProxyModel/qml-proxyrole.html) is a custom role served by the [`SortFilterProxyModel`](https://okcerg.github.io/SortFilterProxyModel/qml-sortfilterproxymodel.html) on top of the roles provided by the source model. The [`name`](https://okcerg.github.io/SortFilterProxyModel/qml-proxyrole.html#name-prop) property is the role name used to query the data for this role.

[`SwitchRole`](https://okcerg.github.io/SortFilterProxyModel/qml-switchrole.html) is a role which use child filters to evaluate its data. If one of its filter accepts a row, the data for this row will be the one of the filter's [`SwitchRole.value`](https://okcerg.github.io/SortFilterProxyModel/qml-switchrole.html#value-attached-prop) attached property.
If no filter accepts a row, the data for this row will be the one of the role specified by [`defaultRoleName`](https://okcerg.github.io/SortFilterProxyModel/qml-switchrole.html#defaultRoleName-prop) (or the static [`defaultValue`](https://okcerg.github.io/SortFilterProxyModel/qml-switchrole.html#defaultValue-prop)).

In our case the role named `sectionRole` will evaluate to `*` if a row has its `favorite` role set to `true`, otherwise it will default to the same data as the role named `firstName`.
This is used to provide a role for the `ListView` section property, enabling us to do a section on 2 roles:

```qml
section {
    property: "sectionRole"
    criteria: ViewSection.FirstCharacter
    ...
}
```
