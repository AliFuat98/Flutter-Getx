const String wordTable = """CREATE TABLE IF NOT EXISTS "Word" (
"wordID"	INTEGER,
"Name" TEXT,
"PictureSrc"	TEXT,
"AudioSrc"	TEXT,
"isPronounced"	INTEGER,
"PronunciationScore"	NUMERIC,
"Reward"	INTEGER,
"categoryID"	INTEGER,
"IsNew" INTEGER,
"IsDeleted" INTEGER,
PRIMARY KEY("wordID" AUTOINCREMENT)
);""";
const String categoryTable = """CREATE TABLE IF NOT EXISTS "Category" (
"ID"	INTEGER,
"Name"	TEXT,
"isCompleted"	INTEGER,
"PictureSrc"	TEXT,
"Reward"	INTEGER,
"IsNew" INTEGER,
"IsDeleted" INTEGER,
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

const String contentTable = """CREATE TABLE IF NOT EXISTS "Content" (
"ID"	INTEGER,
"Name" TEXT,
"PictureSrc"	TEXT,
"isPurchased" BOOLEAN,
"Price"	INTEGER,
"Category"	INTEGER,
PRIMARY KEY("ID" AUTOINCREMENT)
);""";

const List<String> contentTableRows = [
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","Price","Category") VALUES (1,"Ürün-1","assets/images/awards/1.png", 1,100,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","Price","Category") VALUES (2,"Ürün-2","assets/images/awards/2.png", 0,150,2) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","Price","Category") VALUES (3,"Ürün-3","assets/images/awards/3.png", 0,200,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","Price","Category") VALUES (4,"Ürün-4","assets/images/awards/4.png", 0,250,4) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","Price","Category") VALUES (5,"Ürün-5","assets/images/awards/5.png", 0,300,5) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","Price","Category") VALUES (6,"Ürün-6","assets/images/awards/6.png", 0,350,6) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","Price","Category") VALUES (7,"Ürün-7","assets/images/awards/7.png", 0,400,7) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","Price","Category") VALUES (8,"Ürün-8","assets/images/awards/8.png", 0,450,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","Price","Category") VALUES (9,"Ürün-9","assets/images/awards/9.png", 0,500,2) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","Price","Category") VALUES (10,"Ürün-10","assets/images/awards/10.png", 0,550,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","Price","Category") VALUES (11,"Ürün-11","assets/images/awards/11.png", 0,600,4) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","Price","Category") VALUES (12,"Ürün-12","assets/images/awards/12.png", 0,650,5) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","Price","Category") VALUES (13,"Ürün-13","assets/images/awards/13.png", 0,700,6) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","Price","Category") VALUES (14,"Ürün-14","assets/images/awards/14.png", 0,750,7) ;""",
];

const List<String> gameTableRows = [
  """INSERT INTO "Game" ("GameID","Name","Type","Reward","PictureSrc") VALUES (1,'test1',1,50,"assets/images/game/game1.jpg") ;""",
  """INSERT INTO "Game" ("GameID","Name","Type","Reward","PictureSrc") VALUES (2,'test2',2,50,"assets/images/game/game2.jpg") ;""",
  """INSERT INTO "Game" ("GameID","Name","Type","Reward","PictureSrc") VALUES (3,'Listen And Select',3,50,"assets/images/game/game3.jpg") ;""",
  """INSERT INTO "Game" ("GameID","Name","Type","Reward","PictureSrc") VALUES (4,'tes4',4,50,"assets/images/game/game4.jpg") ;""",
  """INSERT INTO "Game" ("GameID","Name","Type","Reward","PictureSrc") VALUES (5,'Listen and Evaluate',5,50,"assets/images/game/game5.jpg");"""
];

const List<String> userTableRows = [
  """INSERT INTO "User" ("UserID","Name","Surname","Age","Coin") VALUES (1,"velet","veled",5,1000) ;""",
];

