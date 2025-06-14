class PantModel {
  int? id;
  int userId;
  String subcategory;
  String primaryColor;
  String secondaryColor;
  String fit;
  String material;
  bool hasPockets;
  int numberOfPockets;
  String pocketStyle;
  String occasion;
  String waistType;
  String legStyle;
  String length;
  String rise;
  String fabricStretch;
  bool beltLoops;
  String fastening;
  String season;
  String sustainability;
  String specialFeatures;
  String careInstructions;

  // Constructor
  PantModel({
    this.id,
    required this.userId,
    required this.subcategory,
    required this.primaryColor,
    required this.secondaryColor,
    required this.fit,
    required this.material,
    required this.hasPockets,
    required this.numberOfPockets,
    required this.pocketStyle,
    required this.occasion,
    required this.waistType,
    required this.legStyle,
    required this.length,
    required this.rise,
    required this.fabricStretch,
    required this.beltLoops,
    required this.fastening,
    required this.season,
    required this.sustainability,
    required this.specialFeatures,
    required this.careInstructions,
  });

  // fromMap constructor
  PantModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        userId = res['userId'],
        subcategory = res['subcategory'],
        primaryColor = res['primaryColor'],
        secondaryColor = res['secondaryColor'],
        fit = res['fit'],
        material = res['material'],
        hasPockets = res['hasPockets'] == 1, // Assuming it's stored as an int (1 for true, 0 for false)
        numberOfPockets = res['numberOfPockets'],
        pocketStyle = res['pocketStyle'],
        occasion = res['occasion'],
        waistType = res['waistType'],
        legStyle = res['legStyle'],
        length = res['length'],
        rise = res['rise'],
        fabricStretch = res['fabricStretch'],
        beltLoops = res['beltLoops'] == 1, // Assuming it's stored as an int (1 for true, 0 for false)
        fastening = res['fastening'],
        season = res['season'],
        sustainability = res['sustainability'],
        specialFeatures = res['specialFeatures'],
        careInstructions = res['careInstructions'];

  // toMap method
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'userId': userId,
      'subcategory': subcategory,
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
      'fit': fit,
      'material': material,
      'hasPockets': hasPockets ? 1 : 0, // Convert boolean to int (1 or 0)
      'numberOfPockets': numberOfPockets,
      'pocketStyle': pocketStyle,
      'occasion': occasion,
      'waistType': waistType,
      'legStyle': legStyle,
      'length': length,
      'rise': rise,
      'fabricStretch': fabricStretch,
      'beltLoops': beltLoops ? 1 : 0, // Convert boolean to int (1 or 0)
      'fastening': fastening,
      'season': season,
      'sustainability': sustainability,
      'specialFeatures': specialFeatures,
      'careInstructions': careInstructions,
    };
  }
}
