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
"inUsed" BOOLEAN,
"Price"	INTEGER,
"Category"	INTEGER,
PRIMARY KEY("ID" AUTOINCREMENT)
);""";

const List<String> contentTableRows = [
  // badge
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (1,"Super Kids","assets/images/awards/badge/1.png", 0, 0,400,7) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (2,"Super Baby","assets/images/awards/badge/2.png", 0, 0,500,7) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (3,"Super Mom","assets/images/awards/badge/3.png", 0, 0,600,7) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (4,"Hero","assets/images/awards/badge/4.png", 0, 0,200,7) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (5,"Hero","assets/images/awards/badge/5.png", 0, 0,250,7) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (6,"Super Hero","assets/images/awards/badge/6.png", 0, 0,300,7) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (7,"Hero","assets/images/awards/badge/7.png", 1, 1,150,7) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (8,"Super Hero","assets/images/awards/badge/8.png", 0, 0,350,7) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (9,"Super Star","assets/images/awards/badge/9.png", 0, 0,700,7) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (10,"Super Boy","assets/images/awards/badge/10.png", 0, 0,500,7) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (11,"Super Boss","assets/images/awards/badge/11.png", 0, 0,150,7) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (12,"Daddy Hero","assets/images/awards/badge/12.png", 0, 0,500,7) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (13,"Super Girl","assets/images/awards/badge/13.png", 0, 0,600,7) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (14,"Super Boss","assets/images/awards/badge/14.png", 0, 0,200,7) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (15,"Super Boss","assets/images/awards/badge/14.png", 0, 0,250,7) ;""",
  // avatar
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (16,"Puppy","assets/images/awards/avatar/1.png", 0, 0,300,6) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (17,"Sleepy Dog","assets/images/awards/avatar/2.png", 1, 1,150,6) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (18,"Dinosaur","assets/images/awards/avatar/3.png", 0, 0,200,6) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (19,"Sleppy Pony","assets/images/awards/avatar/4.png", 0, 0,500,6) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (20,"Pony","assets/images/awards/avatar/5.png", 0, 0,600,6) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (21,"Hungry Pony","assets/images/awards/avatar/6.png", 0, 0,700,6) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (22,"Cooker Bear","assets/images/awards/avatar/7.png", 0, 0,500,6) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (23,"Music Bear","assets/images/awards/avatar/8.png", 0, 0,400,6) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (24,"Honey Bear","assets/images/awards/avatar/9.png", 0, 0,600,6) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (25,"Cool Lama","assets/images/awards/avatar/10.png", 0, 0,1500,6) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (26,"Happy Lama","assets/images/awards/avatar/11.png", 0, 0,1000,6) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (27,"Astronaut","assets/images/awards/avatar/12.png", 0, 0,600,6) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (28,"Tortoise","assets/images/awards/avatar/13.png", 0, 0,300,6) ;""",
  //sticker
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (29,"Duck","assets/images/awards/sticker/1.png", 0, 0,150,5) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (30,"Archer","assets/images/awards/sticker/2.png", 0, 0,1000,5) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (31,"Console","assets/images/awards/sticker/3.png", 0, 0,200,5) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (32,"Toy","assets/images/awards/sticker/4.png", 0, 0,250,5) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (33,"Drop","assets/images/awards/sticker/5.png", 0, 0,250,5) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (34,"Scissors","assets/images/awards/sticker/6.png", 0, 0,300,5) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (35,"Hair Clip","assets/images/awards/sticker/7.png", 0, 0,200,5) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (36,"Ship","assets/images/awards/sticker/8.png", 0, 0,400,5) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (37,"Microphone","assets/images/awards/sticker/9.png", 0, 0,350,5) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (38,"Music Rabbit","assets/images/awards/sticker/10.png", 0, 0,300,5) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (39,"Tortoise","assets/images/awards/sticker/11.png", 0, 0,250,5) ;""",
  // Canndy
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (40,"Box","assets/images/awards/dessert/1.png", 0, 0,50,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (41,"Ice Box","assets/images/awards/dessert/2.png", 0, 0,150,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (42,"Donut","assets/images/awards/dessert/3.png", 0, 0,300,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (43,"Rock","assets/images/awards/dessert/4.png", 0, 0,100,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (44,"Biscuit","assets/images/awards/dessert/5.png", 0, 0,150,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (45,"Croissant","assets/images/awards/dessert/6.png", 0, 0,150,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (46,"Cookie","assets/images/awards/dessert/7.png", 0, 0,200,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (47,"Ice cream","assets/images/awards/dessert/8.png", 0, 0,200,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (48,"Candy Sugar","assets/images/awards/dessert/9.png", 0, 0,200,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (49,"Candy","assets/images/awards/dessert/10.png", 0, 0,50,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (50,"Big Cake","assets/images/awards/dessert/11.png", 0, 0,300,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (51,"Chocolate Bomb","assets/images/awards/dessert/12.png", 0, 0,600,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (52,"Candy","assets/images/awards/dessert/13.png", 0, 0,150,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (53,"Olips","assets/images/awards/dessert/14.png", 0, 0,150,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (54,"Cup Cake","assets/images/awards/dessert/15.png", 0, 0,250,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (55,"Star Cake","assets/images/awards/dessert/16.png", 0, 0,200,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (56,"Lollipop","assets/images/awards/dessert/17.png", 0, 0,150,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (57,"Clock Cake","assets/images/awards/dessert/18.png", 0, 0,200,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (58,"Chocolate Box","assets/images/awards/dessert/19.png", 0, 0,300,1) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (59,"Slice Cake","assets/images/awards/dessert/20.png", 0, 0,300,1) ;""",
  // animation
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (60,"Lisa Simpson","assets/images/awards/animation/1.gif", 0, 0,150,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (61,"Bimo","assets/images/awards/animation/2.gif", 0, 0,300,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (62,"Jump Ponny","assets/images/awards/animation/3.gif", 0, 0,500,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (63,"Scarf Man","assets/images/awards/animation/4.gif", 0, 0,100,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (64,"Anime","assets/images/awards/animation/5.gif", 0, 0,200,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (65,"Cat","assets/images/awards/animation/6.gif", 0, 0,500,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (66,"Kitty","assets/images/awards/animation/7.gif", 0, 0,450,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (67,"Child","assets/images/awards/animation/8.gif", 0, 0,200,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (68,"Stuart Minion","assets/images/awards/animation/9.gif", 0, 0,1000,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (69,"Blue Pony","assets/images/awards/animation/10.gif", 0, 0,1200,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (70,"Girl","assets/images/awards/animation/11.gif", 0, 0,400,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (71,"Mario","assets/images/awards/animation/12.gif", 0, 0,1500,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (72,"Panda","assets/images/awards/animation/13.gif", 0, 0,300,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (73,"Pokemon","assets/images/awards/animation/14.gif", 0, 0,1400,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (74,"Pikachu","assets/images/awards/animation/15.gif", 0, 0,2000,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (75,"Pizza","assets/images/awards/animation/16.gif", 0, 0,300,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (76,"Stuart Minion","assets/images/awards/animation/17.gif", 0, 0,1200,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (77,"Jake Dog","assets/images/awards/animation/18.gif", 0, 0,600,3) ;""",
  """INSERT INTO "Content" ("ID","Name","PictureSrc","isPurchased","inUsed","Price","Category") VALUES (78,"Yellow Creator","assets/images/awards/animation/19.gif", 0, 0,500,3) ;""",
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
