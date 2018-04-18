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

void _putbuf(unsigned char[], unsigned char, unsigned char*, unsigned char);

void _putbuf(unsigned char buff[], unsigned char size, unsigned char *idx, unsigned char val){
    unsigned char vidx = *idx;
    if(vidx >= size){return;}
    buff[vidx] = val;
    *idx = vidx + 1;
}
