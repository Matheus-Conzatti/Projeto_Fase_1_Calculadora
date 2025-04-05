MCU=atmega328p
F_CPU=16000000UL
BAUND=9600
PORT=COM5

AS=avr-as
LD=avr-ld
OBJCOPY=avr-objcopy
AVRDUDE=avrdude

SRC=calculadora.asm
OBJ=calculadora.o
ELF=calculadora.elf
HEX=calculadora.hex

ASFLAGS=-mmcu=$(MCU)
LDFLAGS=
AVRDUDE_FLAGS=-c arduino -p m328p -P $(PORT) -b 115200

all: $(HEX)

$(OBJ): $(SRC)
	$(AS) $(ASFLAGS) -o $@ $<

$(ELF): $(OBJ)
	$(LD) -o $@ $<

$(HEX): $(ELF)
	$(OBJCOPY) -O ihex -R .eeprom $< $@

upload: $(HEX)
	$(AVRDUDE) $(AVRDUDE_FLAGS) -U flash:w:$(HEX):i

monitor:
	screen $(PORT) 9600

clean:
	rm -f *.o *.elf *.hex