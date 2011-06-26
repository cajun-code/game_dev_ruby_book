Tic-Tac-Toe
==============

Problem Statement
-------------------
::

  Create a console program that can interactively play the game of Tic-Tac-Toe
  against a human player.

.. image:: images/tic-tac-toe.png

I always like starting with a general problem of what needs to be built.  Lets
break down what is in a tic-tac-toe game. First thing I think of is the board.
This board is a 3 x 3 grid which gives us 9 cells to deal with. A player takes
turn placing there marker in one of the cells on the board.  The marker is
usually an "X" or an "O".  

.. image:: images/ttt_uml.png

.. Create a program that can interactively play the game of Tic-Tac-Toe
.. against a human player and never lose.

Create a Project
-----------------

The first thing that needs to be done is create a project space

.. code-block:: bash
  
  $ bundle gem tic-tac-toe
  create  tic-tac-toe/Gemfile
  create  tic-tac-toe/Rakefile
  create  tic-tac-toe/.gitignore
  create  tic-tac-toe/tic-tac-toe.gemspec
  create  tic-tac-toe/lib/tic-tac-toe.rb
  create  tic-tac-toe/lib/tic-tac-toe/version.rb
  Initializating git repo in ./tic-tac-toe
  
This creates a basic project structure and sets up an git repository for you.
The Gemfile is a Bundler file that keeps track of the dependencies of the
application.  We will see more about this later.  

The Rakefile is an Task master.  Basically Rake is a command line utility for
running tasks similar to an make file or an ant build script. it gives you the
ability to run tests and package up your application.  I will show the testing
in a little bit. The packaging we will discuss at the end of this chapter.  

The gemspec file defines the project information such as name and description and author information on a project.  We will edit 
that information when we start discussing packaging 

The lib directory is the directory that we put all our source code. Bundler creates a starter file that is the same name as the 
project.  It also created a directory by that same name.  Inside the directory you see a file called version.rb. 

At this point I would create the initial commit to my source control system.  I use git for most of my projects.  

.. code-block:: bash
  
  $ git add .
  $ git commit -m "Initial Project Create"
  
I usually try to keep my commits to a repository small and concise to one topic.  I will periodically show my commit points 
in the book. Now that we have been introduced to the basic project structure lets get on with the project.

Creating the Board
-------------------

Ok now it's time to get down to the hard core stuff.  First thing we are going to create is the test.  I like using a 
process called TDD or Test Driven Development.  This process is where you create a test first. Then show that it fails. 
Then you write the code to make the test pass.  So we need to create a new directory in the project under the tic-tac-toe directory.

.. code-block:: bash

  $ mkdir test
  $ touch test/board_test.rb
  
if you are using redcar or another edit you can right click in the white space and select "New Directory".  Enter the name test.  
Then if you right click the test folder created and select "New File" and name it board_test.rb.  

Open board_test.rb so we can start creating our test

.. code-block:: ruby
  :linenos: 
  
  require 'test/unit'
  $LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))
  require "tic-tac-toe/board"
  
  class BoardTest < Test::Unit::TestCase
    def test_board_create
      board = TicTacToe::Board.new 
      assert_not_nil(board, "Failed to create board")
      assert_equals board.size, 9 
    end
  end 

.. note::

  I know line 2 looks like a nightmare, but it's kind of simple, I am getting the directory name(dirname) of the current file("test/board_test.rb")
  adding the ../lib to that path string.  Then it expands that string it creates a full absolute path string and the "<<" means to 
  push that string on top of the load path.  this way it can find the location of the classes we write for the test

The focus points we need to look at are lines 7 - 9.  We create a new instance of the Board class on line 7.  Then on line 8 we 
check to see if the board was created successfully by checking to see if the board object has been created.  As well as checking 
the size of the board on line 9.  So lets run the test. 


.. code-block:: bash
  
  $ ruby test/board_test.rb
  
:: 

  Loaded suite board_test
  Started
  E
  Finished in 0.001124 seconds.
  
    1) Error:
  test_board_create(BoardTest):
  NameError: Missing or uninitialized constant: BoardTest::TicTacToe
      kernel/common/module.rb:529:in 'const_missing'
      board_test.rb:5:in 'test_board_create'
      kernel/bootstrap/array.rb:71:in 'each'
      kernel/bootstrap/array.rb:71:in 'each'
  
  1 tests, 0 assertions, 0 failures, 1 errors

