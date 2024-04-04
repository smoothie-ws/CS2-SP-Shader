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
    onHeightChanged: {
        if (height != mainLayout.height) {
            height = Qt.binding(function() {return mainLayout.height});
        }
    }

    property int shaderID: 0;

    function displayShaderParameters(shaderId) {
        try {
            root.shaderID = shaderId;
        }
        catch(e) {
            alg.log.error(e.message);
        }
    }

    PainterPlugin {
        onComputationStatusChanged: {
            var meshUrl = alg.project.lastImportedMeshUrl();
            var meshName = meshUrl.split("/").pop().split(".")[0];
            weaponModel.control.currentIndex = weaponModel.control.model.findIndex(weapon => weapon.value === meshName)
        }
    }

    ColumnLayout {
        id: mainLayout
        width: parent.width

        SPParameterGroup {
            Layout.fillWidth: true
            shaderID: root.shaderID
            expandable: false
            padding: 10
            background: Rectangle {
                color: Qt.rgba(1, 1, 1, 0.05)
                border.width: 1
                border.color: Qt.rgba(1, 1, 1, 0.1)
                radius: 10
            }

            SPParameter {
                id: enableLivePreview
                Layout.fillWidth: true
                text: "Live Preview"
                parameter: "u_enable_live_preview"
                key: "checked"
                resettable: false
                SPButton {
                    checkable: true
                    text: checked ? "Enabled" : "Disabled"
                }
            }

            SPParameter {
                id: enablePBRValidation
                Layout.fillWidth: true
                text: "PBR Validation"
                parameter: "u_enable_pbr_validation"
                key: "checked"
                resettable: false
                SPButton {
                    checkable: true
                    text: checked ? "Enabled" : "Disabled"
                }
            }

            SPParameter {
                id: pbrLimits
                visible: enablePBRValidation.control.checked
                SPRangeSlider {
                    text: "PBR Limits"
                    stepSize: 1
                    precision: 0
                    from: 0
                    to: 255
                }
            }
        }

        SPSeparator {
            Layout.fillWidth: true
        }

        ColumnLayout {
            Layout.bottomMargin: 10
            Layout.fillWidth: true
            spacing: 10
            enabled: enableLivePreview.control.checked

            SPParameterGroup {
                Layout.fillWidth: true
                shaderID: root.shaderID
                text: "Common"

                SPParameter {
                    id: weaponModel
                    text: "Weapon"

                    SPComboBox {
                        model: [
                            { text: "AK-47", value: "ak47" },
                            { text: "AUG", value: "aug" },
                            { text: "AWP", value: "awp" },
                            { text: "PP-Bizon", value: "bizon" },
                            { text: "CZ75-Auto", value: "cz75a" },
                            { text: "Desert Eagle", value: "deagle" },
                            { text: "Dual Berettas", value: "elite" },
                            { text: "FAMAS", value: "famas" },
                            { text: "Five-SeveN", value: "fiveseven" },
                            { text: "Glock-18", value: "glock18" },
                            { text: "G3SG1", value: "g3sg1" },
                            { text: "Galil AR", value: "galilar" },
                            { text: "MAC-10", value: "mac10" },
                            { text: "M249", value: "m249" },
                            { text: "M4A1-S", value: "m4a1_silencer" },
                            { text: "M4A4", value: "m4a4" },
                            { text: "MAG-7", value: "mag7" },
                            { text: "MP5-SD", value: "mp5sd" },
                            { text: "MP7", value: "mp7" },
                            { text: "MP9", value: "mp9" },
                            { text: "Negev", value: "negev" },
                            { text: "Nova", value: "nova" },
                            { text: "P2000", value: "hkp2000" },
                            { text: "P250", value: "p250" },
                            { text: "P90", value: "p90" },
                            { text: "R8 Revolver", value: "revolver" },
                            { text: "Sawed-Off", value: "sawedoff" },
                            { text: "SCAR-20", value: "scar20" },
                            { text: "SG 553", value: "sg553" },
                            { text: "SSG 08", value: "ssg08" },
                            { text: "Tec-9", value: "tec9" },
                            { text: "UMP-45", value: "ump45" },
                            { text: "USP-S", value: "usp_silencer" },
                            { text: "XM1014", value: "xm1014" },
                            { text: "Zeus x27", value: "taser" }
                        ]
                        textRole: "text"
                        valueRole: "value"
                    }
                }

                SPParameter {
                    id: finishStyle
                    text: "Finish Style"
                    parameter: "u_finish_style"
                    key: "currentIndex"

                    SPComboBox {
                        model: [
                            { text: "Solid Color", value: 0 },
                            { text: "Hydrographic", value: 1 },
                            { text: "Spray Paint", value: 2 },
                            { text: "Anodized", value: 3 },
                            { text: "Anodized Multicolored", value: 4 },
                            { text: "Anodized Airbrushed", value: 5 },
                            { text: "Custom Paint Job", value: 6 },
                            { text: "Patina", value: 7 },
                            { text: "Gunsmith", value: 8 }
                        ]
                        textRole: "text"
                        valueRole: "value"
                    }
                }

                SPSeparator { }

                SPParameter {
                    parameter: "u_wear"
                    key: "value"
                    SPSlider {
                        text: "Wear Amount"
                        from: wearLimits.control.minValue
                        to: wearLimits.control.maxValue
                        stepSize: 0.01
                    }
                }

                SPParameter {
                    parameter: "u_tex_scale"
                    key: "value"
                    SPSlider {
                        text: "Texture Scale"
                        from: -10
                        to: 10
                    }
                }

                SPParameter {
                    text: "Ignore Weapon Size Scale:"
                    key: "checked"
                    SPButton {
                        checkable: true
                        text: checked ? "Yes" : "No"
                    }
                }
            }

            SPParameterGroup {
                Layout.fillWidth: true
                shaderID: root.shaderID
                text: "Texture Placement"

                SPParameter {
                    SPRangeSlider {
                        text: "Texture Rotation"
                        from: -360
                        to: 360
                        minValue: 0
                        maxValue: 0
                    }
                }

                SPParameter {
                    SPRangeSlider {
                        text: "Texture Offset X"
                        from: -1
                        to: 1
                        minValue: 0
                        maxValue: 0
                    }
                }

                SPParameter {
                    SPRangeSlider {
                        text: "Texture Offset Y"
                        from: -1
                        to: 1
                        minValue: 0
                        maxValue: 0
                    }
                }
            }

            SPParameterGroup {
                Layout.fillWidth: true
                shaderID: root.shaderID
                visible: finishStyle.control.currentIndex != 6
                text: "Color"

                SPParameter {
                    text: finishStyle.control.currentIndex > 6 ? "Base Metal" : "Base Coat"
                    parameter: "u_col0"
                    key: "arrayColor"
                    SPColorButton { }
                }

                SPParameter {
                    visible: finishStyle.control.currentIndex != 3
                    text: finishStyle.control.currentIndex > 6 ? "Patina Tint" : "Red Channel"
                    parameter: "u_col1"
                    key: "arrayColor"
                    SPColorButton { }
                }

                SPParameter {
                    visible: finishStyle.control.currentIndex != 3
                    text: finishStyle.control.currentIndex > 6 ? "Patina Wear" : "Green Channel"
                    parameter: "u_col2"
                    key: "arrayColor"
                    SPColorButton { }
                }

                SPParameter {
                    visible: finishStyle.control.currentIndex != 3
                    text: finishStyle.control.currentIndex > 6 ? "Grime" : "Blue Channel"
                    parameter: "u_col3"
                    key: "arrayColor"
                    SPColorButton { }
                }
            }

            SPParameterGroup {
                Layout.fillWidth: true
                shaderID: root.shaderID
                text: "Effects"

                SPParameter {
                    id: wearLimits

                    SPRangeSlider {
                        text: "Wear Limits"
                        from: 0
                        to: 1
                        minValue: 0
                        maxValue: 1
                    }
                }

                SPSeparator { }

                SPParameter {
                    text: "Pearlescent Mask"
                    parameter: "u_use_pearl_mask"
                    key: "checked"
                    SPButton {
                        checkable: true
                        text: checked ? "Use" : "Do not use"
                    }
                }

                SPParameter {
                    parameter: "u_pearl_scale"
                    key: "value"
                    SPSlider {
                        text: "Pearlescent Scale"
                        from: -6
                        to: 6
                    }
                }

                SPSeparator { }

                SPParameter {
                    id: useRoughnessTexture
                    property bool checked: true
                    text: "Roughness Texture"
                    parameter: "u_use_roughness_tex"
                    key: "checked"
                    SPButton {
                        checkable: true
                        text: checked ? "Use" : "Do not use"

                        onCheckedChanged: {
                            useRoughnessTexture.checked = checked
                        }
                    }
                }
                
                SPParameter {
                    visible: !useRoughnessTexture.checked
                    parameter: "u_paint_roughness"
                    key: "value"
                    SPSlider {
                        text: "Paint Roughness"
                        from: 0
                        to: 1
                    }
                }
            }

            SPParameterGroup {
                Layout.fillWidth: true
                shaderID: root.shaderID
                text: "Advanced"
                toggled: false

                SPParameter {
                    text: "Normal Map"
                    parameter: "u_use_normal_map"
                    key: "checked"
                    SPButton {
                        checkable: true
                        text: checked ? "Use" : "Do not use"
                    }
                }

                SPParameter {
                    text: "Material Mask"
                    parameter: "u_use_material_mask"
                    key: "checked"
                    SPButton {
                        checkable: true
                        text: checked ? "Use" : "Do not use"
                    }
                }

                SPParameter {
                    text: "Ambient Occlusion"
                    parameter: "u_use_ao_tex"
                    key: "checked"
                    SPButton {
                        checkable: true
                        text: checked ? "Use" : "Do not use"
                    }
                }
            }
        }
    }
}
