require 'rainbow'

class NumberSpiral
  attr_reader :cursor, :total_diags

  def initialize(opts = {})
    @total_diags = 0
    @largest_digit = "1"
    @grid = {}
    @cursor = Cursor.new(0,0)
    @direction = :u
  end

  def animate(up_to)
    up_to.times do |i|
      sleep(0.02)
      num = NumberSpiral.new
      puts num.length(i+1)
      @num = num
    end
    puts "Sum of all diagonals: #{Rainbow(@num.total_diags).red}"
  end

  def sum_of_ds(num)
    ns = NumberSpiral.new
    ns.length(num)
    puts "Sum of all diagonals: #{Rainbow(ns.total_diags).red}"
  end

  def length(number)
    number.times do |i|
      add_point(i+1)
    end
    screen = []
    build_grid.each do |x,y|
      row = []
      y.each do |coordinates|
        row << convert(@grid[coordinates], coordinates)
      end
      screen << row.join(" ")
    end
    screen.join("\n")
  end

  def convert(point,coords)
    if point == nil
      " " * @largest_digit.length
    else
      if point.to_s.length < @largest_digit.length
        if coords[0].abs == coords[1].abs
          @total_diags += point.value
          Rainbow(point.to_s + " " * (@largest_digit.length - point.to_s.length)).red
        else
          point.to_s + " " * (@largest_digit.length - point.to_s.length)
        end
      else
        if coords[0].abs == coords[1].abs
          @total_diags += point.value
          Rainbow(point.to_s).red
        else
          point.to_s
        end
      end
    end
  end

  def add_point(number)
    @largest_digit = number.to_s if number.to_s.length > @largest_digit.length
    @grid[@cursor.coords] = SpiralNumber.new(number)
    next_direction if recourse?
    @cursor.move(@direction)
  end

  def next_direction
    case @direction
    when :u
      @direction = :r
    when :r
      @direction = :d
    when :d
      @direction = :l
    when :l
      @direction = :u
    end
  end

  def recourse?
    @grid[@cursor.below(@direction)].nil?
  end

  def build_grid
    width = 1
    @grid.each do |x, y|
      width = x[0] if x[0] > width
    end
    array = (-width..width).to_a
    new_grid = array.product(array)
    answer = {}
    array.each do |i|
      answer[i] = new_grid.select { |x,y| y == i}
    end
    answer
  end

end

class SpiralNumber
  attr_reader :value
  def initialize(value)
    @value = value
  end

  def to_s
    value.to_s
  end
end

class Cursor
  attr_reader :x, :y

  def initialize(x, y)
    @x, @y = x, y
  end

  def coords
    return *[x,y]
  end

  def move(direction)
    case direction
    when :u
      @y += 1
    when :r
      @x += 1
    when :d
      @y -= 1
    when :l
      @x -= 1
    end
    self
  end

  def below(direction)
    new_cursor = self.dup
    case direction
    when :u
      new_cursor.move(:r).coords
    when :r
      new_cursor.move(:d).coords
    when :d
      new_cursor.move(:l).coords
    when :l
      new_cursor.move(:u).coords
    end
  end
end

@ns = NumberSpiral.new
# @ns.length(5)
@ns.animate(300)
# @ns.sum_of_ds(1001*1001)
