#ifndef SERIALINTERFACE_H
#define SERIALINTERFACE_H

#include <QObject>
// #include <QtSerialPort/QSerialPort>
#include <QFileInfo>

#include <iostream>
#include <thread>
#include <queue>

#include "serial/serialib.h"

class SerialInterface : public QObject
{
    Q_OBJECT
public:
    explicit SerialInterface(QObject *parent = nullptr);



private:
    //QSerialPort *cdcSerial;
    serialib *cdcSerial;
    std::string port_name;
    QList<bool> relayData = {false, false, false, false,
                             false, false, false, false,
                             false, false, false, false,
                             false, false, false, false};
    std::queue<uint8_t*> msg_queue;
    bool serialConnected;
    bool call_close_signal;
//    QQueue<uint8_t*> *transmit_queue;

    bool fileExists(QString path);

public slots:
    void startSerial();
    void stopSerial();
    void serialListener();
    QList<bool> getRelayData();
    void changeState(int number, bool value);

signals:
    void setRelayData(QList<bool> signal_data);
    void serial_opened();
    void serial_closed();
};

#endif // SERIALINTERFACE_H
