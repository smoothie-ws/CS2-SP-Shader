import QtQuick 2.7
import QtQuick.Controls 2.0
import AlgWidgets.Style 2.0


ComboBox {
    id: root
    height: 25

    background: Rectangle {
        anchors.fill: parent
        color: root.hovered ? "#333333" : "#2d2d2d"
        border.color: root.checked ? "#378ef0" : "#4e4e4e"
        border.width: 1
        radius: 15
    }

    contentItem: Label {
        id: contentLabel
        text: root.displayText
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        leftPadding: 10
        elide: Text.ElideRight
        color: "#cfcfcf"
    }

    indicator: Image {
        visible: root.menu !== null
        source: AlgStyle.icons.combobox.dropArrow
        y: root.topPadding + (root.availableHeight - height) / 2
        anchors.right: parent.right
        anchors.rightMargin: 10
    }
    
    popup: Popup {
        id: popupMenu
        width: root.width
        height: 150

        background: Rectangle {
            color: "#333333"
            border.color: "#4e4e4e"
            border.width: 1
            radius: 13
        }

        ListView {
            id: listContent
            model: root.model
            anchors.fill: parent
            clip: true
            spacing: 0

            delegate: Rectangle {
                id: listItem
                width: listContent.width
                height: 20
                color: Qt.rgba(0, 0, 0, 0)
                radius: 15

                Label {
                    id: itemLabel
                    x: 10 * scale
                    y: parent.height / 2 - height / 2
                    text: root.textRole === '' ? modelData : (Array.isArray(root.model) ? modelData[root.textRole] : model[root.textRole])
                    color: "#cfcfcf"
                }
                
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        listItem.color = Qt.rgba(1, 1, 1, 0.05)
                        itemLabel.scale = 1.2
                    }

                    onExited: {
                        listItem.color = Qt.rgba(0, 0, 0, 0)
                        itemLabel.scale = 1
                    }

                    onClicked: {
                        root.activated(index)
                        root.currentIndex = index
                        popupMenu.close()
                    }
                }
            }
        }
    }
}
