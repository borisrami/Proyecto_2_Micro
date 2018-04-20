//===-- _putbuf.c - Proyecto 2: cargar un byte en una posición de un array --------------------------------*- c -*-===//
//
//   Proyecto 2 - Microcontroladores aplicados a la industria
//
//   Copyright (c) 2018 Oever González
//   Distribución libre solamente para usos exclusivamente académicos.
//
// EL SOFTWARE SE PROPORCIONA "TAL CUAL", SIN GARANTÍA DE NINGÚN TIPO, EXPRESA O IMPLÍCITA, INCLUYENDO PERO NO LIMITADO
// A GARANTÍAS DE COMERCIALIZACIÓN, IDONEIDAD PARA UN PROPÓSITO PARTICULAR Y NO INFRACCIÓN. EN NINGÚN CASO LOS AUTORES O
//   TITULARES DEL COPYRIGHT SERÁN RESPONSABLES DE NINGUNA RECLAMACIÓN, DAÑOS U OTRAS RESPONSABILIDADES, YA SEA EN UNA
// ACCIÓN DE CONTRATO, AGRAVIO O CUALQUIER OTRO MOTIVO, QUE SURJA DE O EN CONEXIÓN CON EL SOFTWARE O EL USO U OTRO TIPO
//                                              DE ACCIONES EN EL SOFTWARE.
//
//===--------------------------------------------------------------------------------------------------------------===//

// 0x05 es el offset de curr_char

char _putbuf(unsigned char, unsigned char, unsigned char, unsigned char, unsigned char[], unsigned char);

char _putbuf(unsigned char curr_char,
             unsigned char args,
             unsigned char argn,
             unsigned char size,
             unsigned char buff[],
             unsigned char val){
    static unsigned char left;
    static unsigned char idx;
    if(curr_char==0x05){idx = 0x00;left = args*argn;}
    if(idx >= size){return 0xFF;}
    buff[idx] = val;
    left -= 1;
    idx += 1;
    return left==0?0x01:0x00;
}
