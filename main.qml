import QtQuick 2.10
import QtQuick.Controls 2.2
//import QtQuick.Controls.Material 2.12
import SerialInterface 1.0
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("Relay Control")
    visibility: 'FullScreen'

    property var relayStatus: [true, false, false, false,
        false, false, false, false,
        false, false, false, false,
        false, false, false, false]

    property var relayLabel: ['chandelier', 'chandelier', 'chandelier', 'chandlier',
                                'strip', 'halogen', 'halogen', '',
                                '', '', '', '', '',
                                '', '', '', '']


    property bool serialStatus: false
    property int pageNumber: 0

    SerialInterface{
        id: serialInterface
        Component.onCompleted: serialInterface.startSerial()
        onSetRelayData: {
            relayStatus = signal_data
        }
        onSerial_opened: serialStatus = true
        onSerial_closed: serialStatus = false
    }

    background: Rectangle{
        width: parent.width
        height: parent.height
        color: '#121212' //Material.BlueGrey
    }

    //        Image {
    //        source: 'qrc:/images/background29.jpg'
    //    }


    Row{
        id: mainRow
        width: parent.width
        height: parent.height
        spacing: width * 3/100
        Column{
            width: parent.width * 16/100
            height: parent.height
            Rectangle{
                width: parent.width
                height: parent.height
                color: '#000000' //Qt.rgba(0.1, 0.1,0.1, 0.2)
                Column
                {
                    width: parent.width
                    height: parent.height
                    Rectangle{
                        width: parent.width
                        height: parent.height * 12/100
                        color: 'transparent'
                    }

                    Row{
                        width: parent.width * 98/100
                        height: parent.height * 10/100
                        x: parent.width * 2/100
                        Rectangle{
                            width: parent.width * 1/100
                            height: parent.height
                            color: pageNumber==0?'#004080':'transparent'
                        }

                        Rectangle{
                            width: parent.width * 99/100
                            height: parent.height
                            color: pageNumber==0?'#121212':'trnasparent'
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
                                text: 'Lightning'
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: pageNumber=0
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
                            color: pageNumber==1?'#004080':'transparent'
                        }

                        Rectangle{
                            width: parent.width * 99/100
                            height: parent.height
                            color: pageNumber==1?'#121212':'trnasparent'
                            Image {
                                x: parent.width * 5/100
                                anchors.verticalCenter: parent.verticalCenter
                                source: 'qrc:/images/HVAC.png'
                            }
                            Label{
                                //                                anchors.horizontalCenter: parent.horizontalCenter
                                x: parent.width * 2/10
                                anchors.verticalCenter: parent.verticalCenter
                                color: '#FFFFFF'
                                font.pixelSize: parent.width * 1/10
                                text: 'HVAC'
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: pageNumber=1
                                enabled: false
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
                            color: pageNumber==2?'#004080':'transparent'
                        }

                        Rectangle{
                            width: parent.width * 99/100
                            height: parent.height
                            color: pageNumber==2?'#121212':'trnasparent'
                            Image {
                                x: parent.width * 5/100
                                anchors.verticalCenter: parent.verticalCenter
                                source: 'qrc:/images/scenarios.png'
                            }
                            Label{
                                //                                anchors.horizontalCenter: parent.horizontalCenter
                                x: parent.width * 2/10
                                anchors.verticalCenter: parent.verticalCenter
                                color: '#FFFFFF'
                                font.pixelSize: parent.width * 1/10
                                text: 'Scenarios'
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: pageNumber=2
                                enabled: false
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
                            color: pageNumber==3?'#004080':'transparent'
                        }

                        Rectangle{
                            width: parent.width * 99/100
                            height: parent.height
                            color: pageNumber==3?'#121212':'trnasparent'
                            Image {
                                x: parent.width * 5/100
                                anchors.verticalCenter: parent.verticalCenter
                                source: 'qrc:/images/intercom.png'
                            }
                            Label{
                                //                                anchors.horizontalCenter: parent.horizontalCenter
                                x: parent.width * 2/10
                                anchors.verticalCenter: parent.verticalCenter
                                color: '#FFFFFF'
                                font.pixelSize: parent.width * 1/10
                                text: 'Intercom'
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: pageNumber=3
                                enabled: false
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
                            color: pageNumber==4?'#004080':'transparent'
                        }

                        Rectangle{
                            width: parent.width * 99/100
                            height: parent.height
                            color: pageNumber==4?'#121212':'trnasparent'
                            Image {
                                x: parent.width * 5/100
                                anchors.verticalCenter: parent.verticalCenter
                                source: 'qrc:/images/security.png'
                            }
                            Label{
                                //                                anchors.horizontalCenter: parent.horizontalCenter
                                x: parent.width * 2/10
                                anchors.verticalCenter: parent.verticalCenter
                                color: '#FFFFFF'
                                font.pixelSize: parent.width * 1/10
                                text: 'Security'
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: pageNumber=4
                                enabled: false
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
                            color: pageNumber==5?'#004080':'transparent'
                        }

                        Rectangle{
                            width: parent.width * 99/100
                            height: parent.height
                            color: pageNumber==5?'#121212':'trnasparent'
                            Image {
                                x: parent.width * 5/100
                                anchors.verticalCenter: parent.verticalCenter
                                source: 'qrc:/images/camera.png'
                            }
                            Label{
                                //                                anchors.horizontalCenter: parent.horizontalCenter
                                x: parent.width * 2/10
                                anchors.verticalCenter: parent.verticalCenter
                                color: '#FFFFFF'
                                font.pixelSize: parent.width * 1/10
                                text: 'camera'
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: pageNumber=5
                                enabled: false
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
                            color: pageNumber==6?'#004080':'transparent'
                        }

                        Rectangle{
                            width: parent.width * 99/100
                            height: parent.height
                            color: pageNumber==6?'#121212':'trnasparent'
                            Image {
                                x: parent.width * 5/100
                                anchors.verticalCenter: parent.verticalCenter
                                source: 'qrc:/images/settings.png'
                            }
                            Label{
                                //                                anchors.horizontalCenter: parent.horizontalCenter
                                x: parent.width * 2/10
                                anchors.verticalCenter: parent.verticalCenter
                                color: '#FFFFFF'
                                font.pixelSize: parent.width * 1/10
                                text: 'Settings'
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: pageNumber=6
                            }
                        }
                    }



//                    Rectangle{
//                        id: dummySpacer
//                        width: parent.width
//                        height: parent.height * 47/100
//                        color: 'transparent'
//                    }

                    Rectangle{
                        width: parent.width
                        height: parent.height * 2/10
                        color: 'transparent'
//                        visible: true
                        Image {
                            anchors.centerIn: parent
                            source: 'qrc:/images/exit.png'
                            visible: false
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
            spacing: height * 5/100
            visible: pageNumber<=1
            Grid{
                id: panelGrid
                width: parent.width * 8/10
                topPadding: height * 12/100
                leftPadding: width * 12/100
                columns: 4
                spacing: width * 2/100
                Repeater{
                    id: relayRepeatr
                    model: 7
                    Rectangle {
                        width: relayColumn.width * 20/100
                        height: width
                        radius:10
                        rotation: 90
                        gradient: Gradient{
                            GradientStop{position: 0.1; color:'#4B4B4B'}
                            GradientStop{position: 1.0; color:'#232323'}
                        }
                        Column{
                            anchors.fill: parent
                            topPadding: parent.height * 5/100
//                            rightPadding: parent.width * 1/10
                            rotation: -90
                            Column{
                                id: rectImg
                                width: parent.width * 95/100
                                height: parent.height * 5/10
                                spacing: height * 1/10

                                Image{
//                                    id: rectImg
                                    anchors.right: parent.right
//                                    anchors.rightMargin: parent.width * 5/100
                                    source: 'qrc:/images/chandelier-' + (relayStatus[index]? 'on':'off')+ '.png'
                                }

                                Label{
                                    text: 'لوستر'
                                    color: '#FE8A1F'
                                    font.family: 'Inter'
                                    font.pixelSize: parent.width * 8/100
                                    anchors.right: parent.right
                                }

                                Label{
                                    text: 'Chandelier'
                                    color: '#FFFFFF'
                                    font.family: 'Inter'
                                    font.pixelSize: parent.width * 7/100
                                    anchors.right: parent.right
                                }

                            }
                            Row{
                                width: parent.width
                                height: parent.height * 35/100 /*- rectImg.height*/
                                leftPadding: width *1/10
                                topPadding: height * 2/10
                                Rectangle{
                                    width: parent.width * 4/10
                                    height: parent.height * 6/10 + relayStatus[index]
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: relayStatus[index] ? '#33E6B5' : '#FFFFFF'
                                    radius: 5
                                    Rectangle{
                                        width: parent.width - 5
                                        height: parent.height
                                        x: 5
                                        color: relayStatus[index] ? '#33E6B5' : '#FFFFFF'
                                        Label{
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: 'ON'
                                            color: relayStatus[index] ? '#FFFFFF' : '#E633B5'
                                        }
                                    }
                                }
                                Rectangle{
                                    width: parent.width * 4/10
                                    height: parent.height * 6/10 + !relayStatus[index]
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: relayStatus[index] ? '#FFFFFF' : '#E633B5'
                                    radius: 5
                                    Rectangle{
                                        width: parent.width - 5
                                        height: parent.height
                                        color: relayStatus[index] ? '#FFFFFF' : '#E633B5'
                                        Label{
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.horizontalCenter: parent.horizontalCenter
                                            text: 'OFF'
                                            color: relayStatus[index] ? '#E633B5' : '#FFFFFF'
                                        }
                                    }
                                }
                            }
                        }

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                serialInterface.changeState(index, relayStatus[index])
//                                var tmp = []
//                                var i = 0
//                                for(;i<16;i++)
//                                    tmp.push(relayStatus[i])
//                                tmp[index] = !tmp[index]
//                                relayStatus = tmp
                            }
                        }

//                        color: Qt.rgba(0.1, 0.1, 0.1, 0.5)//'transparent'
                            /*Gradient{
                            GradientStop{position: 0.5; color:'#181820'}
                            GradientStop{position: 1.0; color:'#303030'}
                        }*/

                        //                        Rectangle{
                        //                            width: parent.width * 9/10
                        //                            height: parent.height
                        //                            color: 'transparent'//'#181920'
                        //                            border.width: 1
                        //                            border.color: '#101012' //'#282830'//'#101012'
                        //                            Image {
                        //                                anchors.horizontalCenter: parent.horizontalCenter
                        //                                anchors.verticalCenter: parent.verticalCenter
                        //                                source: 'qrc:/images/' + (relayStatus[index] ? 'lamp10' : 'lamp9') + '.png'
                        //                            }
                        //                            MouseArea{
                        //                                anchors.fill: parent
                        //                                onClicked: {
                        //                                    serialInterface.changeState(index, relayStatus[index])
                        ////                                    var tmp = []
                        ////                                    var i = 0
                        ////                                    for(;i<16;i++)
                        ////                                        tmp.push(relayStatus[i])
                        ////                                    tmp[index] = !tmp[index]
                        ////                                    relayStatus = tmp
                        //                                }
                        //                            }
                        //                        }

                        //                        Label{
                        //                            anchors.left: parent.left
                        //                            anchors.bottom: parent.bottom
                        //                            anchors.leftMargin: parent.width * (44-(index>=9?2:0))/100
                        //                            anchors.bottomMargin: parent.width * 9/100
                        //                            text: index+1
                        //                            color: '#454545'
                        //                        }

                    }
                }
            }

            Rectangle{
                id: connectionRct
                width: parent.width * 1/4 //(serialStatus ? 1/10 : 2/10)
                height: 1//parent.height * 1/100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: mainWindow.bottom
                radius: 5
                color: serialStatus ? '#2FB000' : '#B0002F'
                //                Label{
                //                    id: connectionLbl
                //                    anchors.centerIn: parent
                //                    text: serialStatus ? 'CONNECTED' : 'DISCONNECTED'
                //                }
                //                MouseArea{
                //                    anchors.fill: parent
                //                    onClicked: {
                //                        if(serialStatus)
                //                        {
                //                            serialInterface.stopSerial()
                //                            serialStatus = false
                //                        }
                //                        else{
                //                            serialStatus = serialInterface.startSerial()
                //                        }
                //                    }
                //                }
            }
        }

        Column{
            id: settings
            width: parent.width * 75/100
            height: parent.height * 9/10
            spacing: height * 5/100
            visible: pageNumber==6
            Grid{
                id: settingsGrid
                width: parent.width * 8/10
                topPadding: height * 5/100
                leftPadding: width * 12/100
                columns: 2
                spacing: width * 2/100
                Repeater{
                    id: settingsRepeater
                    model: 16
                    Row{
                       width: relayColumn.width * 40/100
                       height: width * 18/100
                       spacing: width*1/100
                        Rectangle{
                            width: parent.width*14/100
                            height: parent.height
                            color: 'red'
                            Label{
                                text: 'Relay ' + (index+1)
                                color: 'white'
                                anchors.centerIn: parent
                            }
                        }

                        Rectangle{
                            width: parent.width*1/10
                            height: parent.height
                            color: 'red'
                        }
                    }
                }
            }
        }
    }
}
