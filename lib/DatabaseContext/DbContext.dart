import 'package:outfitly/Models/AccessoryClothItemModel.dart';
import 'package:outfitly/Models/AthleticWearClothItemModel.dart';
import 'package:outfitly/Models/ClothingItemModel.dart';
import 'package:outfitly/Models/DressClothItemModel.dart';
import 'package:outfitly/Models/FootwearClothItemModel.dart';
import 'package:outfitly/Models/OutWearClothItemModel.dart';
import 'package:outfitly/Models/PantClothItemModel.dart';
import 'package:outfitly/Models/PostModel.dart';
import 'package:outfitly/Models/ShirtClothItemModel.dart';
import 'package:outfitly/Models/SwimWearClothItemModel.dart';
import 'package:outfitly/Models/UndergarmentsClothItemModel.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../Models/UsersModel.dart';

class DbContext {
  static Database? _database;

  Future<Database?> get database async{
    if(_database != null){
      return _database;
    }
    _database = await initDatabase();
    if (_database == null) {
      print("Failed to initialize database");
    } else {
      print("Database initialized successfully");
    }
    return _database;
  }

  Future<Database> initDatabase() async {
    try {
      io.Directory documentDirectory = await getApplicationDocumentsDirectory();
      String path = join(documentDirectory.path, 'Outfitly.db');
      print(path);
      var db = await openDatabase(
        path,
        version: 1,
        onCreate: CreateDatabase,
      );
      return db;
    } catch (e) {
      rethrow;
    }
  }

