class Course < ActiveRecord::Base
  has_many :enrollments,
    primary_key: :id,
    foreign_key: :course_id,
    class_name: :Enrollment

  has_many :prerequisite,
    primary_key: :prereq_id,
    foreign_key: :id,
    class_name: :Course

  has_many :enrolled_students,
    through: :enrollments,
    source: :user
end
