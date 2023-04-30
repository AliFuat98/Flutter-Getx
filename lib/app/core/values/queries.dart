const String wordTable =  """CREATE TABLE IF NOT EXISTS "Word" ("wordID"	INTEGER,"Name" TEXT,"PictureSrc"	TEXT,
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
const List<String> wordTableRows = [
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (1,'Aunt','assets/images/WordImages/aunt.jpeg','assets/audios/aunt.mp3',0,-1.0,50,1);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (2,'Baby','assets/images/WordImages/baby.jpeg','assets/audios/baby.mp3',0,-1.0,50,1);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (3,'Brother','assets/images/WordImages/brother.jpeg','assets/audios/brother.mp3',0,-1.0,50,1);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (4,'Daddy','assets/images/WordImages/daddy.jpeg','assets/audios/daddy.mp3',0,-1.0,50,1);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (5,'Family','assets/images/WordImages/family.jpeg','assets/audios/family.mp3',0,-1.0,50,1);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (6,'Grandma','assets/images/WordImages/grandma.jpeg','assets/audios/grandma.mp3',0,-1.0,50,1);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (7,'Grandpa','assets/images/WordImages/grandpa.jpeg','assets/audios/grandpa.mp3',0,-1.0,50,1);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (8,'Mummy','assets/images/WordImages/mummy.jpeg','assets/audios/mummy.mp3',0,-1.0,50,1);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (9,'Parent','assets/images/WordImages/parents.jpeg','assets/audios/parent.mp3',0,-1.0,50,1);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (10,'Pet','assets/images/WordImages/pets.jpeg','assets/audios/pet.mp3',0,-1.0,50,1);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (11,'Sister','assets/images/WordImages/sister.jpeg','assets/audios/sister.mp3',0,-1.0,100,2);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (12,'Uncle','assets/images/WordImages/uncle.jpeg','assets/audios/uncle.mp3',0,-1.0,100,2);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (13,'Apple','assets/images/WordImages/apple.jpeg','assets/audios/apple.mp3',0,-1.0,100,2);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (14,'Banana','assets/images/WordImages/banana.jpeg','assets/audios/banana.mp3',0,-1.0,100,2);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (15,'Cherry','assets/images/WordImages/cherry.jpeg','assets/audios/cherry.mp3',0,-1.0,100,2);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (16,'Grape','assets/images/WordImages/grapes.jpeg','assets/audios/grape.mp3',0,-1.0,100,2);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (17,'Lemon','assets/images/WordImages/lemon.jpeg','assets/audios/lemon.mp3',0,-1.0,100,2);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (18,'Orange','assets/images/WordImages/orange.jpeg','assets/audios/orange.mp3',0,-1.0,100,2);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (19,'Peach','assets/images/WordImages/peach.jpeg','assets/audios/peach.mp3',0,-1.0,100,2);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (20,'Pear','assets/images/WordImages/pear.jpeg','assets/audios/pair.mp3',0,-1.0,100,2);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (21,'Pineapple','assets/images/WordImages/pineapple.jpeg','assets/audios/pineapple.mp3',0,-1.0,100,2);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (22,'Plum','assets/images/WordImages/plum.jpeg','assets/audios/plum.mp3',0,-1.0,100,2);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (23,'Strawberry','assets/images/WordImages/strawberry.jpeg','assets/audios/strawberry.mp3',0,-1.0,100,2);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (24,'Watermelon','assets/images/WordImages/watermelon.jpeg','assets/audios/watermelon.mp3',0,-1.0,100,2);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (25,'Bread','assets/images/WordImages/bread.jpeg','assets/audios/bread.mp3',0,-1.0,150,3);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (26,'Bun','assets/images/WordImages/buns.jpeg','assets/audios/bun.mp3',0,-1.0,150,3);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (27,'Butter','assets/images/WordImages/butter.jpeg','assets/audios/butter.mp3',0,-1.0,150,3);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (28,'Cake','assets/images/WordImages/cake.jpeg','assets/audios/cake.mp3',0,-1.0,150,3);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (29,'Cheese','assets/images/WordImages/cheese.jpeg','assets/audios/cheese.mp3',0,-1.0,150,3);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (30,'Chip','assets/images/WordImages/chips.jpeg','assets/audios/chip.mp3',0,-1.0,150,3);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (31,'Egg','assets/images/WordImages/egg.jpeg','assets/audios/egg.mp3',0,-1.0,150,3);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (32,'Hamburger','assets/images/WordImages/hamburger.jpeg','assets/audios/hamburger.mp3',0,-1.0,150,3);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (33,'Meat','assets/images/WordImages/meat.jpeg','assets/audios/meat.mp3',0,-1.0,150,3);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (34,'Pizza','assets/images/WordImages/pizza.jpeg','assets/audios/pizza.mp3',0,-1.0,150,3);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (35,'Sandwich','assets/images/WordImages/sandwich.jpeg','assets/audios/sandwich.mp3',0,-1.0,150,3);""",
"""INSERT INTO "Word" ("wordID","Name","PictureSrc","AudioSrc","isPronounced","PronunciationScore","Reward","categoryID") VALUES (36,'Sausage','assets/images/WordImages/sausages.jpeg','assets/audios/sausage.mp3',0,-1.0,150,3)"""
];
const List<String> categoryTableRows = [
"""INSERT INTO "Category" ("ID","Name","isCompleted","PictureSrc","Reward") VALUES (1,'Family',0,'assets/images/CategoryImages/moduleFamily.jpeg',1000);""",
"""INSERT INTO "Category" ("ID","Name","isCompleted","PictureSrc","Reward") VALUES (2,'Fruits',0,'assets/images/CategoryImages/fruitsmodule.jpeg',1000);""",
"""INSERT INTO "Category" ("ID","Name","isCompleted","PictureSrc","Reward") VALUES (3,'Foods',0,'assets/images/CategoryImages/moduleFoods.jpeg',1500);"""
];