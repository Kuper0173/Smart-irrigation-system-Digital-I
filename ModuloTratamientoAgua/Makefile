help: help-sim help-syn
clean: clean-syn clean-sim
# top=top
top=SOC
#test bench del proyecto para la simulación
#tb?=$(top)_tb.v
tb?=cores/led_pwm/led_pwm_tb.v
MACROS_SIM=-DINIT=(2**24-10) -DBENCH -DSIM -DPASSTHROUGH_PLL -DBOARD_FREQ=27 -DCPU_FREQ=27
MACROS_RTL=
MACROS_SYN=
#DESIGN=top.v
DESIGN+= SOC.v
DESIGN+= cores/cpu/femtorv32_quark.v
DESIGN+= chip_select.v
DESIGN+= cores/memory/Memory.v
DESIGN+= cores/uart/perip_uart.v
DESIGN+= cores/uart/uart.v
DESIGN+= cores/mult/perip_mult.v
DESIGN+= cores/mult/mult.v
DESIGN+= cores/dpRAM/dpram.v
DESIGN+= cores/dpRAM/perip_dpram.v
DESIGN+= cores/led_pwm/led_pwm.v
DESIGN+= cores/led_pwm/perip_led_pwm.v
DESIGN+= cores/controladorderiego/controladorderiego.v
DESIGN+= cores/controladorderiego/perip_controladorderiego.v

DIR_BUILD=build
PORT=/dev/ttyUSB0
BAUD=115200 # 57600
# Z: Nombre para empaquetar proyecto
Z=femtoriscv
MORE_SRC2SIM=firmware.hex
MORE_SRC=cores init_dpram.ini firmware docs
c-build:
	make -C ./firmware c-build
c-clean:
	make -C ./firmware c-clean
asm-build:
	make -C ./firmware asm-build
asm-clean:
	make -C ./firmware asm-clean
t:
	picocom $(PORT) -b $(BAUD)

top_NAME=$(basename $(notdir $(DESIGN)))
#################################################
###--- Rules from colorlight-5a-75e-syn.mk ---###
#################################################
top?=$(top_NAME)
LPF?=$(top).lpf
JSON?=$(DIR_BUILD)/$(top).json
PNR?=$(DIR_BUILD)/$(top).pnr
BISTREAM?=$(DIR_BUILD)/$(top).bit
LOG_YOSYS?=$(DIR_BUILD)/yosys-$(top).log
LOG_NEXTPNR?=$(DIR_BUILD)/nextpnr-$(top).log
# MACRO_SYN sirve para indicar definiciones de preprocesamiento en la sintesis
MACROS_SYN := $(foreach macro,$(MACROS_SYN),"$(macro)")

help-syn:
	@printf "\n## SINTESIS Y CONFIGURACIÓN ##\n"
	@printf "\tmake syn\t\t-> Sintetizar diseño\n"
	@printf "\tmake config\t\t-> Configurar fpga en CRAM\n"
	@printf "\tmake config-flash\t-> Guardar el bistream en memoria flash\n"
	@printf "\tmake config-help\t-> Ayuda sobre cómo configurar la Colorlight\n"
	@printf "\tmake detect\t\t-> Detectar FPGA\n"
	@printf "\tmake reset\t\t-> Reiniciar FPGA\n"
	@printf "\tmake erase-flash\t-> Borrar la memoria flash de configuración\n"
	@printf "\tmake log-syn\t\t-> Ver el log de la síntesis con Yosys. Comandos: /palabra -> buscar, n -> próxima palabra, q -> salir, h -> salir\n"
	@printf "\tmake log-pnr\t\t-> Ver el log del place&route con nextpnr. Comandos: /palabra -> buscar, n -> próxima palabra, q -> salir, h -> salir\n"
	@printf "\tmake clean\t\t-> Limipiar síntesis si ha modificado el diseño\n"

syn: json pnr bitstream

OBJS+=$(DESIGN)

$(JSON): $(OBJS)
	mkdir -p $(DIR_BUILD)
	yosys $(MACROS_SYN) -p "synth_ecp5 -top $(top) -json $(JSON)" $(OBJS) -l $(LOG_YOSYS)

log-syn:
	less $(LOG_YOSYS)

$(PNR): $(JSON)
	nextpnr-ecp5 --25k --package CABGA256 --speed 6 --json $(JSON) --lpf $(LPF) --freq 65 --textcfg $(PNR) --log $(LOG_NEXTPNR)

log-pnr:
	less $(LOG_NEXTPNR)

$(BISTREAM): $(PNR)
	ecppack $(PNR) $(BISTREAM)
