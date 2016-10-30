# How mix works
# Elixir contains Mix (dev tool)
# -creates projects
# -compiles projects
# -runs "tasks"
# -manages dependencies


# How to create a project
mix new cards

# To run code
iex -S mix

# To reload changes
recompile

# Cards
# Don't need return statement bc end of function
# return it (implicit return) you could have "return"

# Convention is to use double quotes throughout Elixir

# Arrays/lists
["ace", "two", "three"]

# OOP vs functional programming
# OOP programming
# everything operates on its own instance variable(using this)
# EX. functions are using local object to work
deck = new Deck;
deck.cards #each of deack has own local instance
deck.shuffle
deck.deal
# Functional programming
# We no classes and no instance variables
# instead of calling this.deck, we would call the
# Cards module.create_deck and it will return list of strings
# Everything in elixir is using primitive variables that
# .represent the bare essence of the var we are working with
# No objects!
# Passing into method and always return

# functions
def shuffle(deck) do

end
# Error message will be shuffle/0 <means shuffle with 0 args
# arity - number of arguments a function accepts

# Store cards into deck
deck = Cards.create_deck
Cards.shuffle(deck)
# What happening in elixir with that above code
# immutability
# we are never modifying an existing variable
# we are creating a copy and changing the copy
# So when input deck, a copy is made and the returns
# the copy of the changed deck

# Elixir coding convention
# usually if you have func name with quesiton mark,
# it means it will return boool
contains?

# Enum is good for any list thing

# String interpolation - combines strings or injects
"#{}"

# List comprehension
# A comprhension is a mapping function
# for every element in this, do this
# after doing, all of this it is put into a new array**
cards = for value <- values do
  for suit <- suits do
    "#{value} of #{suit}"
  end
end
# returns a list of each values with suit added on
# reutnr thing just mapped over
# need to flatten bceause create multiple array
List.flatten(cards)

# ALTERNATE TO above (use two comprehensions)
for suit <- suits, value <- values do
  "#{value} of #{suit}"
end

# best design practice:
# delegate to existing methods
# Try not to use if statements -- use case + pattern match

# Tuple
# order specifies some meaning
# list doesnt

# you cant access specific element with EX. [0]

# Pattern Matching
# Elixir's replacement for variables
{hand, rest_of_deck} = Cards.deal(deck, 5)
# because the data structure and num of elements matches up
# perfectly with the structure and elements on the right side
# all of the elements on the right side get assigned to Matching
# position on left hand side
# equal sign essentially means lets match

color1 = ["red"]
> ["red"]
color1
> ["red"]
NEED TO MATCH STRUCTURESSO IF NESTED, match nested
[color1] = ["red"]
> ["red"]
color1
> "red"

# pattern matching with data structures and variables
["red", color] = ["red", "blue"]
# hardcoded red and match color with blue
# must have identical right side
# EX.
{status, binary} = File.read(filename)

case status do
  :ok -> :erlang.binary_to_term binary
  :error -> "That file does not exist"
end
# CHANGE STATEMNT ABOVE into
case File.read(filename) do
  {:ok, binary} -> :erlang.binary_to_term binary
  {:error, reason} -> "That file does not exist"
end
# WHATS HAPPENEING:
# In one step, doing two separate operations
# thats crazy!!!
{:ok, binary} = {:ok, ["filedata"]}
# This won't match
{:ok, _reason} = {:ok, ["filedata"]}
# yes, we know this exists, but i dont want to use it
# use underscore _var name


# Elixir(transpiled) -> erlang(compiled and exe) -> beam
# To use erlang, use = :erlang

# case, variable we are inspecting and then do
case status do
  # if status is :ok, run that line
  :ok -> :erlang.binary_to_term binary
  # if status is :error, return that
  :error -> "That file does not exist"
end

# Atoms
# Think of these like strings
# strings are used put together info and manipulate
#
:ok
# and
:error
# two most common

# Pipe Operator
# original
def create_hand(hand_size) do
  deck = Cards.create_deck
  deck = Cards.shuffle(deck)
  hand = Cards.deal(deck, hand_size)