const List<String> wordTableRows = [
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (1,'Aunt','assets/images/word_images/family/aunt.jpg','audios/aunt.mp3',0,-1.0,50,1,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (2,'Baby','assets/images/word_images/family/baby.jpg','audios/baby.mp3',0,-1.0,50,1,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (3,'Brother','assets/images/word_images/family/brother.jpg','audios/brother.mp3',0,-1.0,50,1,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (4,'Daddy','assets/images/word_images/family/daddy.jpg','audios/daddy.mp3',0,-1.0,50,1,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (5,'Family','assets/images/word_images/family/family.jpg','audios/family.mp3',0,-1.0,50,1,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (6,'Grandma','assets/images/word_images/family/grandma.jpg','audios/grandma.mp3',0,-1.0,50,1,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (7,'Grandpa','assets/images/word_images/family/grandpa.jpg','audios/grandpa.mp3',0,-1.0,50,1,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (8,'Mummy','assets/images/word_images/family/mummy.jpg','audios/mummy.mp3',0,-1.0,50,1,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (9,'Parent','assets/images/word_images/family/parents.jpg','audios/parent.mp3',0,-1.0,50,1,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (10,'Pet','assets/images/word_images/family/pets.jpg','audios/pet.mp3',0,-1.0,50,1,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (11,'Sister','assets/images/word_images/family/sister.jpg','audios/sister.mp3',0,-1.0,100,1,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (12,'Uncle','assets/images/word_images/family/uncle.jpg','audios/uncle.mp3',0,-1.0,100,1,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (13,'Apple','assets/images/word_images/fruits/apple.jpg','audios/apple.mp3',0,-1.0,100,2,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (14,'Banana','assets/images/word_images/fruits/banana.jpg','audios/banana.mp3',0,-1.0,100,2,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (15,'Cherry','assets/images/word_images/fruits/cherry.jpg','audios/cherry.mp3',0,-1.0,100,2,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (16,'Grape','assets/images/word_images/fruits/grapes.jpg','audios/grape.mp3',0,-1.0,100,2,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (17,'Lemon','assets/images/word_images/fruits/lemon.jpg','audios/lemon.mp3',0,-1.0,100,2,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (18,'Orange','assets/images/word_images/fruits/orange.jpg','audios/orange.mp3',0,-1.0,100,2,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (19,'Peach','assets/images/word_images/fruits/peach.jpg','audios/peach.mp3',0,-1.0,100,2,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (20,'Pear','assets/images/word_images/fruits/pear.jpg','audios/pair.mp3',0,-1.0,100,2,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (21,'Pineapple','assets/images/word_images/fruits/pineapple.jpg','audios/pineapple.mp3',0,-1.0,100,2,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (22,'Plum','assets/images/word_images/fruits/plum.jpg','audios/plum.mp3',0,-1.0,100,2,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (23,'Strawberry','assets/images/word_images/fruits/strawberry.jpg','audios/strawberry.mp3',0,-1.0,100,2,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (24,'Watermelon','assets/images/word_images/fruits/watermelon.jpg','audios/watermelon.mp3',0,-1.0,100,2,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (25,'Bread','assets/images/word_images/foods/bread.jpg','audios/bread.mp3',0,-1.0,150,3,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (26,'Bun','assets/images/word_images/foods/bun.jpg','audios/bun.mp3',0,-1.0,150,3,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (27,'Butter','assets/images/word_images/foods/butter.jpg','audios/butter.mp3',0,-1.0,150,3,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (28,'Cake','assets/images/word_images/foods/cake.jpg','audios/cake.mp3',0,-1.0,150,3,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (29,'Cheese','assets/images/word_images/foods/cheese.jpg','audios/cheese.mp3',0,-1.0,150,3,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (30,'Chip','assets/images/word_images/foods/chips.jpg','audios/chip.mp3',0,-1.0,150,3,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (31,'Egg','assets/images/word_images/foods/egg.jpg','audios/egg.mp3',0,-1.0,150,3,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (32,'Hamburger','assets/images/word_images/foods/hamburger.jpg','audios/hamburger.mp3',0,-1.0,150,3,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (33,'Meat','assets/images/word_images/foods/meat.jpg','audios/meat.mp3',0,-1.0,150,3,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (34,'Pizza','assets/images/word_images/foods/pizza.jpg','audios/pizza.mp3',0,-1.0,150,3,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (35,'Sandwich','assets/images/word_images/foods/sandwich.jpg','audios/sandwich.mp3',0,-1.0,150,3,0,0);""",
  """INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID","IsNew","IsDeleted") VALUES (36,'Sausage','assets/images/word_images/foods/sausage.jpg','audios/sausage.mp3',0,-1.0,150,3,0,0);""",
];
const List<String> categoryTableRows = [
  """INSERT INTO "Category" ("ID","Name","isCompleted","PictureSrc","Reward","IsNew","IsDeleted") VALUES (1,'Family',0,'assets/images/category_images/family.png',1000,0,0);""",
  """INSERT INTO "Category" ("ID","Name","isCompleted","PictureSrc","Reward","IsNew","IsDeleted") VALUES (2,'Fruits',0,'assets/images/category_images/fruits.png',1000,0,0);""",
  """INSERT INTO "Category" ("ID","Name","isCompleted","PictureSrc","Reward","IsNew","IsDeleted") VALUES (3,'Foods',0,'assets/images/category_images/foods.png',1500,0,0);""",
];