  CreateDatabase(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys = ON');
    await db.execute("CREATE TABLE MyUsers (UserId INTEGER PRIMARY KEY , FullName TEXT NOT NULL , Phone TEXT , Email TEXT NOT NULL , Address TEXT , BirthDate TEXT , LoginPassword TEXT NOT NULL)");
    await db.execute("CREATE TABLE SocialPosts (postId INTEGER PRIMARY KEY AUTOINCREMENT, UserId INTEGER, IsUnknownPost BOOLEAN, Likes INTEGER, postDateTime TEXT, ScreenCaption TEXT, shirtId INTEGER, pantId INTEGER, outerwearId INTEGER, dressId INTEGER, swimWearId INTEGER, AccessoryId INTEGER, athleticWearId INTEGER, undergarmentId INTEGER, footWearId INTEGER, FOREIGN KEY (UserId) REFERENCES MyUsers(UserId) ON DELETE CASCADE, FOREIGN KEY (shirtId) REFERENCES Shirts(id) ON DELETE CASCADE, FOREIGN KEY (pantId) REFERENCES Pants(id) ON DELETE CASCADE, FOREIGN KEY (outerwearId) REFERENCES Outerwears(id) ON DELETE CASCADE, FOREIGN KEY (dressId) REFERENCES Dresses(id) ON DELETE CASCADE, FOREIGN KEY (swimWearId) REFERENCES SwimWear(id) ON DELETE CASCADE, FOREIGN KEY (AccessoryId) REFERENCES Accessory(id) ON DELETE CASCADE, FOREIGN KEY (athleticWearId) REFERENCES AthleticWear(id) ON DELETE CASCADE, FOREIGN KEY (undergarmentId) REFERENCES UnderGarment(id) ON DELETE CASCADE, FOREIGN KEY (footWearId) REFERENCES Footwear(id) ON DELETE CASCADE)");
    await db.execute('CREATE TABLE Shirts (id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER NOT NULL, subcategory TEXT NOT NULL, primaryColor TEXT NOT NULL, secondaryColor TEXT NOT NULL, size TEXT NOT NULL, fit TEXT NOT NULL, material TEXT NOT NULL, pattern TEXT NOT NULL, hasPockets BOOLEAN NOT NULL, numberOfPockets INTEGER NOT NULL, pocketStyle TEXT NOT NULL, detailingAccents TEXT NOT NULL, occasion TEXT NOT NULL, sleeveType TEXT NOT NULL, neckline TEXT NOT NULL, hemline TEXT NOT NULL, fabricWeight TEXT NOT NULL, collarType TEXT NOT NULL, season TEXT NOT NULL, sustainability TEXT NOT NULL, specialFeatures TEXT NOT NULL, careInstructions TEXT NOT NULL, FOREIGN KEY (userId) REFERENCES MyUsers(UserId) ON DELETE CASCADE)');
    await db.execute('CREATE TABLE Pants (id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER NOT NULL, subcategory TEXT NOT NULL, primaryColor TEXT NOT NULL, secondaryColor TEXT NOT NULL, fit TEXT NOT NULL, material TEXT NOT NULL, hasPockets BOOLEAN NOT NULL, numberOfPockets INTEGER NOT NULL, pocketStyle TEXT NOT NULL, occasion TEXT NOT NULL, waistType TEXT NOT NULL, legStyle TEXT NOT NULL, length TEXT NOT NULL, rise TEXT NOT NULL, fabricStretch TEXT NOT NULL, beltLoops BOOLEAN NOT NULL, fastening TEXT NOT NULL, season TEXT NOT NULL, sustainability TEXT NOT NULL, specialFeatures TEXT NOT NULL, careInstructions TEXT NOT NULL, FOREIGN KEY (userId) REFERENCES MyUsers(UserId) ON DELETE CASCADE)');
    await db.execute('CREATE TABLE Outerwears (id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER NOT NULL, primaryColor TEXT NOT NULL, secondaryColor TEXT NOT NULL, size TEXT NOT NULL, fit TEXT NOT NULL, material TEXT NOT NULL, pattern TEXT NOT NULL, hasPockets BOOLEAN NOT NULL, numberOfPockets INTEGER NOT NULL, pocketStyle TEXT NOT NULL, detailingAccents TEXT NOT NULL, occasion TEXT NOT NULL, sleeveType TEXT NOT NULL, neckline TEXT NOT NULL, hemline TEXT NOT NULL, closureType TEXT NOT NULL, weatherResistance TEXT NOT NULL, season TEXT NOT NULL, sustainability TEXT NOT NULL, specialFeatures TEXT NOT NULL, careInstructions TEXT NOT NULL, FOREIGN KEY (userId) REFERENCES MyUsers(UserId) ON DELETE CASCADE)');
    await db.execute('CREATE TABLE Dresses (id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER NOT NULL, subcategory TEXT NOT NULL, primaryColor TEXT NOT NULL, secondaryColor TEXT NOT NULL, size TEXT NOT NULL, fit TEXT NOT NULL, material TEXT NOT NULL, pattern TEXT, hasPockets INTEGER NOT NULL, numberOfPockets INTEGER NOT NULL, pocketStyle TEXT, occasion TEXT, sleeveType TEXT, neckline TEXT, hemline TEXT, fabricWeight TEXT, collarType TEXT, dressLength TEXT, skirtStyle TEXT, waistline TEXT, backDetails TEXT, season TEXT, sustainability TEXT, specialFeatures TEXT, careInstructions TEXT, FOREIGN KEY (userId) REFERENCES MyUsers(UserId) ON DELETE CASCADE);');
    await db.execute('CREATE TABLE Footwear (id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER NOT NULL, primaryColor TEXT NOT NULL, secondaryColor TEXT NOT NULL, occasion TEXT NOT NULL, size TEXT NOT NULL ,footwearType TEXT NOT NULL, heelHeight TEXT NOT NULL, toeShape TEXT NOT NULL, footwearMaterial TEXT NOT NULL, footwearFastening TEXT NOT NULL, soleType TEXT NOT NULL, isWaterResistant INTEGER NOT NULL CHECK (isWaterResistant IN (0, 1)), season TEXT NOT NULL, sustainability TEXT NOT NULL, careInstructions TEXT NOT NULL, FOREIGN KEY (userId) REFERENCES MyUsers(UserId) ON DELETE CASCADE);');
    await db.execute('CREATE TABLE Accessory (id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER NOT NULL, primaryColor TEXT NOT NULL, secondaryColor TEXT NOT NULL, occasion TEXT NOT NULL, accessoryType TEXT NOT NULL, accessoryMaterial TEXT NOT NULL, accessoryStyle TEXT NOT NULL, accessoryDimensions TEXT NOT NULL, accessoryClosure TEXT NOT NULL, accessoryCompartments INTEGER NOT NULL CHECK (accessoryCompartments IN (0, 1)), numberOfCompartments INTEGER NOT NULL, accessoryHardware TEXT NOT NULL, accessoryHeaviness TEXT NOT NULL, season TEXT NOT NULL, sustainability TEXT NOT NULL, careInstructions TEXT NOT NULL, FOREIGN KEY (userId) REFERENCES MyUsers(UserId) ON DELETE CASCADE);');
    await db.execute('CREATE TABLE UnderGarment (id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER NOT NULL, primaryColor TEXT NOT NULL, secondaryColor TEXT NOT NULL, size TEXT NOT NULL, lingerieType TEXT NOT NULL, supportType TEXT NOT NULL, padding TEXT NOT NULL, strapType TEXT NOT NULL, coverage TEXT NOT NULL, lingerieFabricType TEXT NOT NULL, waistbandStyle TEXT NOT NULL, patternDetails TEXT NOT NULL, season TEXT NOT NULL, sustainability TEXT NOT NULL, careInstructions TEXT NOT NULL, FOREIGN KEY (userId) REFERENCES MyUsers(UserId) ON DELETE CASCADE);');
    await db.execute('CREATE TABLE SwimWear (id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER NOT NULL, primaryColor TEXT NOT NULL, secondaryColor TEXT NOT NULL, size TEXT NOT NULL, swimwearType TEXT NOT NULL, swimwearSupportType TEXT NOT NULL, swimwearStrapType TEXT NOT NULL, swimwearCoverage TEXT NOT NULL, swimwearMaterial TEXT NOT NULL, swimwearFastening TEXT NOT NULL, season TEXT NOT NULL, sustainability TEXT NOT NULL, careInstructions TEXT NOT NULL, FOREIGN KEY (userId) REFERENCES MyUsers(UserId) ON DELETE CASCADE);');
    await db.execute('CREATE TABLE AthleticWear (id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER NOT NULL, primaryColor TEXT NOT NULL, secondaryColor TEXT NOT NULL, size TEXT NOT NULL, athleticwearType TEXT NOT NULL, athleticwearFitType TEXT NOT NULL, athleticwearBreathability TEXT NOT NULL, athleticwearWaistType TEXT NOT NULL, athleticwearMaterial TEXT NOT NULL, hasPockets INTEGER NOT NULL, numberOfPockets INTEGER NOT NULL, pocketStyle TEXT NOT NULL, season TEXT NOT NULL, sustainability TEXT NOT NULL, careInstructions TEXT NOT NULL, FOREIGN KEY (userId) REFERENCES MyUsers(UserId) ON DELETE CASCADE);');
  }

