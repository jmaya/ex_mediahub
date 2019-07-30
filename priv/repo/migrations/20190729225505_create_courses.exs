defmodule MediaHub.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :name, :string
      add :company, :string
      add :file_attachments_count, :integer, null: true, default: 0

      timestamps()

    end
  create index(:courses, [:name], unique: true)

  end
end
