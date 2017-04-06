# BrainfuckVM

This kata from [Codewars](https://www.codewars.com) implements a [Brainfuck](https://en.wikipedia.org/wiki/Brainfuck) interpreter in ruby.

The machine memory should behave like a potentially infinite array of bytes, initialized to 0.

The following instructions are supported:

- `>` increment the data pointer (to point to the next cell to the right)
- `<` decrement the data pointer (to point to the next cell to the left)
- `+` increment (increase by one, truncate overflow: 255 + 1 = 0) the byte at the data pointer
- `-` decrement (decrease by one, treat as unsigned byte: 0 - 1 = 255 ) the byte at the data pointer
- `.` output the byte at the data pointer
- `,` accept one byte of input, storing its value in the byte at the data pointer
- `[` if the byte at the data pointer is zero, then instead of moving the instruction pointer forward to the next command, jump it forward to the command after the matching `]` command
- `]` if the byte at the data pointer is nonzero, then instead of moving the instruction pointer forward to the next command, jump it back to the command after the matching `[` command

A `BrainfuckVM` instance is initialized with two arguments:
- a string with the sequence of machine instructions
- a string, eventually empty, that will be interpreted as an array of bytes using each character's ASCII code and will be consumed by the `,` instruction

The `BrainfuckVM#run!` method will run the code and `BrainfuckVM#output` will return the output of the interpreted code (always as a string), produced by the `.` instruction.

For example, the following code will return a string containing `"Hello World!\n"`:
```ruby
BrainfuckVM.new('++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++++.>.+++.------.--------.>+.>.', '').run!.output
```
