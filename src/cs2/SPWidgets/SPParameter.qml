import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3
import Painter 1.0
import AlgWidgets 2.0
import "../shader.js" as Shader

Item {
    id: root
    implicitHeight: __contentItem.height
    default property alias children: __contentItem.sourceComponent
    property alias control: __contentItem.item
    property alias text: label.text
    property string parameter: ""
    property string key: ""
    property var defaultValue: null
    property int shaderID: 0
    property real spacing: 10
    property real __separatorX: label.text !== "" ? label.width + spacing : 0
    property real availableWidth: width - (__separatorX + (resettable ? resetButton.width : 0))
    property bool isChanged: false
    property alias resettable: resetButton.visible

    AlgLabel { id: label; y: __contentItem.height / 2 - height / 2 }

    Loader {
        id: __contentItem
        x: root.__separatorX
        width: root.availableWidth - spacing
        onLoaded: {
            if (key !== "" && parameter !== "") {
                Shader.connect(item, key, alg.shaders.parameter(shaderID, parameter));
                root.defaultValue = item[key];
                item[key + "Changed"].connect(function(){ root.isChanged = root.defaultValue != item[key]; })
            }
        }
    }

    SPButton {
        id: resetButton
        Layout.alignment: Qt.AlignRight
        x: root.width - width
        y: __contentItem.height / 2 - height / 2
        enabled: root.isChanged && root.key !== "" && parameter !== ""
        icon.source: "../icons/icon_cycle.png"
        icon.width: 14
        icon.height: 14
        background: null
        onClicked: __contentItem.item[root.key] = root.defaultValue
    }
}