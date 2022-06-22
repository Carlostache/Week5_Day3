DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;


PRAGMA foreign_keys = ON;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  users_id INTEGER NOT NULL,

  FOREIGN KEY (users_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  users_id INTEGER NOT NULL,
  questions_id INTEGER NOT NULL,

  FOREIGN KEY (users_id) REFERENCES users(id),
  FOREIGN KEY (questions_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  subject_question INTEGER NOT NULL,
  parent_reference INTEGER,
  user_reference INTEGER NOT NULL,
  body TEXT NOT NULL,

  FOREIGN KEY (subject_question) REFERENCES questions(id),
  FOREIGN KEY (parent_reference) REFERENCES replies(id),
  FOREIGN KEY (user_reference) REFERENCES users(id)
);

CREATE TABLE question_likes( 
  id INTEGER PRIMARY KEY,
  liked_question INTEGER NOT NULL,
  liked_id INTEGER NOT NULL,

  FOREIGN KEY (liked_id) REFERENCES users(id),
  FOREIGN KEY (liked_id) REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Carlos','Morales'),
  ('Leonel','Colina');


INSERT INTO
  questions (title, body, users_id)
VALUES 
  ('How SQL?', 'How do you make SQL tables', (SELECT id FROM users WHERE fname='Carlos' )),
  ('How to insert?', 'How do you fix this?', (SELECT id FROM users WHERE fname='Leonel'));

INSERT INTO
  question_follows (users_id, questions_id)
VALUES
  (1,1),
  (2,2);

INSERT INTO
  replies (subject_question, user_reference, body)
VALUES
  (1, 2, 'I am not sure how to SQL either'),
  (2, 1, 'LOL use INSERT followed by VALUES');


  
  

