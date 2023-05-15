#include "serialinterface.h"

SerialInterface::SerialInterface(QObject *parent)
    : QObject{parent}
{
    cdcSerial = new serialib();
    port_name = "/dev/ttyUSB0";
    serialConnected = false;
}

bool SerialInterface::fileExists(QString path)
{
    QFileInfo check_file(path);
    return check_file.exists();// && check_file.isFile();
}

void SerialInterface::startSerial()
{
    std::thread serial_listener (&SerialInterface::serialListener, this);
    serial_listener.detach();
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
//            std::cout << "connected\n";
            if(cdcSerial->readBytes(data, 18, 1000, 100) == 18)
            {
                if(data[0]=='#' && data[17]=='@')
                {
                    for(int i=1;i<=16;i++)
                    {
                        relayData[i-1] = data[i]=='a';
                        emit setRelayData(relayData);
                    }
                }
            }
            memset(data, 0x00, 18);
            cdcSerial->flushReceiver();
        }
        else
        {
//            std::cout << "Not connected\n";
            serialConnected = false;
            if(call_close_signal)
            {
                cdcSerial->closeDevice();
                emit serial_closed();
                call_close_signal = false;
            }
            for(int i=0;i<=64;i++)
            {
                std::string tmp_port_name = "/dev/ttyUSB" + std::to_string(i);
                if(cdcSerial->openDevice(tmp_port_name.c_str(), 115200, SERIAL_DATABITS_8, SERIAL_PARITY_NONE, SERIAL_STOPBITS_1)==1)
                {
                    serialConnected = true;
                    port_name = tmp_port_name;
                    // std::cout << "connected to: " << port_name << std::endl;
                    emit serial_opened();
                    call_close_signal = true;
                    break;
                }
            }
            std::this_thread::sleep_for(std::chrono::seconds(1));
        }
    }
    //    cdcSerial->closeDevice();
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
    cdcSerial->writeBytes(transmit_data, 3);
    //    msg_queue.push(transmit_data);
}
