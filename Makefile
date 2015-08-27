
SOURCE_REPO="https://gist.github.com/b9a622049d0947173f91.git"

performance.png: cpp-performance.csv rust-performance.csv
	python create_graphs.py

cpp-performance.csv: sources/cpp_prime_generator
	./create_benchmark.sh sources/cpp_prime_generator > cpp-performance.csv

rust-performance.csv: sources/rust_prime_generator
	./create_benchmark.sh sources/rust_prime_generator > rust-performance.csv

sources/cpp_prime_generator: sources/prime-sieve.cpp
	clang++ -std=c++11 sources/prime-sieve.cpp -O3 -o sources/cpp_prime_generator

sources/rust_prime_generator: sources/prime-sieve.rs
	rustc prime-sieve.rs -O -o rust_prime_generator

sources/prime-sieve.rs:
	git clone $(SOURCE_REPO) sources/

sources/prime-sieve.cpp:
	git clone $(SOURCE_REPO) sources/


