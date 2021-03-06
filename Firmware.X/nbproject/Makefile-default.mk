#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=cof
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/Firmware.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=cof
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/Firmware.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS

else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=src/isr.asm src/libtmr2.asm src/main.asm src/libtmr1.asm src/slave_recive.asm lib/symbols.asm src/executer.asm

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/src/isr.o ${OBJECTDIR}/src/libtmr2.o ${OBJECTDIR}/src/main.o ${OBJECTDIR}/src/libtmr1.o ${OBJECTDIR}/src/slave_recive.o ${OBJECTDIR}/lib/symbols.o ${OBJECTDIR}/src/executer.o
POSSIBLE_DEPFILES=${OBJECTDIR}/src/isr.o.d ${OBJECTDIR}/src/libtmr2.o.d ${OBJECTDIR}/src/main.o.d ${OBJECTDIR}/src/libtmr1.o.d ${OBJECTDIR}/src/slave_recive.o.d ${OBJECTDIR}/lib/symbols.o.d ${OBJECTDIR}/src/executer.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/src/isr.o ${OBJECTDIR}/src/libtmr2.o ${OBJECTDIR}/src/main.o ${OBJECTDIR}/src/libtmr1.o ${OBJECTDIR}/src/slave_recive.o ${OBJECTDIR}/lib/symbols.o ${OBJECTDIR}/src/executer.o

# Source Files
SOURCEFILES=src/isr.asm src/libtmr2.asm src/main.asm src/libtmr1.asm src/slave_recive.asm lib/symbols.asm src/executer.asm


CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/Firmware.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=16f887
MP_LINKER_DEBUG_OPTION=-r=ROM@0x1F00:0x1FFE -r=RAM@SHARE:0x70:0x70 -r=RAM@SHARE:0xF0:0xF0 -r=RAM@SHARE:0x170:0x170 -r=RAM@GPR:0x1E5:0x1EF -r=RAM@SHARE:0x1F0:0x1F0
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/src/isr.o: src/isr.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/isr.o.d 
	@${RM} ${OBJECTDIR}/src/isr.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/isr.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/isr.lst\" -e\"${OBJECTDIR}/src/isr.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/isr.o\" \"src/isr.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/isr.o"
	@${FIXDEPS} "${OBJECTDIR}/src/isr.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/libtmr2.o: src/libtmr2.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/libtmr2.o.d 
	@${RM} ${OBJECTDIR}/src/libtmr2.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/libtmr2.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/libtmr2.lst\" -e\"${OBJECTDIR}/src/libtmr2.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/libtmr2.o\" \"src/libtmr2.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/libtmr2.o"
	@${FIXDEPS} "${OBJECTDIR}/src/libtmr2.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/main.o: src/main.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/main.o.d 
	@${RM} ${OBJECTDIR}/src/main.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/main.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/main.lst\" -e\"${OBJECTDIR}/src/main.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/main.o\" \"src/main.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/main.o"
	@${FIXDEPS} "${OBJECTDIR}/src/main.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/libtmr1.o: src/libtmr1.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/libtmr1.o.d 
	@${RM} ${OBJECTDIR}/src/libtmr1.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/libtmr1.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/libtmr1.lst\" -e\"${OBJECTDIR}/src/libtmr1.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/libtmr1.o\" \"src/libtmr1.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/libtmr1.o"
	@${FIXDEPS} "${OBJECTDIR}/src/libtmr1.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/slave_recive.o: src/slave_recive.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/slave_recive.o.d 
	@${RM} ${OBJECTDIR}/src/slave_recive.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/slave_recive.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/slave_recive.lst\" -e\"${OBJECTDIR}/src/slave_recive.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/slave_recive.o\" \"src/slave_recive.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/slave_recive.o"
	@${FIXDEPS} "${OBJECTDIR}/src/slave_recive.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/lib/symbols.o: lib/symbols.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/lib" 
	@${RM} ${OBJECTDIR}/lib/symbols.o.d 
	@${RM} ${OBJECTDIR}/lib/symbols.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/lib/symbols.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/lib/symbols.lst\" -e\"${OBJECTDIR}/lib/symbols.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/lib/symbols.o\" \"lib/symbols.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/lib/symbols.o"
	@${FIXDEPS} "${OBJECTDIR}/lib/symbols.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/executer.o: src/executer.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/executer.o.d 
	@${RM} ${OBJECTDIR}/src/executer.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/executer.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -d__DEBUG -d__MPLAB_DEBUGGER_PICKIT2=1 -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/executer.lst\" -e\"${OBJECTDIR}/src/executer.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/executer.o\" \"src/executer.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/executer.o"
	@${FIXDEPS} "${OBJECTDIR}/src/executer.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
