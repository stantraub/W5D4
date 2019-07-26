require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
  include Singleton
  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User
  attr_accessor :id
  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
      *
      FROM
      users
      WHERE
      id = ?
    SQL

    User.new(data.first)
  end
end

class Question
  attr_accessor :id
  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT 
      *
      FROM 
      questions
      WHERE
      id = ?
    SQL

    Question.new(data.first)
  end
end

class Questionfollows
  def initialize(options)
    @id = options['id']
    @follower_id = options['follower_id']
    @question_id = options['question_id']
  end

  def self.find_by_id(id)
    data = QuestionsDatabase.instance.execute(<<-SQL, id)
     SELECT
     *
     FROM
     question_follows
     WHERE
     id = ?
    SQL

    Questionfollows.new(data.first)
  end
end

# class Replies
#   def initialize(options)
#     @id = options['id']
#     @question_id = options['question_id']
#     @parent_id = options['parent_id']
#     @users_id = options['users_id']
#     @body = options['body']
#   end

#   def self.find_by_id(id)
#     data = QuestionsDatabase.instance.execute(<<-SQL, id)
#       SELECT
#       *
#       FROM
#       replies
#       WHERE
#       id = ?
#     SQL

#     Replies.new(data.first)
#   end
# end

# class Questionlikes
#   def question_likes(options)
#     @id = options['id']
#     @users_id = options['users_id']
#     @questions_id = options['questions_id']
#   end

#   def self.find_by_id(id)
#     data = QuestionsDatabase.instance.execute(<<-SQL, id)
#       SELECT
#       *
#       FROM
#       question_likes
#       WHERE
#       id = ?
#     SQL

#     Questionlikes.new.(data.first)
#   end
# end