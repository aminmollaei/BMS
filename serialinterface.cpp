#include "serialinterface.h"

SerialInterface::SerialInterface(QObject *parent)
    : QObject{parent}
{
    cdcSerial = new serialib();
    port_name = "/dev/ttyACM0";
}

bool SerialInterface::fileExists(QString path)
{
    QFileInfo check_file(path);
    return check_file.exists() && check_file.isFile();
}

void SerialInterface::startSerial()
{
//    std::string port_name;
//    for(int i=0;i<=64;i++)
//    {
//        port_name = "/dev/ttyACM" + std::to_string(i);
//        std::cout << port_name << std::endl;
//        if(cdcSerial->openDevice(port_name.c_str(), 9600)==1)
//        {
//            serialConnected = true;
            std::thread serial_listener (&SerialInterface::serialListener, this);
            serial_listener.detach();
//            return true;
//        }
//    }
//    return false;
}

void SerialInterface::stopSerial()
{
    serialConnected = false;
}

void SerialInterface::serialListener()
{
    uint8_t data[18];
    memset(data, 0x00, 18);
    while(1)
    {
        if(serialConnected && fileExists(QString::fromStdString(port_name)))
        {
            if(cdcSerial->readBytes(data, 18, 2000, 500) == 18)
                if(data[0]=='#' && data[17]=='@')
                    for(int i=1;i<=16;i++)
                    {
                        relayData[i-1] = data[i]=='a';
                        emit setRelayData(relayData);
                    }
        }
        else
        {
            serialConnected = false;
            if(call_close_signal)
            {
                cdcSerial->closeDevice();
                emit serial_closed();
                call_close_signal = false;
            }
            for(int i=0;i<=64;i++)
            {
                std::string tmp_port_name = "/dev/ttyACM" + std::to_string(i);
                if(cdcSerial->openDevice(port_name.c_str(), 9600)==1)
                {
                    serialConnected = true;
                    port_name = tmp_port_name;
                    std::cout << "connected to: " << port_name << std::endl;
                    emit serial_opened();
                    call_close_signal = true;
                    break;
                }
            }
            std::this_thread::sleep_for(std::chrono::seconds(1));
        }
    }
    cdcSerial->closeDevice();
}

QList<bool> SerialInterface::getRelayData()
{
    return relayData;
}

void SerialInterface::changeState(int number, bool value)
{
    uint8_t transmit_data[3];
    transmit_data[0] = 0x23;
    transmit_data[1] = (0x80 | number)+1;
    transmit_data[2] = value ? 0x2d : 0x2c; // Instead of not
    cdcSerial->writeBytes(msg_queue.front(), 3);
//    msg_queue.push(transmit_data);
}
