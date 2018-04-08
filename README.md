# Firmware Proyecto 2

## Tabla de contenidos

[TOC]

## Descripción

Este proyecto es un brazo robótico capaz de dibujar en una superficie, *plotter* de ahora en adelante. Cuenta con funcionamiento autónomo mediante una interfaz de botones, y además, cuenta con un protocolo de comunicación con una computadora para relizar trazos programados.

La interfaz de botones, de ahora en adelante *la interfaz mecánica*, consta de un *joystick* para controlar la posición del puntero, mas un par de botones para presionar y retirar el marcador. Contará con un indicador de control.

### Restricciones

La siguiente lista blanca determina lo que se *puede* usar:

- Microcontrolador PIC16F887 (2)
- Protoboard
- Dispositivos pasivos (resistores, inductores, capacitores)
- Botones pulsadores
- Joystick o, en su defecto, dos potenciómetros
- Servomotores
- Cristales de cuarzo
- Módulo USB-RS232 (FTDI)
- 4 Tornillos M3 x 20 mm
- 8 Tornillos M3 x 10 mm
- 4 Tuercas M3

La siguiente es una lista negra que determina lo que *no se puede* usar:

- El entorno Processing
- Utilizar loops, o *polling* (a menos que resulte en una mejora demostrable)

### Requisitos

- Trabajo escrito, reporte técnico y consideraciones de diseño
- Un video de YouTube donde se explique y demuestre el funcionamiento
- El proyecto funcional, con los siguientes criterios:
  - Arranque correcto del circuito
  - GUI y comunicación serial
  - Funcionamiento autónomo
  - Control de los Servomotores

## Consideraciones de diseño

En esta sección se detallan las consideraciones de diseño, y se justifican las mismas.

### Markdown en vez de $\LaTeX$

Markdown es un mejor lenguaje para escribir documentación que es puramente técnica. Por este motivo se ha adoptado ampliamente en la industria, más que $\LaTeX$ para este particular propósito. Existen intérpretes muy buenos que permiten generar PDF con sintaxis de código, HTML entre líneas y muchas características más.

## Protocolo de intercambio de información mediante el UART

A parte del protocolo UART, y el RS-232, es necesario establecer un protocolo para intercambiar la información pertinente entre los dos dispositivos. En esta sección se establece y define dicho protocolo.

### Dispositivo maestro

El dispositivo maestro es el conversor USB-RS232. El dispositivo maestro envía instrucciones al dispositivo esclavo, pero nunca al revés. Este dispositivo espera que el esclavo envíe únicamente información del estado y los resultados de las órdenes.

### Dispositivo esclavo

Este dispositivo recibe, decodifica y ejecuta instrucciones que recibe desde el dispositivo maestro. Luego de ejecutarlas, debe enviar una serie de datos al maestro para que este esté siempre informado del estado actual del dispositivo esclavo.

### Configuración del puerto serial

El puerto serial se **debe** configurar de la siguiente manera:

- Byte de 8 bits
- Salida y entrada de nivel CMOS (en vez de RS-232)
- Full duplex
- Asíncrono
- Recomendado: baudrate de 38400 como mínimo

### Sintaxis de comandos del dispositivo maestro

Esta sintaxis define la forma y el orden en el cual el dispositivo maestro debe enviar comandos al dispositivo esclavo, optimizando la consistencia por sobre la velocidad, simplicidad o espacio. Este protocolo tiene por nombre *ORPM-01*.

#### Secuencia de inicio

El dispositivo maestro se identifica con el esclavo enviando la siguiente combianción de bytes:

|  0   |  1   |
| :--: | :--: |
| 0xBB | 0x44 |

#### Secuencia de comando

Inmediatamente después de la secuencia de inicio, el dispositivo esclavo está listo para recibir un nuevo comando. Un comando puede tener una cantidad arbitraria de parámetros, pero se debe informar al esclavo al respecto.

- `OPCODE`: es el código de comando que reconoce el esclavo.
  - Mide exactamente 1 byte.
