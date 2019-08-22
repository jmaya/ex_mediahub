defmodule MediaHubWeb.CourseLive.Index do
  use Phoenix.LiveView
  alias MediaHubWeb.CourseView
  alias MediaHub.Courses

  @max_courses 10
  def render(assigns), do: CourseView.render("index.html", assigns)

  def mount(_session, socket) do
    if connected?(socket) do
      Courses.subscribe()
      courses = Courses.list_courses(@max_courses)

      {:ok,
       socket
       |> assign(courses: courses, query: "")}
    else
      {:ok, socket |> assign(courses: [], query: "")}
    end
  end

  def handle_info({Courses, [:course, :created], course}, socket) do
    {:noreply,
     socket
     |> assign(courses: socket.assigns.courses ++ [course])}
  end

  def handle_info({Courses, [:course, :deleted], course}, socket) do
    new_courses =
      socket.assigns.courses
      |> Enum.reject(fn c -> c.id == course.id end)

    {:noreply, socket |> assign(courses: new_courses)}
  end

  def handle_event("filter_courses", %{"query" => ""}, socket) do
    courses = Courses.list_courses(@max_courses)
    {:noreply, socket |> assign(courses: courses)}
  end

  def handle_event("filter_courses", %{"query" => query}, socket) do
    if(String.length(query) > 2) do
      courses = Courses.list_courses_by_name(query)
      {:noreply, socket |> assign(courses: courses)}
    else
      {:noreply, socket}
    end
  end
end
