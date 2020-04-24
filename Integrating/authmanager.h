#ifndef AUTOMANAGER_H
#define AUTOMANAGER_H

#include <QNetworkAccessManager>
#include <QObject>

class AuthManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isRegisterProcessing READ isRegisterProcessing WRITE setRegisterProcessing NOTIFY registerProcessingChanged)
    Q_PROPERTY(bool isLoginProcessing READ isLoginProcessing WRITE setLoginProcessing NOTIFY loginProcessingChanged);

public:
    explicit AuthManager(QObject *parent = nullptr);

    Q_INVOKABLE void authenticate(const QString &login, const QString &password);
    Q_INVOKABLE void registering(const QString &login, const QString &password);

    bool isRegisterProcessing();
    bool isLoginProcessing();
    void setRegisterProcessing(bool value);
    void setLoginProcessing(bool value);

private:
    QNetworkAccessManager _net;
    bool m_isRegisterProcessing;
    bool m_isLoginProcessing;

signals:
    void registererRequestCompleted(QString error);
    void authenticateRequestCompleted(QString error, QString token);
    void registerProcessingChanged(bool);
    void loginProcessingChanged(bool);
};

#endif // AUTOMANAGER_H
