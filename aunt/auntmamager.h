#ifndef AUTOMANAGER_H
#define AUTOMANAGER_H

#include <QNetworkAccessManager>
#include <QObject>

class automanager : public QObject
{
    Q_OBJECT
public:
    explicit automanager(QObject *parent = nullptr);

    void authenticate(const QString &login, const QString &password);

    void registering(const QString &login, const QString &password);

private:
    QNetworkAccessManager _net;

signals:
    void registererRequestCompleted(QString);
    void authenticateRequestCompleted(QString, QString);

};

#endif // AUTOMANAGER_H
