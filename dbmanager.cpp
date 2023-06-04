#include "dbmanager.h"
#include <iostream>

DBManager::DBManager(QObject *parent)
    : QObject{parent}
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("bms.db");
//    if(!db.open())
//    {
//        std::cout << "Error opening database\n";
//    }
//    else
//    {
//        QSqlQuery query;
//        query.prepare("INSERT INTO relayConfigs (number, type, place) VALUES (0, 7, 45)");
//        query.bindValue(":number", "0");
//        query.bindValue(":type", "7");
//        query.bindValue(":place", "45");
//        if(query.exec()) std::cout << "query executed\n";
//        else std::cout << "query failed\n";
//    }
}

QList<QString> DBManager::getRelayConfigs()
{
    QList<QString> relayConfigs;
    for(int i=0;i<NUMBER_OF_RELAYS;i++)
    {
        QString tmp = QString::number(i) + ', 0, -1';
        relayConfigs.append(tmp);
    }

    QSqlDatabase db = QSqlDatabase::database();
    if(!db.open()) return relayConfigs;

    QSqlQuery query(db);
    query.prepare("SELECT * FROM relayConfigs");
    query.exec();
    relayConfigs.clear();
    while(query.next())
    {
        QString tmp = query.value(0).toString() + ',' + query.value(1).toString() + ',' + query.value(2).toString();
        relayConfigs.append(tmp);
    }

    return relayConfigs;
}

bool DBManager::setRelayConfig(int number, int type, int place)
{
    QSqlDatabase db = QSqlDatabase::database();
    if(!db.open()) return false;
    QSqlQuery query(db);
    QString q = "UPDATE relayConfigs SET type=" + QString::number(type) + ", place=" + QString::number(place) + " WHERE number=" + QString::number(number) + ";";
    query.prepare(q);
    return query.exec();
}

