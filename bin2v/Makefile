# Makefile

#CFLAGS = -g -O2
#CFLAGS = -g -static
CFLAGS = -g -O0

OBJS = bin2v.o

#CC = gcc32
CC = gcc
#CC = gcc34
PRG = bin2v

all: bin2v.o PRG

comb.o: bin2v.c
	${CC} -c bin2v.c ${CFLAGS}

PRG: ${OBJS}
	${CC} -o ${PRG} ${OBJS} ${CFLAGS}

clean: clean_PRG

clean_PRG:
	rm -f ${OBJS} ${PRG}
