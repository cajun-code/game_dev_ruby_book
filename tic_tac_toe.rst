Tic-Tac-Toe
==============

Problem Statement
-------------------
::

  Create a console program that can interactively play the game of Tic-Tac-Toe against a human player.

.. image:: images/tic-tac-toe.png

I always like starting with a general problem of what needs to be built.  Lets break down what is in a tic-tac-toe game.
Frist thing I think of is the board.  This board is a 3 x 3 grid which gives us 9 cells to deal with. A player takes turn 
placeing there marker in one of the cells on the board.  The marker is usually an "X" or an "O".  

.. Create a program that can interactively play the game of Tic-Tac-Toe against a human player and never lose.

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
  
This creates a basic project structure and sets up an git repository for you.  The Gemfile is a 
Bundler file that keeps track of the dependencies of the application.  We will see more about this
later.  

The Rakefile is an 