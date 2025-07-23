# Makefile para HC-SR04 con detección de errores

TARGET = hc_sr04
SIMULATOR = iverilog
VIEWER = gtkwave
SRC = $(TARGET).v
TB = $(TARGET)_tb.v
VCD = $(TARGET).vcd
WAVE_CFG = wave.gtkw

all: clean compile simulate view

compile:
	@echo "Compilando $(TARGET)..."
	@if ! $(SIMULATOR) -o $(TARGET).out $(SRC) $(TB); then \
		echo "Error de compilación"; exit 1; \
	fi

simulate:
	@echo "Simulando..."
	@if ! vvp $(TARGET).out; then \
		echo "Error en simulación"; exit 1; \
	fi
	@if [ ! -f "$(VCD)" ]; then \
		echo "Error: No se generó $(VCD)"; exit 1; \
	fi

view:
	@echo "Abriendo GTKWave..."
	@if [ -f "$(VCD)" ]; then \
		$(VIEWER) $(VCD) $(if $(wildcard $(WAVE_CFG)),-a $(WAVE_CFG)) & \
	else \
		echo "Error: $(VCD) no existe"; \
	fi

clean:
	@echo "Limpiando proyecto..."
	@rm -f *.out *.vcd *.vpi *.log

.PHONY: all compile simulate view clean
