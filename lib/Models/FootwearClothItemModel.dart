class FootwearModel {
  int? id;
  int userId;
  String primaryColor;
  String secondaryColor;
  String occasion;
  String size;
  String footwearType;
  String heelHeight;
  String toeShape;
  String footwearMaterial;
  String footwearFastening;
  String soleType;
  bool isWaterResistant;
  String season;
  String sustainability;
  String careInstructions;

  // Constructor
  FootwearModel({
    this.id,
    required this.userId,
    required this.primaryColor,
    required this.secondaryColor,
    required this.occasion,
    required this.size,
    required this.footwearType,
    required this.heelHeight,
    required this.toeShape,
    required this.footwearMaterial,
    required this.footwearFastening,
    required this.soleType,
    required this.isWaterResistant,
    required this.season,
    required this.sustainability,
    required this.careInstructions,
  });

  // fromMap constructor
  FootwearModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        userId = res['userId'],
        primaryColor = res['primaryColor'],
        secondaryColor = res['secondaryColor'],
        occasion = res['occasion'],
        size = res['size'],
        footwearType = res['footwearType'],
        heelHeight = res['heelHeight'],
        toeShape = res['toeShape'],
        footwearMaterial = res['footwearMaterial'],
        footwearFastening = res['footwearFastening'],
        soleType = res['soleType'],
        isWaterResistant = res['isWaterResistant'] == 1, // Assuming it's stored as an int (1 for true, 0 for false)
        season = res['season'],
        sustainability = res['sustainability'],
        careInstructions = res['careInstructions'];

  // toMap method
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'userId': userId,
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
      'occasion': occasion,
      'size':size,
      'footwearType': footwearType,
      'heelHeight': heelHeight,
      'toeShape': toeShape,
      'footwearMaterial': footwearMaterial,
      'footwearFastening': footwearFastening,
      'soleType': soleType,
      'isWaterResistant': isWaterResistant ? 1 : 0, // Convert boolean to int (1 or 0)
      'season': season,
      'sustainability': sustainability,
      'careInstructions': careInstructions,
    };
  }
}
