login with github,
use OAUTH controller
go to site
github send back stuff to oauth controller

Add to dependencies
{:ueberauth, "~> 0.3"},
{:ueberauth_github, " ~> 0.4"}

Add to start up application
:ueberauth, :ueberauth_github

mix deps.get

Also have to register with github create key value
callback important


Go into config.exs
add your client keys


Add auth_controller
and add route

recompile server
mix phoenix.server

# Stash small amount of info on user
conn.assigns


# Need to do migration so can store created users
mix ecto.gen.migration add_users

# Add this into migration change generation
create table(:users) do
  add :email, :string
  add :provider, :string
  add :token, :string
  # Good for security and tracking
  timestamps()
  # A lot of these you don't need, but can store for later use

# After create structure, do:
mix ecto.migrate

# Next, Need to create model so phoenix know about users on DB
singular
create schema and changeset

# In controller
# create changeset and then store it into the DB
def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do
  user_params = %{token: auth.credentials, email: auth.info.email, provider: "github"}
  changeset = User.changeset(%User{}, user_params)
end

# Also create function which checks for user logging in

# Use cookies for login. phoenix calls them sessions





# DO IO.inspect to get information about user
# params object records who the provider is
# we could dynamically get it from params so no need to hardcode
user_params = %{token: auth.credentials, email: auth.info.email, provider: "github"}


#
