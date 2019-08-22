defmodule MediaHubWeb.FileAttachmentControllerTest do
  use MediaHubWeb.ConnCase

  alias MediaHub.Courses

  @create_attrs %{
    content_type: "some content_type",
    file: "some file",
    file_basename: "some file_basename",
    position: 42,
    sha_1_hash: 42,
    course: %{id: 1}
  }
  @update_attrs %{
    content_type: "some updated content_type",
    file: "some updated file",
    file_basename: "some updated file_basename",
    position: 43,
    sha_1_hash: 43,
    course: %{id: 1}
  }
  @invalid_attrs %{
    content_type: nil,
    file: nil,
    file_basename: nil,
    position: nil,
    sha_1_hash: nil
  }

  def fixture(:file_attachment) do
    {:ok, file_attachment} = Courses.create_file_attachment(@create_attrs)
    {:ok, course} = Courses.create_course(%{name: "TestCourse"})
    file_attachment
  end

  describe "index" do
    test "lists all file_attachments", %{conn: conn} do
      conn = get(conn, Routes.file_attachment_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing File attachments"
    end
  end

  describe "new file_attachment" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.file_attachment_path(conn, :new))
      assert html_response(conn, 200) =~ "New File attachment"
    end
  end

  describe "create file_attachment" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn =
        post(conn, Routes.file_attachment_path(conn, :create), file_attachment: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.file_attachment_path(conn, :show, id)

      conn = get(conn, Routes.file_attachment_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show File attachment"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(conn, Routes.file_attachment_path(conn, :create), file_attachment: @invalid_attrs)

      assert html_response(conn, 200) =~ "New File attachment"
    end
  end

  describe "edit file_attachment" do
    setup [:create_file_attachment]

    test "renders form for editing chosen file_attachment", %{
      conn: conn,
      file_attachment: file_attachment
    } do
      conn = get(conn, Routes.file_attachment_path(conn, :edit, file_attachment))
      assert html_response(conn, 200) =~ "Edit File attachment"
    end
  end

  describe "update file_attachment" do
    setup [:create_file_attachment]

    test "redirects when data is valid", %{conn: conn, file_attachment: file_attachment} do
      conn =
        put(conn, Routes.file_attachment_path(conn, :update, file_attachment),
          file_attachment: @update_attrs
        )

      assert redirected_to(conn) == Routes.file_attachment_path(conn, :show, file_attachment)

      conn = get(conn, Routes.file_attachment_path(conn, :show, file_attachment))
      assert html_response(conn, 200) =~ "some updated content_type"
    end

    test "renders errors when data is invalid", %{conn: conn, file_attachment: file_attachment} do
      conn =
        put(conn, Routes.file_attachment_path(conn, :update, file_attachment),
          file_attachment: @invalid_attrs
        )

      assert html_response(conn, 200) =~ "Edit File attachment"
    end
  end

  describe "delete file_attachment" do
    setup [:create_file_attachment]

    test "deletes chosen file_attachment", %{conn: conn, file_attachment: file_attachment} do
      conn = delete(conn, Routes.file_attachment_path(conn, :delete, file_attachment))
      assert redirected_to(conn) == Routes.file_attachment_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.file_attachment_path(conn, :show, file_attachment))
      end
    end
  end

  defp create_file_attachment(_) do
    file_attachment = fixture(:file_attachment)
    {:ok, file_attachment: file_attachment}
  end
end
