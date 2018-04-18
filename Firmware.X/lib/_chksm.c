//===-- chksm.c - Proyecto 2: Rutina para CheckSum --------------------------------------------------------*- c -*-===//
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

#include <stdint.h>

uint16_t _cmuli(uint8_t a, uint8_t b);

int x(char x, char y){
    if(y == x){
        return 0xFF;
    }else if(y == (x+1)){
        return 0xEE;
    }else if(y == (x+2)){
        return 0xDD;
    }
}

uint8_t _chksum(uint8_t opcode, uint8_t args, uint8_t argn, uint8_t arrgs[]){
    if (args == 0){
        return opcode;
    }else{
        uint16_t size_arrgs = _cmuli(args, argn);
        uint8_t chksm = opcode;
        chksm += args;
        chksm += argn;
        for (uint16_t i = 0; i < size_arrgs; i++){
            chksm += arrgs[i];
        }
        return chksm;
    }
}
