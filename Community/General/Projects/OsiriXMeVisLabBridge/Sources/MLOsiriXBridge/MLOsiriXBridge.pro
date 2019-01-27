#
#  MLOsiriXBridge.pro
#  MLOsiriXBridge
#
#  Created by Felix Ritter on 18.01.08.
#  This code is in the public domain.
#

MEVIS_MAINTAINER = fritter

TEMPLATE = lib

TARGET = MLOsiriXBridge

# add dependencies of this project here

CONFIG += dll ML MLTools MLOSXSupport
CONFIG += MLOsiriXServices

# make sure to set CONFIG and non-default MLAB_PACKAGES before the following line
include( $(MLAB_CURRENT_PACKAGE_DIR)/Configuration/DefaultProjectSetup.pri )

DEFINES += MLOSIRIXBRIDGE_EXPORTS ML_DISABLE_DEPRECATED

RELATEDFILES += \
    ../../../../Modules/ML/MLOsiriXBridge/MLOsiriXBridge.def

HEADERS += \
    MLOsiriXBridgeInit.h \
    MLOsiriXBridgeSystem.h \
    mlOsiriXBridge.h

SOURCES += \
    MLOsiriXBridgeInit.cpp

macos {

HEADERS += \
    mlOsiriXBridge_p.h \
    mlMeVisLabLoadDICOM.h \
    mlMeVisLabServicesProtocol.h \
    mlEatDicom.h

OBJECTIVE_SOURCES += \
    mlOsiriXBridge.mm \
    mlOsiriXBridge_p.mm \
    mlMeVisLabLoadDICOM.m \
    mlEatDicom.m

LIBS += \
    -framework Foundation

} else {

SOURCES += \
    mlOsiriXBridge.cpp

}
