defmodule MediaHubWeb.FileAttachmentController do
  use MediaHubWeb, :controller

  alias MediaHub.Courses
  alias MediaHub.Courses.FileAttachment

  def index(conn, _params) do
    file_attachments = Courses.list_file_attachments()
    render(conn, "index.html", file_attachments: file_attachments)
  end

  def new(conn, _params) do
    changeset = Courses.change_file_attachment(%FileAttachment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"file_attachment" => file_attachment_params}) do
    case Courses.create_file_attachment(file_attachment_params) do
      {:ok, file_attachment} ->
        conn
        |> put_flash(:info, "File attachment created successfully.")
        |> redirect(to: Routes.file_attachment_path(conn, :show, file_attachment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    file_attachment = Courses.get_file_attachment!(id)
    render(conn, "show.html", file_attachment: file_attachment)
  end

  def edit(conn, %{"id" => id}) do
    file_attachment = Courses.get_file_attachment!(id)
    changeset = Courses.change_file_attachment(file_attachment)
    render(conn, "edit.html", file_attachment: file_attachment, changeset: changeset)
  end

  def update(conn, %{"id" => id, "file_attachment" => file_attachment_params}) do
    file_attachment = Courses.get_file_attachment!(id)

    case Courses.update_file_attachment(file_attachment, file_attachment_params) do
      {:ok, file_attachment} ->
        conn
        |> put_flash(:info, "File attachment updated successfully.")
        |> redirect(to: Routes.file_attachment_path(conn, :show, file_attachment))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", file_attachment: file_attachment, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    file_attachment = Courses.get_file_attachment!(id)
    {:ok, _file_attachment} = Courses.delete_file_attachment(file_attachment)

    conn
    |> put_flash(:info, "File attachment deleted successfully.")
    |> redirect(to: Routes.file_attachment_path(conn, :index))
  end
end
