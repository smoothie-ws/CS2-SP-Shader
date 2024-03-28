import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

Button {
    id: root

    padding: 4
    opacity: enabled ? 1.0 : 0.3

    background: Rectangle {
        anchors.fill: parent
        color: root.hovered ? "#333333" : "#2d2d2d"
        border.color: root.checked ? "#378ef0" : "#4e4e4e"
        border.width: 1
        radius: 5
    }

    contentItem: RowLayout {
        spacing: 8

        Image {
            source: root.icon.source
            sourceSize.width: root.icon.width
            sourceSize.height: root.icon.height
            visible: root.icon.source !== ""
            opacity: root.hovered ? 1.0 : 0.75
        }

        Text {
            visible: root.text != ""
            text: root.text
            font: root.font
            color: root.hovered ? "#378ef0" : "#cfcfcf"
            verticalAlignment: Text.AlignVCenter
            padding: 2
        }
    }
}