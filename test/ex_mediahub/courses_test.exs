defmodule MediaHub.CoursesTest do
  use MediaHub.DataCase

  alias MediaHub.Courses

  describe "courses" do
    alias MediaHub.Courses.Course

    @valid_attrs %{company: "some company", file_attachments_count: 42, name: "some name"}
    @update_attrs %{
      company: "some updated company",
      file_attachments_count: 43,
      name: "some updated name"
    }
    @invalid_attrs %{company: nil, file_attachments_count: nil, name: nil}

    def course_fixture(attrs \\ %{}) do
      {:ok, course} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Courses.create_course()

      course
    end

    test "list_courses/0 returns all courses" do
      course = course_fixture()
      assert Courses.list_courses() == [course]
    end

    test "get_course!/1 returns the course with given id" do
      course = course_fixture()
      assert Courses.get_course!(course.id) == course
    end

    test "create_course/1 with valid data creates a course" do
      assert {:ok, %Course{} = course} = Courses.create_course(@valid_attrs)
      assert course.company == "some company"
      assert course.file_attachments_count == 42
      assert course.name == "some name"
    end

    @tag :skip
    test "create_course/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Courses.create_course(@invalid_attrs)
    end

    test "update_course/2 with valid data updates the course" do
      course = course_fixture()
      assert {:ok, %Course{} = course} = Courses.update_course(course, @update_attrs)
      assert course.company == "some updated company"
      assert course.file_attachments_count == 43
      assert course.name == "some updated name"
    end

    test "update_course/2 with invalid data returns error changeset" do
      course = course_fixture()
      assert {:error, %Ecto.Changeset{}} = Courses.update_course(course, @invalid_attrs)
      assert course == Courses.get_course!(course.id)
    end

    test "delete_course/1 deletes the course" do
      course = course_fixture()
      assert {:ok, %Course{}} = Courses.delete_course(course)
      assert_raise Ecto.NoResultsError, fn -> Courses.get_course!(course.id) end
    end

    test "change_course/1 returns a course changeset" do
      course = course_fixture()
      assert %Ecto.Changeset{} = Courses.change_course(course)
    end
  end

  describe "file_attachments" do
    alias MediaHub.Courses.FileAttachment

    @valid_attrs %{content_type: "some content_type", file: "some file", file_basename: "some file_basename", position: 42, sha_1_hash: 42}
    @update_attrs %{content_type: "some updated content_type", file: "some updated file", file_basename: "some updated file_basename", position: 43, sha_1_hash: 43}
    @invalid_attrs %{content_type: nil, file: nil, file_basename: nil, position: nil, sha_1_hash: nil}

    def file_attachment_fixture(attrs \\ %{}) do
      {:ok, file_attachment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Courses.create_file_attachment()

      file_attachment
    end

    test "list_file_attachments/0 returns all file_attachments" do
      file_attachment = file_attachment_fixture()
      assert Courses.list_file_attachments() == [file_attachment]
    end

    test "get_file_attachment!/1 returns the file_attachment with given id" do
      file_attachment = file_attachment_fixture()
      assert Courses.get_file_attachment!(file_attachment.id) == file_attachment
    end

    test "create_file_attachment/1 with valid data creates a file_attachment" do
      assert {:ok, %FileAttachment{} = file_attachment} = Courses.create_file_attachment(@valid_attrs)
      assert file_attachment.content_type == "some content_type"
      assert file_attachment.file == "some file"
      assert file_attachment.file_basename == "some file_basename"
      assert file_attachment.position == 42
      assert file_attachment.sha_1_hash == 42
    end

    test "create_file_attachment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Courses.create_file_attachment(@invalid_attrs)
    end

    test "update_file_attachment/2 with valid data updates the file_attachment" do
      file_attachment = file_attachment_fixture()
      assert {:ok, %FileAttachment{} = file_attachment} = Courses.update_file_attachment(file_attachment, @update_attrs)
      assert file_attachment.content_type == "some updated content_type"
      assert file_attachment.file == "some updated file"
      assert file_attachment.file_basename == "some updated file_basename"
      assert file_attachment.position == 43
      assert file_attachment.sha_1_hash == 43
    end

    test "update_file_attachment/2 with invalid data returns error changeset" do
      file_attachment = file_attachment_fixture()
      assert {:error, %Ecto.Changeset{}} = Courses.update_file_attachment(file_attachment, @invalid_attrs)
      assert file_attachment == Courses.get_file_attachment!(file_attachment.id)
    end

    test "delete_file_attachment/1 deletes the file_attachment" do
      file_attachment = file_attachment_fixture()
      assert {:ok, %FileAttachment{}} = Courses.delete_file_attachment(file_attachment)
      assert_raise Ecto.NoResultsError, fn -> Courses.get_file_attachment!(file_attachment.id) end
    end

    test "change_file_attachment/1 returns a file_attachment changeset" do
      file_attachment = file_attachment_fixture()
      assert %Ecto.Changeset{} = Courses.change_file_attachment(file_attachment)
    end
  end
end
