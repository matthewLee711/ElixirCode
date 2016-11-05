defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic

  # Executes before any handler - check if user logged in
  plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
  # Check owner of post
  plug :check_topic_owner when action in [:update, :edit, :delete]

  # Show all topics in html page
  def index(conn, _params) do
    topics = Discuss.Repo.all(Topic)
    render conn, "index.html", topics: topics
  end

  # Serve new.html page
  def new(conn, _params) do
    struct = %Topic{}
    params = %{}
    changeset = Topic.changeset(struct, params)
    render conn, "new.html", changeset: changeset
  end

  # Insert topic into DB -- handler
  def create(conn, params) do
    %{"topic" => topic} = params
    # changeset = Topic.changeset(%Topic{}, topic)
    # Make sure you are logged in so you can add
    changeset = conn.assigns.user
    |> build_assoc(:topics) #create topic struct with user association
    |> Topic.changeset(topic)

    # Insert into DB, perform success or failure
    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index)) #send user to Topic ctrl, index
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end

  # Make edits to topic - params is a map
  def edit(conn, %{"id" => topic_id}) do
    # Pull data out of DB
    topic = Repo.get(Topic, topic_id)
    # Create changset out of topic out of db
    # we make this changeset bc all forms epect to be working with changeset
    changeset = Topic.changeset(topic)

    render conn, "edit.html", changeset: changeset, topic: topic
  end
  # Works with edit - update record that already exists
  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: topic_path(conn, :index))
      {:error, changset} ->
        render conn, "edit.html", changeset: changeset, topic: old_topic
    end
  end

  # Delete topic
  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end

  def check_topic_owner(conn, _params) do
    %{params: %{"id" => topic_id}} = conn
    # If user id from db is same as connection id
    if Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You cannot edit that")
      |> redirect(to: topic_path(conn, :index))
      |> halt()
    end
  end
end