end
# NEW
# Takes return from create_deck and pass it to
# shuffle then from suffle to deal with hand_size
# deal goes first btw
# very consistent first operators
def create_hand(hand_size) do
  Cards.create_deck
  |> Cards.shuffle
  |> Cards.deal(hand_size)
end

# USE EXDOC to help with documentation
# generates documentation html file of different
# GO into mix file and add tuple of dependencies
# this will retreive and install dependencies
mix deps.get

# documentation types:
# module - summary of what module does
# function - individual function
# The syntax for module documentation
# @moduledoc """
# """
# @doc """
# """
# then type to generate documentation
mix docs

TESTING
# test_helper - for global tests
# cards_test - for module specific test
mix test # runs tests
# Test types
# 1. Testing signular specific fact using assertion
# 2. Doc testing < this tests documentation you input!
assert
refute


# Maps
# create basic key value pair
colors = %{primary: "red", secondary "blue"}
# return red
colors.primary
> "red"
# search for specific key value w/ pattern matching
# each value is compared against
%{secondary: secondary_color} = colors
> "blue"
# updating value in map
colors = %{primary: "red"}
# WE DO NOT MAINUPLATE OR CHANGE VALUES IN DS
# We create a new data structure with changes
Map.put(colors, :primary, "blue")
# alternate 2 for updateing Map
%{ colors | primary: "blue"}

# KEYWORD LISTS
# even though this looks like key value pair,
# in memory this is a a tuple
colors = [{:primary, "red"}, {:secondary, "green"}]
colors[:primary]
> "red"
# With keyword list, you can use multiple of the same key
# Maps cannot do that
colors = [{:primary, "red"}, {:primary, "green"}]
> [:primary, "red", :primary, "green"]
# duplicate keys are good for database (ecto)
# keyword lists, you can remove the []*** still passes
# as one argument


# -----------------------------------------------------------

# Hashing stuff
def hash_input(input) do
  :crypto.hash(:md5, input)
  |> :binary.bin_to_list
  # produces string of numbers
end



# Struct
# a map but can be assigned default value and has checking
# create Struct call hex with default value of nil
defstruct hex: nil
# in iex to initialize struct type in..
%Identicon.Image{}
> %Identicon.Image{hex: nil}
# initialize with anything!
%Identicon.Image{hex: []}
> %Identicon.Image{hex: []}
# struct enforce insert SPECIFIC property, mps can insert anything
# You cant attach functions to struct***
# only holds primitive data

# is it an Identicon.imaage?
# does it have a hex property?
# doe it have a hex_list?
# no, it is an undefined variable. lets assign it
def pick_color(image) do
  %Identicon.Image{hex: hex_list} = image
  # grab first three values PATTERN MATHCING!
  [r, g, b] = hex_list
  # BUT, it wont work!
  # since there are too many values, you need
  # to add..
  # acknowledges fact other values, but toss em
  [r, g, b | _tail] = hex_list
end
# HOWEVER, that is too long, lets refactor
def pick_color(image) do
  %Identicon.Image{hex: [r, g, b | _tail]} = image
end

# Another refactor
def pick_color(image) do
  %Identicon.Image{hex: [r, g, b | _tail]} = image
  # Update image struct - create + add rgb
  %Identicon.Image{image | color: {r, g, b}}
end
# TO
def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
  # Update image struct - create + add rgb
  %Identicon.Image{image | color: {r, g, b}}
end


# Called Identicon.Image
defmodule Identicon.Image do

end

# goal of piping is to send around object with all of stuff


# JOIN list together
row ++ []
# INTERSTING
# map can go over exisiting list and do something on each list in main list
def build_grid(%Identicon.Image{hex: hex} = image) do
  hex
  |> Enum.chunk(3)#split into list of 3 and remove tail
  # pass reference of function with one argument
  # mirror ecah row
  |> Enum.map(&mirror_row/1)
  # get rid of lists of lists
  |> List.flatten
  # make it index
  |> Enum.with_index
end

# List.flatten gets rid of lists in lists
# Enum.with_index - turns list with values into tuples with index




























#
