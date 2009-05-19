isEmpty(Community_General_PRI_INCLUDED) {
  message ( loading Community_General.pri )
}
# **InsertLicense** code
# -----------------------------------------------------------------------------
# Community_General prifile
#
# \file    Community_General.pri
# \author  MeVisLab Community
# \date    2009-05-19
#
# 
#
# -----------------------------------------------------------------------------

# include guard against multiple inclusion
isEmpty(Community_General_PRI_INCLUDED) {

Community_General_PRI_INCLUDED = 1

# -- System -------------------------------------------------------------

include( $(MLAB_MeVis_Foundation)/Configuration/SystemInit.pri )

# -- Define local PACKAGE variables -------------------------------------

PACKAGE_ROOT    = $$(MLAB_Community_General)
PACKAGE_SOURCES = "$$(MLAB_Community_General)"/Sources

# Add package library path
LIBS          += -L"$${PACKAGE_ROOT}"/lib

# -- Projects -------------------------------------------------------------

# NOTE: Add projects below to make them available to other projects via the CONFIG mechanism

# You can use this example template for typical projects:
#MLMyProject {
#  CONFIG_FOUND += MLMyProject
#  INCLUDEPATH += $${PACKAGE_SOURCES}/ML/MLMyProject
#  win32:LIBS += MLMyProject$${d}.lib
#  unix:LIBS += -lMLMyProject$${d}
#}

# -- ML Projects -------------------------------------------------------------

# -- Inventor Projects -------------------------------------------------------

# -- Shared Projects ---------------------------------------------------------

# End of projects ------------------------------------------------------------

}
