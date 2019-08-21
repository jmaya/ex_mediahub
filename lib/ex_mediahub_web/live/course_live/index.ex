defmodule MediaHubWeb.CourseLive.Index do
  use Phoenix.LiveView
  alias MediaHubWeb.CourseView
  alias MediaHub.Courses

  def render(assigns), do: CourseView.render("index.html", assigns)

  # def mount(%{courses: courses}, socket) do
  def mount(_session, socket) do
    # if connected?(socket), do: :timer.send_interval(2000, self(), :tick)
    if connected?(socket) do
      Courses.subscribe()
      courses = Courses.list_courses()

      {:ok,
       socket
       |> assign(courses: courses)}
    else
      {:ok, socket |> assign(courses: [])}
    end
  end

  def handle_info({Courses, [:course, :created], course}, socket) do
    {:noreply,
     socket
     |> assign(courses: socket.assigns.courses ++ [course])}
  end
end
