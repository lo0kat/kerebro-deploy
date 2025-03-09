CREATE TABLE IF NOT EXISTS Words (
    id SERIAL PRIMARY KEY,
    kr_word VARCHAR(255) NOT NULL UNIQUE,
    en_word VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Sentences (
    id SERIAL PRIMARY KEY,
    kr_sentence TEXT NOT NULL UNIQUE,
    en_sentence TEXT NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Sequences (
    id SERIAL PRIMARY KEY,
    sequence_name VARCHAR(255) NOT NULL UNIQUE,
    description TEXT,  
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS Word_Sentence_Mappings (
    word_id INT NOT NULL,
    sentence_id INT NOT NULL,
    word_index INT NOT NULL,
    PRIMARY KEY (word_id, sentence_id, word_index),
    FOREIGN KEY (word_id) REFERENCES Words(id) ON DELETE CASCADE,
    FOREIGN KEY (sentence_id) REFERENCES Sentences(id) ON DELETE CASCADE,
    CONSTRAINT unique_word_index UNIQUE (sentence_id, word_index) 
);

CREATE TABLE IF NOT EXISTS Sequence_Sentence_Mappings (
    sequence_id INT NOT NULL,
    sentence_id INT NOT NULL,
    sentence_order_index INT NOT NULL,
    PRIMARY KEY (sequence_id ,sentence_id),
    FOREIGN KEY (sequence_id) REFERENCES Sequences(id) ON DELETE CASCADE,
    FOREIGN KEY (sentence_id) REFERENCES Sentences(id) ON DELETE CASCADE,
    CONSTRAINT unique_order UNIQUE (sequence_id, sentence_order_index)  -- Ensures no duplicate order values in the same sequence
);

-- Inserting words into the Words table
INSERT INTO Words (kr_word, en_word) VALUES
('안녕하세요', 'Hello'),
('학교', 'School'),
('책', 'Book');

-- Inserting sentences into the Sentences table
INSERT INTO Sentences (kr_sentence, en_sentence) VALUES
('안녕하세요, 어떻게 지내세요?', 'Hello, how are you?'),
('학교에 가고 있어요.', 'I am going to school.'),
('이 책을 좋아해요.', 'I like this book.');

-- Inserting sequences into the Sequences table
INSERT INTO Sequences (sequence_name, description) VALUES
('Casual_Conversation', 'A sequence of common phrases.');

-- Inserting word-sentence mappings
INSERT INTO Word_Sentence_Mappings (word_id, sentence_id, word_index) VALUES
-- Sentence 1: '안녕하세요, 어떻게 지내세요?' (Hello, how are you?)
(1, 1, 1),  -- '안녕하세요' (Hello) at position 1

-- Sentence 2: '학교에 가고 있어요.' (I am going to school.)
(2, 2, 1),  -- '학교' (school) at position 1

-- Sentence 3: '이 책을 좋아해요.' (I like this book.)
(3, 3, 2); -- '책을' (book) at position 2


-- Inserting sentence sequence mappings
INSERT INTO Sequence_Sentence_Mappings (sequence_id, sentence_id, sentence_order_index) VALUES
-- Sequence 1: 'Casual_Conversation'
(1, 1, 1),  -- '안녕하세요, 어떻게 지내세요?' (Hello, how are you?) in position 1
(1, 3, 2);  -- '이 책을 좋아해요.' (I like this book.) in position 2