- `ARGS`: es un valor que determina el tamaño, en bytes, de cada uno de los argumentos.
  -  Mide exactamente 1 byte.
  - Cualquier valor mayor a 0 se considera válido.
  -  Si el valor es 0, se supone que el comando no tiene argumentos.
- `ARGN`: es el número total de argumentos que acomapañan al comando.
  -  Mide exactamente 1 byte.
  - Este valor se debe enviar solamente cuando `ARGS` sea distinto de 0.
  - Bajo ninguna circunstancia puede ser 0.
  - Cualquier valor mayor a 0 se considera válido.
- `ARGV[]`: es un array de bytes que contiene todos los argumentos.
  - Mide exactamente $ARGN*ARGS$.
  - Este valor se debe enviar solamente cuando `ARGS` sea distinto de 0.
- `CHKSM`: es un valor que representa una suma de confirmación. Este mecanismo no garantiza detectar todos los errores. Mide exactamente 1 byte. Este valor se debe enviar solamente cuando `ARGS` sea distinto de 0.

##### Comando con `ARGS` distinto de 0:

|    0     |   1    |   2    |     3     | ...  |    3+n    |   4+n   |
| :------: | :----: | :----: | :-------: | :--: | :-------: | :-----: |
| `OPCODE` | `ARGS` | `ARGN` | `ARGV[0]` | ...  | `ARGV[n]` | `CHKSM` |

##### Comando con `ARGS` igual a 0:

|    0     |  1   |    3    |
| :------: | :--: | :-----: |
| `OPCODE` | `0`  | `CHKSM` |

##### Cálculo del `CHKSM`

El cálculo del `CHKSM` se calcula con la siguiente operación:
$$
\left({\sum_{i=0}^kB[i]}\right)\and\texttt{0xFF}
$$
Donde $B[i]$ es el byte en la posición $i$. La posición $0$ corresponde al bit `OPCODE`, y la posición $k$ corresponde al byte anterior al byte `CHKSM`. $\and$ representa la operación lógica *AND*. El byte `CHKSM` no está incluido en la sumatoria.

#### Secuencia de finalización

El dispositivo maestro debe terminar la transimisión con la siguiente secuencia de bytes:

|  0   |  1   |
| :--: | :--: |
| 0xAA | 0x55 |

#### Comandos reservados

La siguiente lista de comandos están reservados. La sintaxis es la siguiente:

​	**OPCODE**(ARGS, ARGN, ARGV1 ...  ARGVN)

​	**OPCODE**(0)

- `0x00`: `ACK(0)`
  - Este comando solicita al dispositivo esclavo enviar una secuencia de bits para determinar que la comunicación es correcta.
  - La respuesta de `ACK` no respeta el protocolo del dispositivo esclavo.
  - La secuencia es `0xAA 0x88 0xB1 0x6B 0x05 0x55`
- `0xFF`: `HUNGUP(0)`
  - Después de enviar este comando, el dispositivo esclavo no enviará más información e ignorará todos los datos enviados por el maestro.
  - Para cancelar el efecto de `HUNGUP`, se debe enviar `ACK`.
  - No se debe esperar una respuesta después de enviara `HUNGUP`.
- `0x01`: `TIMEOUT(2, 1, MS)`
  - `TIMEOUT` establece un tiempo máximo en el cual el dispositivo esclavo estará al pendiente del puerto serial.
    - Aplica desde que se recibe el último byte válido desde el maestro.
  - Una vez ocurrido, como mínimo, `MS` milisegundos, el dispositivo esclavo descartará el comando recibido.
    - Ninguno de los efectos del comando serán efectuados.
    - El dispositivo esclavo envía `ETIMEOUT` y después ejecuta `HUNGUP`
  - Si el dispositivo esclavo detecta un error en el comando, en la sintaxis o en el checksum, debe descartar inmediatamente el comando.
    - Después de, como mínimo, `MS` milisegundos, el dispositivo esclavo enviará un paquete de información de estado con el error `EINVAL` o `ENOGOOD`, y ejecutará el comando `HUNGUP`.