I know what you are thinking "Oh Lord ... I see errors what happened."  I expected this to happen.  First you have to fail to
understand how to pass.  We see here we have a NameError in the test.  This means that it does not understand what is meant by 
TicTacToe.  Ok lets try and fix this. First we need to create the board file "lib/tic-tac-toe/board.rb".  

.. code-block:: ruby
  :linenos:
  
  module TicTacToe
    class Board
      GRID_SIZE = 8
      attr_reader :grid
      def initialize()
        @grid = []
        (0..GRID_SIZE ).each {|x| @grid[x] = nil } 
      end
      def size
        @grid.size
      end
    end
  end

Lets run the test to see if we are successful 

.. code-block:: bash

  $ ruby test/board_test.rb
  Loaded suite test/board_test
  Started
  .
  Finished in 0.0016409999999999999 seconds.
  
  1 tests, 2 assertions, 0 failures, 0 errors

.. note::
  This would be a good place to commit your code to the source repository.

Now that we have the code for a basic class in place, Lets discuss it.

First thing we see in this code is the module statement.  Module is used to
define a logical separations in code.  A module can contain method definitions,
class definitions, and even other module definitions.  Modules can be included in
other modules or classes with the simple:

.. code-block:: ruby

  include <Module Name>
  
The next thing on line 2 is the class statement.  Creating a class is like
defining a blueprint for a building.  Calling dot new on a class, constructs the
class in memory and runs the initialize method.

What the initialize method is use for is to create and initialize the base
values used by the class.  The first thing that is initialized is the grid
variable on line 6.  The at(@) symbol in front of the name means that it's an
instance variable.  Instance variables live inside the object that is created 
in memory.  Line 7, inside the parentheses, is called a range. A range is a
counter that will count from 0 to 8. The each method that is called off that
range will be executed every time.  The code that is inside the curly braces is
a single line block of code.  That code is what gets run every time the range
counts, nil is being put on the array at that location. Once that counter hits 8
it stops.

.. note::
  Nil is a special object in ruby. It represents a non-existant state.
    
Lines 9-11 define a method called size.  This method returns the size of the
grid array.  Return is an implicit keyword, meaning that I don't' have to type it. 
Ruby will automatically return the results of the last line in a method.

Place Marker
^^^^^^^^^^^^^^^^

Now that we understand what how this works so far, we need to add a method that
allows us to place a marker on the grid. Also raise an error if the a marker is
placed outside of the board or if the marker is placed on top of a already taken
cell.  Back to the board_test.rb:

.. code-block:: ruby
  :linenos:
  
  ...
  def test_place_marker
    board = TicTacToe::Board.new
    board.place_marker(4, "X")
    assert_equal board.grid[4], "X"
    assert_raise TicTacToe::BoardError {board.place_marker(9,"O")}
    assert_raise TicTacToe::BoardError {board.place_marker(4, "X")}
  end
  ...

.. code-block:: bash

  $ ruby test/board_test.rb
  Loaded suite test/board_test
  Started
  .E
  Finished in 0.002139 seconds.
  
    1) Error:
  test_place_marker(BoardTest):
  NoMethodError: undefined method 'place_marker' on an instance of TicTacToe::Board.
      kernel/delta/kernel.rb:85:in 'place_marker (method_missing)'
      test/board_test.rb:15:in 'test_place_marker'
      kernel/bootstrap/array.rb:71:in 'each'
      kernel/bootstrap/array.rb:71:in 'each'
  
  2 tests, 2 assertions, 0 failures, 1 errors

Notice when i run the test as expected the test fails.  This test is similar to
the first one.  One thing to point out is the assert_raise method.  it check to
see if the code raises an error when cretin conditions are met.

Now lets write the place marker method on the board class

.. code-block:: ruby
  :linenos:
  
  ...
  def place_marker(index, marker)
    @grid[index] = marker
  end
  ...

Time to run it and see what we get.

