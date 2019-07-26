PRAGMA foreign_keys = ON;


DROP TABLE IF EXISTS question_likes; 
DROP TABLE IF EXISTS replies; 
DROP TABLE IF EXISTS question_follows; 
DROP TABLE IF EXISTS questions; 
DROP TABLE IF EXISTS users;


CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(100),
  lname VARCHAR(100)
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(100),
  body VARCHAR(255),
  author_id INTEGER,
    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  follower_id INTEGER,
  question_id INTEGER,
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER,
  parent_id INTEGER,
  users_id INTEGER,
  body VARCHAR(255),
    FOREIGN KEY (question_id) REFERENCES questions(id),  
    FOREIGN KEY (parent_id) REFERENCES replies(id),
    FOREIGN KEY (users_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
   id INTEGER PRIMARY KEY,
   users_id INTEGER,
   questions_id INTEGER,
    FOREIGN KEY (users_id) REFERENCES users(id),
    FOREIGN KEY (questions_id) REFERENCES questions(id)
);

INSERT INTO users(fname, lname)
VALUES ('tom', 'smith'), ('jennifer', 'kennedy');

INSERT INTO questions (title, body, author_id)
VALUES ('how do I google something?', 'how do I look for stuff on google?', 1),
 ('how do I make pb&j?', 'I am really hungry and I want to make pb&j', 2);

INSERT INTO question_follows (follower_id, question_id)
VALUES (1, 1),
 (2, 2);

INSERT INTO replies (question_id, parent_id, users_id, body)
VALUES (2, null, 1, 'let me google that for you'),
 (1, null, 2, 'here is a link to a website that tells you how to spread peanut butter and then jelly after');

INSERT INTO question_likes (users_id, questions_id)
VALUES (1, 2),
 (2, 1);