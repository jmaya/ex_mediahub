defmodule MediaHub.Courses do
  @moduledoc """
  The Courses context.
  """

  import Ecto.Query, warn: false
  alias MediaHub.Repo

  alias MediaHub.Courses.Course

  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(MediaHub.PubSub, @topic)
  end

  defp broadcast_change({:ok, result}, event) do
    Phoenix.PubSub.broadcast(MediaHub.PubSub, @topic, {__MODULE__, event, result})
    {:ok, result}
  end

  defp broadcast_change({:error, result}, event) do
    Phoenix.PubSub.broadcast(MediaHub.PubSub, @topic, {__MODULE__, event, result})
    {:error, result}
  end

  @doc """
  Returns the list of courses.

  ## Examples

      iex> list_courses()
      [%Course{}, ...]

  """
  def list_courses do
    Repo.all(Course)
  end

  @doc """
  Gets a single course.

  Raises `Ecto.NoResultsError` if the Course does not exist.

  ## Examples

      iex> get_course!(123)
      %Course{}

      iex> get_course!(456)
      ** (Ecto.NoResultsError)

  """
  def get_course!(id), do: Repo.get!(Course, id)

  @doc """
  Creates a course.

  ## Examples

      iex> create_course(%{field: value})
      {:ok, %Course{}}

      iex> create_course(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_course(attrs \\ %{}) do
    %Course{}
    |> Course.changeset(attrs)
    |> Repo.insert()
    |> broadcast_change([:course, :created])
  end

  @doc """
  Updates a course.

  ## Examples

      iex> update_course(course, %{field: new_value})
      {:ok, %Course{}}

      iex> update_course(course, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_course(%Course{} = course, attrs) do
    course
    |> Course.changeset(attrs)
    |> Repo.update()
    |> broadcast_change([:course, :updated])
  end

  @doc """
  Deletes a Course.

  ## Examples

      iex> delete_course(course)
      {:ok, %Course{}}

      iex> delete_course(course)
      {:error, %Ecto.Changeset{}}

  """
  def delete_course(%Course{} = course) do
    course
    |> Repo.delete()
    |> broadcast_change([:course, :deleted])
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking course changes.

  ## Examples

      iex> change_course(course)
      %Ecto.Changeset{source: %Course{}}

  """
  def change_course(%Course{} = course) do
    Course.changeset(course, %{})
  end

  @doc """
  Returns a filtered list of Courses
  """
  def list_courses_by_name(name) do
    query = from c in Course, where: ilike(c.name, ^"%#{name}%")

    query
    |> Repo.all()
  end

  @doc """
  Returns last n by create date
  """

  def list_courses(number_of_courses) do
    query = from c in Course, order_by: c.created_at, limit: ^number_of_courses
    query |> Repo.all()
  end

  alias MediaHub.Courses.FileAttachment

  @doc """
  Returns the list of file_attachments.

  ## Examples

      iex> list_file_attachments()
      [%FileAttachment{}, ...]

  """
  def list_file_attachments do
    Repo.all(FileAttachment)
  end

  @doc """
  Gets a single file_attachment.

  Raises `Ecto.NoResultsError` if the File attachment does not exist.

  ## Examples

      iex> get_file_attachment!(123)
      %FileAttachment{}

      iex> get_file_attachment!(456)
      ** (Ecto.NoResultsError)

  """
  def get_file_attachment!(id), do: Repo.get!(FileAttachment, id)

  @doc """
  Creates a file_attachment.

  ## Examples

      iex> create_file_attachment(%{field: value})
      {:ok, %FileAttachment{}}

      iex> create_file_attachment(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_file_attachment(attrs \\ %{}) do
    %FileAttachment{}
    |> FileAttachment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a file_attachment.

  ## Examples

      iex> update_file_attachment(file_attachment, %{field: new_value})
      {:ok, %FileAttachment{}}

      iex> update_file_attachment(file_attachment, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_file_attachment(%FileAttachment{} = file_attachment, attrs) do
    file_attachment
    |> FileAttachment.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a FileAttachment.

  ## Examples

      iex> delete_file_attachment(file_attachment)
      {:ok, %FileAttachment{}}

      iex> delete_file_attachment(file_attachment)
      {:error, %Ecto.Changeset{}}

  """
  def delete_file_attachment(%FileAttachment{} = file_attachment) do
    Repo.delete(file_attachment)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking file_attachment changes.

  ## Examples

      iex> change_file_attachment(file_attachment)
      %Ecto.Changeset{source: %FileAttachment{}}

  """
  def change_file_attachment(%FileAttachment{} = file_attachment) do
    FileAttachment.changeset(file_attachment, %{})
  end
end
