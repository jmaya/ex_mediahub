defmodule MediaHubWeb.CourseLiveTest do
  use MediaHubWeb.ConnCase
  import Phoenix.LiveViewTest
  alias MediaHub.Courses

  test "disconnected and connected mount", %{conn: conn} do
    conn = get(conn, "/live-courses")
    assert html_response(conn, 200) =~ "<h1>Listing Courses</h1>"
    {:ok, _view, _html} = live(conn)
  end

  test "Lists a Course when it exists", %{conn: conn} do
    {:ok, course} = Courses.create_course(%{name: "Test Course"})
    conn = get(conn, "/live-courses")
    {:ok, _view, html} = live(conn)
    assert html =~ course.name
  end
end
