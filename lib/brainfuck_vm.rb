class BrainfuckVM

  OPENING_BRACKET = '['
  CLOSING_BRACKET = ']'
  BRACKETS = [OPENING_BRACKET, CLOSING_BRACKET]
  INSTRUCTION_SET = {
    '>' => :inc_dp, '<' => :dec_dp,
    '+' => :inc_current_dp_val, '-' => :dec_current_dp_val,
    '.' => :output_cur_dp_val, ',' => :feed_cur_dp_val,
    OPENING_BRACKET => :jump_right, CLOSING_BRACKET => :jump_left
  }
  DATA_BYTES_RANGE = (0..255)

  attr_reader :code, :input, :output

  def initialize(code, input = '')
    @code = code
    @input = input.each_byte.to_a
    @output = ''
    @data = [0]
    @data_pointer = 0
    @instruction_pointer = 0
  end

  def run!
    while @instruction_pointer < @code.size
      tick
      @instruction_pointer += 1
    end
    self
  end

  private

  def inc_dp
    @data_pointer += 1
    @data[@data_pointer] ||= 0
  end

  def dec_dp
    @data_pointer -= 1
    @data[@data_pointer] ||= 0
  end

  def inc_current_dp_val
    @data[@data_pointer] += 1
    @data[@data_pointer] = DATA_BYTES_RANGE.first unless DATA_BYTES_RANGE.include?(@data[@data_pointer])
  end

  def dec_current_dp_val
    @data[@data_pointer] -= 1
    @data[@data_pointer] = DATA_BYTES_RANGE.last unless DATA_BYTES_RANGE.include?(@data[@data_pointer])
  end

  def output_cur_dp_val
    @output << @data[@data_pointer].chr
  end

  def feed_cur_dp_val
    @data[@data_pointer] = @input.shift
  end

  def goto_matching_bracket(current_bracket)
    raise ArgumentError, "wrong current_bracket value" unless BRACKETS.include?(current_bracket)

    other_bracket = current_bracket == OPENING_BRACKET ? CLOSING_BRACKET : OPENING_BRACKET
    direction = current_bracket == OPENING_BRACKET ? 1 : -1

    other_brackets_count = 0
    while @code[@instruction_pointer] != other_bracket || other_brackets_count != 1
      other_brackets_count += 1 if @code[@instruction_pointer] == current_bracket
      other_brackets_count -= 1 if @code[@instruction_pointer] == other_bracket
      @instruction_pointer += direction
    end
  end

  def jump_right
    goto_matching_bracket(OPENING_BRACKET) if @data[@data_pointer] == 0
  end

  def jump_left
    goto_matching_bracket(CLOSING_BRACKET) if @data[@data_pointer] != 0
  end

  def tick
    current_instruction = code[@instruction_pointer]
    send(INSTRUCTION_SET[current_instruction])
  end

end
