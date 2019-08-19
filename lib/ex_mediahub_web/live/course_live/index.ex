defmodule MediaHubWeb.CourseLive.Index do
  use Phoenix.LiveView
  alias MediaHubWeb.CourseView
  alias MediaHub.Courses

  def render(assigns), do: CourseView.render("index.html", assigns)

  # def mount(%{courses: courses}, socket) do
  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(2000, self(), :tick)
    courses = Courses.list_courses()

    {:ok,
     socket
     |> assign(courses: courses)}
  end

  def handle_info(:tick, socket) do
    {:noreply, remove_flash(socket)}
  end

  defp remove_flash(socket) do
    socket
    |> put_flash(:info, "")
  end
end
