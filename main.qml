// Its is not recommended to try to understand this file without Qt Creator IDE.
// Using Qt designer you can preview the application and see the whole application Tree.

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.11
import QtQuick.Controls.Styles 1.4

Window {
    property color dark_gray: "#404040"
    property color light_gray: "#535353"
    property color light_green: "#45ff19"
    property bool app_maximized: false
    property color property_primary_color: "#535353"
    property color property_secondary_color: "#404040"
    property color property_third_color: "#b3b3b3"

    // sets the colors of the whole GUI
    function loadColors(){
        root.property_primary_color = backend.PrimaryColorProperty
        itemColorChoiceBarPrimary.setPrimaryColor(backend.PrimaryColorProperty)
        itemColorChoiceBarSecondary.setSecondaryColor(backend.SecondaryColorProperty)
        itemColorChoiceBarText.setTextColor(backend.ThirdColorProperty)
    }


    id: root
    flags: Qt.FramelessWindowHint | Qt.Window
    width: 640
    height: 300
    visible: true
    color: root.property_primary_color // "#2d2d2d"

    onVisibilityChanged: {
        //console.log("Visiblity changed"); // postponed for future updates
    }

    // when window object finishes loading (onCompleted), run the loadColors function.
    Component.onCompleted: {
        root.loadColors()
    }

    Item {
        id: itemTitleBar
        height: 35
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0

        DragHandler { // allows dragging the application across the screen
            onActiveChanged: if (active) root.startSystemMove();
            target: null
        }

        MouseArea {
            id: mouseArea
            height: 35
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.rightMargin: 180
            anchors.topMargin: 0
            hoverEnabled: true
            onDoubleClicked: { // maximizes the window on double click on title bar (and changes maximize icon)
                if(root.app_maximized == true){
                    imageRestoreAppButton.source = "imports/icons/maximize-app-icon.png";
                    root.showNormal();
                    root.app_maximized = false;
                }
                else if(root.app_maximized == false){
                    imageRestoreAppButton.source = "imports/icons/restore-size-app-icon.png";
                    root.showMaximized();

                    root.app_maximized = true;
                }
            }
            // makes the title bar effect of extending dark color bar
            onEntered: {
                rectTitleBarHoverEffect.property_animation_time = 500
                rectTitleBarHoverEffect.property_width = root.width - 180
                lableSettingsButton.property_leftMargin = 0
            }
            onExited: {
                rectTitleBarHoverEffect.property_animation_time = 500
                rectTitleBarHoverEffect.property_width = 0
                lableSettingsButton.property_leftMargin = -60
            }


        }

        Rectangle {
            property int property_animation_time: 500
            property int property_width: 0
            id: rectTitleBarHoverEffect
            width: property_width
            height: 35
            opacity: 1
            color: root.property_secondary_color
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.topMargin: 0

            Behavior on property_width {
                NumberAnimation{
                    duration: rectTitleBarHoverEffect.property_animation_time
                }
            }
        }



        Item {
            id: itemRestoreAppButton
            x: 520
            y: 0
            width: 60
            height: 35
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 60
            anchors.topMargin: 0

            MouseArea {
                id: mouseAreaRestoreAppButton
                anchors.fill: parent
                hoverEnabled: true
                // maxmizes or restores window size button
                onClicked: {
                    if(root.app_maximized == true){
                        imageRestoreAppButton.source = "imports/icons/maximize-app-icon.png";
                        root.showNormal();
                        root.app_maximized = false;
                    }
                    else if(root.app_maximized == false){
                        imageRestoreAppButton.source = "imports/icons/restore-size-app-icon.png";
                        root.showMaximized();
                        root.app_maximized = true;
                    }
                }
                onEntered: {
                    rectRestoreAppHoverEffect.property_height = 35
                }
                onExited: {
                    rectRestoreAppHoverEffect.property_height = 0
                }

            }

            Rectangle {
                property int property_height: 0
                id: rectRestoreAppHoverEffect
                y: 0
                width: 60
                height: property_height
                opacity: 1
                color: root.property_secondary_color
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0

                Behavior on property_height {
                    NumberAnimation{
                        duration: 200
                    }
                }
            }

            Image {
                id: imageRestoreAppButton
                x: 0
                y: 0
                source: "imports/icons/maximize-app-icon.png"
                fillMode: Image.PreserveAspectFit
            }
        }

        Item {
            id: itemCloseAppButton
            x: 580
            width: 60
            height: 35
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.rightMargin: 0


            MouseArea {
                id: mouseAreaCloseAppButton
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    backend.customCloseApp()
                }
                onEntered: {
                    rectCloseAppHoverEffect.property_height = 35
                }
                onExited: {
                    rectCloseAppHoverEffect.property_height = 0
                }



            }

            Rectangle {
                property int property_height: 0
                id: rectCloseAppHoverEffect
                y: 0
                width: 60
                height: property_height
                opacity: 1
                color: "#ff4444"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0

                Behavior on property_height {
                    NumberAnimation{
                        duration: 200
                    }
                }
            }

            Image {
                id: imageCloseAppButton
                width: 60
                anchors.fill: parent
                source: "imports/icons/close-app-icon.png"
                anchors.topMargin: 0
                fillMode: Image.PreserveAspectFit
            }

        }

        Item {
            id: itemMinimizeAppButton
            x: 460
            y: 0
            width: 60
            height: 35
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 120
            anchors.topMargin: 0

            MouseArea {
                id: mouseAreaMinimizeAppButton
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    root.showMinimized()
                }
                onEntered: {
                    rectMinimizeAppHoverEffect.property_height = 35
                }
                onExited: {
                    rectMinimizeAppHoverEffect.property_height = 0
                }


            }

            Rectangle {
                property int property_height: 0
                id: rectMinimizeAppHoverEffect
                y: 0
                width: 60
                height: property_height
                opacity: 1
                color: root.property_secondary_color
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0

                Behavior on property_height {
                    NumberAnimation{
                        duration: 200
                    }
                }
            }

            Image {
                id: imageMinimizeAppButton
                x: 0
                y: 0
                source: "imports/icons/minimize-app-icon.png"
                fillMode: Image.PreserveAspectFit
            }
        }


        Item {
            id: itemSettingsAppButton
            width: 60
            height: 35
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.leftMargin: 0

            MouseArea {
                id: mouseAreaSettingsAppButton
                anchors.fill: parent
                hoverEnabled: true
                // shows settings and disable main window and vice versa on click
                onClicked: {
                    if(itemSettingsWindow.enabled == true){
                        itemSettingsWindow.enabled = false;
                        itemSettingsWindow.visible = false;
                        itemCentralWindow.visible = true;
                        itemCentralWindow.enabled = true;

                    }
                    else if (itemSettingsWindow.enabled == false){
                        itemSettingsWindow.enabled = true;
                        itemSettingsWindow.visible = true;
                        itemCentralWindow.enabled = false;
                        itemCentralWindow.visible = false;
                    }
                }
                onEntered: {
                    rectTitleBarHoverEffect.property_animation_time = 200
                    rectTitleBarHoverEffect.property_width = 60
                    lableSettingsButton.property_leftMargin = 0
                }
                onExited: {
                    rectTitleBarHoverEffect.property_animation_time = 200
                    rectTitleBarHoverEffect.property_width = 0
                    lableSettingsButton.property_leftMargin = -60
                }


            }

            Label {
                property int property_leftMargin: -60
                id: lableSettingsButton
                width: 60
                color: root.property_third_color
                text: qsTr("Settings")
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.leftMargin: property_leftMargin
                anchors.bottomMargin: 0
                anchors.topMargin: 0
                font.family: "Arial"
                Behavior on property_leftMargin {
                    NumberAnimation{
                        duration: 200
                    }
                }
            }


        }

    }


    Item {
        id: itemCentralWindow
        height: 0
        anchors.fill: parent
        anchors.topMargin: 35
        enabled: true
        visible: true

        Rectangle{
            id: rectCentralWindow
            height: 0
            color: root.property_primary_color
            anchors.fill: parent
            anchors.topMargin: 35
            enabled: true
            visible: true
        }

        Item {
            property int buttons_topMargin: -35 // tells all the buttons to hide
            property string property_ActionChosen: "Shutdown"
            id: itemChooseAction
            y: 227
            height: 35
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0



            MouseArea {
                id: mouseAreaChooseAction
                x: 0
                y: 0
                height: 35
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                propagateComposedEvents: true
                anchors.bottomMargin: 0
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                hoverEnabled: true
            }

            Label {
                id: labelPerformAction
                x: 0
                y: -24
                width: 132
                height: 27
                color: root.property_third_color
                text: qsTr("CHOOSE ACTION:")
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignBottom
                anchors.bottomMargin: 35
                anchors.leftMargin: 0
                font.family: "Arial"
            }

            Rectangle {
                id: rectActionChosen
                y: 0
                width: 128
                height: 35
                opacity: 1
                color: root.property_secondary_color
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.bottomMargin: 0

                Label {
                    id: labelActionChosen
                    x: 0
                    y: 0
                    color: root.property_third_color
                    text: qsTr("Shutdown")
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 12
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    font.family: "Arial"
                }

                MouseArea {
                    id: mouseAreaActionChosen
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: {
                        rectActionChosen.color = root.property_third_color
                        labelActionChosen.color = root.property_secondary_color
                        itemChooseAction.buttons_topMargin = 0
                    }
                    onExited: {
                        rectActionChosen.color = root.property_secondary_color
                        labelActionChosen.color = root.property_third_color
                        itemChooseAction.buttons_topMargin = -35
                    }
                }
            }

            Rectangle {
                id: rectChooseFirst
                y: 0
                width: 128
                height: 35
                opacity: 1
                color: root.property_secondary_color
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.bottomMargin: itemChooseAction.buttons_topMargin
                anchors.leftMargin: 128

                Behavior on anchors.bottomMargin{
                    NumberAnimation{
                        duration: 200
                    }
                }

                Label {
                    id: labelChooseFirst
                    color: root.property_third_color
                    text: qsTr("Reboot")
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 12
                    font.family: "Arial"
                }

                MouseArea {
                    id: mouseAreaChooseFirst
                    anchors.fill: parent
                    anchors.bottomMargin: 0
                    hoverEnabled: true

                    onClicked: {
                        itemChooseAction.property_ActionChosen = labelChooseFirst.text // adds name of button clicked to memory
                        backend.setActionChosen(labelChooseFirst.text)
                        labelChooseFirst.text = labelActionChosen.text // change chosen text to clicked button text
                        labelActionChosen.text = itemChooseAction.property_ActionChosen // change chosen text to button clicked text (from memory)


                    }

                    onEntered: {
                        rectChooseFirst.color = root.property_third_color
                        labelChooseFirst.color = root.property_secondary_color
                        itemChooseAction.buttons_topMargin = 0
                    }
                    onExited: {
                        rectChooseFirst.color = root.property_secondary_color
                        labelChooseFirst.color = root.property_third_color
                        itemChooseAction.buttons_topMargin = -35
                    }
                }
            }

            Rectangle {
                id: rectChooseSecond
                y: 35
                width: 128
                height: 35
                opacity: 1
                color: root.property_secondary_color
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.bottomMargin: itemChooseAction.buttons_topMargin
                anchors.leftMargin: 256

                Behavior on anchors.bottomMargin{
                    NumberAnimation{
                        duration: 300
                    }

                }

                Label {
                    id: labelChooseSecond
                    color: root.property_third_color
                    text: qsTr("Logout")
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Arial"
                    font.pointSize: 12
                }

                MouseArea {
                    id: mouseAreaChooseSecond
                    anchors.fill: parent
                    hoverEnabled: true
                    anchors.bottomMargin: 0

                    onClicked: {
                        itemChooseAction.property_ActionChosen = labelChooseSecond.text // adds name of button clicked to memory
                        backend.setActionChosen(labelChooseSecond.text)
                        labelChooseSecond.text = labelActionChosen.text // change chosen text to clicked button text
                        labelActionChosen.text = itemChooseAction.property_ActionChosen // change chosen text to button clicked text (from memory)

                    }

                    onExited: {
                        rectChooseSecond.color = root.property_secondary_color
                        labelChooseSecond.color = root.property_third_color
                        itemChooseAction.buttons_topMargin = -35
                    }
                    onEntered: {
                        rectChooseSecond.color = root.property_third_color
                        labelChooseSecond.color = root.property_secondary_color
                        itemChooseAction.buttons_topMargin = 0
                    }
                }
            }

            Rectangle {
                id: rectChooseThird
                y: 35
                width: 128
                height: 35
                opacity: 1
                color: root.property_secondary_color
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.bottomMargin: itemChooseAction.buttons_topMargin
                anchors.leftMargin: 384

                Behavior on anchors.bottomMargin{
                    NumberAnimation{
                        duration: 400
                    }
                }

                Label {
                    id: labelChooseThird
                    color: root.property_third_color
                    text: qsTr("Hibernate")
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Arial"
                    font.pointSize: 12
                }

                MouseArea {
                    id: mouseAreaChooseThird
                    anchors.fill: parent
                    hoverEnabled: true
                    anchors.bottomMargin: 0
                    onClicked: {
                        itemChooseAction.property_ActionChosen = labelChooseThird.text // adds name of button clicked to memory
                        backend.setActionChosen(labelChooseThird.text)
                        labelChooseThird.text = labelActionChosen.text // change chosen text to clicked button text
                        labelActionChosen.text = itemChooseAction.property_ActionChosen // change chosen text to button clicked text (from memory)

                    }

                    onExited: {
                        rectChooseThird.color = root.property_secondary_color
                        labelChooseThird.color = root.property_third_color
                        itemChooseAction.buttons_topMargin = -35
                    }
                    onEntered: {
                        rectChooseThird.color = root.property_third_color
                        labelChooseThird.color = root.property_secondary_color

                        itemChooseAction.buttons_topMargin = 0
                    }
                }
            }

            Rectangle {
                id: rectChooseFourth
                y: 35
                width: 128
                height: 35
                opacity: 1
                color: root.property_secondary_color
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.bottomMargin: itemChooseAction.buttons_topMargin
                anchors.leftMargin: 512

                Behavior on anchors.bottomMargin{
                    NumberAnimation{
                        duration: 500
                    }
                }

                Label {
                    id: labelChooseFourth
                    color: root.property_third_color
                    text: qsTr("Maintenance")
                    anchors.fill: parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Arial"
                    font.pointSize: 12
                }

                MouseArea {
                    id: mouseAreaChooseFourth
                    anchors.fill: parent
                    hoverEnabled: true
                    anchors.bottomMargin: 0
                    onClicked: {
                        itemChooseAction.property_ActionChosen = labelChooseFourth.text // adds name of button clicked to memory
                        backend.setActionChosen(labelChooseFourth.text)
                        labelChooseFourth.text = labelActionChosen.text // change chosen text to clicked button text
                        labelActionChosen.text = itemChooseAction.property_ActionChosen // change chosen text to button clicked text (from memory)

                    }

                    onExited: {
                        rectChooseFourth.color = root.property_secondary_color
                        labelChooseFourth.color = root.property_third_color
                        itemChooseAction.buttons_topMargin = -35
                    }
                    onEntered: {
                        rectChooseFourth.color = root.property_third_color
                        labelChooseFourth.color = root.property_secondary_color
                        itemChooseAction.buttons_topMargin = 0
                    }
                }
            }
        }

        RowLayout {
            id: layoutInputFields
            x: 80
            y: 60
            width: 480
            height: 35
            anchors.verticalCenter: rectCentralWindow.verticalCenter
            anchors.verticalCenterOffset: -70
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 15

            Item {
                property int property_hours_value: 0
                id: itemInputFieldHour
                width: 150
                height: 35
                enabled: true

                TextField {
                    property string property_hours_text_value: "" + backend.HoursValue
                    id: textFieldHour
                    text: property_hours_text_value
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Text.AlignHCenter
                    placeholderTextColor: "#353637"
                    font.kerning: true
                    anchors.rightMargin: 25
                    anchors.leftMargin: 25
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    placeholderText: qsTr("Hours")
                    selectByMouse: true
                    maximumLength: 3
                    validator: IntValidator { // validator allows only Int value to be typed
                        bottom: 1;
                        top: 999;
                    }
                    // sends choosen action to C++ side (backend) and does following action based on value (limit control, etc..)
                    onTextChanged: {
                        if(textFieldHour.text.length == 0){
                            backend.setHoursValue(0)
                        }
                        else{
                            backend.setHoursValue(textFieldHour.text)
                        }
                        if(textFieldHour.text <= 998 && textFieldHour.text > 0){
                            rectDownButtonHour.property_rightMargin = 0;
                            rectUpButtonHour.property_leftMargin = 0;
                            labelUpButtonHour.visible = true;
                            labelDownButtonHour.visible = true;
                        }
                        else if(textFieldHour.text <= 0){ // equal 0 or by ANY chance, smaller than.
                            rectDownButtonHour.property_rightMargin = 50;
                            rectUpButtonHour.property_leftMargin = 0;
                            labelDownButtonHour.visible = false;
                            labelUpButtonHour.visible = true;

                        }
                        else if(textFieldHour.text >= 999){
                            rectDownButtonHour.property_rightMargin = 0;
                            rectUpButtonHour.property_leftMargin = 50;
                            labelUpButtonHour.visible = false;
                            labelDownButtonHour.visible = true;
                        }

                    }
                }

                Rectangle {
                    property int property_rightMargin: 50
                    id: rectDownButtonHour
                    width: 25
                    opacity: 1.0
                    color: root.property_secondary_color
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.rightMargin: property_rightMargin
                    anchors.leftMargin: 125

                    Behavior on property_rightMargin{
                        NumberAnimation {
                            duration: 200
                        }
                    }

                    Label {
                        id: labelDownButtonHour
                        color: root.property_third_color
                        text: qsTr("-")
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.bottomMargin: 2
                        anchors.topMargin: -2
                        font.pointSize: 15
                        font.family: "Arial"
                    }

                    MouseArea {
                        id: mouseAreaDownButtonHour
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            labelDownButtonHour.color = root.property_secondary_color
                            rectDownButtonHour.color = root.property_third_color
                        }
                        onExited: {
                            labelDownButtonHour.color = root.property_third_color
                            rectDownButtonHour.color = root.property_secondary_color
                        }
                        onClicked: {
                            if(textFieldHour.text < 1000 && textFieldHour.text > 0){
                                backend.setHoursValue(backend.HoursValue - 1);

                            }
                        }

                    }
                }

                Rectangle {
                    property int property_leftMargin: 0
                    id: rectUpButtonHour
                    width: 200
                    opacity: 1.0
                    color: root.property_secondary_color
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: property_leftMargin
                    anchors.rightMargin: 125
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    Behavior on property_leftMargin{
                        NumberAnimation{
                            duration: 200
                        }
                    }

                    Label {
                        id: labelUpButtonHour
                        color: root.property_third_color
                        text: qsTr("+")
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Arial"
                        font.pointSize: 14
                    }

                    MouseArea {
                        id: mouseAreaUpButtonHour
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            labelUpButtonHour.color = root.property_secondary_color
                            rectUpButtonHour.color = root.property_third_color
                        }
                        onExited: {
                            labelUpButtonHour.color = root.property_third_color
                            rectUpButtonHour.color = root.property_secondary_color
                        }
                        onClicked: {
                            if(textFieldHour.text < 999 && textFieldHour.text >= 0){
                                backend.setHoursValue(backend.HoursValue + 1);

                            }
                        }


                    }
                }

                Text {
                    id: textHoursTitle
                    y: -27
                    height: 21
                    color: root.property_third_color
                    text: qsTr("Hours")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.bottomMargin: 40
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    font.family: "Arial"
                }
            }

            Item {
                property int property_minutes_value: 0
                id: itemInputFieldMinute
                width: 150
                height: 35
                enabled: true

                TextField {
                    property string property_minutes_text_value: "" + backend.MinutesValue
                    id: textFieldMinute
                    text: property_minutes_text_value
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Text.AlignHCenter
                    placeholderTextColor: "#c3c3c3"
                    font.kerning: true
                    anchors.rightMargin: 25
                    anchors.leftMargin: 25
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    placeholderText: qsTr("Minutes")
                    selectByMouse: true
                    maximumLength: 2
                    validator: IntValidator { // validator allows only Int values to be typed
                        bottom: 1;
                        top: 60;
                    }
                    // when text is changed, sends value to c++ and performs limit control (make sure values dont get over 60, etc)
                    onTextChanged: {
                        if(textFieldMinute.text.length == 0){
                            backend.setMinutesValue(0)
                        }
                        else{
                            backend.setMinutesValue(textFieldMinute.text)
                        }
                        if(textFieldMinute.text <= 59 && textFieldMinute.text > 0){
                            rectDownButtonMinute.property_rightMargin = 0;
                            rectUpButtonMinute.property_leftMargin = 0;
                            labelDownButtonMinute.visible = true;
                        }
                        else if(textFieldMinute.text <= 0){ // equal 0 or by ANY chance, smaller than.
                            rectDownButtonMinute.property_rightMargin = 50;
                            rectUpButtonMinute.property_leftMargin = 0;
                            labelDownButtonMinute.visible = false;
                        }
                        else if(textFieldMinute.text >= 60){
                            if (backend.HoursValue < 999){
                                // sets modulus of 60 to Minutes
                                backend.setMinutesValue(backend.MinutesValue % 60);

                                // append 1 to hours
                                backend.setHoursValue(backend.HoursValue + 1);
                            }
                        }
                    }
                }

                Rectangle {
                    property int property_rightMargin: 50
                    id: rectDownButtonMinute
                    width: 25
                    opacity: 1.0
                    color: root.property_secondary_color
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.rightMargin: property_rightMargin
                    anchors.leftMargin: 125

                    Behavior on property_rightMargin{
                        NumberAnimation {
                            duration: 200
                        }
                    }

                    Label {
                        id: labelDownButtonMinute
                        color: root.property_third_color
                        text: qsTr("-")
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.bottomMargin: 2
                        anchors.topMargin: -2
                        font.pointSize: 15
                        font.family: "Arial"
                    }

                    MouseArea {
                        id: mouseAreaDownButtonMinute
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            labelDownButtonMinute.color = root.property_secondary_color
                            rectDownButtonMinute.color = root.property_third_color
                        }
                        onExited: {
                            labelDownButtonMinute.color = root.property_third_color
                            rectDownButtonMinute.color = root.property_secondary_color
                        }
                        onClicked: {
                            if(textFieldMinute.text < 60 && textFieldMinute.text > 0){
                                backend.setMinutesValue(backend.MinutesValue - 1);

                            }
                        }

                    }
                }

                Rectangle {
                    property int property_leftMargin: 0
                    id: rectUpButtonMinute
                    width: 200
                    opacity: 1.0
                    color: root.property_secondary_color
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: property_leftMargin
                    anchors.rightMargin: 125
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    Behavior on property_leftMargin{
                        NumberAnimation{
                            duration: 200
                        }
                    }

                    Label {
                        id: labelUpButtonMinute
                        color: root.property_third_color
                        text: qsTr("+")
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Arial"
                        font.pointSize: 14
                    }

                    MouseArea {
                        id: mouseAreaUpButtonMinute
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            labelUpButtonMinute.color = root.property_secondary_color
                            rectUpButtonMinute.color = root.property_third_color
                        }
                        onExited: {
                            labelUpButtonMinute.color = root.property_third_color
                            rectUpButtonMinute.color = root.property_secondary_color
                        }
                        onClicked: {
                            if(textFieldMinute.text < 60 && textFieldMinute.text >= 0){
                                backend.setMinutesValue(backend.MinutesValue + 1);


                            }
                        }
                    }
                }

                Text {
                    id: textMinutesTitle
                    x: -160
                    y: -26
                    height: 21
                    color: root.property_third_color
                    text: qsTr("Minutes")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 0
                    font.family: "Arial"
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 40
                }
            }

            Item {
                property int property_seconds_value: 0

                id: itemInputFieldSecond
                width: 150
                height: 35
                enabled: true

                TextField {
                    property string property_seconds_text_value: "" + backend.SecondsValue
                    id: textFieldSecond
                    text: property_seconds_text_value
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    horizontalAlignment: Text.AlignHCenter
                    placeholderTextColor: "#353637"
                    font.kerning: true
                    anchors.rightMargin: 25
                    anchors.leftMargin: 25
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    placeholderText: qsTr("Seconds")
                    selectByMouse: true
                    maximumLength: 2
                    validator: IntValidator {
                        bottom: 1;
                        top: 60;
                    }
                    // when text is changed, sends value to c++ and performs limit control (make sure values dont get over 60, etc)
                    onTextChanged: {
                        if(textFieldSecond.text.length == 0){
                            backend.setSecondsValue(0)
                        }
                        else{
                            backend.setSecondsValue(textFieldSecond.text)
                        }
                        if(textFieldSecond.text <= 59 && textFieldSecond.text > 0){
                            rectDownButtonSecond.property_rightMargin = 0;
                            rectUpButtonSecond.property_leftMargin = 0;
                            labelDownButtonSecond.visible = true;
                        }
                        else if(textFieldSecond.text <= 0){ // equal 0 or by ANY chance, smaller than.
                            rectDownButtonSecond.property_rightMargin = 50;
                            rectUpButtonSecond.property_leftMargin = 0;
                            labelDownButtonSecond.visible = false;
                        }
                        else if(textFieldSecond.text >= 60){
                            rectDownButtonSecond.property_rightMargin = 0;
                            rectUpButtonSecond.property_leftMargin = 0;

                            // reset Seconds to modulu of 60 once reached 60
                            backend.setSecondsValue(backend.SecondsValue % 60);

                            // append 1 to minutes
                            backend.setMinutesValue(backend.MinutesValue + 1);

                        }

                    }
                }

                Rectangle {
                    property int property_rightMargin: 50
                    id: rectDownButtonSecond
                    width: 25
                    opacity: 1.0
                    color: root.property_secondary_color
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.rightMargin: property_rightMargin
                    anchors.leftMargin: 125

                    Behavior on property_rightMargin{
                        NumberAnimation {
                            duration: 200
                        }
                    }

                    Label {
                        id: labelDownButtonSecond
                        color: root.property_third_color
                        text: qsTr("-")
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.bottomMargin: 2
                        anchors.topMargin: -2
                        font.pointSize: 15
                        font.family: "Arial"
                    }

                    MouseArea {
                        id: mouseAreaDownButtonSecond
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            labelDownButtonSecond.color = root.property_secondary_color
                            rectDownButtonSecond.color = root.property_third_color
                        }
                        onExited: {
                            labelDownButtonSecond.color = root.property_third_color
                            rectDownButtonSecond.color = root.property_secondary_color
                        }
                        onClicked: {
                            if(textFieldSecond.text < 61 && textFieldSecond.text > 0){
                                backend.setSecondsValue(backend.SecondsValue - 1);

                            }
                        }

                    }
                }

                Rectangle {
                    property int property_leftMargin: 0
                    id: rectUpButtonSecond
                    width: 200
                    opacity: 1.0
                    color: root.property_secondary_color
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: property_leftMargin
                    anchors.rightMargin: 125
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    Behavior on property_leftMargin{
                        NumberAnimation{
                            duration: 200
                        }
                    }

                    Label {
                        id: labelUpButtonSecond
                        color: root.property_third_color
                        text: qsTr("+")
                        anchors.fill: parent
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.family: "Arial"
                        font.pointSize: 14
                    }

                    MouseArea {
                        id: mouseAreaUpButtonSecond
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            labelUpButtonSecond.color = root.property_secondary_color
                            rectUpButtonSecond.color = root.property_third_color
                        }
                        onExited: {
                            labelUpButtonSecond.color = root.property_third_color
                            rectUpButtonSecond.color = root.property_secondary_color
                        }
                        onClicked: {
                            if(textFieldSecond.text <= 61 && textFieldSecond.text >= 0){
                                backend.setSecondsValue(backend.SecondsValue + 1);

                            }
                        }


                    }
                }

                Text {
                    id: textSecondsTitle
                    x: -164
                    y: -26
                    height: 21
                    color: root.property_third_color
                    text: qsTr("Seconds")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Arial"
                    anchors.leftMargin: 0
                    anchors.rightMargin: 0
                    anchors.bottomMargin: 40
                }
            }


        }

        Item {
            id: startTimerButton
            x: 105
            y: 133
            width: 430
            height: 35
            anchors.verticalCenter: rectCentralWindow.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: rectBottomButton
                opacity: 1
                color: root.property_third_color
                anchors.fill: parent
                anchors.rightMargin: 0
            }


            Rectangle {
                property int property_rightMargin: backend.RectButtonTopRightMargin
                id: rectTopButton
                opacity: 10.5
                color: root.property_secondary_color
                anchors.fill: parent
                anchors.rightMargin: property_rightMargin
                Behavior on property_rightMargin {
                    NumberAnimation{
                        duration: 1000
                    }
                }
            }


            Text {
                id: textTimerButton
                text: "START"
                anchors.fill: parent
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                color: root.property_third_color
            }

            MouseArea {
                id: mouseAreaTimerButton
                anchors.fill: parent
                anchors.rightMargin: 0
                hoverEnabled: true

                onEntered: {
                    rectTopButton.color = root.property_third_color
                    textTimerButton.color = root.property_secondary_color
                    rectTopButton.opacity = 0.25

                }
                onExited: {
                    rectTopButton.color = root.property_secondary_color
                    textTimerButton.color = root.property_third_color
                    rectTopButton.opacity = 1
                }
                onClicked: { // when start timer is clicked, changes text value, locks buttons and starts/stops timer from c++ side
                    if(textTimerButton.text == "START"){
                        textTimerButton.text = "STOP";
                        itemInputFieldHour.enabled = false
                        itemInputFieldMinute.enabled = false
                        itemInputFieldSecond.enabled = false
                        textFieldHour.deselect();
                        textFieldMinute.deselect();
                        textFieldSecond.deselect();
                        backend.onStartTimerButton_Clicked(true);
                    }

                    else if (textTimerButton.text == "STOP"){
                        textTimerButton.text = "START";
                        backend.onStartTimerButton_Clicked(false);
                        itemInputFieldHour.enabled = true
                        itemInputFieldMinute.enabled = true
                        itemInputFieldSecond.enabled = true
                        backend.RectButtonTopRightMargin = 0
                    }
                }
            }
        }
    }

    Item {
        // function used to set Colors to the whole graphical user interface - called on every color option with its own colors
        function setPreviewColors(primary_color, secondary_color){
            backend.setPrimaryColorProperty(primary_color)
            backend.setSecondaryColorProperty(secondary_color)
            backend.setThirdColorProperty("#b3b3b3")
            root.property_primary_color = primary_color
            root.property_secondary_color = secondary_color
            root.property_third_color = "#b3b3b3"
            // A workaround to a bug I couldn't solve properly - some objects do not change color unless directly directed
            // force color START timer button
            rectTopButton.color = secondary_color
            // force color Action Bar
            rectActionChosen.color = secondary_color
            rectChooseFirst.color = secondary_color
            rectChooseSecond.color = secondary_color
            rectChooseThird.color = secondary_color
            rectChooseFourth.color = secondary_color
            // force color UP/DOWN clock buttons
            rectUpButtonHour.color = secondary_color
            rectDownButtonHour.color = secondary_color
            rectUpButtonMinute.color = secondary_color
            rectDownButtonMinute.color = secondary_color
            rectUpButtonSecond.color = secondary_color
            rectDownButtonSecond.color = secondary_color
            // labels and text
            labelActionChosen.color = "#b3b3b3"
            labelChooseFirst.color = "#b3b3b3"
            labelChooseSecond.color = "#b3b3b3"
            labelChooseThird.color = "#b3b3b3"
            labelChooseFourth.color = "#b3b3b3"
            labelDownButtonHour.color = "#b3b3b3"
            labelDownButtonMinute.color = "#b3b3b3"
            labelDownButtonSecond.color = "#b3b3b3"
            labelUpButtonHour.color = "#b3b3b3"
            labelUpButtonMinute.color = "#b3b3b3"
            labelUpButtonSecond.color = "#b3b3b3"
            lableSettingsButton.color = "#b3b3b3"
            labelPerformAction.color = "#b3b3b3"
            textTimerButton.color = "#b3b3b3"

        }


        id: itemSettingsWindow
        x: 0
        y: 35
        width: 640
        height: 265
        enabled: false
        visible: false

        Rectangle {
            id: rectSettingsWindow
            color: root.property_primary_color
            anchors.fill: parent

            Rectangle {
                id: rectColorBar
                height: 80
                opacity: 1
                color: root.property_secondary_color
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 20

                Text {
                    id: text1
                    color: root.property_third_color
                    text: qsTr("PRESET COLOR:")
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: false
                    font.family: "Arial"
                }
            }

            RowLayout {
                id: rowLayout
                height: 30
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                spacing: 31
                anchors.topMargin: 55
                anchors.leftMargin: 20
                anchors.rightMargin: 20

                Item {
                    property bool property_is_chosen: rectPrimaryColorPreview1 === root.property_primary_color
                    id: itemColorPack1
                    width: 30
                    height: 30
                    visible: true

                    Rectangle {
                        id: rectColorChosen1
                        color: "#ffffff"
                        anchors.fill: parent
                        anchors.topMargin: -1
                        anchors.bottomMargin: -1
                        anchors.leftMargin: -1
                        anchors.rightMargin: -1
                    }

                    Rectangle {
                        id: rectPrimaryColorPreview1
                        color: "#535353"
                        anchors.fill: parent
                        anchors.bottomMargin: 10
                    }

                    Rectangle {
                        id: rectSecondaryColorPreview1
                        color: "#404040"
                        anchors.fill: parent
                        anchors.topMargin: 20
                        anchors.bottomMargin: 0
                    }

                    MouseArea {
                        id: mouseAreaColorPack1
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectColorChosen1.color = root.property_secondary_color;
                        }
                        onExited: {
                            rectColorChosen1.color = "#ffffff";

                        }
                        onClicked: {
                            itemSettingsWindow.setPreviewColors(rectPrimaryColorPreview1.color, rectSecondaryColorPreview1.color);
                        }
                    }
                }

                Item {
                    property bool property_is_chosen: rectPrimaryColorPreview2 === root.property_primary_color
                    id: itemColorPack2
                    width: 30
                    height: 30
                    visible: true
                    Rectangle {
                        id: rectColorChosen2
                        color: itemColorPack2.property_is_chosen ? "#45ff19" : "#ffffff"
                        anchors.fill: parent
                        anchors.bottomMargin: -1
                        anchors.rightMargin: -1
                        anchors.topMargin: -1
                        anchors.leftMargin: -1
                    }

                    Rectangle {
                        id: rectPrimaryColorPreview2
                        color: "#a90101"
                        anchors.fill: parent
                        anchors.bottomMargin: 10
                    }

                    Rectangle {
                        id: rectSecondaryColorPreview2
                        color: "#690101"
                        anchors.fill: parent
                        anchors.bottomMargin: 0
                        anchors.topMargin: 20
                    }

                    MouseArea {
                        id: mouseAreaColorPack2
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectColorChosen2.color = root.property_secondary_color;
                        }
                        onExited: {
                            rectColorChosen2.color = "#ffffff";

                        }
                        onClicked: {
                            itemSettingsWindow.setPreviewColors(rectPrimaryColorPreview2.color, rectSecondaryColorPreview2.color);
                        }
                    }
                }

                Item {
                    property bool property_is_chosen: rectPrimaryColorPreview3 === root.primary_color
                    id: itemColorPack3
                    width: 30
                    height: 30
                    visible: true
                    Rectangle {
                        id: rectColorChosen3
                        color: itemColorPack3.property_is_chosen ? root.light_green : "#ffffff"
                        anchors.fill: parent
                        anchors.bottomMargin: -1
                        anchors.rightMargin: -1
                        anchors.topMargin: -1
                        anchors.leftMargin: -1
                    }

                    Rectangle {
                        id: rectPrimaryColorPreview3
                        color: "#6700aa"
                        anchors.fill: parent
                        anchors.bottomMargin: 10
                    }

                    Rectangle {
                        id: rectSecondaryColorPreview3
                        color: "#39005d"
                        anchors.fill: parent
                        anchors.bottomMargin: 0
                        anchors.topMargin: 20
                    }

                    MouseArea {
                        id: mouseAreaColorPack3
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectColorChosen3.color = root.property_secondary_color;
                        }
                        onExited: {
                            rectColorChosen3.color = "#ffffff";

                        }
                        onClicked: {
                            itemSettingsWindow.setPreviewColors(rectPrimaryColorPreview3.color, rectSecondaryColorPreview3.color);
                        }
                    }
                }

                Item {
                    property bool property_is_chosen: rectPrimaryColorPreview4 === root.primary_color
                    id: itemColorPack4
                    width: 30
                    height: 30
                    visible: true
                    Rectangle {
                        id: rectColorChosen4
                        color: itemColorPack4.property_is_chosen ? root.light_green : "#ffffff"
                        anchors.fill: parent
                        anchors.bottomMargin: -1
                        anchors.rightMargin: -1
                        anchors.topMargin: -1
                        anchors.leftMargin: -1
                    }

                    Rectangle {
                        id: rectPrimaryColorPreview4
                        color: "#011ea9"
                        anchors.fill: parent
                        anchors.bottomMargin: 10
                    }

                    Rectangle {
                        id: rectSecondaryColorPreview4
                        color: "#001059"
                        anchors.fill: parent
                        anchors.bottomMargin: 0
                        anchors.topMargin: 20
                    }

                    MouseArea {
                        id: mouseAreaColorPack4
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectColorChosen4.color = root.property_secondary_color;
                        }
                        onExited: {
                            rectColorChosen4.color = "#ffffff";

                        }
                        onClicked: {
                            itemSettingsWindow.setPreviewColors(rectPrimaryColorPreview4.color, rectSecondaryColorPreview4.color);
                        }
                    }
                }

                Item {
                    property bool property_is_chosen: rectPrimaryColorPreview5 === root.primary_color
                    id: itemColorPack5
                    width: 30
                    height: 30
                    visible: true
                    Rectangle {
                        id: rectColorChosen5
                        color: itemColorPack5.property_is_chosen ? root.light_green : "#ffffff"
                        anchors.fill: parent
                        anchors.bottomMargin: -1
                        anchors.rightMargin: -1
                        anchors.topMargin: -1
                        anchors.leftMargin: -1
                    }

                    Rectangle {
                        id: rectPrimaryColorPreview5
                        color: "#019da5"
                        anchors.fill: parent
                        anchors.bottomMargin: 10
                    }

                    Rectangle {
                        id: rectSecondaryColorPreview5
                        color: "#01585d"
                        anchors.fill: parent
                        anchors.bottomMargin: 0
                        anchors.topMargin: 20
                    }

                    MouseArea {
                        id: mouseAreaColorPack5
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectColorChosen5.color = root.property_secondary_color;
                        }
                        onExited: {
                            rectColorChosen5.color = "#ffffff";

                        }
                        onClicked: {
                            itemSettingsWindow.setPreviewColors(rectPrimaryColorPreview5.color, rectSecondaryColorPreview5.color);
                        }
                    }
                }

                Item {
                    property bool property_is_chosen: rectPrimaryColorPreview6 === root.primary_color
                    id: itemColorPack6
                    width: 30
                    height: 30
                    visible: true
                    Rectangle {
                        id: rectColorChosen6
                        color: itemColorPack6.property_is_chosen ? root.light_green : "#ffffff"
                        anchors.fill: parent
                        anchors.bottomMargin: -1
                        anchors.rightMargin: -1
                        anchors.topMargin: -1
                        anchors.leftMargin: -1
                    }

                    Rectangle {
                        id: rectPrimaryColorPreview6
                        color: "#00aa49"
                        anchors.fill: parent
                        anchors.bottomMargin: 10
                    }

                    Rectangle {
                        id: rectSecondaryColorPreview6
                        color: "#005d28"
                        anchors.fill: parent
                        anchors.bottomMargin: 0
                        anchors.topMargin: 20
                    }

                    MouseArea {
                        id: mouseArea6
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectColorChosen6.color = root.property_secondary_color;
                        }
                        onExited: {
                            rectColorChosen6.color = "#ffffff";

                        }
                        onClicked: {
                            itemSettingsWindow.setPreviewColors(rectPrimaryColorPreview6.color, rectSecondaryColorPreview6.color);
                        }
                    }
                }

                Item {
                    property bool property_is_chosen: rectPrimaryColorPreview7 === root.primary_color
                    id: itemColorPack7
                    width: 30
                    height: 30
                    visible: true
                    Rectangle {
                        id: rectColorChosen7
                        color: itemColorPack7.property_is_chosen ? root.light_green : "#ffffff"
                        anchors.fill: parent
                        anchors.bottomMargin: -1
                        anchors.rightMargin: -1
                        anchors.topMargin: -1
                        anchors.leftMargin: -1
                    }

                    Rectangle {
                        id: rectPrimaryColorPreview7
                        color: "#9fa501"
                        anchors.fill: parent
                        anchors.bottomMargin: 10
                    }

                    Rectangle {
                        id: rectSecondaryColorPreview7
                        color: "#525500"
                        anchors.fill: parent
                        anchors.bottomMargin: 0
                        anchors.topMargin: 20
                    }

                    MouseArea {
                        id: mouseArea7
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectColorChosen7.color = root.property_secondary_color;
                        }
                        onExited: {
                            rectColorChosen7.color = "#ffffff";

                        }
                        onClicked: {
                            itemSettingsWindow.setPreviewColors(rectPrimaryColorPreview7.color, rectSecondaryColorPreview7.color);
                        }
                    }
                }

                Item {
                    property bool property_is_chosen: rectPrimaryColorPreview8 === root.primary_color
                    id: itemColorPack8
                    width: 30
                    height: 30
                    visible: true
                    Rectangle {
                        id: rectColorChosen8
                        color: itemColorPack8.property_is_chosen ? root.light_green : "#ffffff"
                        anchors.fill: parent
                        anchors.bottomMargin: -1
                        anchors.rightMargin: -1
                        anchors.topMargin: -1
                        anchors.leftMargin: -1
                    }

                    Rectangle {
                        id: rectPrimaryColorPreview8
                        color: "#aa6100"
                        anchors.fill: parent
                        anchors.bottomMargin: 10
                    }

                    Rectangle {
                        id: rectSecondaryColorPreview8
                        color: "#5e3500"
                        anchors.fill: parent
                        anchors.bottomMargin: 0
                        anchors.topMargin: 20
                    }

                    MouseArea {
                        id: mouseAreaColorPack8
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectColorChosen8.color = root.property_secondary_color;
                        }
                        onExited: {
                            rectColorChosen8.color = "#ffffff";

                        }
                        onClicked: {
                            itemSettingsWindow.setPreviewColors(rectPrimaryColorPreview8.color, rectSecondaryColorPreview8.color);
                        }
                    }
                }

                Item {
                    property bool property_is_chosen: rectPrimaryColorPreview9 === root.primary_color
                    id: itemColorPack9
                    width: 30
                    height: 30
                    visible: true
                    Rectangle {
                        id: rectColorChosen9
                        color: itemColorPack9.property_is_chosen ? root.light_green : "#ffffff"
                        anchors.fill: parent
                        anchors.bottomMargin: -1
                        anchors.rightMargin: -1
                        anchors.topMargin: -1
                        anchors.leftMargin: -1
                    }

                    Rectangle {
                        id: rectPrimaryColorPreview9
                        color: "#ae017e"
                        anchors.fill: parent
                        anchors.bottomMargin: 10
                    }

                    Rectangle {
                        id: rectSecondaryColorPreview9
                        color: "#5e0044"
                        anchors.fill: parent
                        anchors.bottomMargin: 0
                        anchors.topMargin: 20
                    }

                    MouseArea {
                        id: mouseAreaColorPack9
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectColorChosen9.color = root.property_secondary_color;
                        }
                        onExited: {
                            rectColorChosen9.color = "#ffffff";

                        }
                        onClicked: {
                            itemSettingsWindow.setPreviewColors(rectPrimaryColorPreview9.color, rectSecondaryColorPreview9.color);
                        }
                    }
                }

                Item {
                    property bool property_is_chosen: rectPrimaryColorPreview10 === root.primary_color
                    id: itemColorPack10
                    width: 30
                    height: 30
                    visible: true
                    Rectangle {
                        id: rectColorChosen10
                        color: itemColorPack10.property_is_chosen ? root.light_green : "#ffffff"
                        anchors.fill: parent
                        anchors.bottomMargin: -1
                        anchors.rightMargin: -1
                        anchors.topMargin: -1
                        anchors.leftMargin: -1
                    }

                    Rectangle {
                        id: rectPrimaryColorPreview10
                        color: "#bdbdbd"
                        anchors.fill: parent
                        anchors.bottomMargin: 10
                    }

                    Rectangle {
                        id: rectSecondaryColorPreview10
                        color: "#8a8a8a"
                        anchors.fill: parent
                        anchors.bottomMargin: 0
                        anchors.topMargin: 20
                    }

                    MouseArea {
                        id: mouseAreaColorPack10
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectColorChosen10.color = root.property_secondary_color;
                        }
                        onExited: {
                            rectColorChosen10.color = "#ffffff";

                        }
                        onClicked: {
                            itemSettingsWindow.setPreviewColors(rectPrimaryColorPreview10.color, rectSecondaryColorPreview10.color);
                        }
                    }
                }
            }


            Rectangle {
                id: rectCustomColorBar
                height: 100
                opacity: 1
                color: root.property_secondary_color
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 110
                anchors.leftMargin: 0
                anchors.rightMargin: 0


                Text {
                    id: text2
                    x: 0
                    y: 0
                    color: root.property_third_color
                    text: qsTr("CUSTOM COLOR:")
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Arial"
                    font.bold: false
                }

            }


            Text {
                id: textPrimaryColor
                text: qsTr("PRIMARY COLOR")
                opacity: 1
                color: root.property_third_color
                anchors.left: parent.left
                anchors.top: parent.top
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Arial"
                anchors.topMargin: 147
                anchors.leftMargin: 42
            }

            Text {
                id: textSecondaryColor
                text: qsTr("SECONDARY COLOR")
                opacity: 1
                anchors.left: parent.left
                anchors.top: parent.top
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 147
                font.family: "Arial"
                anchors.leftMargin: 243
                color: root.property_third_color
            }

            Text {
                id: textTextColor
                text: qsTr("TEXT COLOR")
                opacity: 1
                anchors.left: parent.left
                anchors.top: parent.top
                font.pixelSize: 15
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.topMargin: 147
                font.family: "Arial"
                anchors.leftMargin: 487
                color: root.property_third_color
            }

            Item {
                function setPrimaryColor(primary_color){
                    root.property_primary_color = primary_color
                    backend.setPrimaryColorProperty(primary_color);
                }

                id: itemColorChoiceBarPrimary
                x: 20
                y: 164
                width: 170
                height: 25
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 20
                anchors.bottomMargin: 70

                Rectangle {
                    id: rectPrimaryColorOption1
                    width: 10
                    color: "#ff0000"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 0
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0

                    MouseArea {
                        id: mouseAreaPrimaryColorOption1
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectPrimaryColorOption1.anchors.topMargin = -3
                            rectPrimaryColorOption1.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectPrimaryColorOption1.anchors.topMargin = 0
                            rectPrimaryColorOption1.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarPrimary.setPrimaryColor(rectPrimaryColorOption1.color)
                        }
                    }
                }

                Rectangle {
                    id: rectPrimaryColorOption2
                    width: 10
                    color: "#ff9900"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 10

                    MouseArea {
                        id: mouseAreaPrimaryColorOption2
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectPrimaryColorOption2.anchors.topMargin = -3
                            rectPrimaryColorOption2.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectPrimaryColorOption2.anchors.topMargin = 0
                            rectPrimaryColorOption2.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarPrimary.setPrimaryColor(rectPrimaryColorOption2.color)
                        }
                    }
                }

                Rectangle {
                    id: rectPrimaryColorOption3
                    width: 10
                    color: "#ffe601"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 20

                    MouseArea {
                        id: mouseAreaPrimaryColorOption3
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectPrimaryColorOption3.anchors.topMargin = -3
                            rectPrimaryColorOption3.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectPrimaryColorOption3.anchors.topMargin = 0
                            rectPrimaryColorOption3.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarPrimary.setPrimaryColor(rectPrimaryColorOption3.color)
                        }
                    }
                }

                Rectangle {
                    id: rectPrimaryColorOption4
                    width: 10
                    color: "#ccff00"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 30

                    MouseArea {
                        id: mouseAreaPrimaryColorOption4
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectPrimaryColorOption4.anchors.topMargin = -3
                            rectPrimaryColorOption4.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectPrimaryColorOption4.anchors.topMargin = 0
                            rectPrimaryColorOption4.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarPrimary.setPrimaryColor(rectPrimaryColorOption4.color)
                        }
                    }
                }

                Rectangle {
                    id: rectPrimaryColorOption5
                    width: 10
                    color: "#80ff00"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 40
                    MouseArea {
                        id: mouseAreaPrimaryColorOption5
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectPrimaryColorOption5.anchors.topMargin = -3
                            rectPrimaryColorOption5.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectPrimaryColorOption5.anchors.topMargin = 0
                            rectPrimaryColorOption5.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarPrimary.setPrimaryColor(rectPrimaryColorOption5.color)
                        }
                    }
                }

                Rectangle {
                    id: rectPrimaryColorOption6
                    width: 10
                    color: "#01ff1a"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 50
                    MouseArea {
                        id: mouseAreaPrimaryColorOption6
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectPrimaryColorOption6.anchors.topMargin = -3
                            rectPrimaryColorOption6.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectPrimaryColorOption6.anchors.topMargin = 0
                            rectPrimaryColorOption6.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarPrimary.setPrimaryColor(rectPrimaryColorOption6.color)
                        }
                    }
                }

                Rectangle {
                    id: rectPrimaryColorOption7
                    width: 10
                    color: "#00ffb3"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 60
                    MouseArea {
                        id: mouseAreaPrimaryColorOption7
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectPrimaryColorOption7.anchors.topMargin = -3
                            rectPrimaryColorOption7.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectPrimaryColorOption7.anchors.topMargin = 0
                            rectPrimaryColorOption7.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarPrimary.setPrimaryColor(rectPrimaryColorOption7.color)
                        }
                    }
                }

                Rectangle {
                    id: rectPrimaryColorOption8
                    width: 10
                    color: "#00ffff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 70
                    MouseArea {
                        id: mouseAreaPrimaryColorOption8
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectPrimaryColorOption8.anchors.topMargin = -3
                            rectPrimaryColorOption8.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectPrimaryColorOption8.anchors.topMargin = 0
                            rectPrimaryColorOption8.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarPrimary.setPrimaryColor(rectPrimaryColorOption8.color)
                        }
                    }
                }

                Rectangle {
                    id: rectPrimaryColorOption9
                    width: 10
                    color: "#00b3ff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 80
                    MouseArea {
                        id: mouseAreaPrimaryColorOption9
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectPrimaryColorOption9.anchors.topMargin = -3
                            rectPrimaryColorOption9.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectPrimaryColorOption9.anchors.topMargin = 0
                            rectPrimaryColorOption9.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarPrimary.setPrimaryColor(rectPrimaryColorOption9.color)
                        }
                    }
                }

                Rectangle {
                    id: rectPrimaryColorOption10
                    width: 10
                    color: "#0066ff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 90
                    MouseArea {
                        id: mouseAreaPrimaryColorOption10
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectPrimaryColorOption10.anchors.topMargin = -3
                            rectPrimaryColorOption10.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectPrimaryColorOption10.anchors.topMargin = 0
                            rectPrimaryColorOption10.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarPrimary.setPrimaryColor(rectPrimaryColorOption10.color)
                        }
                    }
                }

                Rectangle {
                    id: rectPrimaryColorOption11
                    width: 10
                    color: "#8000ff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 100
                    MouseArea {
                        id: mouseAreaPrimaryColorOption11
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectPrimaryColorOption11.anchors.topMargin = -3
                            rectPrimaryColorOption11.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectPrimaryColorOption11.anchors.topMargin = 0
                            rectPrimaryColorOption11.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarPrimary.setPrimaryColor(rectPrimaryColorOption11.color)
                        }
                    }
                }

                Rectangle {
                    id: rectPrimaryColorOption12
                    width: 10
                    color: "#cc00ff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 110
                    MouseArea {
                        id: mouseAreaPrimaryColorOption12
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectPrimaryColorOption12.anchors.topMargin = -3
                            rectPrimaryColorOption12.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectPrimaryColorOption12.anchors.topMargin = 0
                            rectPrimaryColorOption12.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarPrimary.setPrimaryColor(rectPrimaryColorOption12.color)
                        }
                    }
                }

                Rectangle {
                    id: rectPrimaryColorOption13
                    width: 10
                    color: "#ff00e6"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 120
                    MouseArea {
                        id: mouseAreaPrimaryColorOption13
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectPrimaryColorOption13.anchors.topMargin = -3
                            rectPrimaryColorOption13.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectPrimaryColorOption13.anchors.topMargin = 0
                            rectPrimaryColorOption13.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarPrimary.setPrimaryColor(rectPrimaryColorOption13.color)
                        }
                    }
                }

                Rectangle {
                    id: rectPrimaryColorOption14
                    width: 10
                    color: "#ff0099"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 130
                    MouseArea {
                        id: mouseAreaPrimaryColorOption14
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectPrimaryColorOption14.anchors.topMargin = -3
                            rectPrimaryColorOption14.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectPrimaryColorOption14.anchors.topMargin = 0
                            rectPrimaryColorOption14.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarPrimary.setPrimaryColor(rectPrimaryColorOption14.color)
                        }
                    }
                }

                Rectangle {
                    id: rectPrimaryColorOption15
                    width: 10
                    color: "#191919"
                    border.color: "#00000000"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 140
                    MouseArea {
                        id: mouseAreaPrimaryColorOption15
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectPrimaryColorOption15.anchors.topMargin = -3
                            rectPrimaryColorOption15.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectPrimaryColorOption15.anchors.topMargin = 0
                            rectPrimaryColorOption15.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarPrimary.setPrimaryColor(rectPrimaryColorOption15.color)
                        }
                    }
                }

                Rectangle {
                    id: rectPrimaryColorOption16
                    width: 10
                    color: "#484848"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 150
                    MouseArea {
                        id: mouseAreaPrimaryColorOption16
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectPrimaryColorOption16.anchors.topMargin = -3
                            rectPrimaryColorOption16.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectPrimaryColorOption16.anchors.topMargin = 0
                            rectPrimaryColorOption16.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarPrimary.setPrimaryColor(rectPrimaryColorOption16.color)
                        }
                    }
                }

                Rectangle {
                    id: rectPrimaryColorOption17
                    width: 10
                    color: "#d2d2d2"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 160
                    MouseArea {
                        id: mouseAreaPrimaryColorOption17
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectPrimaryColorOption17.anchors.topMargin = -3
                            rectPrimaryColorOption17.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectPrimaryColorOption17.anchors.topMargin = 0
                            rectPrimaryColorOption17.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarPrimary.setPrimaryColor(rectPrimaryColorOption17.color)
                        }
                    }
                }
            }

            Item {
                function setSecondaryColor(color_variable){
                    backend.setSecondaryColorProperty(color_variable)
                    root.property_secondary_color = color_variable
                    rectTopButton.color = color_variable

                    // A workaround to a bug I couldn't solve properly - some objects do not change color unless directly directed
                    rectTopButton.color = color_variable
                    rectActionChosen.color = color_variable
                    rectChooseFirst.color = color_variable
                    rectChooseSecond.color = color_variable
                    rectChooseThird.color = color_variable
                    rectChooseFourth.color = color_variable
                    rectUpButtonHour.color = color_variable
                    rectDownButtonHour.color = color_variable
                    rectUpButtonMinute.color = color_variable
                    rectDownButtonMinute.color = color_variable
                    rectUpButtonSecond.color = color_variable
                    rectDownButtonSecond.color = color_variable
                }


                id: itemColorChoiceBarSecondary
                x: 29
                y: 170
                width: 170
                height: 25
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 70
                anchors.leftMargin: 235
                Rectangle {
                    id: rectSecondaryColorOption1
                    width: 10
                    color: "#ff0000"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    MouseArea {
                        id: mouseAreaSecondaryColorOption1
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectSecondaryColorOption1.anchors.topMargin = -3
                            rectSecondaryColorOption1.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectSecondaryColorOption1.anchors.topMargin = 0
                            rectSecondaryColorOption1.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarSecondary.setSecondaryColor(rectSecondaryColorOption1.color)


                        }

                    }
                }

                Rectangle {
                    id: rectSecondaryColorOption2
                    width: 10
                    color: "#ff9900"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 10
                    MouseArea {
                        id: mouseAreaSecondaryColorOption2
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectSecondaryColorOption2.anchors.topMargin = -3
                            rectSecondaryColorOption2.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectSecondaryColorOption2.anchors.topMargin = 0
                            rectSecondaryColorOption2.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarSecondary.setSecondaryColor(rectSecondaryColorOption2.color)
                        }

                    }
                }

                Rectangle {
                    id: rectSecondaryColorOption3
                    width: 10
                    color: "#ffe601"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 20
                    MouseArea {
                        id: mouseAreaSecondaryColorOption3
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectSecondaryColorOption3.anchors.topMargin = -3
                            rectSecondaryColorOption3.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectSecondaryColorOption3.anchors.topMargin = 0
                            rectSecondaryColorOption3.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarSecondary.setSecondaryColor(rectSecondaryColorOption3.color)
                        }

                    }
                }

                Rectangle {
                    id: rectSecondaryColorOption4
                    width: 10
                    color: "#ccff00"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 30
                    MouseArea {
                        id: mouseAreaSecondaryColorOption4
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectSecondaryColorOption4.anchors.topMargin = -3
                            rectSecondaryColorOption4.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectSecondaryColorOption4.anchors.topMargin = 0
                            rectSecondaryColorOption4.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarSecondary.setSecondaryColor(rectSecondaryColorOption4.color)
                        }

                    }
                }

                Rectangle {
                    id: rectSecondaryColorOption5
                    width: 10
                    color: "#80ff00"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 40
                    MouseArea {
                        id: mouseAreaSecondaryColorOption5
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectSecondaryColorOption5.anchors.topMargin = -3
                            rectSecondaryColorOption5.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectSecondaryColorOption5.anchors.topMargin = 0
                            rectSecondaryColorOption5.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarSecondary.setSecondaryColor(rectSecondaryColorOption5.color)
                        }

                    }
                }

                Rectangle {
                    id: rectSecondaryColorOption6
                    width: 10
                    color: "#01ff1a"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 50
                    MouseArea {
                        id: mouseAreaSecondaryColorOption6
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectSecondaryColorOption6.anchors.topMargin = -3
                            rectSecondaryColorOption6.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectSecondaryColorOption6.anchors.topMargin = 0
                            rectSecondaryColorOption6.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarSecondary.setSecondaryColor(rectSecondaryColorOption6.color)
                        }

                    }
                }

                Rectangle {
                    id: rectSecondaryColorOption7
                    width: 10
                    color: "#00ffb3"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 60
                    MouseArea {
                        id: mouseAreaSecondaryColorOption7
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectSecondaryColorOption7.anchors.topMargin = -3
                            rectSecondaryColorOption7.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectSecondaryColorOption7.anchors.topMargin = 0
                            rectSecondaryColorOption7.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarSecondary.setSecondaryColor(rectSecondaryColorOption6.color)
                        }

                    }
                }

                Rectangle {
                    id: rectSecondaryColorOption8
                    width: 10
                    color: "#00ffff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 70
                    MouseArea {
                        id: mouseAreaSecondaryColorOption8
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectSecondaryColorOption8.anchors.topMargin = -3
                            rectSecondaryColorOption8.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectSecondaryColorOption8.anchors.topMargin = 0
                            rectSecondaryColorOption8.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarSecondary.setSecondaryColor(rectSecondaryColorOption8.color)
                        }

                    }
                }

                Rectangle {
                    id: rectSecondaryColorOption9
                    width: 10
                    color: "#00b3ff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 80
                    MouseArea {
                        id: mouseAreaSecondaryColorOption9
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectSecondaryColorOption9.anchors.topMargin = -3
                            rectSecondaryColorOption9.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectSecondaryColorOption9.anchors.topMargin = 0
                            rectSecondaryColorOption9.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarSecondary.setSecondaryColor(rectSecondaryColorOption9.color)
                        }

                    }
                }

                Rectangle {
                    id: rectSecondaryColorOption10
                    width: 10
                    color: "#0066ff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 90
                    MouseArea {
                        id: mouseAreaSecondaryColorOption10
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectSecondaryColorOption10.anchors.topMargin = -3
                            rectSecondaryColorOption10.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectSecondaryColorOption10.anchors.topMargin = 0
                            rectSecondaryColorOption10.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarSecondary.setSecondaryColor(rectSecondaryColorOption10.color)
                        }

                    }
                }

                Rectangle {
                    id: rectSecondaryColorOption11
                    width: 10
                    color: "#8000ff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 100
                    MouseArea {
                        id: mouseAreaSecondaryColorOption11
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectSecondaryColorOption11.anchors.topMargin = -3
                            rectSecondaryColorOption11.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectSecondaryColorOption11.anchors.topMargin = 0
                            rectSecondaryColorOption11.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarSecondary.setSecondaryColor(rectSecondaryColorOption11.color)
                        }

                    }
                }

                Rectangle {
                    id: rectSecondaryColorOption12
                    width: 10
                    color: "#cc00ff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 110
                    MouseArea {
                        id: mouseAreaSecondaryColorOption12
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectSecondaryColorOption12.anchors.topMargin = -3
                            rectSecondaryColorOption12.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectSecondaryColorOption12.anchors.topMargin = 0
                            rectSecondaryColorOption12.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarSecondary.setSecondaryColor(rectSecondaryColorOption12.color)
                        }

                    }
                }

                Rectangle {
                    id: rectSecondaryColorOption13
                    width: 10
                    color: "#ff00e6"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 120
                    MouseArea {
                        id: mouseAreaSecondaryColorOption13
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectSecondaryColorOption13.anchors.topMargin = -3
                            rectSecondaryColorOption13.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectSecondaryColorOption13.anchors.topMargin = 0
                            rectSecondaryColorOption13.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarSecondary.setSecondaryColor(rectSecondaryColorOption13.color)
                        }

                    }
                }

                Rectangle {
                    id: rectSecondaryColorOption14
                    width: 10
                    color: "#ff0099"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 130
                    MouseArea {
                        id: mouseAreaSecondaryColorOption14
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectSecondaryColorOption14.anchors.topMargin = -3
                            rectSecondaryColorOption14.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectSecondaryColorOption14.anchors.topMargin = 0
                            rectSecondaryColorOption14.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarSecondary.setSecondaryColor(rectSecondaryColorOption14.color)
                        }

                    }
                }

                Rectangle {
                    id: rectSecondaryColorOption15
                    width: 10
                    color: "#191919"
                    border.color: "#00000000"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 140
                    MouseArea {
                        id: mouseAreaSecondaryColorOption15
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectSecondaryColorOption15.anchors.topMargin = -3
                            rectSecondaryColorOption15.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectSecondaryColorOption15.anchors.topMargin = 0
                            rectSecondaryColorOption15.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarSecondary.setSecondaryColor(rectSecondaryColorOption15.color)
                        }

                    }
                }

                Rectangle {
                    id: rectSecondaryColorOption16
                    width: 10
                    color: "#484848"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 150
                    MouseArea {
                        id: mouseAreaSecondaryColorOption16
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectSecondaryColorOption16.anchors.topMargin = -3
                            rectSecondaryColorOption16.anchors.bottomMargin = -3
                        }

                        onExited: {
                            rectSecondaryColorOption16.anchors.topMargin = 0
                            rectSecondaryColorOption16.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarSecondary.setSecondaryColor(rectSecondaryColorOption16.color)
                        }

                    }
                }

                Rectangle {
                    id: rectSecondaryColorOption17
                    width: 10
                    color: "#d2d2d2"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 160
                    MouseArea {
                        id: mouseAreaSecondaryColorOption17
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectSecondaryColorOption17.anchors.topMargin = -3
                            rectSecondaryColorOption17.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectSecondaryColorOption17.anchors.topMargin = 0
                            rectSecondaryColorOption17.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarSecondary.setSecondaryColor(rectSecondaryColorOption17.color)
                        }

                    }
                }
            }

            Item {
                function setTextColor(text_color_variable){
                    backend.setThirdColorProperty(text_color_variable)
                    root.property_third_color = text_color_variable
                    labelActionChosen.color = text_color_variable
                    labelChooseFirst.color = text_color_variable
                    labelChooseSecond.color = text_color_variable
                    labelChooseThird.color = text_color_variable
                    labelChooseFourth.color = text_color_variable
                    labelDownButtonHour.color = text_color_variable
                    labelDownButtonMinute.color = text_color_variable
                    labelDownButtonSecond.color = text_color_variable
                    labelUpButtonHour.color = text_color_variable
                    labelUpButtonMinute.color = text_color_variable
                    labelUpButtonSecond.color = text_color_variable
                    lableSettingsButton.color = text_color_variable
                    labelPerformAction.color = text_color_variable
                    textTimerButton.color = text_color_variable
                }

                id: itemColorChoiceBarText
                x: 235
                y: 170
                width: 170
                height: 25
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 70
                anchors.leftMargin: 450
                Rectangle {
                    id: rectTextColorOption1
                    width: 10
                    color: "#ff0000"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 0
                    MouseArea {
                        id: mouseAreaTextColorOption1
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectTextColorOption1.anchors.topMargin = -3
                            rectTextColorOption1.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectTextColorOption1.anchors.topMargin = 0
                            rectTextColorOption1.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarText.setTextColor(rectTextColorOption1.color)


                        }

                    }
                }

                Rectangle {
                    id: rectTextColorOption2
                    width: 10
                    color: "#ff9900"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 10
                    MouseArea {
                        id: mouseAreaTextColorOption2
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectTextColorOption2.anchors.topMargin = -3
                            rectTextColorOption2.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectTextColorOption2.anchors.topMargin = 0
                            rectTextColorOption2.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarText.setTextColor(rectTextColorOption2.color)

                        }

                    }
                }

                Rectangle {
                    id: rectTextColorOption3
                    width: 10
                    color: "#ffe601"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 20
                    MouseArea {
                        id: mouseAreaTextColorOption3
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectTextColorOption3.anchors.topMargin = -3
                            rectTextColorOption3.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectTextColorOption3.anchors.topMargin = 0
                            rectTextColorOption3.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarText.setTextColor(rectTextColorOption3.color)

                        }

                    }
                }

                Rectangle {
                    id: rectTextColorOption4
                    width: 10
                    color: "#ccff00"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 30
                    MouseArea {
                        id: mouseAreaTextColorOption4
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectTextColorOption4.anchors.topMargin = -3
                            rectTextColorOption4.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectTextColorOption4.anchors.topMargin = 0
                            rectTextColorOption4.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarText.setTextColor(rectTextColorOption4.color)

                        }

                    }
                }

                Rectangle {
                    id: rectTextColorOption5
                    width: 10
                    color: "#80ff00"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 40
                    MouseArea {
                        id: mouseAreaTextColorOption5
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectTextColorOption5.anchors.topMargin = -3
                            rectTextColorOption5.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectTextColorOption5.anchors.topMargin = 0
                            rectTextColorOption5.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarText.setTextColor(rectTextColorOption5.color)

                        }

                    }
                }

                Rectangle {
                    id: rectTextColorOption6
                    width: 10
                    color: "#01ff1a"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 50
                    MouseArea {
                        id: mouseAreaTextColorOption6
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectTextColorOption6.anchors.topMargin = -3
                            rectTextColorOption6.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectTextColorOption6.anchors.topMargin = 0
                            rectTextColorOption6.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarText.setTextColor(rectTextColorOption6.color)

                        }

                    }
                }

                Rectangle {
                    id: rectTextColorOption7
                    width: 10
                    color: "#00ffb3"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 60
                    MouseArea {
                        id: mouseAreaTextColorOption7
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectTextColorOption7.anchors.topMargin = -3
                            rectTextColorOption7.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectTextColorOption7.anchors.topMargin = 0
                            rectTextColorOption7.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarText.setTextColor(rectTextColorOption7.color)

                        }

                    }
                }

                Rectangle {
                    id: rectTextColorOption8
                    width: 10
                    color: "#00ffff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 70
                    MouseArea {
                        id: mouseAreaTextColorOption8
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectTextColorOption8.anchors.topMargin = -3
                            rectTextColorOption8.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectTextColorOption8.anchors.topMargin = 0
                            rectTextColorOption8.anchors.bottomMargin = 0
                        }
                        onClicked: {
                            itemColorChoiceBarText.setTextColor(rectTextColorOption8.color)

                        }

                    }
                }

                Rectangle {
                    id: rectTextColorOption9
                    width: 10
                    color: "#00b3ff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 80
                    MouseArea {
                        id: mouseAreaTextColorOption9
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectTextColorOption9.anchors.topMargin = -3
                            rectTextColorOption9.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectTextColorOption9.anchors.topMargin = 0
                            rectTextColorOption9.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarText.setTextColor(rectTextColorOption9.color)

                        }

                    }
                }

                Rectangle {
                    id: rectTextColorOption10
                    width: 10
                    color: "#0066ff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 90
                    MouseArea {
                        id: mouseAreaTextColorOption10
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectTextColorOption10.anchors.topMargin = -3
                            rectTextColorOption10.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectTextColorOption10.anchors.topMargin = 0
                            rectTextColorOption10.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarText.setTextColor(rectTextColorOption10.color)

                        }

                    }
                }

                Rectangle {
                    id: rectTextColorOption11
                    width: 10
                    color: "#8000ff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 100
                    MouseArea {
                        id: mouseAreaTextColorOption11
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectTextColorOption11.anchors.topMargin = -3
                            rectTextColorOption11.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectTextColorOption11.anchors.topMargin = 0
                            rectTextColorOption11.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarText.setTextColor(rectTextColorOption11.color)

                        }

                    }
                }

                Rectangle {
                    id: rectTextColorOption12
                    width: 10
                    color: "#cc00ff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 110
                    MouseArea {
                        id: mouseAreaTextColorOption12
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectTextColorOption12.anchors.topMargin = -3
                            rectTextColorOption12.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectTextColorOption12.anchors.topMargin = 0
                            rectTextColorOption12.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarText.setTextColor(rectTextColorOption12.color)

                        }

                    }
                }

                Rectangle {
                    id: rectTextColorOption13
                    width: 10
                    color: "#ff00e6"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 120
                    MouseArea {
                        id: mouseAreaTextColorOption13
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectTextColorOption13.anchors.topMargin = -3
                            rectTextColorOption13.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectTextColorOption13.anchors.topMargin = 0
                            rectTextColorOption13.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarText.setTextColor(rectTextColorOption13.color)

                        }

                    }
                }

                Rectangle {
                    id: rectTextColorOption14
                    width: 10
                    color: "#ff0099"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 130
                    MouseArea {
                        id: mouseAreaTextColorOption14
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectTextColorOption14.anchors.topMargin = -3
                            rectTextColorOption14.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectTextColorOption14.anchors.topMargin = 0
                            rectTextColorOption14.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarText.setTextColor(rectTextColorOption14.color)

                        }

                    }
                }

                Rectangle {
                    id: rectTextColorOption15
                    width: 10
                    color: "#191919"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 140
                    MouseArea {
                        id: mouseAreaTextColorOption15
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectTextColorOption15.anchors.topMargin = -3
                            rectTextColorOption15.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectTextColorOption15.anchors.topMargin = 0
                            rectTextColorOption15.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarText.setTextColor(rectTextColorOption15.color)

                        }

                    }
                }

                Rectangle {
                    id: rectTextColorOption16
                    width: 10
                    color: "#484848"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 150
                    MouseArea {
                        id: mouseAreaTextColorOption16
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectTextColorOption16.anchors.topMargin = -3
                            rectTextColorOption16.anchors.bottomMargin = -3
                        }

                        onExited: {
                            rectTextColorOption16.anchors.topMargin = 0
                            rectTextColorOption16.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarText.setTextColor(rectTextColorOption16.color)

                        }

                    }
                }

                Rectangle {
                    id: rectTextColorOption17
                    width: 10
                    color: "#d2d2d2"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.topMargin: 0
                    anchors.bottomMargin: 0
                    anchors.leftMargin: 160
                    MouseArea {
                        id: mouseAreaTextColorOption17
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            rectTextColorOption17.anchors.topMargin = -3
                            rectTextColorOption17.anchors.bottomMargin = -3
                        }
                        onExited: {
                            rectTextColorOption17.anchors.topMargin = 0
                            rectTextColorOption17.anchors.bottomMargin = 0
                        }

                        onClicked: {
                            itemColorChoiceBarText.setTextColor(rectTextColorOption17.color)

                        }
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:1.33}D{i:1;locked:true}D{i:2;locked:true}D{i:21;locked:true}
}
##^##*/
