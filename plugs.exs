# Plugs are important for authenticating user
# in every part of your app.
A plug that does a tranformation on connection
Everythign done so far is similar to a plug

Module plugs
init - do some setup
call - called with a conn, must return a conn

Function plugs


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


















#
