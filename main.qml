import QtQuick 2.10
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import SerialInterface 1.0
import QtGraphicalEffects 1.0
import "./"

ApplicationWindow {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("Relay Control")
    visibility: 'FullScreen'

    readonly property int number_of_relays: 16
    property var relayStatus: [false, false, false, false,
        false, false, false, false,
        false, false, false, false,
        false, false, false, false]

    readonly property var pageNames: ['', 'Lightning', 'HVAC', 'Scenarios', 'Intercom', 'Security']
    readonly property var relayMap: ['', 'chandelier', 'hidden strip light', 'halogen', 'wall light']
    readonly property var relayFarsiMap: ['', 'لوستر', 'نور مخفی', 'هالوژن', 'چراغ دیواری', '5', '6', '7', '8', '9', '10', '11', '12', '13', '14', '15']
    property var relayType: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    property var relayPage: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

//    property var relayLabel: ['chandelier', 'chandelier', 'chandelier', 'chandelier',
//        'hidden strip light', 'halogen', 'halogen', 'wall light',
//        'wall light', '', '', '', '',
//        '', '', '', '']

//    property var relayFarsiLabel: ['لوستر', 'لوستر', 'لوستر', 'لوستر',
//        'نور مخفی', 'هالوژن', 'هالوژن', 'چراغ دیواری',
//        'چراغ دیواری', '', '', '', '',
//        '', '', '', '']


    property bool serialStatus: false
    property int pageNumber: 1

    property bool loadCompleted: false


    function settingsChanged(number, type, place)
    {
        if(loadCompleted)
        {
            var updateStatus = DBInterface.setRelayConfig(number, type, place)
            var tmpType = []
            var tmpPage = []
            var i
            for(i=0;i<number_of_relays;i++)
            {
                tmpType.push(relayType[i])
                tmpPage.push(relayPage[i])
            }
            if(updateStatus)
            {
                tmpType[number] = type
                tmpPage[number] = place
            }

            relayType = tmpType
            relayPage = tmpPage
        }
    }

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
        color: UIStyle.backgroundColor //Material.BlueGrey
    }

    Component.onCompleted: {
        var config = DBInterface.getRelayConfigs()
        var i, number, type, place
        var tmpType = []
        var tmpPage = []
        for(i=0;i<number_of_relays;i++)
        {
            tmpType.push(0)
            tmpPage.push(0)
        }

        for(i=0;i<number_of_relays;i++)
        {
            var tmp = config[i].split(',')
            number = parseInt(tmp[0])
            type = parseInt(tmp[1])
            place = parseInt(tmp[2])
            tmpType[number] = type
            tmpPage[number] = place
        }
        relayType = tmpType
        relayPage = tmpPage
        loadCompleted = true
    }

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
                            color: pageNumber==1?'#004080':'transparent'
                        }

                        Rectangle{
                            width: parent.width * 99/100
                            height: parent.height
                            color: pageNumber==1?'#121212':'trnasparent'
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
                                onClicked: pageNumber=1
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
                                onClicked: pageNumber=6
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
                            color: pageNumber==7?'#004080':'transparent'
                        }

                        Rectangle{
                            width: parent.width * 99/100
                            height: parent.height
                            color: pageNumber==7?'#121212':'trnasparent'
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
                                onClicked: pageNumber=7
//                                enabled: false
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
                            onPressAndHold: Qt.quit()
                        }
                    }
                }
            }
        }

        Column{
            id: relayColumn
            width: parent.width * 80/100
            height: parent.height * 9/10
            spacing: height * 5/100
            visible: pageNumber<=1
            topPadding: height * 5/100
            Row{
                id: topRow
                width: parent.width * 8/10
                height: parent.height * 10/100
                leftPadding: width * 7/100
                spacing: width*1/100
                Rectangle{
                    width: parent.width * 8/100
                    height: parent.height
                    color: 'transparent'
                    Label{
                        id: wetherLabel
                        text: 'storm'
                        color: '#FFFFFF'
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: parent.width*34/100
                        font.family: 'Microsoft JhengHei UI';
                    }
                }
                Image{
                    source: 'qrc:/images/storm.png'
                    anchors.verticalCenter: parent.verticalCenter
                }

                Rectangle{
                    width: parent.width * 3/100
                    height: parent.height
                    color: 'transparent'
                }

                Rectangle{
                    width: parent.width * 7/100
                    height: parent.height
                    color: 'transparent'
                    Label{
                        id: thermometerLabel
                        text: "25\xB0 C"
                        color: '#FFFFFF'
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: parent.width*35/100
                        font.family: 'Microsoft JhengHei UI';
                    }
                }
                Image{
                    source: 'qrc:/images/thermometer.png'
                    anchors.verticalCenter: parent.verticalCenter
                }

                Rectangle{
                    width: parent.width * 3/100
                    height: parent.height
                    color: 'transparent'
                }

                Rectangle{
                    width: parent.width * 12/100
                    height: parent.height
                    color: 'transparent'
                    Label{
                        id: locationLabel
                        text: "Mashhad"
                        color: '#FFFFFF'
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: parent.width*22/100
                        font.family: 'Microsoft JhengHei UI';
                    }
                }
                Image{
                    source: 'qrc:/images/location.png'
                    anchors.verticalCenter: parent.verticalCenter
                }

                Rectangle{
                    width: parent.width * 58/100
                    height: parent.height * 3/4
                    color: 'transparent'
                    Label{
                        id: pageName
                        text: 'Lightning'
                        color: '#33B5E6'
                        font.pixelSize: parent.width * 5/100
                        font.family: 'IRANSansXFaNum';
//                        font.weight: 100
                        font.bold: true
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                    }
                }


            }

            Flickable{
                id: flickble
                width: parent.width
                height: parent.height * 70/100 /** 10/12*/
                flickableDirection: Flickable.VerticalFlick
                boundsBehavior: Flickable.DragOverBounds
                clip: true
                contentHeight: panelGrid.height
                ScrollBar.vertical: ScrollBar{
                    width: flickble.width * 1/100
                    anchors.right: parent.right
                    background: Rectangle{
                        color: 'transparent'
                    }
                    contentItem: Rectangle{
                        color: '#3d3d3d' //UIStyle.scrollbar
                        radius: width * 1/2
                    }
                    policy: ScrollBar.AlwaysOn
                    snapMode: ScrollBar.SnapAlways
                }
                Grid{
                    id: panelGrid
                    width: parent.width * 8/10
//                    topPadding: height * 12/100
                    leftPadding: width * 7/100
                    columns: 4
                    spacing: width * 3/100
                    Repeater{
                        id: relayRepeatr
                        model: 16
                        Rectangle {
                            width: relayColumn.width * 20/100
                            height: width
                            radius:10
                            rotation: 90
                            visible: relayPage[index] === pageNumber
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
                                        source: 'qrc:/images/' + relayMap[relayType[index]] + '-' + (relayStatus[index]? 'on':'off')+ '.png'
                                    }

                                    Label{
                                        text: relayFarsiMap[relayType[index]]
                                        color: '#FE8A1F'
                                        font.family: 'Inter'
                                        font.pixelSize: parent.width * 8/100
                                        anchors.right: parent.right
                                    }

                                    Label{
                                        text: relayMap[relayType[index]]
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
                                        color: relayStatus[index] ? '#33B5E6' : '#B3B3B3'
                                        radius: 5
                                        Rectangle{
                                            width: parent.width - 5
                                            height: parent.height
                                            x: 5
                                            color: relayStatus[index] ? '#33B5E6' : '#B3B3B3'
                                            Label{
                                                anchors.verticalCenter: parent.verticalCenter
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                text: 'ON'
                                                color: relayStatus[index] ? '#FFFFFF' : '#33B5E6'
                                            }
                                        }
                                    }
                                    Rectangle{
                                        width: parent.width * 4/10
                                        height: parent.height * 6/10 + !relayStatus[index]
                                        anchors.verticalCenter: parent.verticalCenter
                                        color: relayStatus[index] ? '#B3B3B3' : '#33B5E6'
                                        radius: 5
                                        Rectangle{
                                            width: parent.width - 5
                                            height: parent.height
                                            color: relayStatus[index] ? '#B3B3B3' : '#33B5E6'
                                            Label{
                                                anchors.verticalCenter: parent.verticalCenter
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                text: 'OFF'
                                                color: relayStatus[index] ? '#33B5E6' : '#FFFFFF'
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
                        }
                    }

                    Rectangle{
                        width: relayColumn.width * 20/100
                        height: width
                        radius:5
                        gradient: Gradient{
                            GradientStop{position: 0.1; color:'#4B4B4B'}
                            GradientStop{position: 1.0; color:'#232323'}
                        }

                        Column{
                            width: parent.width
                            height: parent.height * 4/10
                            topPadding: parent.height * 25/100
                            spacing: height*15/100
                            Image{
                                source: 'qrc:/images/all.png'
                                anchors.horizontalCenter:  parent.horizontalCenter
                            }
                            Label{
                                text: 'روشن کردن همه'
                                color: '#FE8A1F'
                                font.family: 'Inter'
                                font.pixelSize: parent.width * 7/100
                                anchors.horizontalCenter:  parent.horizontalCenter
                            }
                            Label{
                                text: 'Turn all on'
                                color: '#FFFFFF'
                                font.family: 'Inter'
                                font.pixelSize: parent.width * 7/100
                                anchors.horizontalCenter:  parent.horizontalCenter
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: serialInterface.changeState(30, false)
                        }
                    }

                    Rectangle{
                        width: relayColumn.width * 20/100
                        height: width
                        radius:5
                        gradient: Gradient{
                            GradientStop{position: 0.1; color:'#4B4B4B'}
                            GradientStop{position: 1.0; color:'#232323'}
                        }

                        Column{
                            width: parent.width
                            height: parent.height * 4/10
                            topPadding: parent.height * 25/100
                            spacing: height*15/100
                            Image{
                                source: 'qrc:/images/all.png'
                                anchors.horizontalCenter:  parent.horizontalCenter
                            }
                            Label{
                                text: 'خاموش کردن همه'
                                color: '#FE8A1F'
                                font.family: 'Inter'
                                font.pixelSize: parent.width * 7/100
                                anchors.horizontalCenter:  parent.horizontalCenter
                            }
                            Label{
                                text: 'Turn all off'
                                color: '#FFFFFF'
                                font.family: 'Inter'
                                font.pixelSize: parent.width * 7/100
                                anchors.horizontalCenter:  parent.horizontalCenter
                            }
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: serialInterface.changeState(30, true)
                        }
                    }
                }
            }

            Rectangle{ //delete
                id: connectionRct
                width: parent.width * 15/100 //(serialStatus ? 1/10 : 2/10)
                height: 1 //parent.height * 1/100
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: mainWindow.bottom
                radius: 5
                color: serialStatus ? '#2FB000' : '#B0002F'
                visible: false
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


            Row{
                width: parent.width * 4/10
                height: parent.height * 25/100
                spacing: width*5/100
                anchors.horizontalCenter: parent.horizontalCenter
                visible: false
            }
        }

        Column{
            id: settings
            width: parent.width * 75/100
            height: parent.height * 9/10
            spacing: height * 5/100
            visible: pageNumber==7
            Grid{
                id: settingsGrid
                width: parent.width * 8/10
                topPadding: height * 5/100
                leftPadding: width * 8/100
                columns: 2
//                spacing: width * 2/100
                Repeater{
                    id: settingsRepeater
                    model: 16
                    Row{
                        width: relayColumn.width * 45/100
                        height: width * 18/100
                        spacing: width*5/100
                        Rectangle{
                            width: parent.width*14/100
                            height: parent.height
                            color: 'transparent'
                            Label{
                                text: 'Relay ' + (index+1)
                                color: 'white'
                                anchors.centerIn: parent
                                font.pixelSize: parent.width * 25/100
                            }
                        }
                        ComboBox{
                            id: labelComboBox
                            width: parent.width*35/100
                            height: parent.height * 5/10
                            editable: true
                            anchors.verticalCenter: parent.verticalCenter
                            Material.theme: Material.Dark
                            Material.accent: Material.Teal
                            contentItem: Text {
                                        text: parent.displayText
                                        font.family: "Arial"
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
//                                        elide: Text.ElideMiddle
                                        color: '#FFFFFF'
                                        font.pixelSize: parent.width * 9/100
                                    }
                            background: Rectangle{
                                width: parent.width
                                height: parent.height
                                color: '#191919'
                            }
                            model: relayMap
                            currentIndex: relayType[index]
                            onCurrentIndexChanged: settingsChanged(index, labelComboBox.currentIndex, pageComboBox.currentIndex)
                        }

                        ComboBox{
                            id: pageComboBox
                            width: parent.width*30/100
                            height: parent.height * 5/10
                            editable: true
                            anchors.verticalCenter: parent.verticalCenter
                            Material.theme: Material.Dark
                            Material.accent: Material.Teal
                            contentItem: Text {
                                        text: parent.displayText
                                        font.family: "Arial"
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
//                                        elide: Text.ElideMiddle
                                        color: '#FFFFFF'
                                        font.pixelSize: parent.width * 10/100
                                    }
                            background: Rectangle{
                                width: parent.width
                                height: parent.height
                                color: '#191919'
                            }
                            model: pageNames
                            currentIndex: relayPage[index]
                            onCurrentIndexChanged: settingsChanged(index, labelComboBox.currentIndex, pageComboBox.currentIndex)
                        }
                    }
                }
            }
        }
    }
}
