/* Punto de arranque o entrada*/
ENTRY(main) /*Función main, originalmente es _start*/
MEMORY
{
    BRAM (RWX) : ORIGIN = 0x0000, LENGTH = 0x8000  /* 32kB RAM, 32768 bytes, 8192 palabras de 32 bits */
}

SECTIONS
{
    .text : {
        . = ALIGN(4);
        *(.text.startup)  /* Sección de inicio */
        *(.text*)        /* Todo el resto de código */
        *(.rodata*)      /* Datos de solo lectura */
        *(.data*)        /* Datos inicializados */
        *(.bss*)         /* Datos no inicializados */
        *(COMMON)        /* Variables comunes */
        . = ALIGN(4);
    } > BRAM

    /* Definición del inicio de la pila al final de la BRAM */
    _stack_start = ORIGIN(BRAM) + LENGTH(BRAM);
}
