#include "authmanager.h"
#include "QJsonObject"
#include "QJsonDocument"
#include "QNetworkReply"
#include "QDebug"


AuthManager::AuthManager(QObject *parent) : QObject(parent)
{
    setRegisterProcessing(false);
    setLoginProcessing(false);
}

void AuthManager::authenticate(const QString &login, const QString &password)
{
    setLoginProcessing(true);
    QUrl url ("http://127.0.0.1:53188/auth");
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");
    QJsonObject body;
    body ["login"] = login;
    body ["password"] = password;
    QByteArray bodyData = QJsonDocument(body).toJson();
    QNetworkReply *reply= _net.post(request, bodyData);
    connect(reply, &QNetworkReply::finished,[this, reply](){
            QJsonObject obj = QJsonDocument::fromJson(reply -> readAll()).object();
            QString token = obj.value("token").toString();
        emit authenticateRequestCompleted(reply -> errorString(), token);
        setLoginProcessing(false);
        reply -> deleteLater();
    });
}

void AuthManager::registering(const QString &login, const QString &password)
{
    setRegisterProcessing(true);
    QUrl url ("http://127.0.0.1:53188/register");
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,"application/json");
    QJsonObject body;
    body ["login"] = login;
    body ["password"] = password;
    QByteArray bodyData = QJsonDocument(body).toJson();
    QNetworkReply *reply= _net.post(request,bodyData);
    connect(reply, &QNetworkReply::finished,[this, reply](){
        emit registererRequestCompleted(reply->errorString());
        setRegisterProcessing(false);
        reply -> deleteLater();
    });
}

bool AuthManager::isRegisterProcessing()
{
    return m_isRegisterProcessing;
}

bool AuthManager::isLoginProcessing()
{
    return m_isLoginProcessing;
}

void AuthManager::setRegisterProcessing(bool value)
{
    if (m_isRegisterProcessing == value)
        return;
    m_isRegisterProcessing = value;
    emit registerProcessingChanged(value);
}

void AuthManager::setLoginProcessing(bool value)
{
    if (m_isLoginProcessing == value)
        return;
    m_isLoginProcessing = value;
    emit loginProcessingChanged(value);
}
