class ClothingItem {
  int? id;
  int userId;
  String category;
  String? subcategory;
  String primaryColor;
  String? secondaryColor;
  String? size;
  String? fit;
  String? material;
  String? pattern;
  bool hasPockets;
  int? numberOfPockets;
  String? pocketStyle;
  List<String>? detailingAccents; // Store multiple detailing styles
  String? occasion;

  // Fields for tops
  String? sleeveType;
  String? neckline;
  String? hemline;
  String? closureType;
  String? fabricWeight;
  String? collarType;

  // Fields for bottoms
  String? waistType;
  String? legStyle;
  String? length;
  String? rise;
  String? fabricStretch;
  bool beltLoops;
  String? fastening;

  // Fields for outerwear
  String? weatherResistance;

  // Fields for dresses
  String? dressLength;
  String? skirtStyle;
  String? waistline;
  String? backDetails;
  String? fabricFlow;

  // Fields for footwear
  String? footwearType;
  String? heelHeight;
  String? toeShape;
  String? footwearMaterial;
  String? footwearFastening;
  String? soleType;
  bool isWaterResistant;

  // Fields for accessories
  String? accessoryType;
  String? accessoryMaterial;
  String? accessoryStyle;
  String? accessoryDimensions; // Length, Width, Depth
  String? accessoryClosure;
  bool accessoryCompartments;
  final String? accessoryHardware;
  final double? accessoryWeight;

  // Fields for lingerie
  String? lingerieType;
  String? supportType;
  String? padding;
  String? strapType;
  String? coverage;
  String? lingerieFabricType;
  String? waistbandStyle; // fixed typo: 'wabandStyle' -> 'waistbandStyle'
  String? patternDetails;

  // Fields for seasonal and sustainability details
  String? season;
  bool isEcoFriendly;
  String? specialFeatures;
  String? careInstructions;

  String? swimwearType; // Holds the selected swimwear type
  String? swimwearsupportType; // Holds the selected support type
  String? swimwearstrapType; // Holds the selected strap type
  String? swimwearcoverage; // Holds the selected coverage type
  String? swimwearmaterial; // Holds the selected material type
  String? swimwearfastening;

  ClothingItem({
    this.id,
    required this.userId,
    required this.category,
    this.subcategory,
    required this.primaryColor,
    this.secondaryColor,
    this.size,
    this.fit,
    this.material,
    this.pattern,
    required this.hasPockets,
    this.numberOfPockets,
    this.pocketStyle,
    this.detailingAccents,
    this.occasion,
    this.sleeveType,
    this.neckline,
    this.length,
    this.hemline,
    this.closureType,
    this.fabricWeight,
    this.collarType,
    this.waistType,
    this.legStyle,
    this.rise,
    this.fabricStretch,
    this.beltLoops = false,
    this.fastening,
    this.weatherResistance,
    this.dressLength,
    this.skirtStyle,
    this.waistline,
    this.backDetails,
    this.fabricFlow,
    this.footwearType,
    this.heelHeight,
    this.toeShape,
    this.footwearMaterial,
    this.footwearFastening,
    this.soleType,
    this.isWaterResistant = false,
    this.accessoryType,
    this.accessoryMaterial,
    this.accessoryStyle,
    this.accessoryDimensions,
    this.accessoryClosure,
    this.accessoryCompartments = false,
    this.accessoryHardware = '',
    this.accessoryWeight = 0.0,
    this.lingerieType,
    this.supportType,
    this.padding,
    this.strapType,
    this.coverage,
    this.lingerieFabricType,
    this.waistbandStyle,
    this.patternDetails,
    this.season,
    this.isEcoFriendly = false,
    this.specialFeatures,
    this.careInstructions,
    this.swimwearType,
    this.swimwearcoverage,
    this.swimwearfastening,
    this.swimwearmaterial,
    this.swimwearstrapType,
    this.swimwearsupportType,
  });

