require 'csv'

class Gauss

  def initialize(matrix)
    @matrix = ensure_floats matrix
  end

  def process
    last_row_index = matrix.size - 1

    (0..last_row_index).each do |row_index|
      value = 1.0 / (matrix[row_index][row_index])
      next if value == 0
      multiply_row row_index, value

      # turn 0 the below rows
      next_row = row_index + 1
      if next_row <= last_row_index
        (next_row..last_row_index).each do |below_row_index|
          value = - matrix[below_row_index][row_index]
          next if value == 0
          sum_and_multiply below_row_index, row_index, value
        end
      end
    end

    print_state
  end

  private
    def matrix
      @matrix || []
    end

    def ensure_floats(new_matrix)
      new_matrix.map{ |array| array.map(&:to_f) }
    end

    def swap_rows(row_index_1, row_index_2)
      matrix[row_index_1], matrix[row_index_2] = matrix[row_index_2], matrix[row_index_1]
    end

    def multiply_row(row_index, constant)
      matrix[row_index].map!{ |cell| cell * constant }
    end

    def sum_and_multiply(row_index_1, row_index_2, constant)
      new_row = matrix[row_index_2].map{ |cell| cell * constant }

      matrix[row_index_1] = matrix[row_index_1].each_with_index.map do |cell, index|
        cell + new_row[index]
      end
    end

    def print_state
      puts "--- matrix ---"
      matrix.each do |row|
        puts row.inspect
      end
    end
end

matrix = CSV.read 'matrix.csv'
gauss_reduction = Gauss.new matrix
gauss_reduction.process
