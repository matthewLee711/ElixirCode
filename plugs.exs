# Plugs are important for authenticating user
# in every part of your app.
A plug that does a tranformation on connection
Everythign done so far is similar to a plug

Module plugs
init - do some setup
call - called with a conn, must return a conn
best used when going to use in multiple controllers

Function plugs
best used when only going to use plug in specific
controller.


Create folder called plugs
and import necessary stuff

SetUser Purpose -
look at connection object, see if there is a user ID assigned
to it. If there is, find that user in the DB and assign it
to the connection object.

# assign user property as user
assign(conn, :user, user) #
# This is returned
# conn.assigns.user => user struct

After create plug, add it router so all controlelrs
can use it

# Checkout your plug
# This shows a user struct
IO.inspect(conn.assigns)

# Drop any session or Signout
configure_session(drop: true)

Create a plug called require_auth
The purpose of this is to show who owns posts and what not
So when you use a router to a specific property,
the require auth will

set user
\/
router
\/
require auth
\/
controller

# Check if user has access to edit
def call(conn, _params) do
  # Return conn if they have access
  if conn.assigns[:user] do
    conn
  else
    conn
    |> put_flash(:error, "You must be logged in")
    |> redirect(to: Helpers.topic_path(conn, :index))
    |> halt() #Tell phoenix not pass to next plug, otherwise it will
  end
end













#
