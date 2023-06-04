#ifndef DBMANAGER_H
#define DBMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QVariant>
#include <QList>

class DBManager : public QObject
{
    Q_OBJECT
    public:
        explicit DBManager(QObject *parent = nullptr);

    private:
        #define NUMBER_OF_RELAYS 16

    public slots:
        QList<QString> getRelayConfigs();
        bool setRelayConfig(int number, int type, int place);
};

#endif // DBMANAGER_H