# USB-UART
CABLE= -c ft232RL
# Pines del FTDI usable
FT232RL_TXD=0
FT232RL_RXD=1
FT232RL_RTS=2
FT232RL_CTS=3
FT232RL_DTR=4
FT232RL_DSR=5
FT232RL_DCD=6
FT232RL_RI=7
# JTAG pines relacionados con los pines del ft232rl
TDI=$(FT232RL_TXD)
TDO=$(FT232RL_CTS)
TCK=$(FT232RL_DTR)
TMS=$(FT232RL_RXD)
# JTAG pines relacionados con los pines del ft232rl
CABLE_PINES?=$(TDI):$(TDO):$(TCK):$(TMS)

CONFIG_OPTIONS+=$(CABLE)

ifneq ($(CABLE_PINES),) # Si cables es diferente de vacío
CONFIG_OPTIONS+= --pins=$(CABLE_PINES)
endif
CONFIG_OPTIONS+= --verbose
CONFIG_OPTIONS+= --freq 3000000
# CONFIG_OPTIONS+= --invert-read-edge

PATH_OPEN_FPGA_LOADER=openFPGALoader

reset:
	$(PATH_OPEN_FPGA_LOADER) $(CONFIG_OPTIONS)  -r

detect:
	$(PATH_OPEN_FPGA_LOADER) $(CONFIG_OPTIONS) --detect $(OPTIONS_CABLE)

config-flash:
	$(PATH_OPEN_FPGA_LOADER) $(CONFIG_OPTIONS) -f $(BISTREAM) --unprotect-flash

erase-flash:
	$(PATH_OPEN_FPGA_LOADER) $(CONFIG_OPTIONS) --bulk-erase --unprotect-flash

config-sram:
	$(PATH_OPEN_FPGA_LOADER) $(CONFIG_OPTIONS) -m $(BISTREAM)

config: config-sram

config-help:
	@printf "## INFORMACIÓN DE CONFIGURACIÓN PARA COLORLIGHT ##\n\n\
	1. ENERGIZAR LA PLACA DE DESARROLLO COLORLIGHT: Para configurar la Colorlight se requiere un bridge como también una fuente de alimentación. \
	En este ejemplo, se supondrá el uso del FT232RL, el cual es un adaptador USB a UART que sirve para emular un bridge JTAG. \
	Primero deberá garantizar la alimentación del ECP5; la Colorlight tiene dos entradas de alimentación, una de 3.3v en el conector J33 y otra de 5v en J18. \
	Si trata de alimentar la Colorlight con el FT232RL a 3.3v es muy probable que no tenga la corriente suficiente para funcionar el circuito de la FPGA y por consiguiente, no se configure. \
	Puede hacer uso de la salida de 5v del FT232RL para configurar la FPGA, siempre y cuando no tenga sensores y actuadores que consuman mucha energia. Por tanto, \
	se RECOMIENDA EL USO DE UNA FUENTE EXTERNA DE 5V PARA UNA CONFIGURACIÓN DE LA COLORLIGHT CORRECTA. \n\n\
	2. PROCESO DE CONFIGURACIÓN: Se puede realizar la configuración a través de los comandos *make config* o *make config-flash*, para tal fin, deberá conectar el adapatador FT232RL a la COLORLIGHT \
	teniendo presente los pines a usar. \n\
	2.1 El FT232RL tiene 8 pines configurables para el JTAG que se identifican de la siguiente manera: \n\n\
	\tFT232RL: TXD=0, RXD=1, RTS=2, CTS=3, DTR=4, DSR=5, DCD=6 y RI=7\n\n\
	2.2 La Colorlight tiene los siguientes puertos de JTAG:\n\n\
	\tJTAG COLORLIGHT: TDI=J32, TDO=J30, TCK=J27 y TMS=J31\n\n\
	2.3 El comando *make config* y los alternativos tiene asociado los pines del JTAG de la siguiente manera: **CABLE_PINES=TDI:TDO:TCK:TMS**, en donde los valores son sustituidos por el número del pin del FT232RL \
	para emular el JTAG. Por defecto, al ejecutar el comando *make config*, los pines que son usados son:\n\n\
	\t-Orden de los pines para la configuración: CABLE_PINES=TDI:TDO:TCK:TMS\n\
	\t-Pines del FT232RL usados por defecto:     CABLE_PINES=$(TDI):$(TDO):$(TCK):$(TMS)\t\t, es decir, La pareja de pines [pinFPGA--pinFT232], como sigue: J32--TXD, J30--CTS, J27--DTR y J31--RXD.\n\n\
	2.4 Si desea hacer uso de otros pines, simplemente conectelos desde el FT232RL al JTAG de la FPGA y en el uso del comando *make config* y sus alternativos, indique explícitamente los pines a usar, ejemplo:\n\n\
	\tmake config CABLE_PINES=5:4:7:6\n\n\
	Lo anterior quiere decir que se ha seleccionado una configuración en la cual se conectará la FPGA y el FT232RL como sigue: TDI--DSR, TDO--DTR, TCK--RI y TMS--DCD.\n\n\
	3. OBSERVACIONES:\n\
	\t-Recuerde conectar el GND del FT232RL al GND de la COLORLIGHT\n\
	\t-Puede agregar la configuración de los cables (CABLE_PINES=pines seleccionados) en las cabeceras del Makefile para que no sea necesaria recordar la configuración de los pines que usted a seleccionado\n\
	\t-Puede detectar una FPGA con el comando *make detect*\n\
	\t-Puede reiniciar una FPGA con el comando *make reset*\n\
	"

