Phoenix           Ecto
Model             Changeset
Controller        Repo


Phoenix depends on ecto
Ecto - deals with changeset stuff and something called a rapo
Repo - portal to DB


Controller <-> changeset <-> Repo <-> Postgres
# In the Controller, we make a changeset which contains
# the data the user is trying to insert
# Changeset will then be inserted into DB by Repo

Repo will automatically check if changeset is valid

# Look for errors under title
<%= error_tag f, :title %>

# In phoenix we're doing a POST request, not a client Side
# ajax request


#
get "/", PageController, :index

# ECTO!
hexdocs.pm/ecto

Querying in elixir ecto
# Select everything in topics table
Discuss.Repo.all(Discuss.Topic)















#
