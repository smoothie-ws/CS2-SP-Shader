import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.7
import Painter 1.0
import AlgWidgets 2.0
import AlgWidgets.Style 2.0
import "SPWidgets"
import "shader.js" as Shader


Rectangle {
    id: root
    color: AlgStyle.background.color.mainWindow
    height: mainLayout.height
    
    Component.onCompleted: {
        
    }

    ColumnLayout {
        id: mainLayout
        width: parent.width

        Rectangle {
            color: "#212121"
            radius: 10
            Layout.fillWidth: true
            Layout.preferredHeight: 50

            RowLayout {
                anchors.fill: parent
                anchors.centerIn: parent
                anchors.margins: 15

                SPButton {
                    id: enableLivePreview
                    Layout.alignment: Qt.AlignCenter
                    text: "Live Preview"
                    checkable: true
                }

                SPButton {
                    id: enablePBRValidation
                    Layout.alignment: Qt.AlignCenter
                    text: "PBR Validate"
                    checkable: true
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 10
            enabled: enableLivePreview.checked

            GridLayout {
                columns: 2
                columnSpacing: 15
                rowSpacing: 10
                Layout.fillWidth: true

                AlgLabel {
                    text: "Weapon"
                }
                AlgComboBox {
                    Layout.fillWidth: true
                    model: [
                        { text: "AK-47", value: 0 },
                        { text: "AUG", value: 1 },
                        { text: "AWP", value: 2 },
                        { text: "PP-Bizon", value: 3 },
                        { text: "CZ75-Auto", value: 4 },
                        { text: "Desert Eagle", value: 5 },
                        { text: "Dual Berettas", value: 6 },
                        { text: "FAMAS", value: 7 },
                        { text: "Five-SeveN", value: 8 },
                        { text: "Glock-18", value: 9 },
                        { text: "G3SG1", value: 10 },
                        { text: "Galil AR", value: 11 },
                        { text: "MAC-10", value: 12 },
                        { text: "M249", value: 13 },
                        { text: "M4A1-S", value: 14 },
                        { text: "M4A4", value: 15 },
                        { text: "MAG-7", value: 16 },
                        { text: "MP5-SD", value: 17 },
                        { text: "MP7", value: 18 },
                        { text: "MP9", value: 19 },
                        { text: "Negev", value: 20 },
                        { text: "Nova", value: 21 },
                        { text: "P2000", value: 22 },
                        { text: "P250", value: 23 },
                        { text: "P90", value: 24 },
                        { text: "R8 Revolver", value: 25 },
                        { text: "Sawed-Off", value: 26 },
                        { text: "SCAR-20", value: 27 },
                        { text: "SG 553", value: 28 },
                        { text: "SSG 08", value: 29 },
                        { text: "Tec-9", value: 30 },
                        { text: "UMP-45", value: 31 },
                        { text: "USP-S", value: 32 },
                        { text: "XM1014", value: 33 },
                        { text: "Zeus x27", value: 34 }
                    ]
                    textRole: "text"
                }

                AlgLabel {
                    text: "Finish Style"
                }
                AlgComboBox {
                    Layout.fillWidth: true
                    model: [
                        { text: "Solid Color", value: 1 },
                        { text: "Hydrographic", value: 2 },
                        { text: "Spray Paint", value: 3 },
                        { text: "Anodized", value: 4 },
                        { text: "Anodized Multicolored", value: 5 },
                        { text: "Anodized Airbrushed", value: 6 },
                        { text: "Custom Paint Job", value: 7 },
                        { text: "Patina", value: 8 },
                        { text: "Gunsmith", value: 9 }
                    ]
                    textRole: "text"
                }
            }

            AlgGroupWidget {
                text: "Wear"
                activeScopeBorder: true
                toggled: true

                GridLayout {
                    columns: 2
                    columnSpacing: 15
                    rowSpacing: 10

                    SPSlider {
                        id: wearAmount
                        text: "Wear Amount"
                        from: wearLimits.minValue.toFixed(2)
                        to: wearLimits.maxValue.toFixed(2)
                        stepSize: 0.01
                    }
                    SPButton {
                        icon.source: "icons/icon_cycle.png"
                        icon.width: 14
                        icon.height: 14
                    }

                    SPRangeSlider {
                        id: wearLimits
                        text: "Wear Limits"
                        from: 0
                        to: 1
                        minValue: 0
                        maxValue: 1
                    }
                    SPButton {
                        icon.source: "icons/icon_cycle.png"
                        icon.width: 14
                        icon.height: 14
                    }
                }
            }

            AlgGroupWidget {
                text: "Texture Placement"
                activeScopeBorder: true
                toggled: true

                GridLayout {
                    columns: 2
                    columnSpacing: 15
                    rowSpacing: 10

                    SPSlider {
                        id: texScale
                        text: "Texture Scale"
                    }
                    SPButton {
                        icon.source: "icons/icon_cycle.png"
                        icon.width: 14
                        icon.height: 14
                    }
                    
                    SPRangeSlider {
                        text: "Texture Rotation"
                        from: -360
                        to: 360
                        minValue: 0
                        maxValue: 0
                    }
                    SPButton {
                        icon.source: "icons/icon_cycle.png"
                        icon.width: 14
                        icon.height: 14
                    }

                    SPRangeSlider {
                        text: "Texture Offset X"
                        from: -1
                        to: 1
                        minValue: 0
                        maxValue: 0
                    }
                    SPButton {
                        icon.source: "icons/icon_cycle.png"
                        icon.width: 14
                        icon.height: 14
                    }

                    SPRangeSlider {
                        text: "Texture Offset Y"
                        from: -1
                        to: 1
                        minValue: 0
                        maxValue: 0
                    }
                    SPButton {
                        icon.source: "icons/icon_cycle.png"
                        icon.width: 14
                        icon.height: 14
                    }
                }
            }

            AlgGroupWidget {
                text: "Color"
                activeScopeBorder: true
                toggled: true

                GridLayout {
                    columns: 3
                    columnSpacing: 15
                    rowSpacing: 10

                    AlgLabel {
                        text: "Base Metal"
                    }
                    SPColorButton {
                        id: colBaseMetal
                    }
                    SPButton {
                        icon.source: "icons/icon_cycle.png"
                        icon.width: 14
                        icon.height: 14
                    }

                    AlgLabel {
                        text: "Patina Tint"
                    }
                    SPColorButton {
                        id: colPatinaTint
                    }
                    SPButton {
                        icon.source: "icons/icon_cycle.png"
                        icon.width: 14
                        icon.height: 14
                    }

                    AlgLabel {
                        text: "Patina Wear"
                    }
                    SPColorButton {
                        id: colPatinaWear
                    }
                    SPButton {
                        icon.source: "icons/icon_cycle.png"
                        icon.width: 14
                        icon.height: 14
                    }

                    AlgLabel {
                        text: "Grime"
                    }
                    SPColorButton {
                        id: colGrime
                    }
                    SPButton {
                        icon.source: "icons/icon_cycle.png"
                        icon.width: 14
                        icon.height: 14
                    }
                }
            }

            AlgGroupWidget {
                text: "Effects"
                activeScopeBorder: true
                toggled: true

                GridLayout {
                    columns: 2
                    columnSpacing: 15
                    rowSpacing: 10

                    SPSlider {
                        text: "Pearlescent Scale"
                        from: -6
                        to: 6
                    }
                    SPButton {
                        icon.source: "icons/icon_cycle.png"
                        icon.width: 14
                        icon.height: 14
                    }

                    SPSlider {
                        text: "Paint Roughness"
                        from: 0
                        to: 1
                    }
                    SPButton {
                        icon.source: "icons/icon_cycle.png"
                        icon.width: 14
                        icon.height: 14
                    }
                }
            }

            AlgGroupWidget {
                text: "Material Textures"
                activeScopeBorder: true
                toggled: true

                GridLayout {
                    columns: 2
                    columnSpacing: 15
                    rowSpacing: 10

                    AlgCheckBox {
                        Layout.fillWidth: true
                        text: "Pearlescent Mask"
                    }
                    SPButton {
                        icon.source: "icons/icon_cycle.png"
                        icon.width: 14
                        icon.height: 14
                    }

                    AlgCheckBox {
                        Layout.fillWidth: true
                        text: "Roughness Texture"
                    }
                    SPButton {
                        icon.source: "icons/icon_cycle.png"
                        icon.width: 14
                        icon.height: 14
                    }

                    AlgCheckBox {
                        Layout.fillWidth: true
                        text: "Normal Map"
                    }
                    SPButton {
                        icon.source: "icons/icon_cycle.png"
                        icon.width: 14
                        icon.height: 14
                    }

                    AlgCheckBox {
                        Layout.fillWidth: true
                        text: "Material Mask"
                    }
                    SPButton {
                        icon.source: "icons/icon_cycle.png"
                        icon.width: 14
                        icon.height: 14
                    }

                    AlgCheckBox {
                        Layout.fillWidth: true
                        text: "Ambient Occlusion"
                    }
                    SPButton {
                        icon.source: "icons/icon_cycle.png"
                        icon.width: 14
                        icon.height: 14
                    }
                }
            }
        }
    }
}