.. code-block:: bash

  $ ruby test/board_test.rb
  Loaded suite test/board_test
  Started
  .E
  Finished in 0.002041 seconds.
  
    1) Error:
  test_place_marker(BoardTest):
  NoMethodError: undefined method 'BoardError' on an instance of BoardTest.
      kernel/delta/kernel.rb:85:in 'BoardError (method_missing)'
      test/board_test.rb:17:in 'test_place_marker'
      kernel/bootstrap/array.rb:71:in 'each'
      kernel/bootstrap/array.rb:71:in 'each'
  
  2 tests, 3 assertions, 0 failures, 1 errors

Oh no what did I do wrong.  There is no BoardError defined.  So lets create
that. Go to the lib/tic-tac-toe/board.rb file and add:

.. code-block:: ruby
  :linenos:

  class BoardError < Exception
  end

Now rerun the test again:

.. code-block:: bash

  $ ruby test/board_test.rb
  Loaded suite test/board_test
  Started
  .F
  Finished in 0.069226 seconds.
  
    1) Failure:
  test_place_marker(BoardTest)
      [test/board_test.rb:17:in 'test_place_marker'
       kernel/bootstrap/array.rb:71:in 'each'
       kernel/bootstrap/array.rb:71:in 'each']:
  <TicTacToe::BoardError> exception expected but none was thrown.
  
  2 tests, 4 assertions, 1 failures, 0 errors

Well it failed.  Was that what we expected? not really so how do we fix this. We
need to add the raise statement to the place_marker method.

.. code-block:: ruby
  :linenos:
  
  ...
  def place_marker(index, marker)
    if index < 0 or index > GRID_SIZE 
      raise BoardError.new, "#{index} is outside the board"
    end
    if @grid[index].nil?
      @grid[index] = marker
    else
      raise BoardError.new, "#{index} is already used"
    end
  end
  ...
  
Time to run the test again and see what that says:

.. code-block:: bash

  $ ruby test/board_test.rb
  Loaded suite test/board_test
  Started
  ..
  Finished in 0.002402 seconds.
  
  2 tests, 5 assertions, 0 failures, 0 errors

Yay, the test passes.  Time to explain what is going on.

.. note::
  Test passing is always a good time to commit back to source control.
  
Now lets start with the definition of the place_marker method on line 2.  The if
statement on line 3 starts a decision block.  Basically if the index is not
between 0 and 8 then execute line 4. This line raises an error called a
BoardError, with the message "#{index} is outside the board".  The "#{index}" is
injecting the value of index into the string, so if index = 9 then it would
print "9 is outside the board".  The raise statement also stops execution of the
method, so nothing after the error was raised was executed.

After we have made it through the first if we come to check if the block on the
board is empty.  "nil?" will return true for false depending if a nil exists in
the object we are calling the method on.  In this case if the cell is nil then
place the marker there if not raise an error that the cell is already taken.

Clearing the Board
^^^^^^^^^^^^^^^^^^^^^^
Now that we can place markers on the board, we need a way to clear the board.
To test this should be simple as these steps:

1. Place a marker on the board
2. Assert that the marker is there
3. Call clear on the board
4. Assert that that cell is nil

So lets put this to code. Create a new test method in board_test.rb

.. code-block:: ruby
  :linenos:
  
  ...
  def test_clear_board
    board = TicTacToe::Board.new
    board.place_marker(4, "X")
    assert_equal board.grid[4], "X"
    board.clear
    assert_nil board.grid[4]
  end
  ...

.. code-block:: bash

  $ ruby test/board_test.rb
  Loaded suite test/board_test
  Started
  .E.
  Finished in 0.003509 seconds.
  
    1) Error:
  test_clear_board(BoardTest):
  NoMethodError: undefined method 'clear' on an instance of TicTacToe::Board.
      kernel/delta/kernel.rb:85:in 'clear (method_missing)'
      test/board_test.rb:25:in 'test_clear_board'
      kernel/bootstrap/array.rb:71:in 'each'
      kernel/bootstrap/array.rb:71:in 'each'
  
  3 tests, 6 assertions, 0 failures, 1 errors
  
Now we have our failing test lets code the clear method:

.. code-block:: ruby
  :linenos:
  
  ...
  def clear
    @grid.clear
  end
  ...
  
.. code-block:: bash

  $ ruby test/board_test.rb
  Loaded suite test/board_test
  Started
  ...
  Finished in 0.0025109999999999998 seconds.
  
  3 tests, 7 assertions, 0 failures, 0 errors

Line 3 is the focus point for this method.  Clear is a method on an array that
removes all items from the array.

