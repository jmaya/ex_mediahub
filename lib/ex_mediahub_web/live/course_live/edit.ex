defmodule MediaHubWeb.CourseLive.Edit do
  use Phoenix.LiveView
  alias MediaHubWeb.CourseView
  alias MediaHub.Courses

  def mount(%{path_params: %{"course_id" => course_id}}, socket) do
    course = Courses.get_course!(course_id)

    {:ok,
     socket
     |> assign(course: course, changeset: Courses.change_course(course))}
  end

  def render(assigns), do: CourseView.render("edit.html", assigns)
end