  // Convert the ClothingItem to a Map
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'UserId':userId,
      'category': category,
      'subcategory': subcategory,
      'primaryColor': primaryColor,
      'secondaryColor': secondaryColor,
      'size': size,
      'fit': fit,
      'material': material,
      'pattern': pattern,
      'hasPockets': hasPockets ? 1 : 0,
      'numberOfPockets': numberOfPockets,
      'pocketStyle': pocketStyle,
      'detailingAccents': detailingAccents,
      'occasion': occasion,
      'sleeveType': sleeveType,
      'neckline': neckline,
      'length': length,
      'hemline': hemline,
      'closureType': closureType,
      'fabricWeight': fabricWeight,
      'collarType': collarType,
      'waistType': waistType,
      'legStyle': legStyle,
      'rise': rise,
      'fabricStretch': fabricStretch,
      'beltLoops': beltLoops ? 1 : 0,
      'fastening': fastening,
      'weatherResistance': weatherResistance,
      'dressLength': dressLength,
      'skirtStyle': skirtStyle,
      'waistline': waistline,
      'backDetails': backDetails,
      'fabricFlow': fabricFlow,
      'footwearType': footwearType,
      'heelHeight': heelHeight,
      'toeShape': toeShape,
      'footwearMaterial': footwearMaterial,
      'footwearFastening': footwearFastening,
      'soleType': soleType,
      'isWaterResistant': isWaterResistant ? 1 : 0,
      'accessoryType': accessoryType,
      'accessoryMaterial': accessoryMaterial,
      'accessoryStyle': accessoryStyle,
      'accessoryDimensions': accessoryDimensions,
      'accessoryClosure': accessoryClosure,
      'accessoryCompartments': accessoryCompartments ? 1 : 0,
      'accessoryHardware': accessoryHardware,
      'accessoryWeight': accessoryWeight,
      'lingerieType': lingerieType,
      'supportType': supportType,
      'padding': padding,
      'strapType': strapType,
      'coverage': coverage,
      'lingerieFabricType': lingerieFabricType,
      'waistbandStyle': waistbandStyle,
      'patternDetails': patternDetails,
      'season': season,
      'isEcoFriendly': isEcoFriendly ? 1 : 0,
      'specialFeatures': specialFeatures,
      'careInstructions': careInstructions,
    };
  }

  // Create a ClothingItem from a Map
  ClothingItem.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        userId = res['UserId'],
        category = res['category'],
        subcategory = res['subcategory'],
        primaryColor = res['primaryColor'],
        secondaryColor = res['secondaryColor'],
        size = res['size'],
        fit = res['fit'],
        material = res['material'],
        pattern = res['pattern'],
        hasPockets = res['hasPockets'] == 1,
        numberOfPockets = res['numberOfPockets'],
        pocketStyle = res['pocketStyle'],
        detailingAccents = List<String>.from(res['detailingAccents'] ?? []),
        occasion = res['occasion'],
        sleeveType = res['sleeveType'],
        neckline = res['neckline'],
        length = res['length'],
        hemline = res['hemline'],
        closureType = res['closureType'],
        fabricWeight = res['fabricWeight'],
        collarType = res['collarType'],
        waistType = res['waistType'],
        legStyle = res['legStyle'],
        rise = res['rise'],
        fabricStretch = res['fabricStretch'],
        beltLoops = res['beltLoops'] == 1,
        fastening = res['fastening'],
        weatherResistance = res['weatherResistance'],
        dressLength = res['dressLength'],
        skirtStyle = res['skirtStyle'],
        waistline = res['waistline'],
        backDetails = res['backDetails'],
        fabricFlow = res['fabricFlow'],
        footwearType = res['footwearType'],
        heelHeight = res['heelHeight'],
        toeShape = res['toeShape'],
        footwearMaterial = res['footwearMaterial'],
        footwearFastening = res['footwearFastening'],
        soleType = res['soleType'],
        isWaterResistant = res['isWaterResistant'] == 1,
        accessoryType = res['accessoryType'],
        accessoryMaterial = res['accessoryMaterial'],
        accessoryStyle = res['accessoryStyle'],
        accessoryDimensions = res['accessoryDimensions'],
        accessoryClosure = res['accessoryClosure'],
        accessoryCompartments = res['accessoryCompartments'] == 1,
        accessoryHardware = res['accessoryHardware'],
        accessoryWeight = res['accessoryWeight'],
        lingerieType = res['lingerieType'],
        supportType = res['supportType'],
        padding = res['padding'],
        strapType = res['strapType'],
        coverage = res['coverage'],
        lingerieFabricType = res['lingerieFabricType'],
        waistbandStyle = res['waistbandStyle'],
        patternDetails = res['patternDetails'],
        season = res['season'],
        isEcoFriendly = res['isEcoFriendly'] == 1,
        specialFeatures = res['specialFeatures'],
        careInstructions = res['careInstructions'];
}
