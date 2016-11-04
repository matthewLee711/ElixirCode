defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic

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
    changeset = Topic.changeset(%Topic{}, topic)
    # Insert into DB, perform success or failure
    case Repo.insert(changeset) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index)) #send user to Topic ctrl, index
      {:error, changeset} ->
        render conn, "new.html", changeset: changeset
    end
  end
end
