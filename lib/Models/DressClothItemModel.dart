class DressModel {
  int? id;
  int userId;
  String subcategory;
  String primaryColor;
  String secondaryColor;
  String size;
  String fit;
  String material;
  String pattern;
  bool hasPockets;
  int numberOfPockets;
  String pocketStyle;
  String occasion;
  String sleeveType;
  String neckline;
  String hemline;
  String fabricWeight;
  String collarType;
  String dressLength;
  String skirtStyle;
  String waistline;
  String backDetails;
  String season;
  String sustainability;
  String specialFeatures;
  String careInstructions;

  // Constructor
  DressModel({
    this.id,
    required this.userId,
    required this.subcategory,
    required this.primaryColor,
    required this.secondaryColor,
    required this.size,
    required this.fit,
    required this.material,
    required this.pattern,
    required this.hasPockets,
    required this.numberOfPockets,
    required this.pocketStyle,
    required this.occasion,
    required this.sleeveType,
    required this.neckline,
    required this.hemline,
    required this.fabricWeight,
    required this.collarType,
    required this.dressLength,
    required this.skirtStyle,
    required this.waistline,
    required this.backDetails,
    required this.season,
    required this.sustainability,
    required this.specialFeatures,
    required this.careInstructions,
  });

  // fromMap constructor
  DressModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        userId = res['userId'],
        subcategory = res['subcategory'],
        primaryColor = res['primaryColor'],
        secondaryColor = res['secondaryColor'],
        size = res['size'],
        fit = res['fit'],
        material = res['material'],
        pattern = res['pattern'],
        hasPockets = res['hasPockets'] == 1, // Assuming it's stored as an int (1 for true, 0 for false)
        numberOfPockets = res['numberOfPockets'],
        pocketStyle = res['pocketStyle'],
        occasion = res['occasion'],
        sleeveType = res['sleeveType'],
        neckline = res['neckline'],
        hemline = res['hemline'],
        fabricWeight = res['fabricWeight'],
        collarType = res['collarType'],
        dressLength = res['dressLength'],
        skirtStyle = res['skirtStyle'],
        waistline = res['waistline'],
        backDetails = res['backDetails'],
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
      'size': size,
      'fit': fit,
      'material': material,
      'pattern': pattern,
      'hasPockets': hasPockets ? 1 : 0, // Convert boolean to int (1 or 0)
      'numberOfPockets': numberOfPockets,
      'pocketStyle': pocketStyle,
      'occasion': occasion,
      'sleeveType': sleeveType,
      'neckline': neckline,
      'hemline': hemline,
      'fabricWeight': fabricWeight,
      'collarType': collarType,
      'dressLength': dressLength,
      'skirtStyle': skirtStyle,
      'waistline': waistline,
      'backDetails': backDetails,
      'season': season,
      'sustainability': sustainability,
      'specialFeatures': specialFeatures,
      'careInstructions': careInstructions,
    };
  }
}
