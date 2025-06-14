class AthleticWearModel {
  int? id;
  int userId;
  String primaryColor;
  String secondaryColor;
  String size;
  String athleticwearType;
  String athleticwearFitType;
  String athleticwearBreathability;
  String athleticwearWaistType;
  String athleticwearMaterial;
  bool hasPockets;
  int numberOfPockets;
  String pocketStyle;
  String season;
  String sustainability;
  String careInstructions;

  // Constructor
  AthleticWearModel({
    this.id,
    required this.userId,
    required this.primaryColor,
    required this.secondaryColor,
    required this.size,
    required this.athleticwearType,
    required this.athleticwearFitType,
    required this.athleticwearBreathability,
    required this.athleticwearWaistType,
    required this.athleticwearMaterial,
    required this.hasPockets,
    required this.numberOfPockets,
    required this.pocketStyle,
    required this.season,
    required this.sustainability,
    required this.careInstructions,
  });

  // fromMap constructor
  AthleticWearModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        userId = res['userId'],
        primaryColor = res['primaryColor'],
        secondaryColor = res['secondaryColor'],
        size = res['size'],
        athleticwearType = res['athleticwearType'],
        athleticwearFitType = res['athleticwearFitType'],
        athleticwearBreathability = res['athleticwearBreathability'],
        athleticwearWaistType = res['athleticwearWaistType'],
        athleticwearMaterial = res['athleticwearMaterial'],
        hasPockets = res['hasPockets'] == 1, // Convert int to boolean
        numberOfPockets = res['numberOfPockets'],
        pocketStyle = res['pocketStyle'],
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
      'size': size,
      'athleticwearType': athleticwearType,
      'athleticwearFitType': athleticwearFitType,
      'athleticwearBreathability': athleticwearBreathability,
      'athleticwearWaistType': athleticwearWaistType,
      'athleticwearMaterial': athleticwearMaterial,
      'hasPockets': hasPockets ? 1 : 0, // Convert boolean to int
      'numberOfPockets': numberOfPockets,
      'pocketStyle': pocketStyle,
      'season': season,
      'sustainability': sustainability,
      'careInstructions': careInstructions,
    };
  }
}