else
${OBJECTDIR}/src/isr.o: src/isr.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/isr.o.d 
	@${RM} ${OBJECTDIR}/src/isr.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/isr.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/isr.lst\" -e\"${OBJECTDIR}/src/isr.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/isr.o\" \"src/isr.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/isr.o"
	@${FIXDEPS} "${OBJECTDIR}/src/isr.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/libtmr2.o: src/libtmr2.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/libtmr2.o.d 
	@${RM} ${OBJECTDIR}/src/libtmr2.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/libtmr2.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/libtmr2.lst\" -e\"${OBJECTDIR}/src/libtmr2.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/libtmr2.o\" \"src/libtmr2.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/libtmr2.o"
	@${FIXDEPS} "${OBJECTDIR}/src/libtmr2.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/main.o: src/main.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/main.o.d 
	@${RM} ${OBJECTDIR}/src/main.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/main.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/main.lst\" -e\"${OBJECTDIR}/src/main.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/main.o\" \"src/main.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/main.o"
	@${FIXDEPS} "${OBJECTDIR}/src/main.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/libtmr1.o: src/libtmr1.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/libtmr1.o.d 
	@${RM} ${OBJECTDIR}/src/libtmr1.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/libtmr1.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/libtmr1.lst\" -e\"${OBJECTDIR}/src/libtmr1.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/libtmr1.o\" \"src/libtmr1.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/libtmr1.o"
	@${FIXDEPS} "${OBJECTDIR}/src/libtmr1.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/slave_recive.o: src/slave_recive.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/slave_recive.o.d 
	@${RM} ${OBJECTDIR}/src/slave_recive.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/slave_recive.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/slave_recive.lst\" -e\"${OBJECTDIR}/src/slave_recive.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/slave_recive.o\" \"src/slave_recive.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/slave_recive.o"
	@${FIXDEPS} "${OBJECTDIR}/src/slave_recive.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/lib/symbols.o: lib/symbols.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/lib" 
	@${RM} ${OBJECTDIR}/lib/symbols.o.d 
	@${RM} ${OBJECTDIR}/lib/symbols.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/lib/symbols.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/lib/symbols.lst\" -e\"${OBJECTDIR}/lib/symbols.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/lib/symbols.o\" \"lib/symbols.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/lib/symbols.o"
	@${FIXDEPS} "${OBJECTDIR}/lib/symbols.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
${OBJECTDIR}/src/executer.o: src/executer.asm  nbproject/Makefile-${CND_CONF}.mk
	@${MKDIR} "${OBJECTDIR}/src" 
	@${RM} ${OBJECTDIR}/src/executer.o.d 
	@${RM} ${OBJECTDIR}/src/executer.o 
	@${FIXDEPS} dummy.d -e "${OBJECTDIR}/src/executer.err" $(SILENT) -c ${MP_AS} $(MP_EXTRA_AS_PRE) -q -p$(MP_PROCESSOR_OPTION)  -l\"${OBJECTDIR}/src/executer.lst\" -e\"${OBJECTDIR}/src/executer.err\" $(ASM_OPTIONS)    -o\"${OBJECTDIR}/src/executer.o\" \"src/executer.asm\" 
	@${DEP_GEN} -d "${OBJECTDIR}/src/executer.o"
	@${FIXDEPS} "${OBJECTDIR}/src/executer.o.d" $(SILENT) -rsi ${MP_AS_DIR} -c18 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/Firmware.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk  ../libsdcc.X/dist/default/debug/libsdcc.X.lib  
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE)   -p$(MP_PROCESSOR_OPTION)  -w -x -u_DEBUG -z__ICD2RAM=1 -m"${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map" -i   -z__MPLAB_BUILD=1  -z__MPLAB_DEBUG=1 -z__MPLAB_DEBUGGER_PICKIT2=1 $(MP_LINKER_DEBUG_OPTION) -odist/${CND_CONF}/${IMAGE_TYPE}/Firmware.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}   ..\libsdcc.X\dist\default\debug\libsdcc.X.lib   -i
else
dist/${CND_CONF}/${IMAGE_TYPE}/Firmware.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk  ../libsdcc.X/dist/default/production/libsdcc.X.lib 
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_LD} $(MP_EXTRA_LD_PRE)   -p$(MP_PROCESSOR_OPTION)  -w  -m"${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map" -i   -z__MPLAB_BUILD=1  -odist/${CND_CONF}/${IMAGE_TYPE}/Firmware.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}  ${OBJECTFILES_QUOTED_IF_SPACED}   ..\libsdcc.X\dist\default\production\libsdcc.X.lib   -i
endif


# Subprojects
.build-subprojects:
	cd /D ../libsdcc.X && ${MAKE}  -f Makefile CONF=default


# Subprojects
.clean-subprojects:
	cd /D ../libsdcc.X && rm -rf "build/default" "dist/default"

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
