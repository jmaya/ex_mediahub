defmodule MediaHubWeb.CourseLive.New do
  use Phoenix.LiveView
  alias MediaHubWeb.CourseView
  alias MediaHub.Courses
  alias MediaHub.Courses.Course

  alias MediaHubWeb.Router.Helpers, as: Routes

  def mount(_session, socket) do
    {:ok,
     socket
     |> assign(changeset: Courses.change_course(%Course{}))}
  end

  def render(assigns), do: CourseView.render("new.html", assigns)

  def handle_event("validate", %{"course" => params}, socket) do
    changeset =
      %Course{}
      |> Course.changeset(params)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"course" => course_params}, socket) do
    case Courses.create_course(course_params) do
      {:ok, _course} ->
        {:stop,
         socket
         |> put_flash(:info, "Course created")
         |> redirect(to: Routes.live_path(socket, MediaHubWeb.CourseLive.Index))}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
