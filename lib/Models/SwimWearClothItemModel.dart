class SwimWearModel {
  int? id;
  int userId;
  String primaryColor;
  String secondaryColor;
  String size;
  String swimwearType;
  String swimwearSupportType; // Corrected property name
  String swimwearStrapType; // Corrected property name
  String swimwearCoverage; // Corrected property name
  String swimwearMaterial; // Corrected property name
  String swimwearFastening; // Corrected property name
  String season;
  String sustainability;
  String careInstructions;

  // Constructor
  SwimWearModel({
    this.id,
    required this.userId,
    required this.primaryColor,
    required this.secondaryColor,
    required this.size,
    required this.swimwearType,
    required this.swimwearSupportType,
    required this.swimwearStrapType,
    required this.swimwearCoverage,
    required this.swimwearMaterial,
    required this.swimwearFastening,
    required this.season,
    required this.sustainability,
    required this.careInstructions,
  });

  // fromMap constructor
  SwimWearModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        userId = res['userId'],
        primaryColor = res['primaryColor'],
        secondaryColor = res['secondaryColor'],
        size = res['size'],
        swimwearType = res['swimwearType'],
        swimwearSupportType = res['swimwearSupportType'],
        swimwearStrapType = res['swimwearStrapType'],
        swimwearCoverage = res['swimwearCoverage'],
        swimwearMaterial = res['swimwearMaterial'],
        swimwearFastening = res['swimwearFastening'],
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
      'swimwearType': swimwearType,
      'swimwearSupportType': swimwearSupportType,
      'swimwearStrapType': swimwearStrapType,
      'swimwearCoverage': swimwearCoverage,
      'swimwearMaterial': swimwearMaterial,
      'swimwearFastening': swimwearFastening,
      'season': season,
      'sustainability': sustainability,
      'careInstructions': careInstructions,
    };
  }
}