Checking the Board for a winner
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The next challenge we have is to check the board and see if there is a winner
present.  so lets take a look at a board and see what we can tell.

.. image:: images/board.png
    :width: 200px
   
  
As we can see by the board pattern analysis show that there are 8 winning
patterns. The patterns can be broken up into 3 sections.  The horizontal
patterns such as [0,1,2], [3,4,5], and [6,7,8].  The vertical patterns are
[0,3,6], [1,4,7], and [2,5,8].  The diagonal patterns are [2,4,6] and [0,4,8].
So with this knowledge lets create a constant for winning patterns in the board
class. To declare a constant you start the name with a capital.  

.. code-block:: ruby
  :linenos:
  
  ...
  WINNING_PATTERNS = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [2,4,6],
      [0,4,8],
    ]
  ...

With the patterns declared we can write the test to check the winners.

.. code-block:: ruby
  :linenos:
  
  ...
  def test_check_winner
    board = TicTacToe::Board.new
    board.place_marker(3, "X")
    board.place_marker(4, "X")
    board.place_marker(5, "X")    
    assert board.check_winner
    assert_equals board.winner, "X" 
  end
  ...

This test tests only one possible case of the horizontal center row.  Lets
rewrite the test to loop through the pattern array and test each condition.

.. code-block:: ruby
  :linenos:
  
  ...
  def test_check_winner
    board = TicTacToe::Board.new    
    TicTacToe::Board::WINNING_PATTERNS.each do |pattern|
      board.place_marker(pattern[0], "X")
      board.place_marker(pattern[1], "X")
      board.place_marker(pattern[2], "X")
      assert board.check_winner
      assert_equals board.winner, "X"
      board.clear
    end     
  end
  ...

Now we run the test.

.. code-block:: bash
  
  $ ruby test/board_test.rb
  Loaded suite test/board_test
  Started
  .E..
  Finished in 0.003186 seconds.
  
    1) Error:
  test_check_board(BoardTest):
  NoMethodError: undefined method 'check_winner' on an instance of TicTacToe::Board.
      kernel/delta/kernel.rb:85:in 'check_winner (method_missing)'
      test/board_test.rb:35:in 'test_check_winner'
      kernel/bootstrap/array.rb:71:in 'each'
      test/board_test.rb:31:in 'test_check_winner'
      kernel/bootstrap/array.rb:71:in 'each'
      kernel/bootstrap/array.rb:71:in 'each'
  
  4 tests, 7 assertions, 0 failures, 1 errors

Ok, lets look at the test before we code the check_board method.  On line 4 we
see ".each do |pattern|" hanging off the WINNING_PATTERNS constant. The each
method iterates over a block of code.  The block of code is defined by the "do"
keyword until it reaches an "end" statement.  The pipe symbol("|") defines
parameters from the each statement to the block. This means that pattern is a
variable whose value will change each cycle through.  So first time through
pattern will equal [0,1,2] and the next time it will equal [3,4,5] til it goes
through all the elements listed in the patterns list.  Each element in the
pattern is a 0 indexed list. That means pattern[0] will give me 0 as a value to
pass to place_marker. Now we can use this technique to create the check_board
method.

.. code-block:: ruby
  :linenos:
  
  ...
  def winner
    @winner
  end
  def check_winner
    result = false
    Board::WINNING_PATTERNS.each do |pattern|
      a = @grid[pattern[0]]
      b = @grid[pattern[1]]
      c = @grid[pattern[2]]
      if a.nil? and b.nil? and c.nil?
        next
      end
      if a == b and a == c
        result = true
        @winner = a
        break
      end
      result
    end
    ...

.. code-block:: bash

  $ ruby test/board_test.rb
  Loaded suite test/board_test
  Started
  ....
  Finished in 0.0036179999999999997 seconds.
  
  4 tests, 23 assertions, 0 failures, 0 errors

We having passing test, Let's go over the check_winner method.  On line 7,
notice we are looping though the WINNING_PATTERNS constant again.  But the big
points to look at are lines 12 and 17.  The next statement inside a loop tells
the system to start the loop over on the next element.  The break statement
tells the system to end the loop now, no matter how many elements are left.  So
line 11 reads, If all elements in the cells are nil then skip to the next
pattern.  The reverse holds true for break statement.  if a, b, and c are equal
then quit the loop and declare we have a winner.

