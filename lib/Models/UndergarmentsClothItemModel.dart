class UnderGarmentModel {
  int? id;
  int userId;
  String primaryColor;
  String secondaryColor;
  String size;
  String lingerieType;
  String supportType;
  String padding;
  String strapType;
  String coverage;
  String lingerieFabricType;
  String waistbandStyle;
  String patternDetails;
  String season;
  String sustainability;
  String careInstructions;

  // Constructor
  UnderGarmentModel({
    this.id,
    required this.userId,
    required this.primaryColor,
    required this.secondaryColor,
    required this.size,
    required this.lingerieType,
    required this.supportType,
    required this.padding,
    required this.strapType,
    required this.coverage,
    required this.lingerieFabricType,
    required this.waistbandStyle,
    required this.patternDetails,
    required this.season,
    required this.sustainability,
    required this.careInstructions,
  });

  // fromMap constructor
  UnderGarmentModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        userId = res['userId'],
        primaryColor = res['primaryColor'],
        secondaryColor = res['secondaryColor'],
        size = res['size'],
        lingerieType = res['lingerieType'],
        supportType = res['supportType'],
        padding = res['padding'],
        strapType = res['strapType'],
        coverage = res['coverage'],
        lingerieFabricType = res['lingerieFabricType'],
        waistbandStyle = res['waistbandStyle'],
        patternDetails = res['patternDetails'],
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
      'lingerieType': lingerieType,
      'supportType': supportType,
      'padding': padding,
      'strapType': strapType,
      'coverage': coverage,
      'lingerieFabricType': lingerieFabricType,
      'waistbandStyle': waistbandStyle,
      'patternDetails': patternDetails,
      'season': season,
      'sustainability': sustainability,
      'careInstructions': careInstructions,
    };
  }
}
