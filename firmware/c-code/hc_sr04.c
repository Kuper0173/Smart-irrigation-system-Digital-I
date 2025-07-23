#include <stdint.h>

// Direcciones base de los registros del periférico
#define HC_SR04_BASE      0xE0000000
#define REG_DISTANCE      (*(volatile uint32_t*)(HC_SR04_BASE + 0x00))
#define REG_THRESHOLD     (*(volatile uint32_t*)(HC_SR04_BASE + 0x04))
#define REG_CONTROL       (*(volatile uint32_t*)(HC_SR04_BASE + 0x08))

// Configuración de umbrales (en ticks)
     // 58 ticks ≈ 1cm a 25MHz
#define HIGH_THRESHOLD 580         // 100cm (nivel bajo)
#define LOW_THRESHOLD  290          // 50cm (nivel alto)

// Prototipos de funciones
void init_hcsr04(void);
uint32_t read_distance(void);
void set_threshold(uint32_t threshold_cm);
void control_bomba(uint32_t distance, uint8_t calidad_agua);


int main() {
    uint32_t distancia;
    uint8_t calidad_agua = 1; // 1 = agua buena, 0 = agua mala
    
    // Inicialización
    init_hcsr04();
    set_threshold(HIGH_THRESHOLD);
    
    while(1) {
        // Leer distancia actual
        distancia = read_distance();
        
        // Controlar bomba según distancia y calidad del agua
        control_bomba(distancia, calidad_agua);
        
        // Pequeño delay entre lecturas
        wait(15); // Implementar según tu sistema
    }
    
    return 0;
}

// Inicializa el periférico HC-SR04
void init_hcsr04() {
    // Habilitar el sensor
    REG_CONTROL = 0x1;
    
    // Configurar umbral inicial
    set_threshold(HIGH_THRESHOLD);
}

// Lee la distancia actual en ticks
uint32_t read_distance() {
    return REG_DISTANCE & 0xFFFF; // Solo los 16 bits bajos
}

// Configura el umbral en centímetros
void set_threshold(uint32_t threshold) {
    REG_THRESHOLD = threshold;
}

// Controla la bomba según distancia y calidad del agua
void control_bomba(uint32_t distance, uint8_t calidad_agua){   
    
    // Solo activar si el agua es de buena calidad
    if (calidad_agua) {
        if(distance > HIGH_THRESHOLD) {
            // Nivel bajo: activar bomba
            REG_CONTROL |= 0x2; // Bit 1 controla la bomba
            putstring("Bomba DESACTIVADA - Nivel bajo: ");
 
        } 
        else   {
            // Nivel alto: desactivar bomba
            REG_CONTROL &= ~0x2;
          putstring("Bomba DESACTIVADA - Nivel alto: ");

    } 
}
    else {
        // Agua no apta, desactivar bomba
        REG_CONTROL &= ~0x2;
        putstring("Bomba DESACTIVADA - Agua no apta\n");
    }
}