This is great, everything is working and tested.  There is only one thing that
needs to be done.  Create a failing test case for the check_winner method.

.. code-block:: ruby
  :linenos:
  
  ...
  def test_check_winner_no_selection
    board = TicTacToe::Board.new
    assert board.check_winner == false
    assert_nil board.winner
  end
  
  def test_check_winner_one_marker
    board = TicTacToe::Board.new
    board.place_marker(4, "X")
    assert board.check_winner == false
    assert_nil board.winner
  end
  ...

There is nothing really special about these two test.  I just wanted to make
sure we had complete coverage and tested a couple of fail cases.  Running the
test you should see the following result.  This wraps up the check_winner
method.  

.. code-block:: bash

  $ ruby test/board_test.rb
  Loaded suite test/board_test
  Started
  ......
  Finished in 0.004778 seconds.
  
  6 tests, 27 assertions, 0 failures, 0 errors


Keeping Track of the last move
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The last thing left for the board class is to keep track of the last move.  When
tic-tac-toe is played on a sheet of paper the two players can always see the
others last move.  Playing inside a computer, We need a place to allow some of
that visibility.  The best thing is to track the last move of any player on the
board. Personally tracking more than the last move for this game is overkill.
As always we need to create our test.

.. code-block:: ruby
  :linenos:
  
  ...
  def test_last_move
    board = TicTacToe::Board.new
    board.place_marker(4, "X")
    assert_equal board.last_move, 4
  end
  ...

.. code-block:: bash
  
  $ ruby test/board_test.rb
  Loaded suite test/board_test
  Started
  .....E.
  Finished in 0.004595999999999999 seconds.
  
    1) Error:
  test_last_move(BoardTest):
  NoMethodError: undefined method 'last_move' on an instance of TicTacToe::Board.
      kernel/delta/kernel.rb:85:in 'last_move (method_missing)'
      test/board_test.rb:57:in 'test_last_move'
      kernel/bootstrap/array.rb:71:in 'each'
      kernel/bootstrap/array.rb:71:in 'each'
  
  7 tests, 27 assertions, 0 failures, 1 errors

This test is simple but it checks what we need.  First, it creates an instance
of the board.  Then it places "X" in the center square.  After that it checks to
see if the index 4 was recorded as the last move. Now let us fix the errors.

.. code-block:: ruby
  :linenos:
  
  class Board
    ...
    attr_reader :grid, :last_move
    ...
    def place_marker(index, marker)
      if index < 0 or index > GRID_SIZE 
        raise BoardError.new, "#{index} is outside the board"
      end
      if @grid[index].nil?
        @grid[index] = marker
        @last_move = index
      else
        raise BoardError.new, "#{index} is already used"
      end
    end
    
    ...
    def clear
      @grid.clear
      @winner = nil
      @last_move = nil
    end
    ...
  end

For this first we will add ":last_move" to the attr_reader line.  attr_reader
creates a last_move method for us.  Next inside the place_marker method, when we
place the marker on the grid. We store the index in the last_move variable.
Just as a extra step we are going to clear the last_move variable in the clear
method.  Now run the test to see if we cleared the error.  

.. code-block:: bash

  $ ruby test/board_test.rb
  Loaded suite test/board_test
  Started
  .......
  Finished in 0.003224 seconds.
  
  7 tests, 28 assertions, 0 failures, 0 errors

There the Board class is complete.  Let's do a little house keeping to clean
things up.  Under the test folder lets create a new file called
ts_tic_tac_toe.rb.  What we are creating is a Test Suite.  This way we have one
place to run all our test from.  Also we need to move the line that adds the lib
directory to the path.  Plus we need to add a new copy of that line to add the
other test we write to the path. The suite file should look like this:

.. code-block:: ruby
  
  require "test/unit"

  $LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))
  $LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__)))
  
  require "board_test"
  
Notice the only thing we have to do to include another test is require the test
name. Lets run it and see if we get the same results:

.. code-block:: bash
  
  $ ruby test/ts_tic_tac_toe.rb
  Loaded suite test/ts_tic_tac_toe
  Started
  .......
  Finished in 0.004621 seconds.
  
  7 tests, 28 assertions, 0 failures, 0 errors

