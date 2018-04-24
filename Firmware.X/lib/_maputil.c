/* ===-- _maputil.c - Proyecto 2: Utilidades de mapeo-------*- pic8-asm -*-===//
* 
* 	Laboratorio 4 - Microcontroladores aplicados a la industria
* 
*  Copyright (c) 2018 Oever González
* 
*  Distribución libre solamente para usos exclusivamente académicos.
* 
*  EL SOFTWARE SE PROPORCIONA "TAL CUAL", SIN GARANTÍA DE NINGÚN TIPO, EXPRESA O
*     IMPLÍCITA, INCLUYENDO PERO NO LIMITADO A GARANTÍAS DE COMERCIALIZACIÓN,
*   IDONEIDAD PARA UN PROPÓSITO PARTICULAR Y NO INFRACCIÓN. EN NINGÚN CASO LOS
*  AUTORES O TITULARES DEL COPYRIGHT SERÁN RESPONSABLES DE NINGUNA RECLAMACIÓN,
*  DAÑOS U OTRAS RESPONSABILIDADES, YA SEA EN UNA ACCIÓN DE CONTRATO, AGRAVIO O
*  CUALQUIER OTRO MOTIVO, QUE SURJA DE O EN CONEXIÓN CON EL SOFTWARE O EL USO U
*                    OTRO TIPO DE ACCIONES EN EL SOFTWARE.
* 
* ===----------------------------------------------------------------------===//
*/

#include <stdint.h>

/*
 * Esta operacion es una version fuertemente optimizada de una division entera
 * utilizando shift logico.
 * Cualquier division con denominador conocido se puede convertir en una serie
 * de shift logico y sumas. Esto es mucho mas facil y rapido para la CPU que
 * una division larga, media vez la CPU tenga instrucciones de shift logico.
 *
 * Para esto, primero se debe conocer la operacion.
 *      -> (x*0xff)/1000
 * La operacion x*0xff se puede simplificar a
 *      -> (x<<8)/1000
 * Para una division entera, se usa esta formula
 *      -> (n*_fact)>>_shift
 * El factor se encuentra de esta forma, procurando el valor mas cercano a un
 * entero, procurando que no se desborde
 *      -> (_prev<<_shift)/_entr
 * Donde _entr es el valor a dividir, mientras que _prev es el valor que se
 * prevee el resultado de la division, es decir, una relacion _entr:_prev
 *      -> (1<<17)/1000    1:1000
 * La operacion que aplica la division es, entonces
 *      -> ((x<<8)*131)>>17
 * La multiplicacion se puede reducir a sumas y shift logico:
 *      -> Encontrar las potencias de dos que suman 131:
 *         131: 1<<7 + 1<<1 + 1<<0
 * Se aplican los shift logicos a la operacion
 *      -> ((x<<8)<<7+(x<<8)<<1+(x<<8)<<0)>>17
 * La operacion todavia se puede simplificar si se combinan los shift
 *      -> ((x<<15)+(x<<9)+(x<<8))>>17
 * 
 * En el caso del PIC, donde mientras mas grande es el shift, mas tardada es la
 * operacion, conviene reducir los shift. Todos en la misma proporcion.
 *      -> ((x<<7)+(x<<1)+(x<<0))>>9
 *      -> ((x<<7)+(x<<1)+x)>>9
 */
uint8_t fast_map_255_70(uint8_t x){
    //  -> (x*70)/255
    //  -> (x*71)>>8
    //  -> ((x<<0)+(x<<1)+(x<<2)+(x<<6))>>8
    uint16_t ex = ((uint16_t)x);
    ex += x<<1;
    ex += x<<2;
    ex += x<<6;
    ex = ex>>8;
    return ex;
}
