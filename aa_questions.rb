require "sqlite3"
require "singleton"

class Aa_QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('aa_questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class User
  attr_accessor :id, :fname, :lname

  def self.find_by_id(id)
    data = Aa_QuestionsDatabase.instance.execute("SELECT * FROM users WHERE id = #{id}")
    data.map { |datum| User.new(datum) }
  end

  def self.find_by_name(fname, lname)
    data = Aa_QuestionsDatabase.instance.execute(<<-SQL, fname: fname, lname:lname)
    SELECT * FROM users WHERE fname = :fname AND lname= :lname
    SQL
    data.map { |datum| User.new(datum) }
  end

  def initialize(datum)
    @id = datum['id']
    @fname = datum['fname']
    @lname = datum['lname']
  end

  def authored_questions
    Question.find_by_users_id(self.id)
  end

end

class Questions
  attr_accessor :id, :title, :body, :users_id

  def self.find_by_id(id)
    data = Aa_QuestionsDatabase.instance.execute("Select * FROM questions WHERE id = #{id}")
    data.map { |datum| Questions.new(datum) }
  end

  def self.find_by_users_id(users_id)
    data = Aa_QuestionsDatabase.instance.execute("Select * FROM questions WHERE users_id = #{users_id}")
    data.map { |datum| Questions.new(datum) }
  end

  def initialize(datum)
    @id = datum['id']
    @title = datum['title']
    @body = datum['body']
    @users_id = datum['users_id']
  end

end


class Questions_follows
  attr_accessor :id, :questions_id, :users_id

  def self.find_by_id(id)
    data = Aa_QuestionsDatabase.instance.execute("Select * FROM questions_follows WHERE id = #{id}")
    data.map { |datum| Question_follows.new(datum) }
  end

  def initialize(datum)
    @id = datum['id']
    @questions_id = datum['questions_id']
    @users_id = datum['users_id']
  end

end

class Replies
  attr_accessor :id, :subject_question, :parent_reference, :user_reference, :body

  def self.find_by_id(id)
    data = Aa_QuestionsDatabase.instance.execute("Select * FROM replies WHERE id = #{id}")
    data.map { |datum| Replies.new(datum) }
  end

  def self.find_by_user_reference(user_reference)
    data = Aa_QuestionsDatabase.instance.execute("Select * FROM replies WHERE user_reference = #{user_reference}")
    data.map { |datum| Replies.new(datum) }
  end

  def self.find_by_subject_question(subject_question)
    data = Aa_QuestionsDatabase.instance.execute("Select * FROM replies WHERE subject_question = #{subject_question}")
    data.map { |datum| Replies.new(datum) }
  end

  def initialize(datum)
    @id = datum['id']
    @subject_question = datum['subject_question']
    @parent_reference = datum['parent_reference']
    @user_reference = datum['user_reference']
    @body = datum['body']
  end

end

class Question_likes
  attr_accessor :id, :liked_question, :liked_id

  def self.find_by_id(id)
    data = Aa_QuestionsDatabase.instance.execute("Select * FROM question_likes WHERE id = #{id}")
    data.map { |datum| Question_likes.new(datum) }
  end

  def initialize(datum)
    @id = datum['id']
    @liked_question = datum['liked_question']
    @liked_id = datum['liked_id']
  end

end