Awesome All test pass.  Only one more thing I would like to do to clean up.
Remove the following line from the board class, also we need to rerun the test
to make sure we did not break something:

.. code-block:: ruby

  (0..GRID_SIZE ).each {|x| @grid[x] = nil }

.. code-block:: bash
  
  $ ruby test/ts_tic_tac_toe.rb
  Loaded suite test/ts_tic_tac_toe
  Started
  F......
  Finished in 0.053641999999999995 seconds.
  
    1) Failure:
  test_board_create(BoardTest)
      [/Users/adavis/Projects/game_dev_ruby_book/code/tic-tac-toe/test/board_test.rb:10:in 'test_board_create'
       kernel/bootstrap/array.rb:71:in 'each'
       kernel/bootstrap/array.rb:71:in 'each']:
  <0> expected but was
  <9>.
  
  7 tests, 28 assertions, 1 failures, 0 errors

Ok, what did I do wrong? The answer is nothing.  The old trick of initializing
the array in a loop is wasted code.  This comes from Java and C++ where not doing
this would be an error.  so this is one instance I would say we need to adjust
the test.  I personally am not a fan of adjusting the test.  The only time
adjust the test is ok if for some reason the code that it was testing in no
longer valid.  Also we need to remove the size method from the board.  It is
another fallback to java when that method would be necessary.  Lets make comment
out the size method in the board class:

.. code-block:: ruby

  #def size
  #  @grid.size
  #end
  
The pound sign(#) is a single line comment.  if we start each line of the method
with the comment then the method goes away.  Same goes for the test:

.. code-block:: ruby
  
  def test_board_create
    board = TicTacToe::Board.new  
    assert_not_nil board
    #assert_equal board.size, 9 
  end

The reason that i can say, that board.size and the initialize are invalid and
need to be removed if you notice in the last run of the test is that all the
other test pass. Which proved that this code was not necessary.  Lets run the
test again just to confirm:

.. code-block:: bash

  $ ruby test/ts_tic_tac_toe.rb
  Loaded suite test/ts_tic_tac_toe
  Started
  .......
  Finished in 0.002908 seconds.
  
  7 tests, 27 assertions, 0 failures, 0 errors

Every thing looks good, it's time to move on to the player class.

Creating the Player
--------------------

The Player is the person playing the game.  A player has a name and a marker.
He/She also knows what board they are playing on.  The player knows how to take
their turn by placing there marker at a given location, as well as check to see
if there is a winner on the board.

.. image:: images/player.png

Based on the description above, the player class should look like the UML class
diagram above.  UML is a modeling language used to pictorialy describe a
program.  The class element that is pictured is a rectangle broken up into three
compartments.  The top compartment is the title of the class.  the second
compartment is for attributes of the class.  These are mostly instance variables
inside the class.  The third compartment is for the operations of the class.
The operations are methods that will preform actions on the attributes of the class

Setting up the Player Class
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

With these defined we can start setting up the project to add the player class.

1. Create player_test.rb under the test directory.
2. Under lib/tic-tac-toe, create a player.rb
3. Add the player_test to the ts_tic_tac_toe.rb test suite

Lets look at ts_tic_tac_toe.rb first:

.. code-block:: ruby

  require "player_test"
  
This line adds the player test file to the test suite.  This way we can exeute all the
tests created at once.  Now we can start creating the test for the player class.  Open
player_test.rb and add the code:

.. code-block:: ruby
  :linenos:
  
  require "test/unit"
  require "tic-tac-toe/board"
  require "tic-tac-toe/player"
  
  class PlayerTest < Test::Unit::TestCase
    def setup
      @board = TicTacToe::Board.new
      @player = TicTacToe::Player.new "Allan", @board, "X"
    end
    def test_player_create
      @board.clear
      assert_not_nil @player
    end
  end

  
If we run the test suite we should see:

.. code-block:: bash

  $ ruby test/ts_tic_tac_toe.rb
  Loaded suite test/ts_tic_tac_toe
  Started
  .......E
  Finished in 0.004219 seconds.
  
    1) Error:
  test_player_create(PlayerTest):
  NameError: Missing or uninitialized constant: TicTacToe::Player
      kernel/common/module.rb:533:in 'const_missing'
      /home/alley/Projects/game_dev_ruby_book/code/tic-tac-toe/test/player_test.rb:10:in 'test_player_create'
      kernel/bootstrap/array.rb:71:in 'each'
      kernel/bootstrap/array.rb:71:in 'each'
  
  8 tests, 27 assertions, 0 failures, 1 errors

