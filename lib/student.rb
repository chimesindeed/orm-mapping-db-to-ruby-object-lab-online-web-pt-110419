require 'pry'
class Student
  attr_accessor :id, :name, :grade


  def self.new_from_db(row)
   new_student = Student.new
   new_student.id = row[0]
   new_student.name = row[1]
   new_student.grade = row[2]
   new_student
  end


  def self.all
    sql = <<-SQL
    SELECT * FROM students
    SQL
    
    all_rows = DB[:conn].execute(sql)
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
    all_rows
  end

  def self.find_by_name(name)
    sql = <<-SQL
    SELECT name from students
    SQL
    names = DB[:conn].execute(sql)
    names
    binding.pry
    # find the student in the database given a name
    # return a new instance of the Student class
  end
  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end