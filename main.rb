#!/usr/bin/env ruby

require './lib/brainfuck_vm'

# "Hello world!" in Brainfuck
print BrainfuckVM.new('++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.').run!.output
