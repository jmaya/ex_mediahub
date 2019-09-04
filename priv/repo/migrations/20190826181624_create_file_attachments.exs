defmodule MediaHub.Repo.Migrations.CreateFileAttachments do
  use Ecto.Migration

  def change do
    create table(:file_attachments) do
      add :file, :string, required: true
      add :sha_1_hash, :string
      add :content_type, :string
      add :file_basename, :string, required: true
      add :position, :integer, default: 0
      add :course_id, references(:courses, on_delete: :nothing), required: true

      timestamps inserted_at: :created_at
    end

    create index(:file_attachments, [:course_id])
  end
end
