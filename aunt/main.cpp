#include <QCoreApplication>
#include "auntmamager.h"

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    automanager auth;
    auth.registering("123456@gmail.com", "123456");
    auth.authenticate("123456@gmail.com", "123456");
    return a.exec();
}
