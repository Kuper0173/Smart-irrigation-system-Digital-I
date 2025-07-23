#include <stdint.h>
#include "libs/time.h"
#include "libs/uart.h"

// Dirección base del periférico de riego
#define PERIP_CONTROLADOR   0x00430000

// Offsets de los registros
#define REG_TURBIDEZ        0x01
#define REG_READY           0x02
#define REG_ENABLE_ESP      0x03
#define REG_LED_VALVULA     0x04

// Punteros a registros del periférico
volatile uint32_t *const turbidez_reg    = (uint32_t *)(PERIP_CONTROLADOR + REG_TURBIDEZ);
volatile uint32_t *const ready_reg       = (uint32_t *)(PERIP_CONTROLADOR + REG_READY);
volatile uint32_t *const enable_esp_rd   = (uint32_t *)(PERIP_CONTROLADOR + REG_ENABLE_ESP);
volatile uint32_t *const led_valvula_rd  = (uint32_t *)(PERIP_CONTROLADOR + REG_LED_VALVULA);

// Mensaje de bienvenida
const char hello[] = "Sistema de riego iniciado.\n\r";

// Función para imprimir un byte en hexadecimal (por consola UART)
void putchar_hex(uint8_t value) {
    const char hex_chars[] = "0123456789ABCDEF";
    putChar(hex_chars[(value >> 4) & 0x0F]);
    putChar(hex_chars[value & 0x0F]);
}

int main() {
    putstring(hello);

    for (int i = 0; i < 5; i++) {
        wait(10);
        putstring("Soy el valor del adc");
    }


    // 2. Leer valor desde UART
    uint32_t valor_raw = getChar();
    uint8_t valor_turbidez = (uint8_t)(valor_raw & 0xFF);

    // 3. Mostrar valor en consola
    putstring("Turbidez recibida: ");
    putchar_hex(valor_turbidez);
    putstring("\n\r");

    // 4. Escribir en registro de turbidez
    *turbidez_reg = (uint32_t)valor_turbidez;

    // 5. Espera entre ciclos (opcional)
    wait(10);



    return 0;
}
