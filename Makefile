
SOURCE_REPO="https://gist.github.com/986de79c13e61e4ce2b0.git"

performance.png: cpp-performance.csv rust-performance.csv
	python create_graphs.py

cpp-performance.csv: sources/cpp_prime_generator
	./create_benchmark.sh sources/cpp_prime_generator > cpp-performance.csv

rust-performance.csv: sources/rust_prime_generator
	./create_benchmark.sh sources/rust_prime_generator > rust-performance.csv

sources/cpp_prime_generator: sources/prime-sieve.cpp
	clang++ -std=c++11 sources/prime-sieve.cpp -O3 -o sources/cpp_prime_generator

sources/rust_prime_generator: sources/prime-sieve.rs
	rustc sources/prime-sieve.rs -O -o sources/rust_prime_generator

sources/prime-sieve.rs:
	git clone $(SOURCE_REPO) sources/

sources/prime-sieve.cpp:
	git clone $(SOURCE_REPO) sources/



