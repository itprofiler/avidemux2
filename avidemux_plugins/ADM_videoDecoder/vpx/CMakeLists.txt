INCLUDE(vd_plugin)
include(admCheckVpx)
# LibVPX
checkVpxDec()
IF (USE_VPX_DEC)
    SET(vpx_SRCS
        vpxPlugin.cpp
        ADM_vpx.cpp
    )
    INCLUDE_DIRECTORIES(${CMAKE_CURRENT_BINARY_DIR})
    INCLUDE_DIRECTORIES(${VPX_INCLUDEDIR})

    ADD_LIBRARY(ADM_vd_vpx SHARED ${vpx_SRCS})
    TARGET_LINK_LIBRARIES(ADM_vd_vpx ${VPX_LDFLAGS})
    INIT_VIDEO_DECODER(ADM_vd_vpx)
    INSTALL_VIDEO_DECODER(ADM_vd_vpx)
ENDIF (USE_VPX_DEC)