Lets talk about the test for a second.  Setup is a new method that we have not
seen before. this is a method on the TestCase class that is execute before each
test is run.  By adding the method to our version we have overridden that method
to preform the functionality we needed.  TestCase also provides a teardown
method to clean up after a test.  We will go overloading methods later when we
look at the computer player.


.. code-block:: ruby
  :linenos:
  
  module TicTacToe
    class Player
      attr_accessor :name,  :marker
      attr_reader :board
      def initialize(name ="", board = nil, marker = "" )
        @name = name
        @board = board
        @marker = marker
      end
    end
  end

.. code-block:: bash

  $ ruby test/ts_tic_tac_toe.rb
  Loaded suite test/ts_tic_tac_toe
  Started
  ........
  Finished in 0.004096 seconds.
  
  8 tests, 28 assertions, 0 failures, 0 errors

One of the big things we see in the player class is "attr_accessor".
Attr_accessor is a ruby helper method.  It generates accessor methods for a
given variable.  so with "attr_accessor :name", the methods that are generated
look like:

.. code-block:: ruby
  
  def name
    @name
  end
  def name=(value)
    @name = value
  end
  
Attr_reader does has the same effect but it does not create the assignment
method. There is also "attr_writer", which creates the writer method.

Adding the take_turn method to Player
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Now for the heavy lifting of the player class, The take_turn method. we always
start with the stest so add this next section to the player_test.rb:

.. code-block:: ruby
  :linenos:
  
  ...
  def test_take_turn
    @board.clear
    @player.take_turn(4)
    assert_equal 4, @board.last_move
    @board.clear
    @player.take_turn(3)
    @player.take_turn(4)
    @player.take_turn(5)
    assert_equal @board.winner, @player.marker
  end
  ...

.. code-block:: bash

  $ ruby test/ts_tic_tac_toe.rb
  
  Loaded suite test/ts_tic_tac_toe
  Started
  ........E
  Finished in 0.004625 seconds.
  
    1) Error:
  test_take_turn(PlayerTest):
  NoMethodError: undefined method 'take_turn' on an instance of TicTacToe::Player.
      kernel/delta/kernel.rb:85:in 'take_turn (method_missing)'
      /home/alley/Projects/game_dev_ruby_book/code/tic-tac-toe/test/player_test.rb:16:in 'test_take_turn'
      kernel/bootstrap/array.rb:71:in 'each'
      kernel/bootstrap/array.rb:71:in 'each'
  
  9 tests, 28 assertions, 0 failures, 1 errors

In this test, we place the players marker in cell 4.  Then we check the last
move on the board and make sure it is the cell we selected.  Then clear the
board and place markers across the center row.  Finally test to see if the board
winner is the player marker. Now that we have run the test and it failed.  It's
time to code the take_turn method.

.. code-block:: ruby
  :linenos:
  
  def take_turn(cell)
    @board.place_marker(cell, @marker)
    @board.check_winner
  end

.. code-block:: bash

  $ ruby test/ts_tic_tac_toe.rb
  Loaded suite test/ts_tic_tac_toe
  Started
  .........
  Finished in 0.004477 seconds.
  
  9 tests, 30 assertions, 0 failures, 0 errors

The take turn method is fairly simple.  It builds on what was created for the
board and packages these steps together.  This brings us to the Computer Player.

Creating the Computer Player
-----------------------------

The ComputerPlayer class is going to extend what we build for the player.  It
overrides the take_turn method and adds the AI(Artifical Intelengence) for
placing the marker.

.. image:: images/computer_player.png

Let's create the test case for the computer player. Create a file called
computer_player_test.rb in the test directory. Also we need to add it to the
test suite so open up ts_tic_tac_toe.rb.

.. code-block:: ruby
  :linenos:
  
  # computer_player_test.rb
  class ComputerPlayerTest < Test::Unit::TestCase
  
  end

.. code-block:: ruby
  :linenos:
  
  # add this line to ts_tic_tac_toe
  require 'computer_player_test'




Creating the Game Controller
------------------------------


Packaging the Game 
--------------------


Summary
-----------
