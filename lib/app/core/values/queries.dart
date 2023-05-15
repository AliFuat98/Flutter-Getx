const String wordTable =
    """CREATE TABLE IF NOT EXISTS "Word" ("wordID"	INTEGER,"Name" TEXT,"PictureSrc"	TEXT,
"AudioSrc"	TEXT,"isPronounced"	INTEGER,"PronunciationScore"	NUMERIC,"Reward"	INTEGER,"categoryID"	INTEGER,
PRIMARY KEY("wordID" AUTOINCREMENT)
);""";
const String categoryTable = """CREATE TABLE IF NOT EXISTS "Category" (
"ID"	INTEGER,
"Name"	TEXT,
"isCompleted"	INTEGER,
"PictureSrc"	TEXT,
"Reward"	INTEGER,
PRIMARY KEY("ID" AUTOINCREMENT)
);""";

const String gameTable = """CREATE TABLE IF NOT EXISTS "Game" (
"GameID"	INTEGER,
"Name"	TEXT,
"Type"	INTEGER,
"Reward"	INTEGER,
"PictureSrc"	TEXT,
PRIMARY KEY("GameID" AUTOINCREMENT)
);""";

const String userTable = """CREATE TABLE IF NOT EXISTS "User" (
"UserID"	INTEGER,
"Name"	TEXT,
"Surname"	TEXT,
"Age"	INTEGER,
"Coin"	INTEGER,
PRIMARY KEY("UserID" AUTOINCREMENT)
);""";

const String GameUserTable = """CREATE TABLE IF NOT EXISTS "GameUser" (
"UserID"	INTEGER,
"GameID"	TEXT,
"Score" FLOAT,
"Date"  TEXT,
"Timetaken" INTEGER,
"IsFinished" BOOLEAN,
FOREIGN KEY (UserID) REFERENCES User(UserID),
FOREIGN KEY (GameID) REFERENCES Game(GameID)
);""";

const List<String> gameTableRows = [
  """INSERT INTO "Game" ("GameID","Name","Type","Reward","PictureSrc") VALUES (1,'test1',1,50,"assets/images/game/game1.jpg");""",
  """INSERT INTO "Game" ("GameID","Name","Type","Reward","PictureSrc") VALUES (2,'test2',2,50,"assets/images/game/game2.jpg");""",
  """INSERT INTO "Game" ("GameID","Name","Type","Reward","PictureSrc") VALUES (3,'Listen And Select',3,50,"assets/images/game/game3.jpg");""",
  """INSERT INTO "Game" ("GameID","Name","Type","Reward","PictureSrc") VALUES (4,'tes4',4,50,"assets/images/game/game4.jpg");""",
];

const List<String> userTableRows = [
  """INSERT INTO "User" ("UserID","Name","Surname","Age","Coin") VALUES (1,"velet","veled",5,0);""",
];

