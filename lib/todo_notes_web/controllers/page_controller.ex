defmodule TodoNotesWeb.PageController do
  use TodoNotesWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
