defmodule MediaHubWeb.CourseLive.Edit do
  use Phoenix.LiveView
  alias MediaHubWeb.Router.Helpers, as: Routes

  alias MediaHubWeb.CourseView
  alias MediaHub.Courses
  alias MediaHub.Courses.Course

  def mount(%{path_params: %{"course_id" => course_id}}, socket) do
    course = Courses.get_course!(course_id)

    {:ok,
     socket
     |> assign(course: course, changeset: Courses.change_course(course))}
  end

  def render(assigns), do: CourseView.render("edit.html", assigns)

  def handle_event("validate", %{"course" => params}, socket) do
    changeset =
      %Course{}
      |> Course.changeset(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"course" => course_params}, socket) do
    case Courses.update_course(socket.assigns.course, course_params) do
      {:ok, course} ->
        {:stop,
         socket
         #  |> put_flash(:info, "Course created")
         |> redirect(to: Routes.live_path(socket, MediaHubWeb.CourseLive.Show, course.id))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
