defmodule MediaHub.Courses.FileAttachment do
  use Ecto.Schema
  import Ecto.Changeset

  alias MediaHub.Courses.Course

  schema "file_attachments" do
    field :content_type, :string
    field :file, :string
    field :file_basename, :string
    field :position, :integer
    field :sha_1_hash, :string
    belongs_to(:course, Course)

    timestamps inserted_at: :created_at
  end

  @doc false
  def changeset(file_attachment, attrs) do
    file_attachment
    |> cast(attrs, [:file, :sha_1_hash, :content_type, :file_basename, :position])
    |> validate_required([:file, :sha_1_hash, :content_type, :file_basename, :position])
    |> put_assoc(:course, attrs.course)
  end
end
