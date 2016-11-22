        IF(CROSS)
                SET(WINDRES ${CMAKE_RC_COMPILER})
        ELSE(CROSS)
                SET(WINDRES windres.exe)
        ENDIF(CROSS)
include(admTimeStamp)
#
MACRO(WINDRESIFY src)
   IF(NOT MSVC)
        # add icon and version info
        SET(FILEVERSION_STRING "${AVIDEMUX_VERSION}")
        SET(PRODUCTVERSION_STRING "${AVIDEMUX_VERSION}")
        STRING(REPLACE "." "," FILEVERSION ${FILEVERSION_STRING})
        STRING(REPLACE "." "," PRODUCTVERSION ${PRODUCTVERSION_STRING})
        ADM_TIMESTAMP(date)
        SET(PRODUCTVERSION "${PRODUCTVERSION},${date}")
        SET(FILEVERSION "${FILEVERSION},${date}")

        IF (ADM_CPU_X86_64)
	        SET(WIN_RES_TARGET "pe-x86-64")
        ELSE (ADM_CPU_X86_64)
	        SET(WIN_RES_TARGET "pe-i386")
        ENDIF (ADM_CPU_X86_64)

        SET(AVIDEMUX_ICON "adm.ico")
        CONFIGURE_FILE("${AVIDEMUX_TOP_SOURCE_DIR}/cmake/admWin32.rc.in" ${CMAKE_CURRENT_BINARY_DIR}/admWin.rc IMMEDIATE)

        if (MINGW)
	        SET(ADM_WIN_RES "adm.obj")
	        SET( ${src} ${ADM_WIN_RES})
	        ADD_CUSTOM_COMMAND(OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${ADM_WIN_RES} COMMAND ${WINDRES} -F ${WIN_RES_TARGET} -i ${CMAKE_CURRENT_BINARY_DIR}/admWin.rc -o ${CMAKE_CURRENT_BINARY_DIR}/${ADM_WIN_RES} -O coff --define VS_VERSION_INFO=1)
        endif (MINGW)
	ELSE (NOT MSVC)
		#SET(${src}  ${CMAKE_CURRENT_BINARY_DIR}/admWin.rc)
	endif (NOT MSVC)

ENDMACRO(WINDRESIFY src)
