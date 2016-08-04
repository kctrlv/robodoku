class Solver
  def initialize(puzzle_text) #Initialize unsolved puzzle as 9x9 2D array
    @two_d_array = puzzle_text.split("\n").map {|row| row.split('')}
  end

  def get_peers(row_index, col_index) #Returns an array of cell's peers
    peers = []

    #Shovel in the row and the column
    peers << @two_d_array[row_index]
    peers << @two_d_array.map {|array| array[col_index]}

    #Determine the greater coordinates of the square
    square_row_coords = [[0,1,2],[3,4,5],[6,7,8]][row_index/3]
    square_col_coords = [[0,1,2],[3,4,5],[6,7,8]][col_index/3]

    #Shovel in the square
    peers << square_row_coords.map do |x|
      square_col_coords.map do |y|
        @two_d_array[x][y]
      end
    end

    #Flatten to make an array, remove duplicates and spaces and finally remove self
    peers.flatten.uniq.reject do |n|
      n==" "||n==@two_d_array[row_index][col_index]
    end
  end

  def solve_easy_cell(row_index, col_index) #Solves cell if peers are full
    peers = get_peers(row_index, col_index)
    if peers.length == 8
      cell_solution = ('1'..'9').reject {|peers_array| peers.include?(peers_array)}[0]
      @two_d_array[row_index][col_index] = cell_solution
    end
  end

  def solve_easy_cycle() #Runs solve_easy_cell on the whole puzzle once
    9.times do |x|
      9.times do |y|
        solve_easy_cell(x,y)
      end
    end
  end

  def solve #Easy puzzle will solve, harder puzzles will quickly stop trying
    tried_easy_counter = 0
    while @two_d_array.flatten.include?(" ")
      # puts "trying to solve with easy method"
      solve_easy_cycle()
      tried_easy_counter += 1
      if tried_easy_counter > 100
        return "This puzzle can't be solved by this algorithm"
      end
    end
    # puts "Solved"

    # @two_d_array.inspect

    # @two_d_array.each do |row|
    #   puts row.join("")
    # end
    puts @two_d_array.map {|row| row.join}
  end
end
