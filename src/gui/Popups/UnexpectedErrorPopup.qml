// SPDX-License-Identifier: LGPL-3.0-or-later

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "../Base"
import "../Base/ButtonLayout"

HColumnPopup {
    id: popup


    property string errorType
    property string message: ""
    property string traceback: ""


    page.footer: ButtonLayout {
        ApplyButton {
            text: qsTr("Report")
            icon.name: "report-error"
            enabled: false  // TODO
        }

        CancelButton {
            id: cancelButton
            text: qsTr("Ignore")
            onClicked: popup.close()
        }
    }

    onOpened: cancelButton.forceActiveFocus()


    SummaryLabel {
        text: qsTr("Unexpected error occured: <i>%1</i>").arg(errorType)
        textFormat: Text.StyledText
    }

    HScrollView {
        clip: true

        Layout.fillWidth: true
        Layout.fillHeight: true

        HTextArea {
            text: [message, traceback].join("\n\n") || qsTr("No info available")
            readOnly: true
            font.family: theme.fontFamily.mono
            focusItemOnTab: hideCheckBox
        }
    }

    HCheckBox {
        id: hideCheckBox
        text: qsTr("Hide this type of error until restart")
        onCheckedChanged:
            checked ?
            window.hideErrorTypes.add(errorType) :
            window.hideErrorTypes.delete(errorType)

        Layout.fillWidth: true
    }
}
