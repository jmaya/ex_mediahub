defmodule MediaHub.Courses.Course do
  use Ecto.Schema
  import Ecto.Changeset

  schema "courses" do
    field :company, :string
    field :file_attachments_count, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(course, attrs) do
    course
    |> cast(attrs, [:name, :company, :file_attachments_count])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
