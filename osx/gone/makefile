all: gone

clean:
	rm -rf bin

gone: src/main.m
	mkdir -p bin
	clang -framework Foundation src/main.m -o bin/gone

