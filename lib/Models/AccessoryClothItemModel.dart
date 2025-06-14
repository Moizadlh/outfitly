class AccessoryModel {
  int? id;
  int userId;
  String primaryColor;
  String secondaryColor;
  String occasion;
  String accessoryType;
  String accessoryMaterial;
  String accessoryStyle;
  String accessoryDimensions; // Length, Width, Depth
  String accessoryClosure;
  bool accessoryCompartments;
  int numberOfCompartments;
  String accessoryHardware;
  String accessoryHeaviness;
  String season;
  String sustainability;
  String careInstructions;

  // Constructor
  AccessoryModel({
    this.id,
    required this.userId,
    required this.primaryColor,
    required this.secondaryColor,
    required this.occasion,
    required this.accessoryType,
    required this.accessoryMaterial,
    required this.accessoryStyle,
    required this.accessoryDimensions,
    required this.accessoryClosure,
    required this.accessoryCompartments,
    required this.numberOfCompartments,
    required this.accessoryHardware,
    required this.accessoryHeaviness,
    required this.season,
    required this.sustainability,
    required this.careInstructions,
  });

  // fromMap constructor
  AccessoryModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        userId = res['userId'],
        primaryColor = res['primaryColor'],
        secondaryColor = res['secondaryColor'],
        occasion = res['occasion'],
        accessoryType = res['accessoryType'],
        accessoryMaterial = res['accessoryMaterial'],
        accessoryStyle = res['accessoryStyle'],
        accessoryDimensions = res['accessoryDimensions'],
        accessoryClosure = res['accessoryClosure'],
        accessoryCompartments = res['accessoryCompartments'] == 1, // Assuming it's stored as an int (1 for true, 0 for false)
        numberOfCompartments = res['numberOfCompartments'],
        accessoryHardware = res['accessoryHardware'],
        accessoryHeaviness = res['accessoryHeaviness'],
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
      'accessoryType': accessoryType,
      'accessoryMaterial': accessoryMaterial,
      'accessoryStyle': accessoryStyle,
      'accessoryDimensions': accessoryDimensions,
      'accessoryClosure': accessoryClosure,
      'accessoryCompartments': accessoryCompartments ? 1 : 0, // Convert boolean to int (1 or 0)
      'numberOfCompartments': numberOfCompartments,
      'accessoryHardware': accessoryHardware,
      'accessoryHeaviness': accessoryHeaviness,
      'season': season,
      'sustainability': sustainability,
      'careInstructions': careInstructions,
    };
  }
}
