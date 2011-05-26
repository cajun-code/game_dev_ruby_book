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

  I know line 2 looks like a nightmare, but it's kind of simple, I am getting the dirname of the current file("test/board_test.rb")
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
define a logical seperations in code.  A module can contain method defnitions,
class definitions, and even other module defnitions.  Modules can be included in
other modules or classes with the simple:

.. code-block:: ruby

  include <Module Name>
  


Creating the Player
--------------------


Creating the Computer Player
-----------------------------


Creating the Game Controller
------------------------------


Packaging the Game 
--------------------


Summary
-----------
