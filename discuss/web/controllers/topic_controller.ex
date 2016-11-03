defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic

  def new(conn, _params) do
    struct = %Topic{}
    params = %{}
    changeset = Topic.changeset(struct, params)
    render conn, "new.html", changeset: changeset
  end

  def create(conn, params) do
    %{"topic" => topic} = params
  end
end
