#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "serialinterface.h"

void tst()
{
//    QSerialPort *cdcSerial = new QSerialPort();
//    cdcSerial->setPortName("/dev/ttyACM0");
//    cdcSerial->setBaudRate(QSerialPort::Baud9600);
////    cdcSerial->setStopBits(QSerialPort::OneStop);
////    cdcSerial->setParity(QSerialPort::EvenParity);
////    cdcSerial->setDataBits(QSerialPort::Data7);
////    cdcSerial->setFlowControl(QSerialPort::NoFlowControl);

//    char data[18];
//    //memset(data, 0x02, 18);
//    if(cdcSerial->open(QIODevice::ReadWrite))
//    {
//        std::cout << "opened succesfully\n";
//        for(int i=0;i<10;i++)
//        {
//            while(cdcSerial->isOpen())
//                if(cdcSerial->waitForReadyRead(-1))
//                {
//                    //std::cout << "New available adata: " << cdcSerial->bytesAvailable();
//                    //QByteArray datas = cdcSerial->readAll();
//                    cdcSerial->read(data, 18);
//                    std::cout << data << std::endl;
//                }
////            cdcSerial->read(data, 10);
////            std::cout << data << std::endl;
//        }
//    }
//    else
//        std::cout << "can not open\n";
//    cdcSerial->close();
}

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    qmlRegisterType<SerialInterface>("SerialInterface", 1, 0, "SerialInterface");

//    std::thread serial_listener (tst);
//    serial_listener.detach();

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);


    return app.exec();
}
