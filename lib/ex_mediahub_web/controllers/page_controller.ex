defmodule MediaHubWeb.PageController do
  use MediaHubWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