json:$(JSON)
pnr:$(PNR)
bitstream:$(BISTREAM)

Z?=prj
zip:
	$(RM) $Z $Z.zip
	mkdir -p $Z
	head -n -3 Makefile > $Z/Makefile
	sed -n '5,$$p' $(MK_SYN) >> $Z/Makefile	# Empieza a escribir desde la línea 6
	sed -n '7,$$p' $(MK_SIM) >> $Z/Makefile # Empieza a escribir desde la línea 7
	cp -var *.v *.md *.lpf .gitignore $Z
ifneq ($(wildcard *.pdf),) # Si existe un archivo .pdf
	cp -var *.pdf $Z
endif
ifneq ($(wildcard *.mem),) # Si existe un archivo .mem
	cp -var *.mem $Z
endif
ifneq ($(wildcard *.hex),) # Si existe un archivo .hex
	cp -var *.hex $Z
endif
ifneq ($(wildcard *.png),) # Si existe un archivo .png
	cp -var *.png $Z
endif
ifneq ($(wildcard *.txt),) # Si existe un archivo .txt
	cp -var *.txt $Z
endif
ifneq ($(wildcard *.gtkw),) # Si existe un archivo .gtkw
	cp -var *.gtkw $Z
endif
ifdef MORE_SRC
	cp -var $(MORE_SRC) $Z
endif
	zip -r $Z.zip $Z

init:
	@echo "build/\nsim/\n*.log\n$Z/\n" > .gitignore
	touch $(top).png README.md

clean-syn:
	$(RM) -rf $(DIR_BUILD)
	# $(RM) -f $(JSON) $(PNR) $(BISTREAM)

.PHONY: clean
# .PHONY: upload clean $(top).json $(top).bin $(top).pnr init_dir_build
###############################
###--- Rules from sim.mk ---###
###############################
tb?=$(top_NAME)_tb.v
TBN=$(basename $(notdir $(tb)))

S=sim
LOG_YOSYS_RTL?=$(S)/yosys-$(top).log

.ONESHELL:
SHELL=/bin/bash
# Enviroment conda to activate
ENV=digital
CONDA_ACTIVATE = source $$($$CONDA_EXE info --base)/etc/profile.d/conda.sh ; conda activate; conda activate $(ENV)
RUN = $(CONDA_ACTIVATE) &&
RUN =# Activate if don't use CONDA

help-sim:
	@printf "\n## SIMULACIÓN Y RTL##"
	@printf "\tmake rtl \t-> Crear el RTL desde el TOP\n"
	@printf "\tmake sim \t-> Simular diseño\n"
	@printf "\tmake wave \t-> Ver simulación en gtkwave\n"
	@printf "\tmake log-rtl \t-> Ver el log del RTL. Comandos: /palabra -> buscar, n -> próxima palabra, q -> salir, h -> salir\n"
	@printf "\nEjemplos de simulaciones con más argumentos:\n"
	@printf "\tmake sim VVP_ARG=+inputs=5\t\t:Agregar un argumento a la simulación\n"
	@printf "\tmake sim VVP_ARG=+a=5\ +b=6\t\t:Agregar varios argumentos a la simulación\n"
	@printf "\tmake sim VVP_ARG+=+a=5 VVP_ARG+=+b=6\t:Agregar varios argumentos a la simulación\n"
	@printf "\tmake rtl top=modulo1\t\t\t:Obtiene el RTL de otros modulos (submodulos)\n"
	@printf "\tmake rtl rtl2png\t\t\t:Convertir el RTL del TOP desde formato svg a png\n"
	@printf "\tmake rtl rtl2png top=modulo1\t\t:Además de convertir, obtiene el RTL de otros modulos (submodulos)\n"
	@printf "\tmake ConvertOneVerilogFile\t\t:Crear un único verilog del diseño\n"

rtl: rtl-from-json view-svg

sim: clean-sim iverilog-compile vpp-simulate wave

