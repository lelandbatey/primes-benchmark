#!/usr/bin/env python

from __future__ import print_function
import subprocess
import argparse
import sys
import os


def main():
	parser = argparse.ArgumentParser('Runs benchmarks of prime generation programs.')
	parser.add_argument('executable_path', help='Path to the executable be benchmarks')
	parser.add_argument('--first', default=100000, type=int)
	parser.add_argument('--last', default=1000000, type=int)
	parser.add_argument('--samples', type=int)
	parser.add_argument('--increment', type=int)

	args = parser.parse_args()

	exe = args.executable_path
	first = args.first
	last = args.last

	increment = None
	# You can provide the increment of the sample or the number of samples, but specifying neither defaults to 20 samples
	if not args.increment and not args.samples:
		args.samples = 20

	if args.samples and not args.increment:
		increment = (last-first)/args.samples
	elif args.increment and not args.samples:
		increment = args.increment
	elif args.increment and args.samples:
		print("Please provide at least one of either an increment or a number of samples, but not both.")
		parser.print_help()
	curr_prime = first

	print("Nth Prime, Elapsed (Wall Clock) Time, Maximum Resident Set Size (kbytes)")
	while curr_prime <= last:
		command = "/usr/bin/time -f \"%e,%M\" {} {} 2>&1 >/dev/null"
		command = command.format(exe, curr_prime)
		result = subprocess.check_output(command, shell=True)
		result = result.strip()
		result = "{},{}".format(curr_prime, result)
		print(result)
		curr_prime += increment


if __name__ == '__main__':
	main()

