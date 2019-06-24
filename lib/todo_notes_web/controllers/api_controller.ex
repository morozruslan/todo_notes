defmodule TodoNotesWeb.ApiController do
  @moduledoc false

  @compile {:parse_transform, :ms_transform}

  use TodoNotesWeb, :controller

  @typep conn()           :: Plug.Conn.t()
  @typep result()         :: Plug.Conn.t()

  @spec index(conn, params) :: result when
          conn:   conn(),
          params: map(),
          result: result()

  def index(conn, _params) do
    with {:ok, tasks} <- get_all_tasks()
      do
      render(conn, "tasks.json", %{tasks: tasks})
    end
  end

  @spec create(conn, params) :: result when
          conn:   conn(),
          params: %{id: integer(), value: String.t()},
          result: result()

  def create(conn,%{"id" => id, "task" => task}) do
    with :ok <- add(id, task)
      do
      render(conn, "success.json", %{status: "success"})
    else
      error ->
        render(conn, "error.json", %{error: error})
    end
  end

  @spec update(conn, params) :: result when
          conn:   conn(),
          params: %{id: integer(), value: String.t(),  status: String.t()},
          result: result()

  def update(conn,%{"id" => id, "task" => task, "status" => status}) do
    with :ok <- update(id, task, status)
      do
      render(conn, "success.json", %{status: "success"})
    else
      error ->
        render(conn, "error.json", %{error: error})
    end
  end

  @spec delete(conn, params) :: result when
          conn:   conn(),
          params: %{id: integer()},
          result: result()

  def delete(conn, %{"id" => id}) do
    with :ok <- delete(id)
      do
      render(conn, "success.json", %{status: "success"})
    else
      error ->
        render(conn, "error.json", %{error: error})
    end
  end

  defp get_all_tasks do
    {:ok, ref} = :dets.open_file(:tasks, [])
    all_rows = :dets.select(ref , :ets.fun2ms(fn(x) -> x end))
    all_tasks = Enum.map(all_rows, fn {_, x} -> x end)
    :dets.close(ref)
    {:ok, all_tasks}
  end

  defp add(id, task) do
    {:ok, ref} = :dets.open_file(:tasks, [])
    if if_exist(id, ref) do
      :already_exists
    else
      :dets.insert_new(ref, {id, %{:id => id, :task => task, :status => "to do"}})
      :dets.close(ref)
      :ok
    end
  end

  defp update(id, task, status) do
    {:ok, ref} = :dets.open_file(:tasks, [])
    if if_exist(String.to_integer(id), ref) do
      :dets.insert(ref, {String.to_integer(id), %{:id => id, :task => task, :status => status}})
      :dets.close(ref)
      :ok
    else
      :not_found
    end
  end

  defp delete(id) do
    {:ok, ref} = :dets.open_file(:tasks, [])
    if if_exist(String.to_integer(id), ref) do
      :dets.delete(ref, String.to_integer(id))
      :dets.close(ref)
      :ok
    else
      :not_found
    end
  end

  defp if_exist(id, ref) do
    case :dets.lookup(ref , id) do
      [{_, _}] ->
        :true
      _ ->
        :false
    end
  end

end