MACROS_SIM := $(foreach macro,$(MACROS_SIM),"$(macro)")
# MORE_SRC2SIM permite agregar más archivos fuentes para la simulación
MORE_SRC2SIM?=
iverilog-compile:
	mkdir -p $S
ifneq ($(MORE_SRC2SIM), )
	cp -var $(MORE_SRC2SIM) $S
endif
	iverilog $(MACROS_SIM) -o $S/$(TBN).vvp -s $(TBN) $(tb) $(DESIGN)

# VVP_ARG permite agregar argumentos en la simulación con vvp
VVP_ARG=
vpp-simulate:
	cd $S && vvp $(TBN).vvp -vcd $(VVP_ARG) -dumpfile=$(TBN).vcd

wave:
	@gtkwave $S/$(TBN).vcd $(TBN).gtkw || (echo "No hay un forma de onda que mostrar en gtkwave, posiblemente no fue solicitada en la simulación")

MACROS_RTL := $(foreach macro,$(MACROS_RTL),"$(macro)")
json-yosys: ## Generar json para el rtl de netlistsvg
	mkdir -p $S
	$(RUN) yosys $(MACROS_RTL) -p 'prep -top $(top); hierarchy -check; proc; write_json $S/$(top).json' $(DESIGN) -l $(LOG_YOSYS_RTL)

log-rtl:
	less $(LOG_YOSYS_RTL)

# Convertir el diseño en un solo archivo de verilog
ConvertOneVerilogFile:
	mkdir -p $S
	$(RUN) yosys $(MACROS_SIM) -p 'prep -top $(top); hierarchy -check; proc; opt -full; write_verilog -noattr -nodec $S/$(top).v' $(DESIGN)
	# yosys -p 'read_verilog $(DESIGN); prep -top $(TOP); hierarchy -check; proc; opt -full; write_verilog -noattr -noexpr -nodec $S/$(TOP).v'
	# yosys -p 'read_verilog $(DESIGN); prep -top $(TOP); hierarchy -check; proc; flatten; synth; write_verilog -noattr -noexpr $S/$(TOP).v'

rtl-from-json: json-yosys
	cp $S/$(top).json $S/$(top)_origin.json # Hacer una copia desde el archivo origen
	sed -E 's/"\$$paramod\$$[^\\]+\\\\([^"]+)"/"\1"/g' $S/$(top)_origin.json > $S/$(top).json # Quitar parametros en el nombre del módulo para que sea legible.
	$(RUN) netlistsvg $S/$(top).json -o $S/$(top).svg
	## convert2SvgwithWhiteBackground
	sed -i 's|<svg\([^>]*\)>|<svg\1>\n  <rect width="100%" height="100%" fill="white"/>|' $S/$(top).svg

view-svg:
	eog $S/$(top).svg

rtl-xdot:
	$(RUN) yosys $(MACROS_SIM) -p $(RTL_COMMAND)

rtl2png:
	convert -density 200 -resize 1200 $S/$(top).svg $(top).png
	# convert -resize 1200 -quality 100 $S/$(TOP).svg $(TOP).png

init-sim:	
	@printf "sim/\n$Z/\n" > .gitignore
	touch README.md $(top).png

RM=rm -rf
# EMPAQUETAR SIMULACIÓN EN .ZIP
Z?=prj
zip-sim:
	$(RM) $Z $Z.zip
	mkdir -p $Z
	# Quitar las últimas dos líneas del Makefile y crear copia en el directorio $Z
	head -n -2 Makefile > $Z/Makefile
	# Agregar el contenido de sim.mk después de la línea 6
	sed -n '6,$$p' $(MK_SIM) >> $Z/Makefile
	cp -var *.v *.md .gitignore $Z
ifneq ($(wildcard *.mem),) # Si existe un archivo .png
	cp -var *.mem $Z
endif
ifneq ($(wildcard *.hex),) # Si existe un archivo .png
	cp -var *.hex $Z
endif
ifneq ($(wildcard *.png),) # Si existe un archivo .png
	cp -var *.png $Z
endif
ifneq ($(wildcard *.svg),) # Si existe un archivo .png
	cp -var *.svg $Z
endif
ifneq ($(wildcard *.txt),) # Si existe un archivo .txt
	cp -var *.txt $Z
endif
ifneq ($(wildcard *.gtkw),) # Si existe un archivo .txt
	cp -var *.gtkw $Z
endif
ifneq ($(wildcard *.dig),) # Si existe un archivo .dig
	cp -var *.dig $Z
endif
	zip -r $Z.zip $Z

clean-sim:
	rm -rf $S $Z $Z.zip

## YOSYS ARGUMENTS
RTL_COMMAND?='read_verilog $(DESIGN);\
						 hierarchy -check;\
						 show $(top)'

