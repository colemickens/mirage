// SPDX-License-Identifier: LGPL-3.0-or-later

import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ToolTip {
    id: toolTip
    delay: instant ? 0 : theme.controls.toolTip.delay
    padding: background.border.width

    background: Rectangle {
        id: background
        color: theme.controls.toolTip.background
        border.color: theme.controls.toolTip.border
        border.width: theme.controls.toolTip.borderWidth
    }

    contentItem: HRowLayout {
        HLabel {
            id: label
            color: theme.controls.toolTip.text
            text: toolTip.text
            wrapMode: Text.Wrap

            leftPadding: theme.spacing / 1.5
            rightPadding: leftPadding
            topPadding: theme.spacing / 2
            bottomPadding: topPadding

            Layout.maximumWidth: Math.min(
                window.width / 1.25, theme.fontSize.normal * 0.5 * 75,
            )
        }
    }

    enter: Transition {
        HNumberAnimation { property: "opacity"; from: 0.0; to: 1.0 }
    }
    exit: Transition {
        HNumberAnimation { property: "opacity"; to: 0.0 }
    }

    onHideNowChanged: if (visible && hideNow) toolTip.hide()


    property bool instant: false

    property alias label: label
    property alias backgroundColor: background.color

    readonly property bool hideNow: ! window.hovered


    function instantShow() {
        if (visible) return
        instant = true
        open()
        instant = false
    }


    TapHandler {
        onTapped: toolTip.hide()
    }

    HoverHandler {
        onHoveredChanged: if (! hovered) toolTip.hide()
    }
}
