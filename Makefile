CFLAGS=-O3 -Wall
SRC=scale.c simple.c

scale: $(SRC)
	$(CC) $(CFLAGS) $(SRC) -o ./bin/$@

clean:
	rm -f ./bin/scale