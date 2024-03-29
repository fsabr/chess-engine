CC = g++
DBGFLAGS = -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG
CPPFLAGS = -std=c++17 -Wall -Wextra -Wpedantic -Wshadow -O3
BUILD = build
SRC = src

engine: ${BUILD}/main.o ${BUILD}/search.o ${BUILD}/zobrist.o ${BUILD}/display.o ${BUILD}/game.o ${BUILD}/game_fen.o ${BUILD}/game_moves.o ${BUILD}/game_make_move.o ${BUILD}/game_piece_moves.o ${BUILD}/notation.o ${BUILD}/types.o
	$(CC) $(CPPFLAGS) $^ -o $@

${BUILD}/game.o: ${SRC}/game.h ${SRC}/types.h ${SRC}/game.cpp
	$(CC) $(CPPFLAGS) -c ${SRC}/game.cpp -o $@

${BUILD}/game_fen.o: ${SRC}/game.h ${SRC}/types.h ${SRC}/notation.h ${SRC}/game_fen.cpp
	$(CC) $(CPPFLAGS) -c ${SRC}/game_fen.cpp -o $@

${BUILD}/game_moves.o: ${SRC}/game.h ${SRC}/types.h ${SRC}/movement.h ${SRC}/game_moves.cpp
	$(CC) $(CPPFLAGS) -c ${SRC}/game_moves.cpp -o $@

${BUILD}/game_make_move.o: ${SRC}/game.h ${SRC}/types.h ${SRC}/movement.h ${SRC}/game_make_move.cpp
	$(CC) $(CPPFLAGS) -c ${SRC}/game_make_move.cpp -o $@

${BUILD}/game_piece_moves.o: ${SRC}/game.h ${SRC}/types.h ${SRC}/movement.h ${SRC}/game_piece_moves.cpp
	$(CC) $(CPPFLAGS) -c ${SRC}/game_piece_moves.cpp -o $@

${BUILD}/types.o: ${SRC}/types.h ${SRC}/types.cpp
	$(CC) $(CPPFLAGS) -c ${SRC}/types.cpp -o $@

${BUILD}/notation.o: ${SRC}/types.h ${SRC}/notation.h ${SRC}/notation.cpp
	$(CC) $(CPPFLAGS) -c ${SRC}/notation.cpp -o $@

${BUILD}/display.o: ${SRC}/notation.h ${SRC}/display.h ${SRC}/game.h ${SRC}/display.cpp
	$(CC) $(CPPFLAGS) -c ${SRC}/display.cpp -o $@

${BUILD}/zobrist.o: ${SRC}/game.h ${SRC}/search.h ${SRC}/zobrist_hash.cpp
	$(CC) $(CPPFLAGS) -c ${SRC}/zobrist_hash.cpp -o $@

${BUILD}/search.o: ${SRC}/game.h ${SRC}/search.h ${SRC}/minimax_search.cpp
	$(CC) $(CPPFLAGS) -c ${SRC}/minimax_search.cpp -o $@

${BUILD}/main.o: ${SRC}/game.h ${SRC}/notation.h ${SRC}/types.h ${SRC}/search.h ${SRC}/display.h ${SRC}/main.cpp
	$(CC) $(CPPFLAGS) -c ${SRC}/main.cpp -o $@

clean:
	${RM} ${BUILD}/*
	${RM} engine

format:
	clang-format -i src/*
