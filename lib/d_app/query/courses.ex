defmodule DApp.Query.Courses do
  @moduledoc """
  The Courses context.
  """

  import Ecto.Query, warn: false
  alias DApp.Repo

  alias DApp.Schema.Program
  alias DApp.Schema.Semester

  @doc """
  Returns the list of programs.

  ## Examples

      iex> list_programs()
      [%Program{}, ...]

  """
  def get_programs_list do
    query = from(p in Program, order_by: [desc: p.inserted_at])
    Repo.all(query)
  end

  @doc """
  Gets a single program.

  Raises `Ecto.NoResultsError` if the Program does not exist.

  ## Examples

      iex> get_program!(123)
      %Program{}

      iex> get_program!(456)
      ** (Ecto.NoResultsError)

  """

  def get_program(id) do
    query = from(p in Program, where: p.id == ^id)
    case Repo.one(query) do
      nil ->
        {:error, :program_does_not_exist}
      program ->
        {:ok, program}
    end
  end

  @doc """
  Creates a program.

  ## Examples

      iex> create_program(%{field: value})
      {:ok, %Program{}}

      iex> create_program(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_program(attrs \\ %{}) do
    %Program{}
    |> Program.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a program.

  ## Examples

      iex> update_program(program, %{field: new_value})
      {:ok, %Program{}}

      iex> update_program(program, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_program({:ok, %Program{} = program}, attrs) do
    program
    |> Program.changeset(attrs)
    |> case do
         %Ecto.Changeset{valid?: true} = changeset ->
           Repo.update(changeset)

         changeset ->
           {:error, changeset}
       end
  end
  def update_program({:error, :program_does_not_exist}, _) do
    {:error, ["Program Doesn't Exist"]}
  end

  @doc """
  Deletes a program.

  ## Examples

      iex> delete_program(program)
      {:ok, %Program{}}

      iex> delete_program(program)
      {:error, %Ecto.Changeset{}}

  """
  def delete_program({:ok, program}) do
    case Repo.delete(program) do
      {:ok, program} -> {:ok, program}
      _ -> {:error , ["Unable to Delete Program!"]}
    end
  end
  def delete_program({:error, program_does_not_exist}) do
    {:error, ["Program Does Not Exist"]}
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking program changes.

  ## Examples

      iex> change_program(program)
      %Ecto.Changeset{data: %Program{}}

  """
  def change_program(%Program{} = program, attrs \\ %{}) do
    Program.changeset(program, attrs)
  end

  @doc """
  Returns the list of semesters.

  ## Examples

      iex> list_semesters()
      [%Semester{}, ...]

  """
  def list_semesters do
    Repo.all(Semester)
  end

  @doc """
  Gets a single semester.

  Raises `Ecto.NoResultsError` if the Semester does not exist.

  ## Examples

      iex> get_semester!(123)
      %Semester{}

      iex> get_semester!(456)
      ** (Ecto.NoResultsError)

  """
  def get_semester(semester_id, program_id) do
    query = from(s in Semester,
      where: s.id == ^semester_id,
      where: s.program_id == ^program_id,
      preload: [:program]
    )
    case Repo.one(query) do
      nil -> {:error, :semester_does_not_exist}
      semester -> {:ok, semester}
    end
  end

  @doc """
  Creates a semester.

  ## Examples

      iex> create_semester(%{field: value})
      {:ok, %Semester{}}

      iex> create_semester(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_semester(attrs \\ %{}) do
    %Semester{}
    |> Semester.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a semester.

  ## Examples

      iex> update_semester(semester, %{field: new_value})
      {:ok, %Semester{}}

      iex> update_semester(semester, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_semester({:ok, %Semester{} = semester}, attrs) do
    semester
    |> Semester.changeset(attrs)
    |> case do
         %Ecto.Changeset{valid?: true} = changeset ->
           Repo.update(changeset)

         changeset ->
           {:error, changeset}
       end
  end

  @doc """
  Deletes a semester.

  ## Examples

      iex> delete_semester(semester)
      {:ok, %Semester{}}

      iex> delete_semester(semester)
      {:error, %Ecto.Changeset{}}

  """
  def delete_semester({:ok, semester}) do
    case Repo.delete(semester) do
      {:ok, semester} -> {:ok, semester}
      _ -> {:error , ["Unable to Delete Semester!"]}
    end
  end
  def delete_semester({:error, semester_does_not_exist}) do
    {:error, ["Semester Does Not Exist"]}
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking semester changes.

  ## Examples

      iex> change_semester(semester)
      %Ecto.Changeset{data: %Semester{}}

  """
  def change_semester(%Semester{} = semester, attrs \\ %{}) do
    Semester.changeset(semester, attrs)
  end

  alias DApp.Schema.TeacherCourse

  @doc """
  Returns the list of teacher_courses.

  ## Examples

      iex> list_teacher_courses()
      [%TeacherCourse{}, ...]

  """
  def list_teacher_courses do
    Repo.all(TeacherCourse)
  end

  @doc """
  Gets a single teacher_course.

  Raises `Ecto.NoResultsError` if the Teacher  cource does not exist.

  ## Examples

      iex> get_teacher_course!(123)
      %TeacherCourse{}

      iex> get_teacher_course!(456)
      ** (Ecto.NoResultsError)

  """
  def get_teacher_course!(id), do: Repo.get!(TeacherCourse, id)

  @doc """
  Creates a teacher_course.

  ## Examples

      iex> create_teacher_course(%{field: value})
      {:ok, %TeacherCourse{}}

      iex> create_teacher_course(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_teacher_course(attrs \\ %{}) do
    %TeacherCourse{}
    |> TeacherCourse.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a teacher_course.

  ## Examples

      iex> update_teacher_course(teacher_course, %{field: new_value})
      {:ok, %TeacherCourse{}}

      iex> update_teacher_course(teacher_course, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_teacher_course(%TeacherCourse{} = teacher_course, attrs) do
    teacher_course
    |> TeacherCourse.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a teacher_course.

  ## Examples

      iex> delete_teacher_course(teacher_course)
      {:ok, %TeacherCourse{}}

      iex> delete_teacher_course(teacher_course)
      {:error, %Ecto.Changeset{}}

  """
  def delete_teacher_course(%TeacherCourse{} = teacher_course) do
    Repo.delete(teacher_course)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking teacher_course changes.

  ## Examples

      iex> change_teacher_course(teacher_course)
      %Ecto.Changeset{data: %TeacherCourse{}}

  """
  def change_teacher_course(%TeacherCourse{} = teacher_course, attrs \\ %{}) do
    TeacherCourse.changeset(teacher_course, attrs)
  end

  alias DApp.Schema.StudentCourse

  @doc """
  Returns the list of student_courses.

  ## Examples

      iex> list_student_courses()
      [%StudentCourse{}, ...]

  """
  def list_student_courses do
    Repo.all(StudentCourse)
  end

  @doc """
  Gets a single student_course.

  Raises `Ecto.NoResultsError` if the Student  cource does not exist.

  ## Examples

      iex> get_student_course!(123)
      %StudentCourse{}

      iex> get_student_course!(456)
      ** (Ecto.NoResultsError)

  """
  def get_student_course!(id), do: Repo.get!(StudentCourse, id)

  @doc """
  Creates a student_course.

  ## Examples

      iex> create_student_course(%{field: value})
      {:ok, %StudentCourse{}}

      iex> create_student_course(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_student_course(attrs \\ %{}) do
    %StudentCourse{}
    |> StudentCourse.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a student_course.

  ## Examples

      iex> update_student_course(student_course, %{field: new_value})
      {:ok, %StudentCourse{}}

      iex> update_student_course(student_course, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_student_course(%StudentCourse{} = student_course, attrs) do
    student_course
    |> StudentCourse.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a student_course.

  ## Examples

      iex> delete_student_course(student_course)
      {:ok, %StudentCourse{}}

      iex> delete_student_course(student_course)
      {:error, %Ecto.Changeset{}}

  """
  def delete_student_course(%StudentCourse{} = student_course) do
    Repo.delete(student_course)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking student_course changes.

  ## Examples

      iex> change_student_course(student_course)
      %Ecto.Changeset{data: %StudentCourse{}}

  """
  def change_student_course(%StudentCourse{} = student_course, attrs \\ %{}) do
    StudentCourse.changeset(student_course, attrs)
  end
end
