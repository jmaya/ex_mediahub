defmodule MediaHubWeb.CourseLive.Show do
  use Phoenix.LiveView
  alias MediaHubWeb.CourseView
  alias MediaHub.Courses

  def mount(%{path_params: %{"course_id" => course_id}}, socket) do
    course = Courses.get_course!(course_id)

    {:ok,
     socket
     |> assign(course: course)}
  end

  def render(assigns), do: CourseView.render("show.html", assigns)
end
