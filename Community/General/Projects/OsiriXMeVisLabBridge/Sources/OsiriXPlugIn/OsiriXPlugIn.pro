#
#  OsiriXPlugIn.pro
#  OsiriXMeVisLabBridgePlugin
#
#  Created by Felix Ritter on 18.01.08.
#  This code is in the public domain.
#

MEVIS_MAINTAINER = fritter

TEMPLATE = aux

DESTDIR = $$PWD/../../../../bin/PlugIns

TARGET = OsiriXMeVisLabBridge.osirixplugin

# Create Info.plist file from template file given in MLAB_INFO_PLIST_TEMPLATE
ML_INFO_PLIST_TEMPLATE = $$PWD/Info-template.plist
include ( $$(MLAB_MeVis_Foundation)/Configuration/CreateInfoPListFromTemplate.pri )
system ( mv -f \"$$QMAKE_INFO_PLIST\" \"$$PWD/Info.plist\" )

# Detect OS version
include ($(MLAB_MeVis_BuildSystem)/Configuration/System.pri)

xcodebuild.target = $$TARGET
xcodebuild.commands = /usr/bin/xcodebuild -scheme \"Build Plugin\" -configuration Release MACOSX_DEPLOYMENT_TARGET=$$QMAKE_MACOSX_DEPLOYMENT_TARGET clean build

macos:release:!debug:QMAKE_EXTRA_TARGETS += xcodebuild