  Future<UsersModel> InsertUser(UsersModel user) async{
    var dbClient = await database;
    await dbClient?.insert('MyUsers', user.toMap());
    return user;
  }

  Future<List<UsersModel>> GetAllUsers() async {
    var dbClient = await database;  // Ensure _database is accessed via the async database getter
    if (dbClient == null) {
      print("Empty return");
      return [];
    }
    final List<Map<String, Object?>> result = await dbClient.rawQuery("SELECT * FROM MyUsers");
    return result.map((e) => UsersModel.fromMap(e)).toList();
  }

  Future<int> UpdateUser(UsersModel user) async{
    var dbClient = await database;
    return await dbClient!.update('MyUsers', user.toMap(),where: 'UserId = ?',whereArgs: [user.UserId]);
  }

  Future<int> DeleteUser(UsersModel user) async {
    var dbClient = await database;
    return await dbClient!.delete('MyUsers',where: 'UserId = ?',whereArgs: [user.UserId]);
  }

  Future<ClothingItem> InsertClothingItem(ClothingItem item) async {
    var dbClient = await database;
    await dbClient?.insert('ClothingItems', item.toMap(),conflictAlgorithm: ConflictAlgorithm.replace,);
    return item;
  }

  Future<List<ClothingItem>> getAllClothingItems() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning empty list.");
      return [];
    }
    final List<Map<String, Object?>> result = await dbClient.rawQuery("SELECT * FROM ClothingItems");
    return result.map((e) => ClothingItem.fromMap(e)).toList();
  }

  Future<int> updateClothingItem(ClothingItem item) async {
    var dbClient = await database;
    return await dbClient!.update(
      'ClothingItems',
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<int> deleteClothingItem(ClothingItem item) async {
    var dbClient = await database;
    return await dbClient!.delete(
      'ClothingItems',
      where: 'id = ?',
      whereArgs: [item.id],
    );
  }

  Future<PostItemModel> InsertPost(PostItemModel post) async {
    var dbClient = await database;
    await dbClient?.insert('SocialPosts', post.toMap());
    return post;
  }

  Future<List<PostItemModel>> GetAllPosts() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Empty return");
      return [];
    }
    final List<Map<String, Object?>> result = await dbClient.rawQuery("SELECT * FROM SocialPosts");
    return result.map((e) => PostItemModel.fromMap(e)).toList();
  }

  Future<int> UpdatePost(PostItemModel post) async {
    var dbClient = await database;
    return await dbClient!.update('SocialPosts', post.toMap(), where: 'postId = ?', whereArgs: [post.postId]);
  }

  Future<int> DeletePost(PostItemModel post) async {
    var dbClient = await database;
    return await dbClient!.delete('SocialPosts', where: 'postId = ?', whereArgs: [post.postId]);
  }

  Future<PostItemModel?> getPostItemById(int? id) async {
    var dbClient = await database; // Assume 'database' is your database instance
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null; // Return null if the database client is null
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
      "SELECT * FROM SocialPosts WHERE postId = ?",
      [id],
    );

    if (result.isNotEmpty) {
      return PostItemModel.fromMap(result.first); // Return the first matching item
    } else {
      return null; // Return null if no item is found
    }
  }

  Future<ClothingItem?> getClothingItemById(int? id) async {
    var dbClient = await database; // Assume 'database' is your database instance
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null; // Return null if the database client is null
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
      "SELECT * FROM ClothingItems WHERE id = ?",
      [id],
    );

    if (result.isNotEmpty) {
      return ClothingItem.fromMap(result.first); // Return the first matching item
    } else {
      return null; // Return null if no item is found
    }
  }

  Future<UsersModel?> getUserById(int? id) async {
    var dbClient = await database; // Assume 'database' is your database instance
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null; // Return null if the database client is null
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
      "SELECT * FROM MyUsers WHERE UserId = ?",
      [id],
    );

    if (result.isNotEmpty) {
      return UsersModel.fromMap(result.first); // Return the first matching item
    } else {
      return null; // Return null if no item is found
    }
  }

  Future<int?> getLastClothingItemId() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    // Execute the query to get the last item by ID
    final List<Map<String, Object?>> result = await dbClient.rawQuery(
        "SELECT id FROM ClothingItems ORDER BY id DESC LIMIT 1"
    );

    // Check if any results were returned and return the ID if available
    if (result.isNotEmpty) {
      return result.first['id'] as int?;
    } else {
      print("No items found, returning null.");
      return null;
    }
  }

  // Insert Shirt
  Future<ShirtModel> insertShirt(ShirtModel shirt) async {
    var dbClient = await database;
    await dbClient?.insert('Shirts', shirt.toMap());
    return shirt;
  }

  // Insert Pants
  Future<PantModel> insertPants(PantModel pants) async {
    var dbClient = await database;
    await dbClient?.insert('Pants', pants.toMap());
    return pants;
  }

  // Insert Outerwear
  Future<OuterWearModel> insertOuterwear(OuterWearModel outerwear) async {
    var dbClient = await database;
    await dbClient?.insert('Outerwears', outerwear.toMap());
    return outerwear;
  }

  // Insert Dress
  Future<DressModel> insertDress(DressModel dress) async {
    var dbClient = await database;
    await dbClient?.insert('Dresses', dress.toMap());
    return dress;
  }

  // Insert Footwear
  Future<FootwearModel> insertFootwear(FootwearModel footwear) async {
    var dbClient = await database;
    await dbClient?.insert('Footwear', footwear.toMap());
    return footwear;
  }

  // Insert Accessory
  Future<AccessoryModel> insertAccessory(AccessoryModel accessory) async {
    var dbClient = await database;
    await dbClient?.insert('Accessory', accessory.toMap());
    return accessory;
  }

  // Insert UnderGarment
  Future<UnderGarmentModel> insertUnderGarment(UnderGarmentModel undergarment) async {
    var dbClient = await database;
    await dbClient?.insert('UnderGarment', undergarment.toMap());
    return undergarment;
  }

  // Insert SwimWear
  Future<SwimWearModel> insertSwimWear(SwimWearModel swimwear) async {
    var dbClient = await database;
    await dbClient?.insert('SwimWear', swimwear.toMap());
    return swimwear;
  }

  // Insert AthleticWear
  Future<AthleticWearModel> insertAthleticWear(AthleticWearModel athleticWear) async {
    var dbClient = await database;
    await dbClient?.insert('AthleticWear', athleticWear.toMap());
    return athleticWear;
  }


  Future<List<ShirtModel>> getAllShirts() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Empty return");
      return [];
    }
    final List<Map<String, Object?>> result = await dbClient.rawQuery("SELECT * FROM Shirts");
    return result.map((e) => ShirtModel.fromMap(e)).toList();
  }

  Future<int> updateShirt(ShirtModel shirt) async {
    var dbClient = await database;
    return await dbClient!.update('Shirts', shirt.toMap(), where: 'id = ?', whereArgs: [shirt.id]);
  }

  Future<int> deleteShirt(ShirtModel shirt) async {
    var dbClient = await database;
    return await dbClient!.delete('Shirts', where: 'id = ?', whereArgs: [shirt.id]);
  }

  Future<List<PantModel>> getAllPants() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Empty return");
      return [];
    }
    final List<Map<String, Object?>> result = await dbClient.rawQuery("SELECT * FROM Pants");
    return result.map((e) => PantModel.fromMap(e)).toList();
  }

  Future<int> updatePants(PantModel pants) async {
    var dbClient = await database;
    return await dbClient!.update('Pants', pants.toMap(), where: 'id = ?', whereArgs: [pants.id]);
  }

  Future<int> deletePants(PantModel pants) async {
    var dbClient = await database;
    return await dbClient!.delete('Pants', where: 'id = ?', whereArgs: [pants.id]);
  }


  Future<List<OuterWearModel>> getAllOuterwear() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Empty return");
      return [];
    }
    final List<Map<String, Object?>> result = await dbClient.rawQuery("SELECT * FROM Outerwears");
    return result.map((e) => OuterWearModel.fromMap(e)).toList();
  }

  Future<int> updateOuterwear(OuterWearModel outerwear) async {
    var dbClient = await database;
    return await dbClient!.update('Outerwears', outerwear.toMap(), where: 'id = ?', whereArgs: [outerwear.id]);
  }

  Future<int> deleteOuterwear(OuterWearModel outerwear) async {
    var dbClient = await database;
    return await dbClient!.delete('Outerwears', where: 'id = ?', whereArgs: [outerwear.id]);
  }

  Future<List<DressModel>> getAllDresses() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Empty return");
      return [];
    }
    final List<Map<String, Object?>> result = await dbClient.rawQuery("SELECT * FROM Dresses");
    return result.map((e) => DressModel.fromMap(e)).toList();
  }

  Future<int> updateDress(DressModel dress) async {
    var dbClient = await database;
    return await dbClient!.update('Dresses', dress.toMap(), where: 'id = ?', whereArgs: [dress.id]);
  }

  Future<int> deleteDress(DressModel dress) async {
    var dbClient = await database;
    return await dbClient!.delete('Dresses', where: 'id = ?', whereArgs: [dress.id]);
  }

  Future<List<FootwearModel>> getAllFootwear() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Empty return");
      return [];
    }
    final List<Map<String, Object?>> result = await dbClient.rawQuery("SELECT * FROM Footwear");
    return result.map((e) => FootwearModel.fromMap(e)).toList();
  }

  Future<int> updateFootwear(FootwearModel footwear) async {
    var dbClient = await database;
    return await dbClient!.update('Footwear', footwear.toMap(), where: 'id = ?', whereArgs: [footwear.id]);
  }

  Future<int> deleteFootwear(FootwearModel footwear) async {
    var dbClient = await database;
    return await dbClient!.delete('Footwear', where: 'id = ?', whereArgs: [footwear.id]);
  }

  Future<List<AccessoryModel>> getAllAccessories() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Empty return");
      return [];
    }
    final List<Map<String, Object?>> result = await dbClient.rawQuery("SELECT * FROM Accessory");
    return result.map((e) => AccessoryModel.fromMap(e)).toList();
  }

  Future<int> updateAccessory(AccessoryModel accessory) async {
    var dbClient = await database;
    return await dbClient!.update('Accessory', accessory.toMap(), where: 'id = ?', whereArgs: [accessory.id]);
  }

  Future<int> deleteAccessory(AccessoryModel accessory) async {
    var dbClient = await database;
    return await dbClient!.delete('Accessory', where: 'id = ?', whereArgs: [accessory.id]);
  }

  Future<List<UnderGarmentModel>> getAllUnderGarments() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Empty return");
      return [];
    }
    final List<Map<String, Object?>> result = await dbClient.rawQuery("SELECT * FROM UnderGarment");
    return result.map((e) => UnderGarmentModel.fromMap(e)).toList();
  }

  Future<int> updateUnderGarment(UnderGarmentModel undergarment) async {
    var dbClient = await database;
    return await dbClient!.update('UnderGarment', undergarment.toMap(), where: 'id = ?', whereArgs: [undergarment.id]);
  }

  Future<int> deleteUnderGarment(UnderGarmentModel undergarment) async {
    var dbClient = await database;
    return await dbClient!.delete('UnderGarment', where: 'id = ?', whereArgs: [undergarment.id]);
  }

  Future<List<SwimWearModel>> getAllSwimWear() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Empty return");
      return [];
    }
    final List<Map<String, Object?>> result = await dbClient.rawQuery("SELECT * FROM SwimWear");
    return result.map((e) => SwimWearModel.fromMap(e)).toList();
  }

  Future<int> updateSwimWear(SwimWearModel swimwear) async {
    var dbClient = await database;
    return await dbClient!.update('SwimWear', swimwear.toMap(), where: 'id = ?', whereArgs: [swimwear.id]);
  }

  Future<int> deleteSwimWear(SwimWearModel swimwear) async {
    var dbClient = await database;
    return await dbClient!.delete('SwimWear', where: 'id = ?', whereArgs: [swimwear.id]);
  }

  Future<List<AthleticWearModel>> getAllAthleticWear() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Empty return");
      return [];
    }
    final List<Map<String, Object?>> result = await dbClient.rawQuery("SELECT * FROM AthleticWear");
    return result.map((e) => AthleticWearModel.fromMap(e)).toList();
  }

  Future<int> updateAthleticWear(AthleticWearModel athleticWear) async {
    var dbClient = await database;
    return await dbClient!.update('AthleticWear', athleticWear.toMap(), where: 'id = ?', whereArgs: [athleticWear.id]);
  }

  Future<int> deleteAthleticWear(AthleticWearModel athleticWear) async {
    var dbClient = await database;
    return await dbClient!.delete('AthleticWear', where: 'id = ?', whereArgs: [athleticWear.id]);
  }

  Future<ShirtModel?> getShirtItemById(int? id) async {
    var dbClient = await database; // Assume 'database' is your database instance
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null; // Return null if the database client is null
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
      "SELECT * FROM Shirts WHERE id = ?",
      [id],
    );

    if (result.isNotEmpty) {
      return ShirtModel.fromMap(result.first); // Return the first matching item
    } else {
      return null; // Return null if no item is found
    }
  }

  Future<int?> getLastShirtItemId() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    // Execute the query to get the last item by ID
    final List<Map<String, Object?>> result = await dbClient.rawQuery(
        "SELECT id FROM Shirts ORDER BY id DESC LIMIT 1"
    );

    // Check if any results were returned and return the ID if available
    if (result.isNotEmpty) {
      return result.first['id'] as int?;
    } else {
      print("No items found, returning null.");
      return null;
    }
  }

  Future<PantModel?> getPantsItemById(int? id) async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
      "SELECT * FROM Pants WHERE id = ?",
      [id],
    );

    if (result.isNotEmpty) {
      return PantModel.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int?> getLastPantsItemId() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
        "SELECT id FROM Pants ORDER BY id DESC LIMIT 1"
    );

    if (result.isNotEmpty) {
      return result.first['id'] as int?;
    } else {
      print("No items found, returning null.");
      return null;
    }
  }

  Future<OuterWearModel?> getOuterwearItemById(int? id) async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
      "SELECT * FROM Outerwears WHERE id = ?",
      [id],
    );

    if (result.isNotEmpty) {
      return OuterWearModel.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int?> getLastOuterwearItemId() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
        "SELECT id FROM Outerwears ORDER BY id DESC LIMIT 1"
    );

    if (result.isNotEmpty) {
      return result.first['id'] as int?;
    } else {
      print("No items found, returning null.");
      return null;
    }
  }

  Future<FootwearModel?> getFootwearItemById(int? id) async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
      "SELECT * FROM Footwear WHERE id = ?",
      [id],
    );

    if (result.isNotEmpty) {
      return FootwearModel.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int?> getLastFootwearItemId() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
        "SELECT id FROM Footwear ORDER BY id DESC LIMIT 1"
    );

    if (result.isNotEmpty) {
      return result.first['id'] as int?;
    } else {
      print("No items found, returning null.");
      return null;
    }
  }

  Future<DressModel?> getDressItemById(int? id) async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
      "SELECT * FROM Dresses WHERE id = ?",
      [id],
    );

    if (result.isNotEmpty) {
      return DressModel.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int?> getLastDressItemId() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
        "SELECT id FROM Dresses ORDER BY id DESC LIMIT 1"
    );

    if (result.isNotEmpty) {
      return result.first['id'] as int?;
    } else {
      print("No items found, returning null.");
      return null;
    }
  }

  Future<AccessoryModel?> getAccessoryItemById(int? id) async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
      "SELECT * FROM Accessory WHERE id = ?",
      [id],
    );

    if (result.isNotEmpty) {
      return AccessoryModel.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int?> getLastAccessoryItemId() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
        "SELECT id FROM Accessory ORDER BY id DESC LIMIT 1"
    );

    if (result.isNotEmpty) {
      return result.first['id'] as int?;
    } else {
      print("No items found, returning null.");
      return null;
    }
  }

  Future<UnderGarmentModel?> getUnderGarmentItemById(int? id) async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
      "SELECT * FROM UnderGarment WHERE id = ?",
      [id],
    );

    if (result.isNotEmpty) {
      return UnderGarmentModel.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int?> getLastUnderGarmentItemId() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
        "SELECT id FROM UnderGarment ORDER BY id DESC LIMIT 1"
    );

    if (result.isNotEmpty) {
      return result.first['id'] as int?;
    } else {
      print("No items found, returning null.");
      return null;
    }
  }

  Future<SwimWearModel?> getSwimWearItemById(int? id) async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
      "SELECT * FROM SwimWear WHERE id = ?",
      [id],
    );

    if (result.isNotEmpty) {
      return SwimWearModel.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int?> getLastSwimWearItemId() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
        "SELECT id FROM SwimWear ORDER BY id DESC LIMIT 1"
    );

    if (result.isNotEmpty) {
      return result.first['id'] as int?;
    } else {
      print("No items found, returning null.");
      return null;
    }
  }

  Future<AthleticWearModel?> getAthleticWearItemById(int? id) async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
      "SELECT * FROM AthleticWear WHERE id = ?",
      [id],
    );

    if (result.isNotEmpty) {
      return AthleticWearModel.fromMap(result.first);
    } else {
      return null;
    }
  }

  Future<int?> getLastAthleticWearItemId() async {
    var dbClient = await database;
    if (dbClient == null) {
      print("Database client is null, returning null.");
      return null;
    }

    final List<Map<String, Object?>> result = await dbClient.rawQuery(
        "SELECT id FROM AthleticWear ORDER BY id DESC LIMIT 1"
    );

    if (result.isNotEmpty) {
      return result.first['id'] as int?;
    } else {
      print("No items found, returning null.");
      return null;
    }
  }

}