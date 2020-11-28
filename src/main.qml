import QtQuick 2.5
import QtWayland.Compositor 1.1
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
// import QtQuick.VirtualKeyboard 2.1

WaylandCompositor {
    WaylandOutput {
        sizeFollowsWindow: true
        window: Window {
            id: win
            width: 800
            height: 480
            visible: true
            color: "gray"
            SwipeView {
                id: swipeView
                interactive: false
//		anchors.left: parent.left
//		anchors.top: parent.top
//		anchors.right: parent.right
//		anchors.bottom: inputPanel.top
                anchors.fill: parent
                Repeater {
                    model: shellSurfaces
                    ShellSurfaceItem {
                        shellSurface: modelData
                        onSurfaceDestroyed: shellSurfaces.remove(index)
                    }
                }
            }
            Component.onCompleted: drawer.open()
            Drawer {
                id: drawer
                width: win.width * 0.3
                height: win.height
                ListView {
                    anchors.fill: parent
                    model: shellSurfaces
                    spacing: 5
                    delegate: WaylandQuickItem {
                        inputEventsEnabled: false
                        sizeFollowsSurface: false
                        surface: modelData.surface
                        width: parent.width
                        height: win.height * 0.3
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                drawer.close()
                                swipeView.currentIndex = index;
                            }
                        }
                        Button {
                            text: "x"
                            anchors.right: parent.right
                            onClicked: modelData.surface.client.close()
                        }
                    }
                }
            }

//	InputPanel {
//	    id: inputPanel
//	    visible: active
//	    y: active ? parent.height - inputPanel.height : parent.height
//	    anchors.left: parent.left
//	    anchors.right: parent.right
//	}
        }
    }
    ListModel { id: shellSurfaces }
    XdgShellV6 {
        onToplevelCreated: {
            shellSurfaces.append({shellSurface: xdgSurface});
            toplevel.sendFullscreen(Qt.size(win.width, win.height));
        }
    }

    IviApplication {
        onIviSurfaceCreated: {
            shellSurfaces.append({shellSurface: iviSurface});
            iviSurface.sendConfigure(Qt.size(win.width, win.height));
        }
    }
}

