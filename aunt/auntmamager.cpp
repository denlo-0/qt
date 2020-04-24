#include "auntmamager.h"
#include "QJsonObject"
#include "QJsonDocument"
#include "QNetworkReply"
#include "QDebug"


automanager::automanager(QObject *parent) : QObject(parent)
{

}

void automanager::authenticate(const QString &login, const QString &password)
{
    QUrl url ("http://127.0.0.1:54696/auth");

    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader,
                      "application/json");

    QJsonObject body;
    body ["login"] = login;
    body ["password"] = password;
    QByteArray bodyData = QJsonDocument(body).toJson();

    QNetworkReply *reply= _net.post(request, bodyData);

    connect(reply, &QNetworkReply::finished,[this, reply](){
            QJsonObject obj = QJsonDocument::fromJson(reply -> readAll()).object();
            QString token = obj.value("token").toString();
            emit authenticateRequestCompleted(reply -> errorString(), token);
            qDebug()<<"token:"<<token;
            reply -> deleteLater();
        });
}

void automanager::registering(const QString &login, const QString &password)
{
    QUrl url ("http://127.0.0.1:54696/register");

    QNetworkRequest request(url);

    request.setHeader(QNetworkRequest::ContentTypeHeader,
                     "application/json");

    QJsonObject body;
    body ["login"] = login;
    body ["password"] = password;
    QByteArray bodyData = QJsonDocument(body).toJson();

    QNetworkReply *reply= _net.post(request,bodyData);

    connect(reply, &QNetworkReply::finished,[this, reply](){
        emit registererRequestCompleted(reply->errorString());
        qDebug()<<"error:"<<reply->errorString();
        reply -> deleteLater();
    });
}
