Intent:
See form to create a new topic
Action:
GET /topics/new
Controller method Name:
new

Intent:
Submit form to create a topic
Action:
POST /topics
Controller method name:
create

Intent:
Get a list of all topics
Action:
GET /topics
Controller method name:
index

Intent:
Delete a topic with ID of 12
Action:
DELETE /topics/12
Controller method name:
delete

Intent:
See the form to update and existing topic with ID of 12
Action:
GET /topics/12/edit
Controller method name:
edit

Intent:
Submit the form to update a topic with ID 12
Action:
PUT /topics/12
Controller method name:
update




# IN ROUTES FOLDER, instead all of that\
# get "/", TopicController, :index
# get "/topics/new", TopicController, :new
# post "/topics", TopicController, :create
# get "/topics/:id/edit", TopicController, :edit
# put "/topics/:id", TopicController, :update
resources "/", TopicController
