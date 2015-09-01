
from __future__ import print_function
from pprint import pprint
import csv

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.font_manager import FontProperties

def read_csv(csvname):
	contents = None
	with open(csvname) as csvfile:
		reader = csv.DictReader(csvfile)
		contents = [row for row in reader]
	return contents

def plot_data(fignum, key, data):
	plt.figure(fignum)

def extract_key(data, field='time'):
	key = None
	floatable = False
	for x in sorted(data[0].keys()):
		if field in x.lower():
			key = x
	try:
		if float(data[0][key])**2 > 0.0:
			floatable = True
	except: pass

	return [float(entry[key]) if floatable else entry[key] for entry in data]


def extract_time(data):
	return [float(entry.split(':')[1]) for entry in extract_key(data)]


def main():
	cpp_performance = read_csv('cpp-performance.csv')
	rust_performance = read_csv('rust-performance.csv')

	cpp_time = extract_time(cpp_performance)
	rust_time = extract_time(rust_performance)
	cpp_mem = extract_key(cpp_performance, 'size')
	rust_mem = extract_key(rust_performance, 'size')
	cpp_mem = [x/1000.0 for x in cpp_mem]
	rust_mem = [x/1000.0 for x in rust_mem]

	fontP = FontProperties()
	fontP.set_size('xx-small')

	f, (ax1, ax2) = plt.subplots(1, 2)
	f.suptitle('Language Performance Generating One Million Primes', fontsize=15)

	ax1.plot(cpp_time, label='C++', color='blue')
	ax1.plot(rust_time, label='Rust', color='red')
	ax1.set_title('Speed')
	ax1.set_ylabel('Runtime (seconds)')
	ax1.set_xlabel('Experiment number')
	ax1.legend(fontsize='x-small')
	ax1.set_ylim(0, (lambda x: x+0.25*x)(max(cpp_time+rust_time)))

	ax2.plot(cpp_mem, label='C++', color='blue')
	ax2.plot(rust_mem, label='Rust', color='red')
	ax2.set_title('Memory')
	ax2.set_ylabel('Maximum Resident Set Size (mbytes)')
	ax2.set_xlabel('Experiment number')
	ax2.legend(fontsize='x-small')
	ax2.set_ylim(0, max(cpp_mem + rust_mem)+0.25*max(rust_mem))

	plt.tight_layout()
	plt.subplots_adjust(top=0.88)

	f.savefig('performance.png', bbox_inches='tight', dpi=300)

	#pprint(cpp_performance)
	#pprint(rust_performance)

if __name__ == "__main__":
	main()
