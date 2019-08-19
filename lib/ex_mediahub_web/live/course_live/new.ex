defmodule MediaHubWeb.CourseLive.New do
  use Phoenix.LiveView
  alias MediaHubWeb.CourseView
  alias MediaHub.Courses
  alias MediaHub.Courses.Course

  def mount(_session, socket) do
    {:ok,
     socket
     |> assign(changeset: Courses.change_course(%Course{}))}
  end

  def render(assigns), do: CourseView.render("new.html", assigns)

  # def mount(%{courses: courses}, socket) do
end
