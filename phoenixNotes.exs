# What is phoenix used for?
# Acts as a webserver (digital ocean, etc)

mix phoenix.new ______
# HTML, JSON, Websockets (user receives)
# phoenix
# database (traditionally postgres)

# How phoenix handles incoming requests

# Make sure to have postgres installed before\
# running this command
# This will create a postgres on phoenix
mix ecto.create

http://stackoverflow.com/questions/21862054/single-page-application-advantages-and-disadvantages
Server Side Templating
# Used when you want to have a different collection of webpages
# with distinct URLs that a user can visit
# Everytime a user clicks on a new link, they are served
# a brand new html document

Single page app
# Get back single html document
# User will think they navigate somewhere.
# This is all on one page and javascript loads stuff.

Templates vs Layouts
# Templates
# .eex = template file

# Layout
# File that makes everything common to any page
# Layout is important to put styles or CDNS you want to use across app
# People use material design over bootstrap now

# Phoenix's MVC

# Model - raw data of the topic (just title - not look good)
# View - template that takes the model and makes it look nice
# Controller - figures ou what user is looking for, grabs correct Model
# .and stuffs it into the view, returns the result to the user. Puts
# model and view together

muffin batter - model (the raw content)
pan - view (makes muffin looks good)
person - controller (cook and puts batter into pan)

Request (http request)
\/
Router (takes request, inspect url)
\/
Controller <- Model <- Database
\/
View <- Template
\/
Response

# URL, then get pagecontroller, open index
get "/", PageController, :index
# In page_controller - find index.html and send back to user
# Make sure to have
def index(conn, _param) do
  rend conn, "index.html" # if make connection, send index.html
end

# Views and Templates
Phoenix looks at each view. It takes PageView, removes View -> Page
Then it will look inside the templates folder and try to find a folder
with the name page in it
# There is an intrinsic relatoiin between name of View and finding
# templates
# What happens next?
# Phoenix is going to take every template inside that folder and add
# it as a function to the page view. Specifically called render("name.html")
# OVERALL Page Controller, View, and template are all linked by name

# Lets you run your server in IEX, good for debugging
iex -S mix phoenix.server
# EX
Discuss.PageView
Discuss.PageView.render("index.html")

# Model Layer
Phoenix doesnt care about database - as long as its supported
Phoenix knows db exisits but doesnt know whats in it
Need to use models and migrations

# Postgres
Phoenix           Postgres
Topic Model <---> Table of topics models (collection of data)
# We create models to let phoenix know what inside postgres
# You also use migrations to instruct what should be inside the DB
Table of topics
id | title
0   stuff
1   nice
2   go

# Migrations
# Generate a migration for add_topics
mix ecto.gen.migration add_topics
# timestamp is important because order of execution of migrations
# is important
# Inside change, input
# This creates a table called topics
# make sure there is a column called title and type string
create table(:topics) do
  add :title, :string
end
# This generates chagnes made
mix ecto.migrate
# Postico is a free gui

PROBLEM
-Need to add new URL for user to visit (distinct)
Solution
-Add new route in router file

Problem
-New routes must map up to a method in a controller
Solution
-Add a new method in a controller to handle this request.
The method will decide what to do with the request (render a form?)

Problem
-Need to show a form to the user (controller thing)
Solution
-Make a new template that contains the form

Problem
-Need to translate data in the form to something that can be
saved int the database
Solution
-Create a 'Topic' Model that can translate raw data from the form
into something that can be saved into the database

Problem
-The controller and view that we currently have are related to a Page
but we are making stuff related to a topic
Solution
-Make a new controller and view to handle everything related to 'Topics'

# Phoenix uses restful conventions
Think of what are ways a user may want to mainpulate or use our 'Topics'


# Scratch
step 1. Need to create route so user can interact with
get "/topics/new", TopicController, :new

step 2. Create topic controller
topic_controller.ex
# This grabs everything about controller from web.ex file
use Discuss.Web :controller
# Extra
# error fixxed by import controller
topiccontroller.init/1 undefined or private

# IN WEB.ex, you can add a specific .ex file to controller and
# ALL CONTROLLERS WILL HAVE IT
IO.puts "+++++"
IO.inspect conn
IO.puts "+++++"
IO.inspect params
IO.puts "+++++"

# Conn is a struct | VERY IMPORTANT
# Represents both incoming and outgoing requests
# Pass it around in functions and send off again
# params helps parse the url

# OOP code reesue 9However, elixir doesnt do this (bc functional)
ControllerBaseClass -> TopicController(extends base class)
# Base class has init and handle_request < topic inherits those

keyword
import - take all functions out of this module and give them to this
other module. EX. module A imports B. Module A can use  Module B stuff.
alias - give me a shortcut to this other module. Alias is alternate to
import.
use - I want to do some really fancy setup

step 3. Create model to handle forms - relate to DB
topic.ex
We need to have a model schema. informs db of model. have to tell
phoenix of what is inside of postgres
# Model lets phoenix know whats inside the DB
create schema and changeset in Topic model
schema "topics" do
  field :title, :string
end

# Does validation and can be insert into db
def changeset(struct, params \\ %{}) do
  struct
  |> cast(params, [:title])
  |> validate_required([:title])
end

Changeset + Form Template = Usable Form

step 4.
Controller, one model, one view, 1 folder inside templates
when you create folder in template, make it singlar.
When you create the html file, make sure to name the html
file as the name of the function in the controller

step 5. MAKE sure to render html

WE CAN WRITE elixir code to generate our form for us


HTML RENDERING WITH ELIXIR
# here comes elixir code

<%= form_for @changeset, topic_path(@conn, :create), fn f -> end %>

<% end %>
# Create a form, using this changeset, whenever someone
# presses enter(topic_path), send it to the create route,
# which is related to topics. topic_path is to figure which
# route we want to send this to.
\/(what is actually running
form_for(@changeset, topic_path(@conn, :create)), fn f ->
end
# This form also expects to be sent in a changeset and conn
DONT FORGET
# If you are rendering an html page that needs an input
# you dont have to pass in conn
render conn, "new.html", changeset: changeset

new -- see form
create - actually create it

# CREATE
csrf token for security
params stores all inputs user wants to submit
HOW params stores stuff
params = %{"topic" => "asdf"}
# TO access, use pattern matching
%{"topic" => giveme} = params
> giveme
"asdf"
vs.
colors = %{red: "green"} #red is turned into an atom
# thats why colors.red is accessable

# Show all routes
mix phoenix.routes


# To make edits
get "/topics/:id/edit", TopicController, :edit
send to topics with ID to edit. send to controller to
edt handler

Changeset + topic struct + form template = useable form

# Topic added to generate correct path when submit form
render conn, "edit.html", changeset: changeset, topic: topic

# We pulled the topic out of the DB and pass it into template
# then pass it to topic path JUST to generate the correct route


# HOW UPDATE IS WORKING
def update(conn, %{"id", => topic_id, "topic" => topic}) do
  # Get old topic
  old_topic = Repo.get(Topic, topic_id)
  # pass old and new topic you want to update to
  changeset = Topic.changeset(old_topic, topic)
end

# How to specify delete
<%= link "Delete", to: topic_path(@conn, :delete, topic), method: :delete %>









#
