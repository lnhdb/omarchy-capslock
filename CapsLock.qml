import QtQuick
import Quickshell.Io
import qs.Ui
import "Model.js" as Model

BarWidget {
  id: root
  moduleName: "lnhdb.capslock"

  property bool capsOn: false

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  // Hyprland raises no event when Caps Lock changes, so ask it.
  Timer {
    interval: 200
    repeat: true
    running: true
    triggeredOnStart: true
    onTriggered: if (!reader.running) reader.running = true
  }

  Process {
    id: reader
    command: ["hyprctl", "-j", "devices"]
    stdout: StdioCollector {
      waitForEnd: true
      onStreamFinished: {
        var on = Model.capsOn(text)
        if (on !== null) root.capsOn = on
      }
    }
  }

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "󰪛"
    dimmed: !root.capsOn
    pressable: false
    tooltipText: root.capsOn ? "Caps Lock on" : "Caps Lock off"
  }
}