const List<String> wordTableRows = [
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (1,'Aunt','assets/images/word_images/family/aunt.jpg','audios/aunt.mp3',0,-1.0,50,1);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (2,'Baby','assets/images/word_images/family/baby.jpg','audios/baby.mp3',0,-1.0,50,1);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (3,'Brother','assets/images/word_images/family/brother.jpg','audios/brother.mp3',0,-1.0,50,1);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (4,'Daddy','assets/images/word_images/family/daddy.jpg','audios/daddy.mp3',0,-1.0,50,1);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (5,'Family','assets/images/word_images/family/family.jpg','audios/family.mp3',0,-1.0,50,1);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (6,'Grandma','assets/images/word_images/family/grandma.jpg','audios/grandma.mp3',0,-1.0,50,1);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (7,'Grandpa','assets/images/word_images/family/grandpa.jpg','audios/grandpa.mp3',0,-1.0,50,1);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (8,'Mummy','assets/images/word_images/family/mummy.jpg','audios/mummy.mp3',0,-1.0,50,1);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (9,'Parent','assets/images/word_images/family/parents.jpg','audios/parent.mp3',0,-1.0,50,1);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (10,'Pet','assets/images/word_images/family/pets.jpg','audios/pet.mp3',0,-1.0,50,1);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (11,'Sister','assets/images/word_images/family/sister.jpg','audios/sister.mp3',0,-1.0,100,1);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (12,'Uncle','assets/images/word_images/family/uncle.jpg','audios/uncle.mp3',0,-1.0,100,1);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (13,'Apple','assets/images/word_images/fruits/apple.jpg','audios/apple.mp3',0,-1.0,100,2);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (14,'Banana','assets/images/word_images/fruits/banana.jpg','audios/banana.mp3',0,-1.0,100,2);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (15,'Cherry','assets/images/word_images/fruits/cherry.jpg','audios/cherry.mp3',0,-1.0,100,2);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (16,'Grape','assets/images/word_images/fruits/grapes.jpg','audios/grape.mp3',0,-1.0,100,2);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (17,'Lemon','assets/images/word_images/fruits/lemon.jpg','audios/lemon.mp3',0,-1.0,100,2);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (18,'Orange','assets/images/word_images/fruits/orange.jpg','audios/orange.mp3',0,-1.0,100,2);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (19,'Peach','assets/images/word_images/fruits/peach.jpg','audios/peach.mp3',0,-1.0,100,2);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (20,'Pear','assets/images/word_images/fruits/pear.jpg','audios/pair.mp3',0,-1.0,100,2);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (21,'Pineapple','assets/images/word_images/fruits/pineapple.jpg','audios/pineapple.mp3',0,-1.0,100,2);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (22,'Plum','assets/images/word_images/fruits/plum.jpg','audios/plum.mp3',0,-1.0,100,2);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (23,'Strawberry','assets/images/word_images/fruits/strawberry.jpg','audios/strawberry.mp3',0,-1.0,100,2);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (24,'Watermelon','assets/images/word_images/fruits/watermelon.jpg','audios/watermelon.mp3',0,-1.0,100,2);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (25,'Bread','assets/images/word_images/foods/bread.jpg','audios/bread.mp3',0,-1.0,150,3);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (26,'Bun','assets/images/word_images/foods/bun.jpg','audios/bun.mp3',0,-1.0,150,3);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (27,'Butter','assets/images/word_images/foods/butter.jpg','audios/butter.mp3',0,-1.0,150,3);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (28,'Cake','assets/images/word_images/foods/cake.jpg','audios/cake.mp3',0,-1.0,150,3);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (29,'Cheese','assets/images/word_images/foods/cheese.jpg','audios/cheese.mp3',0,-1.0,150,3);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (30,'Chip','assets/images/word_images/foods/chips.jpg','audios/chip.mp3',0,-1.0,150,3);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (31,'Egg','assets/images/word_images/foods/egg.jpg','audios/egg.mp3',0,-1.0,150,3);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (32,'Hamburger','assets/images/word_images/foods/hamburger.jpg','audios/hamburger.mp3',0,-1.0,150,3);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (33,'Meat','assets/images/word_images/foods/meat.jpg','audios/meat.mp3',0,-1.0,150,3);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (34,'Pizza','assets/images/word_images/foods/pizza.jpg','audios/pizza.mp3',0,-1.0,150,3);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (35,'Sandwich','assets/images/word_images/foods/sandwich.jpg','audios/sandwich.mp3',0,-1.0,150,3);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (36,'Sausage','assets/images/word_images/foods/sausage.jpg','audios/sausage.mp3',0,-1.0,150,3)"""
];
const List<String> categoryTableRows = [
  """INSERT INTO "Category" ("ID","Name","isCompleted","PictureSrc","Reward") VALUES (1,'Family',0,'assets/images/category_images/family.png',1000);""",
  """INSERT INTO "Category" ("ID","Name","isCompleted","PictureSrc","Reward") VALUES (2,'Fruits',0,'assets/images/category_images/fruits.png',1000);""",
  """INSERT INTO "Category" ("ID","Name","isCompleted","PictureSrc","Reward") VALUES (3,'Foods',0,'assets/images/category_images/foods.png',1500);"""
];
