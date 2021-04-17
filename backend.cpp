#include "backend.h"
#include <QObject>
#include <iostream>
#include <string>


BackEnd::BackEnd( QObject *parent) : QObject(parent)
{
    connect(timer, SIGNAL(timeout()), this, SLOT(TimerIntervalCalled())); // connects QTimer's timeout signal to custom slot
    this->timer->setInterval(1000); // sets timeout interval to every 1000ms (1 second)
    setActionChosen("Shutdown"); // choose default action (Shutdown)
    setHoursValue(0);
    setSecondsValue(0);
    setMinutesValue(0);
    LoadSettings();



}


void BackEnd::LoadSettings(){
     bool is_contained = settings->contains("Color/Primary");
     if (is_contained == false){ // check if settings exist - create if true, load if false
        settings->setValue("Color/Primary", "#535353");
        settings->setValue("Color/Secondary", "#404040");
        settings->setValue("Color/Third", "#b3b3b3");
        setPrimaryColorProperty("#535353");
        setSecondaryColorProperty("#404040");
        setThirdColorProperty("#b3b3b3");
     }
     else if(is_contained == true){
         QString primary_color = settings->value("Color/Primary").value<QString>();
         QString secondary_color = settings->value("Color/Secondary").value<QString>();
         QString third_color = settings->value("Color/Third").value<QString>();
         setPrimaryColorProperty(primary_color);
         setSecondaryColorProperty(secondary_color);
         setThirdColorProperty(third_color);

     }
}


// convert std::string to QString
QString BackEnd::toQString(std::string const &s)
{
    return QString::fromUtf8(s.c_str());
}
// convert from QString to std::string
std::string BackEnd::fromQString(QString const &s)
{
    return std::string(s.toUtf8().constData());
}

// Called when exit applicaton button clicked (closes application)
void BackEnd::customCloseApp(){
    settings->setValue("Color/Primary", m_PrimaryColorProperty);
    settings->setValue("Color/Secondary", m_SecondaryColorProperty);
    settings->setValue("Color/Third", m_ThirdColorProperty);

    QCoreApplication::quit();
}

// Changes the action to perform (shutdown,reboot,etc..) (called from QML (front end) side)
void BackEnd::setActionChosen(QString str_param){
    this->action_chosen = str_param;
    std::cout << fromQString(this->action_chosen) << std::endl;
}
// Called on START timer button click (called from QML side)
void BackEnd::onStartTimerButton_Clicked(bool is_start_timer){
    if (is_start_timer == true){
        int TimerStartSecondsValue = (this->m_HoursValue * 60 * 60) + (this->m_MinutesValue * 60) + (this->m_SecondsValue); // Total number of seconds (local variable)
        this->setTimerStartSecondsValue(TimerStartSecondsValue);  // set property of total number of seconds (used to calculate timer bar in TimerIntervalCalled) (value doesnt change until reset)
        this->setTimerSecondsValueLeft(TimerStartSecondsValue); // set property of total number of seconds (Value changes every second)
        this->timer->start(1000); // starts the timer with interval of 1000ms (timer is auto-repeating - it wont stop after 1000ms, but will restart)

    }
    else if (is_start_timer == false){  // stops the timer and resets time
        this->setTimerSecondsValueLeft(0);
        this->timer->stop();
    }
}

// called every 1000ms (1 second) after timer has been started
void BackEnd::TimerIntervalCalled(){
    setTimerSecondsValueLeft(getTimerSecondsValueLeft() - 1); // decrease 1 second from timer
    std::cout << getTimerSecondsValueLeft() << std::endl; // print for debugging
    if (this->getTimerSecondsValueLeft() < 1){ // action to perform when timers time reaches 0
        // perform shutdown action
        PerformShutdownOperation();
        this->timer->stop();

    }
    else{ // adjusts the time in the timer based on the decreased 1 second.
        int hours_left = getTimerSecondsValueLeft() / 3600;
        int minutes_left = (getTimerSecondsValueLeft() - (hours_left * 3600)) / 60;
        int seconds_left = (getTimerSecondsValueLeft() - (hours_left * 3600) - (minutes_left * 60));

        std::cout << "H:" << hours_left << " M:" << minutes_left << " S:" << seconds_left << std::endl; // for debug
        setHoursValue(hours_left);
        setMinutesValue(minutes_left);
        setSecondsValue(seconds_left);
        // temp values, used to show the timerbar.
        float temp_TimerSecsLeft = getTimerSecondsValueLeft() -1;
        float temp_TimerSecsStart = getTimerStartSecondsValue();
        float rect_button_right_margin_calc = (1 - (temp_TimerSecsLeft / temp_TimerSecsStart)) * 430.0;
        setRectButtonTopRightMargin(rect_button_right_margin_calc);

    }

}

// perform the action commanded by user once timer reaches 1 seconds
void BackEnd::PerformShutdownOperation(){
    if(this->action_chosen == "Shutdown"){
        system("shutdown /p");
    }
    else if(this->action_chosen == "Reboot"){
        system("shutdown /r /t 0");
    }
    else if(this->action_chosen == "Logout"){
        system("shutdown /l");
    }
    else if(this->action_chosen == "Hibernate"){
        system("shutdown /h /t 0");
    }
    else if(this->action_chosen == "Maintenance"){
        system("shutdown /r /o /t 0");
    }

    QCoreApplication::quit();
}
