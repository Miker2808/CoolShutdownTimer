#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QQuickItem>
#include <QTimer>
#include <QSettings>
class BackEnd : public QObject
{
    Q_OBJECT
    QML_ELEMENT



public:
    explicit BackEnd(QObject *parent = nullptr);


    QString toQString(std::string const &s);
    std::string fromQString(QString const &s);
    QTimer *timer = new QTimer(this); // Construct timer on start, and re-use it during run time.
    QSettings *settings = new QSettings("Config.ini", QSettings::IniFormat, this); // settings object for config file
    void PerformShutdownOperation(); // Slot - called when close application is clicked
    void LoadSettings();

    // Q_PROPERTY - properties that are accessible both from QML and C++ side.
    Q_PROPERTY(int SecondsValue READ getSecondsValue WRITE setSecondsValue NOTIFY SecondsValueChanged);
    Q_PROPERTY(int HoursValue READ getHoursValue WRITE setHoursValue NOTIFY HoursValueChanged);
    Q_PROPERTY(int MinutesValue READ getMinutesValue WRITE setMinutesValue NOTIFY MinutesValueChanged);
    Q_PROPERTY(int TimerStartSecondsValue READ getTimerStartSecondsValue WRITE setTimerStartSecondsValue NOTIFY TimerStartSecondsValueChanged);
    Q_PROPERTY(int TimerSecondsValueLeft READ getTimerSecondsValueLeft WRITE setTimerSecondsValueLeft NOTIFY TimerSecondsValueLeftChanged);
    Q_PROPERTY(int RectButtonTopRightMargin READ getRectButtonTopRightMargin WRITE setRectButtonTopRightMargin NOTIFY RectButtonTopRightMarginChanged);
    Q_PROPERTY(QString PrimaryColorProperty READ getPrimaryColorProperty WRITE setPrimaryColorProperty NOTIFY PrimaryColorPropertyChanged);
    Q_PROPERTY(QString SecondaryColorProperty READ getSecondaryColorProperty WRITE setSecondaryColorProperty NOTIFY SecondaryColorPropertyChanged);
    Q_PROPERTY(QString ThirdColorProperty READ getThirdColorProperty WRITE setThirdColorProperty NOTIFY ThirdColorPropertyChanged);
    // Functions that are called from the QML side, but run on the C++ side
    Q_INVOKABLE void customCloseApp(); // qml connected method: calling function works from QML side as well, will close the app
    Q_INVOKABLE void setActionChosen(QString str_param);
    Q_INVOKABLE void onStartTimerButton_Clicked(bool is_start_timer); // bool tells the function whether it starts the timer or stops it


    QString action_chosen = "Shutdown"; // chosen action: Shutdown, Reboot, Logout, Sleep, Hibernate
    int hours_value = 0;
    int minutes_value = 0;
    int seconds_value = 0;

    // Qt refractored section: part of Q_PROPERTY
    int getSecondsValue() const { return m_SecondsValue; }
    int getHoursValue() const { return m_HoursValue; }
    int getMinutesValue() const { return m_MinutesValue; }
    int getTimerStartSecondsValue() const { return m_TimerStartSecondsValue; }
    int getTimerSecondsValueLeft() const { return m_TimerSecondsValueLeft; }
    int getRectButtonTopRightMargin() const { return m_RectButtonTopRightMargin; }
    QString getPrimaryColorProperty() const { return m_PrimaryColorProperty; }
    QString getSecondaryColorProperty() const { return m_SecondaryColorProperty; }
    QString getThirdColorProperty() const { return m_ThirdColorProperty; }

public slots:
    void TimerIntervalCalled(); // Slot called every second once the timer started.

    // Qt refractored section: part of Q_PROPERTY
    void setSecondsValue(int SecondsValue)
    {
        if (m_SecondsValue == SecondsValue)
            return;

        m_SecondsValue = SecondsValue;
        emit SecondsValueChanged(m_SecondsValue);
    }

    void setHoursValue(int HoursValue)
    {
        if (m_HoursValue == HoursValue)
            return;

        m_HoursValue = HoursValue;
        emit HoursValueChanged(m_HoursValue);
    }

    void setMinutesValue(int MinutesValue)
    {
        if (m_MinutesValue == MinutesValue)
            return;

        m_MinutesValue = MinutesValue;
        emit MinutesValueChanged(m_MinutesValue);
    }

    void setTimerStartSecondsValue(int TimerStartSecondsValue)
    {
        if (m_TimerStartSecondsValue == TimerStartSecondsValue)
            return;

        m_TimerStartSecondsValue = TimerStartSecondsValue;
        emit TimerStartSecondsValueChanged(m_TimerStartSecondsValue);
    }

    void setTimerSecondsValueLeft(int TimerSecondsValueLeft)
    {
        if (m_TimerSecondsValueLeft == TimerSecondsValueLeft)
            return;

        m_TimerSecondsValueLeft = TimerSecondsValueLeft;
        emit TimerSecondsValueLeftChanged(m_TimerSecondsValueLeft);
    }

    void setRectButtonTopRightMargin(int RectButtonTopRightMargin)
    {
        if (m_RectButtonTopRightMargin == RectButtonTopRightMargin)
            return;

        m_RectButtonTopRightMargin = RectButtonTopRightMargin;
        emit RectButtonTopRightMarginChanged(m_RectButtonTopRightMargin);
    }

    void setPrimaryColorProperty(QString PrimaryColorProperty)
    {
        if (m_PrimaryColorProperty == PrimaryColorProperty)
            return;

        m_PrimaryColorProperty = PrimaryColorProperty;
        emit PrimaryColorPropertyChanged(m_PrimaryColorProperty);
    }

    void setSecondaryColorProperty(QString SecondaryColorProperty)
    {
        if (m_SecondaryColorProperty == SecondaryColorProperty)
            return;

        m_SecondaryColorProperty = SecondaryColorProperty;
        emit SecondaryColorPropertyChanged(m_SecondaryColorProperty);
    }

    void setThirdColorProperty(QString ThirdColorProperty)
    {
        if (m_ThirdColorProperty == ThirdColorProperty)
            return;

        m_ThirdColorProperty = ThirdColorProperty;
        emit ThirdColorPropertyChanged(m_ThirdColorProperty);
    }

signals:

    // Qt refractored section: part of Q_PROPERTY
    void SecondsValueChanged(int SecondsValue);
    void HoursValueChanged(int HoursValue);
    void MinutesValueChanged(int MinutesValue);
    void TimerStartSecondsValueChanged(int TimerStartSecondsValue);
    void TimerSecondsValueLeftChanged(int TimerSecondsValueLeft);
    void RectButtonTopRightMarginChanged(int RectButtonTopRightMargin);

    void PrimaryColorPropertyChanged(QString PrimaryColorProperty);

    void SecondaryColorPropertyChanged(QString SecondaryColorProperty);

    void ThirdColorPropertyChanged(QString ThirdColorProperty);

private:

    // Qt refractored section: part of Q_PROPERTY
    int m_SecondsValue = 0;
    int m_HoursValue = 0;
    int m_MinutesValue = 0;

    int m_TimerStartSecondsValue = 0;
    int m_TimerSecondsValueLeft = 0;
    int m_RectButtonTopRightMargin = 0;

    QString m_PrimaryColorProperty;
    QString m_SecondaryColorProperty;
    QString m_ThirdColorProperty;
};

#endif // BACKEND_H
