# **InsertLicense** code
# -----------------------------------------------------------------------------
# MLWEMCommunityModules profile
#
# \file    MLWEMCommunityModules.pro
# \author  Bart De Dobbelaer
# \date    05/2009
# -----------------------------------------------------------------------------

TARGET = MLWEMCommunityModules

DESTDIR = ../../../lib
DLLDESTDIR = ../../../lib

# set high warn level (warn 4 on MSCV)
WARN = HIGH

# add dependencies of this project here

CONFIG += dll ML MLBase MLTools MathUtils newmat MLWEM boost

MLAB_PACKAGES += MeVisLab_Standard

# make sure that this file is included after CONFIG and MLAB_PACKAGES
include ($(MLAB_MeVis_Foundation)/Configuration/IncludePackages.pri)


DEFINES += MLWEMCOMMUNITYMODULES_EXPORTS

MSVC_USE_SUBDIRS = 1

HEADERS += \
    MLWEMCommunityModulesInit.h \
    MLWEMCommunityModulesSystem.h \
    WEMPlane\WEMMarchingCubes.h \
    WEMPlane\WEMPlane.h

SOURCES += \
    MLWEMCommunityModulesInit.cpp \
    WEMPlane\WEMPlane.cpp

RELATEDFILES += \
    ../../../Modules/ML/MLWEMCommunityModules/MLWEMCommunityModules.def 
