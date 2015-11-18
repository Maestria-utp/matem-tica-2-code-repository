require 'csv'

class Gauss

  def initialize(matrix)
    @matrix = ensure_ints matrix
  end

  def process
    puts "execute gauss reduction"
    print_state

    puts "interchange rows 1 and 3"
    swap_rows 0, 2
    print_state

    puts "multiply row 2 by 5"
    multiply_row 1, 5
    print_state

    puts "to row 0 sum row 1 by 2"
    sum_and_multiply 0, 1, 2
    print_state
  end

  private
    def matrix
      @matrix || []
    end

    def ensure_ints(new_matrix)
      new_matrix.map{ |array| array.map(&:to_i) }
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
