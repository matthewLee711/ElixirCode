Changesets
Goal of changeset is to validate

struct -- record that is in the database or about to be
params -- new properties want to insert on record
cast -- not only how to update db with new properties
but also if record is valid
validate_required([:title]) -- made sure it contains
:title property


# Create a struct
struct = %Discuss.Topic{}

# Create params object
params = %{title: "greate js"}

Discuss.Topic.changeset(struct, params)
> #Ecto.Changeset<action: nil, changes: %{title: "great"},
errors: [], data: #DIscuss.Topic<>, valid?: true>

changeset is not only a function, but an object as well.
object knows changes that must be made.
"Changes" sees new params, no errors, shows it is valid

Discuss.Topic.changeset(struct, %{})
> Error, title can't be blank, valid? false

Once you are done, with changeset, save it!
















#
