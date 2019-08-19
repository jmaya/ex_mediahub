defmodule MediaHubWeb.CourseLive.Index do
  use Phoenix.LiveView
  alias MediaHubWeb.CourseView
  alias MediaHub.Courses

  def render(assigns), do: CourseView.render("index.html", assigns)

  # def mount(%{courses: courses}, socket) do
  def mount(_session, socket) do
    courses = Courses.list_courses()

    {:ok,
     socket
     |> assign(courses: courses)}
  end
end
