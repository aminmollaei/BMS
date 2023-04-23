#include "serialinterface.h"

SerialInterface::SerialInterface(QObject *parent)
    : QObject{parent}
{
//    relayData = new QList<bool>;
//    relayData.reserve(16);
    cdcSerial = new QSerialPort();
    cdcSerial->setPortName("/dev/ttyACM0");
    cdcSerial->setBaudRate(QSerialPort::Baud9600);
}

bool SerialInterface::startSerial()
{
    if(cdcSerial->open(QIODevice::ReadWrite))
    {
        std::thread serial_listener (&SerialInterface::serialListener, this);
        serial_listener.detach();
        return true;
    }
    return false;
}

void SerialInterface::serialListener()
{
//    std::cout << "serial listener is working\n";
    QByteArray data;

    while(cdcSerial->isOpen())
    {
//        std::cout << "listening\n";
        if(cdcSerial->waitForReadyRead(-1))
        {
//            std::cout << "serial received\n";
            if(cdcSerial->bytesAvailable() == 18)
                data = cdcSerial->readAll();
//            std::cout << "data: " << data.toStdString() << std::endl;
            if(data[0]== '#' && data[17] == '@')
            {
                for(int i=1;i<=16;i++)
                {
//                    std::cout << i << std::endl;
//                    std::cout << relayData[i] << std::endl;
//                    std::cout << "---\n";
                    relayData[i-1] = data[i]=='a';
                }
//                    (*relayData)[i-1] = (data[i]=='a');
                emit setRelayData();
            }
        }
    }
}

QList<bool> SerialInterface::getRelayData()
{
    return relayData;
}
