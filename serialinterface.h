#ifndef SERIALINTERFACE_H
#define SERIALINTERFACE_H

#include <QObject>
#include <QtSerialPort/QSerialPort>

#include <iostream>
#include <thread>

class SerialInterface : public QObject
{
    Q_OBJECT
public:
    explicit SerialInterface(QObject *parent = nullptr);



private:
    QSerialPort *cdcSerial;
    QList<bool> relayData = {false, false, false, false,
                             false, false, false, false,
                             false, false, false, false,
                             false, false, false, false};

public slots:
    bool startSerial();
    void serialListener();
    QList<bool> getRelayData();

signals:
    void setRelayData();
};

#endif // SERIALINTERFACE_H
