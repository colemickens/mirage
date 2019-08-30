import QtQuick 2.12
import "Base"
import "utils.js" as Utils

HShortcutHandler {
    property Item flickTarget: Item {}

    // App

    HShortcut {
        enabled: debugMode
        sequences: settings.keys.startDebugger
        onPressed: py.call("APP.pdb")
    }

    HShortcut {
        sequences: settings.keys.reloadConfig
        onPressed: py.loadSettings(() => { mainUI.pressAnimation.start() })
    }

    // Page scrolling

    HShortcut {
        sequences: settings.keys.scrollUp
        onPressed: Utils.smartVerticalFlick(flickTarget, -335)
        onHeld: pressed(event)
    }

    HShortcut {
        sequences: settings.keys.scrollDown
        onPressed: Utils.smartVerticalFlick(flickTarget, 335)
        onHeld: pressed(event)
    }

    HShortcut {
        sequences: settings.keys.scrollPageUp
        onPressed: Utils.smartVerticalFlick(
            flickTarget, -2.3 * flickTarget.height, 10,
        )
        onHeld: pressed(event)
    }

    HShortcut {
        sequences: settings.keys.scrollPageDown
        onPressed: Utils.smartVerticalFlick(
            flickTarget, 2.3 * flickTarget.height, 10,
        )
        onHeld: pressed(event)
    }


    // SidePane

    HShortcut {
        enabled: mainUI.accountsPresent
        sequences: settings.keys.focusSidePane
        onPressed: mainUI.sidePane.setFocus()
    }

    HShortcut {
        enabled: mainUI.accountsPresent
        sequences: settings.keys.clearRoomFilter
        onPressed: mainUI.sidePane.toolBar.roomFilter = ""
    }

    HShortcut {
        enabled: mainUI.accountsPresent
        sequences: settings.keys.addNewAccount
        onPressed: mainUI.sidePane.toolBar.addAccountButton.clicked()
    }

    HShortcut {
        enabled: mainUI.accountsPresent
        sequences: settings.keys.goToPreviousRoom
        onPressed: mainUI.sidePane.sidePaneList.previous()
        onHeld: pressed(event)
    }

    HShortcut {
        enabled: mainUI.accountsPresent
        sequences: settings.keys.goToNextRoom
        onPressed: mainUI.sidePane.sidePaneList.next()
        onHeld: pressed(event)
    }

    HShortcut {
        enabled: mainUI.accountsPresent
        sequences: settings.keys.toggleCollapseAccount
        onPressed: mainUI.sidePane.sidePaneList.toggleCollapseAccount()
    }
}
