import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.12
import SerialInterface 1.0

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Relay Control")
    visibility: 'FullScreen'

    property var relayStatus: [false, false, false, false,
                                false, false, false, false,
                                false, false, false, false,
                                false, false, false, false]

    SerialInterface{
        id: serialInterface
        Component.onCompleted: serialInterface.startSerial()
        onSetRelayData: {
           var data_in = serialInterface.getRelayData()
           relayStatus = data_in
           //console.log(data_in)
        }
    }

    background: Rectangle{
        width: parent.width
        height: parent.height
        color: '#1b1b23' //Material.BlueGrey
    }

    Row{
        id: mainRow
        width: parent.width
        height: parent.height
        spacing: width * 3/100
        Column{
            width: parent.width * 18/100
            height: parent.height
            Rectangle{
                width: parent.width
                height: parent.height
                color: '#101012'
                Column
                {
                    width: parent.width
                    height: parent.height
                    Rectangle{
                        width: parent.width
                        height: parent.height * 12/100
                        Image {
                            height: parent.height * 8/10
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: 'qrc:/images/DDEMS.png'
                        }
                    }

                    Row{
                        width: parent.width * 98/100
                        height: parent.height * 10/100
                        x: parent.width * 2/100
                        Rectangle{
                            width: parent.width * 1/100
                            height: parent.height
                            color: '#004080'
                        }

                        Rectangle{
                            width: parent.width * 99/100
                            height: parent.height
                            color: '#1b1b23'
                            Image {
                                x: parent.width * 5/100
                                anchors.verticalCenter: parent.verticalCenter
                                source: 'qrc:/images/dash24.png'
                            }
                            Label{
//                                anchors.horizontalCenter: parent.horizontalCenter
                                x: parent.width * 2/10
                                anchors.verticalCenter: parent.verticalCenter
                                color: '#FFFFFF'
                                font.pixelSize: parent.width * 1/10
                                text: 'Dashboard'
                            }
                        }
                    }

                    Row{
                        width: parent.width * 98/100
                        height: parent.height * 10/100
                        x: parent.width * 2/100
                        Rectangle{
                            width: parent.width * 1/100
                            height: parent.height
                            color: 'transparent'//'#004080'
                        }

                        Rectangle{
                            width: parent.width * 99/100
                            height: parent.height
                            color: 'transparent'//'#1b1b23'
                            Image {
                                x: parent.width * 5/100
                                anchors.verticalCenter: parent.verticalCenter
                                source: 'qrc:/images/settings.png'
                            }
                            Label{
                                x: parent.width * 2/10
                                anchors.verticalCenter: parent.verticalCenter
                                color: '#FFFFFF'
                                font.pixelSize: parent.width * 1/10
                                text: 'Settings'
                            }
                        }
                    }



                    Rectangle{
                        id: dummySpacer
                        width: parent.width
                        height: parent.height * 47/100
                        color: 'transparent'
                    }

                    Rectangle{
                        width: parent.width
                        height: parent.height * 2/10
                        color: 'transparent'
                        Image {
                            anchors.centerIn: parent
                            source: 'qrc:/images/exit.png'
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: Qt.quit()
                        }
                    }
                }
            }
        }

        Column{
            id: relayColumn
            width: parent.width * 75/100
            height: parent.height * 9/10

            Grid{
                id: panelGrid
                width: parent.width * 8/10
                topPadding: height * 12/100
                leftPadding: width * 12/100
                columns: 4
                spacing: width * 2/100
                Repeater{
                    id: relayRepeatr
                    model: 16
                    Rectangle{
                        width: relayColumn.width * 20/100
                        height: relayColumn.height * 1/5
                        color: 'transparent'

                        Rectangle{
                            width: parent.width * 9/10
                            height: parent.height
                            color: 'transparent'//'#181920'
                            border.width: 1
                            border.color: '#282830'//'#101012'
                            Image {
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter
                                source: 'qrc:/images/' + (relayStatus[index] ? 'lamp10' : 'lamp9') + '.png'
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    var tmp = []
                                    var i = 0
                                    for(;i<16;i++)
                                        tmp.push(relayStatus[i])
                                    tmp[index] = !tmp[index]
                                    relayStatus = tmp
                                }
                            }
                        }

                        Label{
                            anchors.left: parent.left
                            anchors.bottom: parent.bottom
                            anchors.leftMargin: parent.width * (44-(index>=9?2:0))/100
                            anchors.bottomMargin: parent.width * 9/100
                            text: index+1
                            color: '#454545'
                        }

                    }


//                    Button{
//                        width: relayColumn.width * 1/5
//                        height: relayColumn.height * 1/10
//                        text: 'relay ' + (index+1)
////                        color: Material.Green
//                        onClicked: //Qt.quit()
//                        background: Rectangle{
//                            width: parent.width
//                            height: parent.height
//                            color: '#B0002F'//'#2FB000'
//                            radius: height * 1/4
//                        }

//                    }

//                    Rectangle{
//                        width: relayColumn.width * 1/5
//                        height: relayColumn.height * 1/15
//                        color: Material.Green
//                        MouseArea{
//                            anchors.fill: parent
//                            onClicked:{
//                                Qt.quit()
//                            }
//                        }
//                    }
                }
            }
        }


    }
}
