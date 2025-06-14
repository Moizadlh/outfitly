import 'package:flutter/material.dart';
import 'package:outfitly/DatabaseContext/DbContext.dart';
import 'package:outfitly/Models/AccessoryClothItemModel.dart';
import 'package:outfitly/Models/AthleticWearClothItemModel.dart';
import 'package:outfitly/Models/ClothingCommonModel.dart';
import 'package:outfitly/Models/ClothingItemModel.dart';
import 'package:outfitly/Models/DressClothItemModel.dart';
import 'package:outfitly/Models/FootwearClothItemModel.dart';
import 'package:outfitly/Models/OutWearClothItemModel.dart';
import 'package:outfitly/Models/PantClothItemModel.dart';
import 'package:outfitly/Models/ShirtClothItemModel.dart';
import 'package:outfitly/Models/SwimWearClothItemModel.dart';
import 'package:outfitly/Models/UndergarmentsClothItemModel.dart';

class AddEditClosetScreen extends StatefulWidget {
  final ClothingItem? item;
  final ClothingItemModel? clothingItem;
  final int? userId;
  final Function(dynamic) onSave;

  const AddEditClosetScreen({Key? key, this.item,this.clothingItem, required this.onSave,required this.userId}) : super(key: key);

  @override
  _AddEditClosetScreenState createState() => _AddEditClosetScreenState();
}

class _AddEditClosetScreenState extends State<AddEditClosetScreen> {
  final _formKey = GlobalKey<FormState>();
  late dynamic categoryItem;
  DbContext? _dbContext;
  bool IsDataLoaded = false;

  String? _category;
  String? _subcategory;
  String _primaryColor = '';
  String? _secondaryColor;
  String? _size = '';
  String? _fit = '';
  String? _material = '';
  String? _pattern = '';
  bool _hasPockets = false;
  int? _numberOfPockets = 0;
  String? _pocketStyle = '';
  List<String>? _detailingAccents = [];
  String? _occasion = '';

  // For tops
  String? _sleeveType;
  String? _neckline;
  String? _hemline;
  String? _closureType;
  String? _collarType;
  String? _fabricWeight;

  // Fields for Pants
  String? _pantlength;
  String? _waistSize;
  String? _legStyle;
  String? _rise;
  String? _fabricStretch;
  bool _beltLoops = false;
  String? _fastening;

  // Fields for outerwear
  String? _weatherResistance;

  // Fields for Dresses
  String? _dressLength;
  String? _skirtStyle;
  String? _waistline;
  String? _backDetails;

  // ForShoes
  String? _footwearType;
  String? _toeShape;
  String? _footwearmaterial;
  String? _footwearfastening;
  String? _soleType;
  String? _heelHeight;
  bool _isWaterResistant = false;

  // Fields for Accessories
  String? _accessoryDimensions;
  String? _accessoryType; // Holds the selected accessory type
  String? _closure; // Holds the selected closure type
  String? _accessoryMaterial; // Holds the selected material type
  String _style = ''; // Holds the style input
  bool _hasCompartments = false;
  int? _numberOfCompartments = 0;
  String _hardware = ''; // Holds the hardware input
  String? _accessoryweight;// For accessories

  // For Lingerie
  String? _lingerieType; // Holds the selected lingerie type
  String? _lingerieSupportType; // Holds the selected support type
  String? _lingeriePadding; // Holds the selected padding type
  String? _lingerieStrapType; // Holds the selected strap type
  String? _lingerieCoverage; // Holds the selected coverage type
  String? _lingerieFabricType; // Holds the selected fabric type
  String? _lingerieWaistbandStyle; // Holds the selected waistband style
  String? _lingeriePatternDetails;

  // For SWIMWEAR
  String? swimwearType;
  String? swimwearSupportType;
  String? swimwearStrapType;
  String? swimwearCoverage;
  String? swimwearMaterial;
  String? swimwearFastening;

  // For AthleteWEAR
  String? _athleticWearType;
  String? _athleticWearFit;
  String? _athleticWearFabric;
  String? _athleticWearBreathability;
  String? _athleticWearWaistType;


  String? _season;
  String? _sustainability;
  String? _specialFeatures;
  String? _careInstructions;


  @override
  void initState() {
    super.initState();
    _dbContext = DbContext();
    categoryItemInitializtion();
    // _populateFields(widget.item);
  }

  void _populateFields(ClothingItem? item) {
    if ( item != null ){
    _category = item.category;
    _subcategory = item.subcategory;
    _primaryColor = item.primaryColor;
    _secondaryColor = item.secondaryColor;
    _size = item.size;
    _fit = item.fit;
    _material = item.material;
    _pattern = item.pattern;
    _hasPockets = item.hasPockets;
    _numberOfPockets = item.numberOfPockets;
    _pocketStyle = item.pocketStyle;
    _detailingAccents = item.detailingAccents;
    _occasion = item.occasion;
    _sleeveType = item.sleeveType;
    _neckline = item.neckline;
    _pantlength = item.length; // For pants
    _waistSize = item.waistline; // For pants
    _dressLength = item.dressLength; // For dresses
    _accessoryDimensions = item.accessoryDimensions;// For accessories
    // _fabricType = item.fabricType;
    }
    else{
      _primaryColor = 'Red';
      _size = 'S';
      _fit = 'Regular';
      _material = 'Cotton';
      _pattern = 'Solid';
      _pocketStyle = '';
      _occasion = 'Casual';
    }
  }

  void categoryItemInitializtion(){
    if(widget.clothingItem != null){
      var item = widget.clothingItem;
      if(item!.shirt != null){
        print(item.shirt);
        categoryItem = item.shirt;
        print(categoryItem);
        _category = 'Shirt';
        _subcategory = categoryItem.subcategory;
        _primaryColor = categoryItem.primaryColor;
        _secondaryColor = categoryItem.secondaryColor;
        _size = categoryItem.size;
        _fit = categoryItem.fit;
        _material = categoryItem.material;
        _pattern = categoryItem.pattern;
        _hasPockets = categoryItem.hasPockets;
        _numberOfPockets = categoryItem.numberOfPockets;
        _pocketStyle = categoryItem.pocketStyle;
        _detailingAccents = categoryItem.detailingAccents;
        _occasion = categoryItem.occasion;
        _sleeveType = categoryItem.sleeveType;
        _neckline = categoryItem.neckline;
        _hemline = categoryItem.hemline;
        _fabricWeight = categoryItem.fabricWeight;
        _collarType = categoryItem.collarType;
        _season = categoryItem.season;
        _sustainability = categoryItem.sustainability;
        _specialFeatures = categoryItem.specialFeatures;
        _careInstructions = categoryItem.careInstructions;
      }
      else if(item.pant != null){
        categoryItem = item.pant;
        _category = 'Pants';
        _subcategory = categoryItem.subcategory;
        _primaryColor = categoryItem.primaryColor;
        _secondaryColor = categoryItem.secondaryColor;
        // _size = categoryItem.size;
        _fit = categoryItem.fit;
        _material = categoryItem.material;
        // _pattern = categoryItem.pattern;
        _hasPockets = categoryItem.hasPockets;
        _numberOfPockets = categoryItem.numberOfPockets;
        _pocketStyle = categoryItem.pocketStyle;
        _occasion = categoryItem.occasion;
        _waistSize = categoryItem.waistType;
        _legStyle = categoryItem.legStyle;
        _pantlength = categoryItem.length;
        _rise = categoryItem.rise;
        _fabricStretch = categoryItem.fabricStretch;
        _beltLoops = categoryItem.beltLoops;
        _fastening = categoryItem.fastening;
        _season = categoryItem.season;
        _sustainability = categoryItem.sustainability;
        _specialFeatures = categoryItem.specialFeatures;
        _careInstructions = categoryItem.careInstructions;
      }
      else if(item.outerWear != null){
        categoryItem = item.outerWear;
        _category = 'OuterWear';
        _primaryColor = categoryItem.primaryColor;
        _secondaryColor = categoryItem.secondaryColor;
        _size = categoryItem.size;
        _fit = categoryItem.fit;
        _material = categoryItem.material;
        _pattern = categoryItem.pattern;
        _hasPockets = categoryItem.hasPockets;
        _numberOfPockets = categoryItem.numberOfPockets;
        _pocketStyle = categoryItem.pocketStyle;
        _detailingAccents = categoryItem.detailingAccents;
        _occasion = categoryItem.occasion;
        _sleeveType = categoryItem.sleeveType;
        _neckline = categoryItem.neckline;
        _hemline = categoryItem.hemline;
        _closureType = categoryItem.closureType;
        _weatherResistance = categoryItem.weatherResistance;
        _season = categoryItem.season;
        _sustainability = categoryItem.sustainability;
        _specialFeatures = categoryItem.specialFeatures;
        _careInstructions = categoryItem.careInstructions;
      }
      else if(item.footWear != null){
        categoryItem = item.footWear;
        _category = 'Shoes';
        _primaryColor = categoryItem.primaryColor;
        _secondaryColor = categoryItem.secondaryColor;
        _size = categoryItem.size;
        _occasion = categoryItem.occasion;
        _footwearType = categoryItem.footwearType;
        _toeShape = categoryItem.toeShape;
        _footwearmaterial = categoryItem.footwearMaterial;
        _footwearfastening = categoryItem.footwearFastening;
        _heelHeight = categoryItem.heelHeight;
        _soleType = categoryItem.soleType;
        _isWaterResistant = categoryItem.isWaterResistant;
        _season = categoryItem.season;
        _sustainability = categoryItem.sustainability;
        _careInstructions = categoryItem.careInstructions;
      }
      else if(item.dress != null){
        categoryItem = item.dress;
        _category = 'Dress';
        _subcategory = categoryItem.subcategory;
        _primaryColor = categoryItem.primaryColor;
        _secondaryColor = categoryItem.secondaryColor;
        _size = categoryItem.size;
        _fit = categoryItem.fit;
        _material = categoryItem.material;
        _pattern = categoryItem.pattern;
        _hasPockets = categoryItem.hasPockets;
        _numberOfPockets = categoryItem.numberOfPockets;
        _pocketStyle = categoryItem.pocketStyle;
        // _detailingAccents = categoryItem.detailingAccents;
        _occasion = categoryItem.occasion;
        _sleeveType = categoryItem.sleeveType;
        _neckline = categoryItem.neckline;
        _hemline = categoryItem.hemline;
        _fabricWeight = categoryItem.fabricWeight;
        _collarType = categoryItem.collarType;
        _dressLength = categoryItem.dressLength;
        _skirtStyle = categoryItem.skirtStyle;
        _waistline = categoryItem.waistline;
        _backDetails = categoryItem.backDetails;
        _season = categoryItem.season;
        _sustainability = categoryItem.sustainability;
        _specialFeatures = categoryItem.specialFeatures;
        _careInstructions = categoryItem.careInstructions;
      }
      else if(item.accessory != null){
        categoryItem = item.accessory;
        _category = 'Accessory';
        _primaryColor = categoryItem.primaryColor;
        _secondaryColor = categoryItem.secondaryColor;
        _occasion = categoryItem.occasion;
        _accessoryType = categoryItem.accessoryType;
        _accessoryMaterial = categoryItem.accessoryMaterial;
        _style = categoryItem.accessoryStyle;
        _accessoryDimensions = categoryItem.accessoryDimensions;
        _closure = categoryItem.accessoryClosure;
        _hasCompartments = categoryItem.accessoryCompartments;
        _numberOfCompartments = categoryItem.numberOfCompartments;
        _hardware = categoryItem.accessoryHardware;
        _accessoryweight = categoryItem.accessoryHeaviness;
        _season = categoryItem.season;
        _sustainability = categoryItem.sustainability;
        _careInstructions = categoryItem.careInstructions;
      }
      else if(item.underGarment != null){
        categoryItem = item.underGarment;
        _category = 'Lingrie';
        _primaryColor = categoryItem.primaryColor;
        _secondaryColor = categoryItem.secondaryColor;
        _size = categoryItem.size;
        _lingerieType = categoryItem.lingerieType;
        _lingerieSupportType = categoryItem.supportType;
        _lingeriePadding = categoryItem.padding;
        _lingerieStrapType = categoryItem.strapType;
        _lingerieCoverage = categoryItem.coverage;
        _lingerieFabricType = categoryItem.lingerieFabricType;
        _lingerieWaistbandStyle = categoryItem.waistbandStyle;
        _lingeriePatternDetails = categoryItem.patternDetails;
        _season = categoryItem.season;
        _sustainability = categoryItem.sustainability;
        _careInstructions = categoryItem.careInstructions;
      }
      else if(item.swimWear != null){
        categoryItem = item.swimWear;
        _category = 'SwimWear';
        _primaryColor = categoryItem.primaryColor;
        _secondaryColor = categoryItem.secondaryColor;
        _size = categoryItem.size;
        swimwearType = categoryItem.swimwearType;
        swimwearSupportType = categoryItem.swimwearSupportType;
        swimwearStrapType = categoryItem.swimwearStrapType;
        swimwearCoverage = categoryItem.swimwearCoverage;
        swimwearMaterial = categoryItem.swimwearMaterial;
        swimwearFastening = categoryItem.swimwearFastening;
        _season = categoryItem.season;
        _sustainability = categoryItem.sustainability;
        _careInstructions = categoryItem.careInstructions;
      }
      else if(item.athleticWear != null){
        categoryItem = item.athleticWear;
        _category = 'AthleticWear';
        _primaryColor = categoryItem.primaryColor;
        _secondaryColor = categoryItem.secondaryColor;
        _size = categoryItem.size;
        _athleticWearType = categoryItem.athleticwearType;
        _athleticWearFit = categoryItem.athleticwearFitType;
        _athleticWearBreathability = categoryItem.athleticwearBreathability;
        _athleticWearWaistType = categoryItem.athleticwearWaistType;
        _athleticWearFabric = categoryItem.athleticwearMaterial;
        _hasPockets = categoryItem.hasPockets;
        _numberOfPockets = categoryItem.numberOfPockets;
        _pocketStyle = categoryItem.pocketStyle;
        _season = categoryItem.season;
        _sustainability = categoryItem.sustainability;
        _careInstructions = categoryItem.careInstructions;
      }
    }
    else{
      _primaryColor = 'Red';
      _size = 'S';
      _fit = 'Regular';
      _material = 'Cotton';
      _pattern = 'Solid';
      _pocketStyle = '';
      _occasion = 'Casual';
      _detailingAccents = ["Regular"];

    }
    IsDataLoaded = true;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(widget.clothingItem == null ? 'Create Outfit' : 'Update Outfit',style: TextStyle(color: Colors.white),),
      ),
      body: !(IsDataLoaded) ? Center(child: CircularProgressIndicator()) :
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if(widget.clothingItem == null)SizedBox(height: 10,),
              if(widget.clothingItem == null)_buildCategoryDropdown(),
              if(_category == 'Shirt' || _category == 'Pants' || _category == 'Dress')SizedBox(height: 10,),
              if(_category == 'Shirt' || _category == 'Pants' || _category == 'Dress')_buildSubcategoryDropdown(),
              if(_category != null)SizedBox(height: 10,),if(_category != null)_buildColorInput(),
              if(_category != null)SizedBox(height: 10,),if(_category != null)_buildSecondColorInput(),
              if(_category == 'Shirt' || _category == 'Pants' || _category == 'OuterWear' || _category == 'Dress')SizedBox(height: 10,),
              if(_category == 'Shirt' || _category == 'Pants' || _category == 'OuterWear' || _category == 'Dress')_buildFitDropdown(),
              if(_category == 'Shirt' || _category == 'Pants' || _category == 'OuterWear' || _category == 'Dress')SizedBox(height: 10,),
              if(_category == 'Shirt' || _category == 'Pants' || _category == 'OuterWear' || _category == 'Dress')_buildMaterialDropdown(),
              if(_category == 'Shirt' || _category == 'OuterWear' || _category == 'Dress')SizedBox(height: 10,),
              if(_category == 'Shirt' || _category == 'OuterWear' || _category == 'Dress')_buildPatternDropdown(),
              if(_category == 'Shirt' || _category == 'Pants' || _category == 'OuterWear' || _category == 'Dress' || _category == 'AthleticWear')SizedBox(height: 10,),
              if(_category == 'Shirt' || _category == 'Pants' || _category == 'OuterWear' || _category == 'Dress' || _category == 'AthleticWear')_buildPocketFields(),
              if(_category == 'Shirt' || _category == 'OuterWear')SizedBox(height: 10,),
              if(_category == 'Shirt' || _category == 'OuterWear')_buildDetailingAccentsField(),
              if(_category != 'Lingrie' && _category != 'SwimWear' && _category != 'AthleticWear' && _category != null)SizedBox(height: 10,),
              if(_category != 'Lingrie' && _category != 'SwimWear' && _category != 'AthleticWear' && _category != null)_buildOccasionDropdown(),
              if(_category != 'Accessory' && _category != 'Pants' && _category != null)SizedBox(height: 10,),
              if(_category != 'Accessory' && _category != 'Pants' && _category != null)_buildSizeDropdown(),
              if(_category == 'Dress' || _category == 'Shirt')SizedBox(height: 10,),
              if(_category == 'Dress' || _category == 'Shirt')_buildFabricWeightDropdown(),

              // For Shirts/Jackets AND Dress Commons
              if(_category == 'Shirt' || _category == 'OuterWear' || _category == 'Dress')SizedBox(height: 10,),
              if(_category == 'Shirt' || _category == 'OuterWear' || _category == 'Dress')_buildSleeveTypeDropdown(),
              if(_category == 'Shirt' || _category == 'OuterWear' || _category == 'Dress')SizedBox(height: 10,),
              if(_category == 'Shirt' || _category == 'OuterWear' || _category == 'Dress')_buildNecklineDropdown(),
              if(_category == 'Shirt' || _category == 'OuterWear' || _category == 'Dress')SizedBox(height: 10,),
              if(_category == 'Shirt' || _category == 'OuterWear' || _category == 'Dress')_buildHemlineDropdown(),
              if(_category == 'Shirt' || _category == 'Dress')SizedBox(height: 10,),
              if(_category == 'Shirt' || _category == 'Dress')_buildCollarTypeDropdown(),

              // FOR PANTS
              if(_category == 'Pants')SizedBox(height: 10,),
              if(_category == 'Pants')_buildWaistSizeDropdown(),
              if(_category == 'Pants')SizedBox(height: 10,),
              if(_category == 'Pants')_buildpantLengthDropdown(),
              if(_category == 'Pants')SizedBox(height: 10,),
              if(_category == 'Pants')_buildLegStyleDropdown(),
              if(_category == 'Pants')SizedBox(height: 10,),
              if(_category == 'Pants')_buildRiseDropdown(),
              if(_category == 'Pants')SizedBox(height: 10,),
              if(_category == 'Pants')_buildFabricStretchDropdown(),
              if(_category == 'Pants')SizedBox(height: 10,),
              if(_category == 'Pants')_buildFasteningDropdown(),
              if(_category == 'Pants')SizedBox(height: 10,),
              if(_category == 'Pants') _buildBeltLoopsToggle(),

              // For Jackets
              if(_category == 'OuterWear')SizedBox(height: 10,),
              if(_category == 'OuterWear')_buildClosureTypeDropdown(),
              if(_category == 'OuterWear')SizedBox(height: 10,),
              if(_category == 'OuterWear')_buildWeatherResistanceDropdown(),

              // For dresses
              if(_category == 'Dress')SizedBox(height: 10,),
              if(_category == 'Dress')_buildDressLengthDropdown(),
              if(_category == 'Dress')SizedBox(height: 10,),
              if(_category == 'Dress')_buildSkirtStyleDropdown(), // Skirt Style dropdown
              if(_category == 'Dress')SizedBox(height: 10,),
              if(_category == 'Dress')_buildWaistlineDropdown(), // Waistline dropdown
              if(_category == 'Dress')SizedBox(height: 10,),
              if(_category == 'Dress')_buildBackDetailsDropdown(), // Back Details dropdown

              // For Shoes
              if(_category == 'Shoes')SizedBox(height: 10,),
              if(_category == 'Shoes')_buildFootwearTypeDropdown(),
              if(_category == 'Shoes')SizedBox(height: 10,),
              if(_category == 'Shoes')_buildHeelHeightDropdown(),
              if(_category == 'Shoes')SizedBox(height: 10,),
              if(_category == 'Shoes')_buildToeShapeDropdown(),
              if(_category == 'Shoes')SizedBox(height: 10,),
              if(_category == 'Shoes')_buildfootwearMaterialDropdown(),
              if(_category == 'Shoes')SizedBox(height: 10,),
              if(_category == 'Shoes')_buildfootwearFasteningDropdown(),
              if(_category == 'Shoes')SizedBox(height: 10,),
              if(_category == 'Shoes')_buildSoleTypeDropdown(),
              if(_category == 'Shoes')SizedBox(height: 10,),
              if(_category == 'Shoes')_buildWaterResistantToggle(),

              // For Accessories
              if(_category == 'Accessory')SizedBox(height: 10,),
              if(_category == 'Accessory')_buildAccessoryTypeDropdown(),
              if(_category == 'Accessory')SizedBox(height: 10,),
              if(_category == 'Accessory')_buildAccessoryDimensionsInput(),
              if(_category == 'Accessory')SizedBox(height: 10,),
              if(_category == 'Accessory')_buildAcessoryMaterialDropdown(),
              if(_category == 'Accessory')SizedBox(height: 10,),
              if(_category == 'Accessory')_buildStyleInput(),
              if(_category == 'Accessory')SizedBox(height: 10,),
              if(_category == 'Accessory')_buildClosureDropdown(),
              if(_category == 'Accessory')SizedBox(height: 10,),
              if(_category == 'Accessory')_buildCompartmentsToggle(),
              if(_category == 'Accessory')SizedBox(height: 10,),
              if(_category == 'Accessory')_buildHardwareInput(),
              if(_category == 'Accessory')SizedBox(height: 10,),
              if(_category == 'Accessory')_buildWeightInput(),

              // For Lingrie
              if(_category == 'Lingrie')SizedBox(height: 10,),
              if(_category == 'Lingrie')_buildLingerieTypeDropdown(),
              if(_category == 'Lingrie')SizedBox(height: 10,),
              if(_category == 'Lingrie')_buildLingerieSupportTypeDropdown(),
              if(_category == 'Lingrie')SizedBox(height: 10,),
              if(_category == 'Lingrie')_buildLingeriePaddingDropdown(),
              if(_category == 'Lingrie')SizedBox(height: 10,),
              if(_category == 'Lingrie')_buildLingerieStrapTypeDropdown(),
              if(_category == 'Lingrie')SizedBox(height: 10,),
              if(_category == 'Lingrie')_buildLingerieCoverageDropdown(),
              if(_category == 'Lingrie')SizedBox(height: 10,),
              if(_category == 'Lingrie')_buildLingerieFabricTypeDropdown(),
              if(_category == 'Lingrie')SizedBox(height: 10,),
              if(_category == 'Lingrie')_buildLingerieWaistbandStyleDropdown(),
              if(_category == 'Lingrie')SizedBox(height: 10,),
              if(_category == 'Lingrie')_buildLingeriePatternDetailsInput(),

              // For SwimWear
              if(_category == 'SwimWear')SizedBox(height: 10,),
              if(_category == 'SwimWear')_buildSwimwearTypeDropdown(),
              if(_category == 'SwimWear')SizedBox(height: 10,),
              if(_category == 'SwimWear')_buildSwimwearSupportTypeDropdown(),
              if(_category == 'SwimWear')SizedBox(height: 10,),
              if(_category == 'SwimWear')_buildSwimwearStrapTypeDropdown(),
              if(_category == 'SwimWear')SizedBox(height: 10,),
              if(_category == 'SwimWear')_buildSwimwearCoverageDropdown(),
              if(_category == 'SwimWear')SizedBox(height: 10,),
              if(_category == 'SwimWear')_buildSwimwearMaterialDropdown(),
              if(_category == 'SwimWear')SizedBox(height: 10,),
              if(_category == 'SwimWear')_buildSwimwearFasteningDropdown(),

              // For AthleticWear
              if(_category == 'AthleticWear')SizedBox(height: 10,),
              if(_category == 'AthleticWear')_buildAthleticWearTypeDropdown(),
              if(_category == 'AthleticWear')SizedBox(height: 10,),
              if(_category == 'AthleticWear')_buildAthleticWearFitDropdown(),
              if(_category == 'AthleticWear')SizedBox(height: 10,),
              if(_category == 'AthleticWear')_buildAthleticWearFabricDropdown(),
              if(_category == 'AthleticWear')SizedBox(height: 10,),
              if(_category == 'AthleticWear')_buildAthleticWearBreathabilityDropdown(),
              if(_category == 'AthleticWear')SizedBox(height: 10,),
              if(_category == 'AthleticWear')_buildAthleticWearWaistTypeDropdown(),

              if(_category != null)SizedBox(height: 10,),if(_category != null)_buildSeasonDropdown(),
              if(_category != null)SizedBox(height: 10,),if(_category != null)_buildSustainabilityDropdown(),
              if(_category == 'Shirt' || _category == 'Pants' || _category == 'OuterWear' || _category == 'Dress')SizedBox(height: 10,),
              if(_category == 'Shirt' || _category == 'Pants' || _category == 'OuterWear' || _category == 'Dress')_buildSpecialFeaturesDropdown(),
              if(_category != null)SizedBox(height: 10,),if(_category != null)_buildCareInstructionsDropdown(),
              SizedBox(height: 25,),
              ElevatedButton.icon(
                onPressed: _saveForm,
                label: Text('Save',style: TextStyle(color: Colors.white,),),
                icon: Icon(Icons.save,color: Colors.white,),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField(
      value: _category,
      onChanged: (value) {
        setState(() {
          _category = value as String;
          // Reset fields related to category
          print(_subcategory);
          _subcategory = null;// Reset subcategory
          print(_subcategory);
        });
      },
      items: ['Shirt', 'Pants', 'Shoes', 'OuterWear', 'Dress', 'Accessory' , 'Lingrie', 'SwimWear' , 'AthleticWear']
          .map((category) => DropdownMenuItem(value: category, child: Text(category)))
          .toList(),
      decoration: InputDecoration(labelText: 'Category'),
      validator: _validateDropdown,
    );
  }

  Widget _buildSubcategoryDropdown() {
    List<String> subcategories = [];
    if (_category == 'Pants') {
      subcategories = ['Jeans', 'Trousers', 'Leggings' , 'Cargo' , 'shorts'];
    } else if (_category == 'Shirt') {
      subcategories = ['Shirt','T_Shirt','Crop Top', 'Blouse', 'Tank Top'];
    } else if (_category == 'Dress') {
      subcategories = ['Maxi', 'Midi', 'Mini'];
    }
    return DropdownButtonFormField(
      value: _subcategory,
      onChanged: (value) {
        setState(() {
          _subcategory = value as String;
        });
      },
      items: subcategories.map((sub) => DropdownMenuItem(value: sub, child: Text(sub))).toList(),
      decoration: InputDecoration(labelText: 'Subcategory'),
      validator: _validateDropdown,
    );
  }

  Widget _buildColorInput() {
    return DropdownButtonFormField(
      value: _primaryColor,
      onChanged: (value) {
        setState(() {
          _primaryColor = value as String;
          // Reset fields related to category
          // _subcategory = null; // Reset subcategory
        });
      },
      items: ['Red', 'Blue', 'Green', 'Black', 'White', 'Yellow','Pink','Gray','Brown','Purple']
          .map((primaryColor) => DropdownMenuItem(value: primaryColor, child: Text(primaryColor)))
          .toList(),
      decoration: InputDecoration(labelText: 'Primary Color'),
      validator: _validateDropdown,
    );
  }

  Widget _buildSecondColorInput() {
    return DropdownButtonFormField(
      value: _secondaryColor,
      onChanged: (value) {
        setState(() {
          _secondaryColor = value as String;
          // Reset fields related to category
          // _subcategory = null; // Reset subcategory
        });
      },
      items: ['Red', 'Blue', 'Green', 'Black', 'White', 'Yellow','Pink','Gray','Brown','Purple']
          .map((secondColor) => DropdownMenuItem(value: secondColor, child: Text(secondColor)))
          .toList(),
      decoration: InputDecoration(labelText: 'Secondary Color'),
      validator: _validateDropdown,
    );
  }

  Widget _buildSizeDropdown() {
    return DropdownButtonFormField(
      value: _size,
      onChanged: (value) {
        setState(() {
          _size = value as String;
        });
      },
      items: ['S', 'M', 'L', 'XL']
          .map((size) => DropdownMenuItem(value: size, child: Text(size)))
          .toList(),
      decoration: InputDecoration(labelText: 'Size'),
      validator: _validateDropdown,
    );
  }

  Widget _buildFitDropdown() {
    return DropdownButtonFormField(
      value: _fit,
      onChanged: (value) {
        setState(() {
          _fit = value as String;
        });
      },
      items: ['Regular', 'Slim', 'Loose']
          .map((fit) => DropdownMenuItem(value: fit, child: Text(fit)))
          .toList(),
      decoration: InputDecoration(labelText: 'Fit'),
      validator: _validateDropdown,
    );
  }

  Widget _buildMaterialDropdown() {
    return DropdownButtonFormField(
      value: _material,
      onChanged: (value) {
        setState(() {
          _material = value as String;
        });
      },
      items: ['Cotton', 'Polyester', 'Wool','Silk', 'Linen', 'Denim',]
          .map((material) => DropdownMenuItem(value: material, child: Text(material)))
          .toList(),
      decoration: InputDecoration(labelText: 'Material'),
      validator: _validateDropdown,
    );
  }

  Widget _buildPatternDropdown() {
    return DropdownButtonFormField(
      value: _pattern,
      onChanged: (value) {
        setState(() {
          _pattern = value as String;
        });
      },
      items: ['Solid', 'Striped', 'Checked']
          .map((pattern) => DropdownMenuItem(value: pattern, child: Text(pattern)))
          .toList(),
      decoration: InputDecoration(labelText: 'Pattern'),
      validator: _validateDropdown,
    );
  }

  Widget _buildPocketFields() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Has Pockets?'),
            Switch(
              value: _hasPockets,
              onChanged: (value) {
                setState(() {
                  _hasPockets = value;
                  _numberOfPockets = 1;
                  _pocketStyle = '';
                });
              },
            ),
          ],
        ),
        if(_hasPockets) DropdownButtonFormField(
                value: _numberOfPockets,
            onChanged: (value) {
            setState(() {
              _numberOfPockets = value as int;
            });
            },
            items: [1, 2, 3, 4, 5]
                .map((pockets) => DropdownMenuItem(value: pockets, child: Text(pockets.toString())))
                .toList(),
            decoration: InputDecoration(labelText: 'Pockets'),
            // validator: _validateDropdown,
            ),
            if(_hasPockets) DropdownButtonFormField(
            value: _pocketStyle,
            onChanged: (value) {
            setState(() {
              _pocketStyle = value as String;
            });
            },
            items: ['','Patch', 'Side', 'Zippered']
                .map((style) => DropdownMenuItem(value: style, child: Text(style)))
                .toList(),
            decoration: InputDecoration(labelText: 'Pocket Style'),
              validator: _validateDropdown,
            ),
      ],
    );
  }

  Widget _buildDetailingAccentsField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Detailing Accents (comma separated)'),
      initialValue: _detailingAccents!.join(','),
      onChanged: (value) {
        _detailingAccents = value.split(',').map((e) => e.trim()).toList();
      },
    );
  }

  Widget _buildOccasionDropdown() {
    return DropdownButtonFormField(
      value: _occasion,
      onChanged: (value) {
        setState(() {
          _occasion = value as String;
        });
      },
      items: ['Casual', 'Formal', 'Sport']
          .map((occasion) => DropdownMenuItem(value: occasion, child: Text(occasion)))
          .toList(),
      decoration: InputDecoration(labelText: 'Occasion'),
      validator: _validateDropdown,
    );
  }

  Widget _buildSleeveTypeDropdown() {
    return DropdownButtonFormField(
      value: _sleeveType,
      onChanged: (value) {
        setState(() {
          _sleeveType = value as String;
        });
      },
      items: ['Short', 'Long', 'Sleeveless']
          .map((sleeveType) => DropdownMenuItem(value: sleeveType, child: Text(sleeveType)))
          .toList(),
      decoration: InputDecoration(labelText: 'Sleeve Type'),
      validator: _validateDropdown,
    );
  }

  // Widget _buildLengthDropdown() {
  //   return DropdownButtonFormField(
  //     value: _length,
  //     onChanged: (value) {
  //       setState(() {
  //         _length = value as String;
  //       });
  //     },
  //     items: ['Full-Length', 'Ankle-Length', 'Cropped', 'Long-line', 'Regular']
  //         .map((length) => DropdownMenuItem(value: length, child: Text(length)))
  //         .toList(),
  //     decoration: InputDecoration(labelText: 'Length (for Pants)'),
  //   );
  // }

  Widget _buildWaistSizeDropdown() {
    return DropdownButtonFormField(
      value: _waistSize,
      onChanged: (value) {
        setState(() {
          _waistSize = value as String;
        });
      },
      items: ['24','26', '28','30', '32', '34', '36','38' , '40','42' ,'44']
          .map((waistSize) => DropdownMenuItem(value: waistSize, child: Text(waistSize)))
          .toList(),
      decoration: InputDecoration(labelText: 'Waist Size (for Pants)'),
      validator: _validateDropdown,
    );
  }

  Widget _buildDressLengthDropdown() {
    return DropdownButtonFormField(
      value: _dressLength,
      onChanged: (value) {
        setState(() {
          _dressLength = value as String;
        });
      },
      items: ['Short', 'Midi', 'Maxi']
          .map((length) => DropdownMenuItem(value: length, child: Text(length)))
          .toList(),
      decoration: InputDecoration(labelText: 'Dress Length'),
      validator: _validateDropdown,
    );
  }

  Widget _buildAccessoryDimensionsInput() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Dimensions for Accessories (Comma spearated)'),
      initialValue: _accessoryDimensions,
      onChanged: (value) {
        _accessoryDimensions = value;
      },
    );
  }

  Widget _buildNecklineDropdown() {
    return DropdownButtonFormField<String>(
      value: _neckline,
      onChanged: (value) {
        setState(() {
          _neckline = value; // Update the selected neckline
        });
      },
      items: ['Round', 'V-Neck', 'Scoop', 'High Neck', 'Off Shoulder']
          .map((neckline) => DropdownMenuItem<String>(
        value: neckline,
        child: Text(neckline),
      ))
          .toList(),
      decoration: InputDecoration(labelText: 'Neckline Type'), // Label for the dropdown
      validator: _validateDropdown,
    );
  }

  Widget _buildHemlineDropdown() {
    return DropdownButtonFormField<String>(
      value: _hemline,
      onChanged: (value) {
        setState(() {
          _hemline = value; // Update the selected hemline
        });
      },
      items: ['Straight', 'Curved', 'Asymmetrical', 'Layered']
          .map((hemline) => DropdownMenuItem<String>(
        value: hemline,
        child: Text(hemline),
      ))
          .toList(),
      decoration: InputDecoration(labelText: 'Hemline Type'), // Label for the dropdown
      validator: _validateDropdown,
    );
  }

  // Method to build the Closure Type Dropdown
  Widget _buildClosureTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: _closureType,
      onChanged: (value) {
        setState(() {
          _closureType = value; // Update the selected closure type
        });
      },
      items: ['Buttons', 'Zipper', 'Hook & Eye', 'Snap' , 'lining' , 'Hooded']
          .map((closure) => DropdownMenuItem<String>(
        value: closure,
        child: Text(closure),
      ))
          .toList(),
      decoration: InputDecoration(labelText: 'Closure Type'),
      validator: _validateDropdown,
    );
  }

  // Method to build the Collar Type Dropdown
  Widget _buildCollarTypeDropdown() {
    return DropdownButtonFormField<String>(
      value: _collarType,
      onChanged: (value) {
        setState(() {
          _collarType = value; // Update the selected collar type
        });
      },
      items: ['No Collar', 'Pointed Collar', 'Mandarin Collar', 'Peter Pan Collar']
          .map((collar) => DropdownMenuItem<String>(
        value: collar,
        child: Text(collar),
      ))
          .toList(),
      decoration: InputDecoration(labelText: 'Collar Type'), // Label for the dropdown
      validator: _validateDropdown,
    );
  }

  Widget _buildFabricWeightDropdown() {
    return DropdownButtonFormField<String>(
      value: _fabricWeight,
      onChanged: (value) {
        setState(() {
          _fabricWeight = value; // Update the selected fabric weight
        });
      },
      items: ['Lightweight', 'Medium Weight', 'Heavyweight', 'Extra Heavyweight']
          .map((weight) => DropdownMenuItem<String>(
        value: weight,
        child: Text(weight),
      ))
          .toList(),
      decoration: InputDecoration(labelText: 'Fabric Weight'), // Label for the dropdown
      validator: _validateDropdown,
    );
  }

  // Method to build the Length Dropdown
  Widget _buildpantLengthDropdown() {
    return DropdownButtonFormField<String>(
      value: _pantlength,
      onChanged: (value) {
        setState(() {
          _pantlength = value; // Update the selected length
        });
      },
      items: ['Crop', 'Regular', 'Longline']
          .map((length) => DropdownMenuItem<String>(
        value: length,
        child: Text(length),
      ))
          .toList(),
      decoration: InputDecoration(labelText: 'Length'), // Label for the dropdown
      validator: _validateDropdown,
    );
  }

  // Method to build the Leg Style Dropdown
  Widget _buildLegStyleDropdown() {
    return DropdownButtonFormField<String>(
      value: _legStyle,
      onChanged: (value) {
        setState(() {
          _legStyle = value; // Update the selected leg style
        });
      },
      items: ['Straight', 'Skinny', 'Bootcut', 'Wide Leg']
          .map((style) => DropdownMenuItem<String>(
        value: style,
        child: Text(style),
      ))
          .toList(),
      decoration: InputDecoration(labelText: 'Leg Style'), // Label for the dropdown
      validator: _validateDropdown,
    );
  }

  // Method to build the Rise Dropdown
  Widget _buildRiseDropdown() {
    return DropdownButtonFormField<String>(
      value: _rise,
      onChanged: (value) {
        setState(() {
          _rise = value; // Update the selected rise
        });
      },
      items: ['High-Rise', 'Mid-Rise', 'Low-Rise']
          .map((rise) => DropdownMenuItem<String>(
        value: rise,
        child: Text(rise),
      ))
          .toList(),
      decoration: InputDecoration(labelText: 'Rise'), // Label for the dropdown
      validator: _validateDropdown,
    );
  }

  // Method to build the Fabric Stretch Dropdown
  Widget _buildFabricStretchDropdown() {
    return DropdownButtonFormField<String>(
      value: _fabricStretch,
      onChanged: (value) {
        setState(() {
          _fabricStretch = value; // Update the selected fabric stretch
        });
      },
      items: ['Stretchy', 'Non-Stretch']
          .map((stretch) => DropdownMenuItem<String>(
        value: stretch,
        child: Text(stretch),
      ))
          .toList(),
      decoration: InputDecoration(labelText: 'Fabric Stretch'), // Label for the dropdown
      validator: _validateDropdown,
    );
  }

  // Method to build the Fastening Dropdown
  Widget _buildFasteningDropdown() {
    return DropdownButtonFormField<String>(
      value: _fastening,
      onChanged: (value) {
        setState(() {
          _fastening = value; // Update the selected fastening
        });
      },
      items: ['Zipper', 'Button', 'Hook & Eye']
          .map((fastening) => DropdownMenuItem<String>(
        value: fastening,
        child: Text(fastening),
      ))
          .toList(),
      decoration: InputDecoration(labelText: 'Fastening'), // Label for the dropdown
      validator: _validateDropdown,
    );
  }

  // Method to build the Belt Loops Toggle Switch
  Widget _buildBeltLoopsToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Belt Loops'), // Label for the toggle
        Switch(
          value: _beltLoops,
          onChanged: (value) {
            setState(() {
              _beltLoops = value; // Update the toggle state
            });
          },
        ),
      ],
    );
  }

  // Method to build the Weather Resistance Dropdown
  Widget _buildWeatherResistanceDropdown() {
    return DropdownButtonFormField(
      value: _weatherResistance,
      onChanged: (value) {
        setState(() {
          _weatherResistance = value as String;
        });
      },
      items: ['Waterproof', 'Water-Resistant', 'Not Water-Resistant'] // Example options
          .map((option) => DropdownMenuItem(value: option, child: Text(option)))
          .toList(),
      decoration: InputDecoration(labelText: 'Weather Resistance'),
      validator: _validateDropdown,
    );
  }

  // Skirt Style Dropdown
  Widget _buildSkirtStyleDropdown() {
    return DropdownButtonFormField(
      value: _skirtStyle,
      onChanged: (value) {
        setState(() {
          _skirtStyle = value as String;
        });
      },
      items: ['A-Line', 'Pencil', 'Maxi', 'Mini', 'Pleated'] // Example options
          .map((style) => DropdownMenuItem(value: style, child: Text(style)))
          .toList(),
      decoration: InputDecoration(labelText: 'Skirt Style'),
      validator: _validateDropdown,
    );
  }

// Waistline Dropdown
  Widget _buildWaistlineDropdown() {
    return DropdownButtonFormField(
      value: _waistline,
      onChanged: (value) {
        setState(() {
          _waistline = value as String;
        });
      },
      items: ['High Waist', 'Mid Rise', 'Low Rise'] // Example options
          .map((waistline) => DropdownMenuItem(value: waistline, child: Text(waistline)))
          .toList(),
      decoration: InputDecoration(labelText: 'Waistline'),
      validator: _validateDropdown,
    );
  }

// Back Details Dropdown
  Widget _buildBackDetailsDropdown() {
    return DropdownButtonFormField(
      value: _backDetails,
      onChanged: (value) {
        setState(() {
          _backDetails = value as String;
        });
      },
      items: ['Plain', 'Lace-Up', 'Zipper', 'Buttons'] // Example options
          .map((detail) => DropdownMenuItem(value: detail, child: Text(detail)))
          .toList(),
      decoration: InputDecoration(labelText: 'Back Details'),
      validator: _validateDropdown,
    );
  }

  // Footwear Type Dropdown
  Widget _buildFootwearTypeDropdown() {
    return DropdownButtonFormField(
      value: _footwearType,
      onChanged: (value) {
        setState(() {
          _footwearType = value as String;
        });
      },
      items: ['Sneakers', 'Boots', 'Sandals', 'Flats'] // Example options
          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
          .toList(),
      decoration: InputDecoration(labelText: 'Footwear Type'),
      validator: _validateDropdown,
    );
  }

// Heel Height Numeric Dropdown
  Widget _buildHeelHeightDropdown() {
    return DropdownButtonFormField<String>(
      value: _heelHeight,
      onChanged: (value) {
        setState(() {
          _heelHeight = value as String;
        });
      },
      items: ["0.5", "1.0","2.0", "3.0", "4.0", "5.0"] // Example numeric options
          .map((height) => DropdownMenuItem(value: height, child: Text('$height inches')))
          .toList(),
      decoration: InputDecoration(labelText: 'Heel Height (inches)'),
      validator: _validateDropdown,
    );
  }

// Toe Shape Dropdown
  Widget _buildToeShapeDropdown() {
    return DropdownButtonFormField(
      value: _toeShape,
      onChanged: (value) {
        setState(() {
          _toeShape = value as String;
        });
      },
      items: ['Round', 'Pointed', 'Square', 'Open Toe'] // Example options
          .map((shape) => DropdownMenuItem(value: shape, child: Text(shape)))
          .toList(),
      decoration: InputDecoration(labelText: 'Toe Shape'),
      validator: _validateDropdown,
    );
  }

// Material Dropdown
  Widget _buildfootwearMaterialDropdown() {
    return DropdownButtonFormField(
      value: _footwearmaterial,
      onChanged: (value) {
        setState(() {
          _footwearmaterial = value as String;
        });
      },
      items: ['Leather', 'Suede', 'Canvas', 'Synthetic'] // Example options
          .map((material) => DropdownMenuItem(value: material, child: Text(material)))
          .toList(),
      decoration: InputDecoration(labelText: 'Footwear Material'),
      validator: _validateDropdown,
    );
  }

// Fastening Dropdown
  Widget _buildfootwearFasteningDropdown() {
    return DropdownButtonFormField(
      value: _footwearfastening,
      onChanged: (value) {
        setState(() {
          _footwearfastening = value as String;
        });
      },
      items: ['Laces', 'Slip-On', 'Buckles', 'Zippers'] // Example options
          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
          .toList(),
      decoration: InputDecoration(labelText: 'Footwear-Fastening'),
      validator: _validateDropdown,
    );
  }

// Sole Type Dropdown
  Widget _buildSoleTypeDropdown() {
    return DropdownButtonFormField(
      value: _soleType,
      onChanged: (value) {
        setState(() {
          _soleType = value as String;
        });
      },
      items: ['Rubber', 'Leather', 'EVA', 'PU'] // Example options
          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
          .toList(),
      decoration: InputDecoration(labelText: 'Sole Type'),
      validator: _validateDropdown,
    );
  }

// Water Resistant Toggle Switch
  Widget _buildWaterResistantToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Water Resistant'),
        Switch(
          value: _isWaterResistant,
          onChanged: (value) {
            setState(() {
              _isWaterResistant = value;
            });
          },
        ),
      ],
    );
  }

  // Accessory Type Dropdown
  Widget _buildAccessoryTypeDropdown() {
    return DropdownButtonFormField(
      value: _accessoryType,
      onChanged: (value) {
        setState(() {
          _accessoryType = value as String;
        });
      },
      items: ['Bag', 'Belt', 'Hat', 'Scarf', 'Gloves' ,'Jewelarry'] // Example options
          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
          .toList(),
      decoration: InputDecoration(labelText: 'Accessory Type'),
      validator: _validateDropdown,
    );
  }

  // Material Dropdown
  Widget _buildAcessoryMaterialDropdown() {
    return DropdownButtonFormField(
      value: _accessoryMaterial,
      onChanged: (value) {
        setState(() {
          _accessoryMaterial = value as String;
        });
      },
      items: ['Leather', 'Cotton', 'Polyester', 'Synthetic','Wool'] // Example options
          .map((material) => DropdownMenuItem(value: material, child: Text(material)))
          .toList(),
      decoration: InputDecoration(labelText: 'Acessory Material'),
      validator: _validateDropdown,
    );
  }

// Style Text Input
  Widget _buildStyleInput() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Style'),
      initialValue: _style,
      onChanged: (value) {
        setState(() {
          _style = value;
        });
      },
    );
  }

// Closure Dropdown
  Widget _buildClosureDropdown() {
    return DropdownButtonFormField(
      value: _closure,
      onChanged: (value) {
        setState(() {
          _closure = value as String;
        });
      },
      items: ['Zipper', 'Button', 'Magnetic', 'Snap'] // Example options
          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
          .toList(),
      decoration: InputDecoration(labelText: 'Closure'),
      validator: _validateDropdown,
    );
  }

// Compartments Toggle Switch
  Widget _buildCompartmentsToggle() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Compartment?'),
            Switch(
              value: _hasCompartments,
              onChanged: (value) {
                setState(() {
                  _hasCompartments = value;
                  _numberOfCompartments = 1;
                });
              },
            ),
          ],
        ),
        if(_hasCompartments) DropdownButtonFormField(
          value: _numberOfCompartments,
          onChanged: (value) {
            setState(() {
              _numberOfCompartments = value as int;
            });
          },
          items: [1, 2, 3, 4, 5]
              .map((compartments) => DropdownMenuItem(value: compartments, child: Text(compartments.toString())))
              .toList(),
          decoration: InputDecoration(labelText: 'Number of Compartments'),
        ),
      ],
    );
  }

// Hardware Text Input
  Widget _buildHardwareInput() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Hardware'),
      initialValue: _hardware,
      onChanged: (value) {
        setState(() {
          _hardware = value;
        });
      },
    );
  }

// Weight Numeric Input
  Widget _buildWeightInput() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Weight (kg)'),
      keyboardType: TextInputType.number,
      initialValue: _accessoryweight,
      onChanged: (value) {
        setState(() {
          _accessoryweight = value;
        });
      },
    );
  }

  // Lingerie Type Dropdown
  Widget _buildLingerieTypeDropdown() {
    return DropdownButtonFormField(
      value: _lingerieType,
      onChanged: (value) {
        setState(() {
          _lingerieType = value as String;
        });
      },
      items: ['Bra', 'Panty', 'Bodysuit', 'Chemise'] // Example options
          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
          .toList(),
      decoration: InputDecoration(labelText: 'Lingerie Type'),
    );
  }

// Lingerie Support Type Dropdown
  Widget _buildLingerieSupportTypeDropdown() {
    return DropdownButtonFormField(
      value: _lingerieSupportType,
      onChanged: (value) {
        setState(() {
          _lingerieSupportType = value as String;
        });
      },
      items: ['Underwire', 'Wireless', 'Push-Up'] // Example options
          .map((supportType) => DropdownMenuItem(value: supportType, child: Text(supportType)))
          .toList(),
      decoration: InputDecoration(labelText: 'Support Type'),
      validator: _validateDropdown,
    );
  }

// Lingerie Padding Dropdown
  Widget _buildLingeriePaddingDropdown() {
    return DropdownButtonFormField(
      value: _lingeriePadding,
      onChanged: (value) {
        setState(() {
          _lingeriePadding = value as String;
        });
      },
      items: ['Light', 'Moderate', 'Heavy'] // Example options
          .map((padding) => DropdownMenuItem(value: padding, child: Text(padding)))
          .toList(),
      decoration: InputDecoration(labelText: 'Padding'),
      validator: _validateDropdown,
    );
  }

// Lingerie Strap Type Dropdown
  Widget _buildLingerieStrapTypeDropdown() {
    return DropdownButtonFormField(
      value: _lingerieStrapType,
      onChanged: (value) {
        setState(() {
          _lingerieStrapType = value as String;
        });
      },
      items: ['Adjustable', 'Non-Adjustable', 'Removable'] // Example options
          .map((strapType) => DropdownMenuItem(value: strapType, child: Text(strapType)))
          .toList(),
      decoration: InputDecoration(labelText: 'Strap Type'),
      validator: _validateDropdown,
    );
  }

// Lingerie Coverage Dropdown
  Widget _buildLingerieCoverageDropdown() {
    return DropdownButtonFormField(
      value: _lingerieCoverage,
      onChanged: (value) {
        setState(() {
          _lingerieCoverage = value as String;
        });
      },
      items: ['Full', 'Partial', 'Minimal'] // Example options
          .map((coverage) => DropdownMenuItem(value: coverage, child: Text(coverage)))
          .toList(),
      decoration: InputDecoration(labelText: 'Coverage'),
      validator: _validateDropdown,
    );
  }

// Lingerie Fabric Type Dropdown
  Widget _buildLingerieFabricTypeDropdown() {
    return DropdownButtonFormField(
      value: _lingerieFabricType,
      onChanged: (value) {
        setState(() {
          _lingerieFabricType = value as String;
        });
      },
      items: ['Cotton', 'Silk', 'Lace', 'Synthetic'] // Example options
          .map((fabricType) => DropdownMenuItem(value: fabricType, child: Text(fabricType)))
          .toList(),
      decoration: InputDecoration(labelText: 'Fabric Type'),
      validator: _validateDropdown,
    );
  }

// Lingerie Waistband Style Dropdown
  Widget _buildLingerieWaistbandStyleDropdown() {
    return DropdownButtonFormField(
      value: _lingerieWaistbandStyle,
      onChanged: (value) {
        setState(() {
          _lingerieWaistbandStyle = value as String;
        });
      },
      items: ['Elastic', 'Lace', 'Seamless'] // Example options
          .map((waistbandStyle) => DropdownMenuItem(value: waistbandStyle, child: Text(waistbandStyle)))
          .toList(),
      decoration: InputDecoration(labelText: 'Waistband Style'),
      validator: _validateDropdown,
    );
  }

// Lingerie Pattern Details Text Input
  Widget _buildLingeriePatternDetailsInput() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Pattern Details'),
      onChanged: (value) {
        setState(() {
          _lingeriePatternDetails = value;
        });
      },
    );
  }

  // Type of Swimwear Dropdown
  Widget _buildSwimwearTypeDropdown() {
    return DropdownButtonFormField(
      value: swimwearType,
      onChanged: (value) {
        setState(() {
          swimwearType = value as String;
        });
      },
      items: ['One-Piece', 'Bikini', 'Trunks', 'Boardshorts'] // Example options
          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
          .toList(),
      decoration: InputDecoration(labelText: 'Type of Swimwear'),
      validator: _validateDropdown,
    );
  }

  // Support Type Dropdown
  Widget _buildSwimwearSupportTypeDropdown() {
    return DropdownButtonFormField(
      value: swimwearSupportType,
      onChanged: (value) {
        setState(() {
          swimwearSupportType = value as String;
        });
      },
      items: ['Underwire', 'Wireless'] // Example options
          .map((supportType) => DropdownMenuItem(value: supportType, child: Text(supportType)))
          .toList(),
      decoration: InputDecoration(labelText: 'Support Type'),
      validator: _validateDropdown,
    );
  }

  // Strap Type Dropdown
  Widget _buildSwimwearStrapTypeDropdown() {
    return DropdownButtonFormField(
      value: swimwearStrapType,
      onChanged: (value) {
        setState(() {
          swimwearStrapType = value as String;
        });
      },
      items: ['Removable', 'Adjustable'] // Example options
          .map((strapType) => DropdownMenuItem(value: strapType, child: Text(strapType)))
          .toList(),
      decoration: InputDecoration(labelText: 'Strap Type'),
      validator: _validateDropdown,
    );
  }

  // Coverage Dropdown
  Widget _buildSwimwearCoverageDropdown() {
    return DropdownButtonFormField(
      value: swimwearCoverage,
      onChanged: (value) {
        setState(() {
          swimwearCoverage = value as String;
        });
      },
      items: ['Full', 'Medium', 'Minimal'] // Example options
          .map((coverage) => DropdownMenuItem(value: coverage, child: Text(coverage)))
          .toList(),
      decoration: InputDecoration(labelText: 'Coverage'),
      validator: _validateDropdown,
    );
  }

  // Material Dropdown
  Widget _buildSwimwearMaterialDropdown() {
    return DropdownButtonFormField(
      value: swimwearMaterial,
      onChanged: (value) {
        setState(() {
          swimwearMaterial = value as String;
        });
      },
      items: ['Nylon', 'Spandex', 'Lycra'] // Example options
          .map((material) => DropdownMenuItem(value: material, child: Text(material)))
          .toList(),
      decoration: InputDecoration(labelText: 'Material'),
      validator: _validateDropdown,
    );
  }

  // Fastening Dropdown
  Widget _buildSwimwearFasteningDropdown() {
    return DropdownButtonFormField(
      value: swimwearFastening,
      onChanged: (value) {
        setState(() {
          swimwearFastening = value as String;
        });
      },
      items: ['Tie', 'Clip', 'Pull-On'] // Example options
          .map((fastening) => DropdownMenuItem(value: fastening, child: Text(fastening)))
          .toList(),
      decoration: InputDecoration(labelText: 'Fastening'),
      validator: _validateDropdown,
    );
  }

  // Type of Athletic Wear Dropdown
  Widget _buildAthleticWearTypeDropdown() {
    return DropdownButtonFormField(
      value: _athleticWearType,
      onChanged: (value) {
        setState(() {
          _athleticWearType = value as String;
        });
      },
      items: ['Leggings', 'Sports Bra', 'Track Pants'] // Example options
          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
          .toList(),
      decoration: InputDecoration(labelText: 'Type of Athletic Wear'),
      validator: _validateDropdown,
    );
  }

  // Fit Dropdown
  Widget _buildAthleticWearFitDropdown() {
    return DropdownButtonFormField(
      value: _athleticWearFit,
      onChanged: (value) {
        setState(() {
          _athleticWearFit = value as String;
        });
      },
      items: ['Compression', 'Loose', 'Regular'] // Example options
          .map((fit) => DropdownMenuItem(value: fit, child: Text(fit)))
          .toList(),
      decoration: InputDecoration(labelText: 'Fit'),
      validator: _validateDropdown,
    );
  }

  // Fabric Dropdown
  Widget _buildAthleticWearFabricDropdown() {
    return DropdownButtonFormField(
      value: _athleticWearFabric,
      onChanged: (value) {
        setState(() {
          _athleticWearFabric = value as String;
        });
      },
      items: ['Moisture-Wicking', 'Cotton', 'Nylon', 'Polyester'] // Example options
          .map((fabric) => DropdownMenuItem(value: fabric, child: Text(fabric)))
          .toList(),
      decoration: InputDecoration(labelText: 'Fabric'),
      validator: _validateDropdown,
    );
  }

  // Breathability Dropdown
  Widget _buildAthleticWearBreathabilityDropdown() {
    return DropdownButtonFormField(
      value: _athleticWearBreathability,
      onChanged: (value) {
        setState(() {
          _athleticWearBreathability = value as String;
        });
      },
      items: ['High', 'Medium', 'Low'] // Example options
          .map((breathability) => DropdownMenuItem(value: breathability, child: Text(breathability)))
          .toList(),
      decoration: InputDecoration(labelText: 'Breathability'),
      validator: _validateDropdown,
    );
  }

  // Waist Type Dropdown
  Widget _buildAthleticWearWaistTypeDropdown() {
    return DropdownButtonFormField(
      value: _athleticWearWaistType,
      onChanged: (value) {
        setState(() {
          _athleticWearWaistType = value as String;
        });
      },
      items: ['Elastic', 'Drawstring'] // Example options
          .map((waistType) => DropdownMenuItem(value: waistType, child: Text(waistType)))
          .toList(),
      decoration: InputDecoration(labelText: 'Waist Type'),
      validator: _validateDropdown,
    );
  }

  // Season Dropdown
  Widget _buildSeasonDropdown() {
    return DropdownButtonFormField(
      value: _season,
      onChanged: (value) {
        setState(() {
          _season = value as String;
        });
      },
      items: ['Summer', 'Winter', 'Spring', 'Fall']
          .map((season) => DropdownMenuItem(value: season, child: Text(season)))
          .toList(),
      decoration: InputDecoration(labelText: 'Season'),
      validator: _validateDropdown,
    );
  }

  // Sustainability Dropdown
  Widget _buildSustainabilityDropdown() {
    return DropdownButtonFormField(
      value: _sustainability,
      onChanged: (value) {
        setState(() {
          _sustainability = value as String;
        });
      },
      items: ['Eco-Friendly', 'Organic', 'Recycled Materials']
          .map((sustainability) => DropdownMenuItem(value: sustainability, child: Text(sustainability)))
          .toList(),
      decoration: InputDecoration(labelText: 'Sustainability'),
      validator: _validateDropdown,
    );
  }

  // Special Features Dropdown
  Widget _buildSpecialFeaturesDropdown() {
    return DropdownButtonFormField(
      value: _specialFeatures,
      onChanged: (value) {
        setState(() {
          _specialFeatures = value as String;
        });
      },
      items: ['UV Protection', 'Anti-Wrinkle', 'Stain-Resistant']
          .map((feature) => DropdownMenuItem(value: feature, child: Text(feature)))
          .toList(),
      decoration: InputDecoration(labelText: 'Special Features'),
      validator: _validateDropdown,
    );
  }

  // Care Instructions Dropdown
  Widget _buildCareInstructionsDropdown() {
    return DropdownButtonFormField(
      value: _careInstructions,
      onChanged: (value) {
        setState(() {
          _careInstructions = value as String;
        });
      },
      items: ['Machine Wash', 'Dry Clean', 'Hand Wash']
          .map((instruction) => DropdownMenuItem(value: instruction, child: Text(instruction)))
          .toList(),
      decoration: InputDecoration(labelText: 'Care Instructions'),
      validator: _validateDropdown,
    );
  }

  String? _validateDropdown(value) {
    if (value == null || value.isEmpty) {
      return 'Please select an option'; // Error message for empty dropdown
    }
    return null; // No error
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      // ClothingItem newItem = ClothingItem(
      //   userId: widget.userId ?? 0,
      //   category: _category!,
      //   subcategory: _subcategory!,
      //   primaryColor: _primaryColor,
      //   secondaryColor: _secondaryColor,
      //   size: _size,
      //   fit: _fit,
      //   material: _material,
      //   pattern: _pattern,
      //   hasPockets: _hasPockets,
      //   numberOfPockets: _numberOfPockets,
      //   pocketStyle: _pocketStyle,
      //   detailingAccents: _detailingAccents,
      //   occasion: _occasion,
      //   sleeveType: _sleeveType,
      //   length: _pantlength, // For pants
      //   waistline: _waistSize, // For pants
      //   dressLength: _dressLength, // For dresses
      //   accessoryDimensions: _accessoryDimensions ?? "", // For accessories
      // );
      if(_category == 'Shirt'){
        ShirtModel shirtItem = new ShirtModel(userId: widget.userId??0, subcategory: _subcategory??"", primaryColor: _primaryColor, secondaryColor: _secondaryColor??"", size: _size??"", fit: _fit??"", material: _material??"", pattern: _pattern??"", hasPockets: _hasPockets, numberOfPockets: _numberOfPockets??0, pocketStyle: _pocketStyle??"", detailingAccents: _detailingAccents??[], occasion: _occasion??"", sleeveType: _sleeveType??"", neckline: _neckline??"", hemline: _hemline??"", fabricWeight: _fabricWeight??"", collarType: _collarType??"", season: _season??"", sustainability: _sustainability??"", specialFeatures: _specialFeatures??"", careInstructions: _careInstructions??"");
        if(widget.clothingItem != null){
          shirtItem.id = widget.clothingItem!.shirt!.id ?? 0;
          _dbContext!.updateShirt(shirtItem);
        }
        else{
          _dbContext!.insertShirt(shirtItem);
          shirtItem.id = await _dbContext!.getLastShirtItemId();
        }
        widget.onSave(shirtItem);
      }
      else if(_category == 'Pants'){
        PantModel pantItem = new PantModel(userId: widget.userId??0, subcategory: _subcategory??"", primaryColor: _primaryColor, secondaryColor: _secondaryColor??"", fit: _fit??"", material: _material??"", hasPockets: _hasPockets, numberOfPockets: _numberOfPockets??0, pocketStyle: _pocketStyle??"", occasion: _occasion??"", waistType: _waistSize??"", legStyle: _legStyle??"", length: _pantlength??"", rise: _rise??"", fabricStretch: _fabricStretch??"", beltLoops: _beltLoops, fastening: _fastening??"", season: _season??"", sustainability: _sustainability??"", specialFeatures: _specialFeatures??"", careInstructions: _careInstructions??"");
        if(widget.clothingItem != null){
          pantItem.id = widget.clothingItem!.pant!.id ?? 0;
          _dbContext!.updatePants(pantItem);
        }
        else{
          _dbContext!.insertPants(pantItem);
          pantItem.id = await _dbContext!.getLastPantsItemId();
        }
        widget.onSave(pantItem);
        print(pantItem);
      }
      else if(_category == 'Dress'){
        DressModel dressItem = new DressModel(userId: widget.userId??0, subcategory: _subcategory??"", primaryColor: _primaryColor, secondaryColor: _secondaryColor??"", fit: _fit??"", pattern: _pattern??"" ,material: _material??"",size: _size??"" ,hasPockets: _hasPockets, numberOfPockets: _numberOfPockets??0, pocketStyle: _pocketStyle??"", occasion: _occasion??"", skirtStyle: _skirtStyle??"", sleeveType: _sleeveType??"", dressLength: _dressLength??"", neckline: _neckline??"", hemline: _hemline??"", fabricWeight: _fabricWeight??"", collarType: _collarType??"", waistline: _waistline??"",backDetails: _backDetails??"" ,season: _season??"", sustainability: _sustainability??"", specialFeatures: _specialFeatures??"", careInstructions: _careInstructions??"");
        if(widget.clothingItem != null){
          dressItem.id = widget.clothingItem!.dress!.id ?? 0;
          _dbContext!.updateDress(dressItem);
        }
        else{
          _dbContext!.insertDress(dressItem);
          dressItem.id = await _dbContext!.getLastDressItemId();
        }
        widget.onSave(dressItem);
        print(dressItem);
      }
      else if(_category == 'OuterWear'){
        OuterWearModel outwerwearItem = new OuterWearModel(userId: widget.userId??0, primaryColor: _primaryColor, secondaryColor: _secondaryColor??"", fit: _fit??"", pattern: _pattern??"" ,material: _material??"",size: _size??"" ,hasPockets: _hasPockets, numberOfPockets: _numberOfPockets??0, pocketStyle: _pocketStyle??"", occasion: _occasion??"", closureType: _closureType??"", sleeveType: _sleeveType??"", detailingAccents: _detailingAccents??[], neckline: _neckline??"", hemline: _hemline??"",weatherResistance: _weatherResistance??"",season: _season??"", sustainability: _sustainability??"", specialFeatures: _specialFeatures??"", careInstructions: _careInstructions??"");
        if(widget.clothingItem != null){
          outwerwearItem.id = widget.clothingItem!.outerWear!.id ?? 0;
          _dbContext!.updateOuterwear(outwerwearItem);
        }
        else{
          _dbContext!.insertOuterwear(outwerwearItem);
          outwerwearItem.id = await _dbContext!.getLastOuterwearItemId();
        }
        widget.onSave(outwerwearItem);
        print(outwerwearItem);
      }
      else if(_category == 'Accessory'){
        AccessoryModel accessoryItem = new AccessoryModel(userId: widget.userId??0, primaryColor: _primaryColor, secondaryColor: _secondaryColor??"", accessoryClosure: _closure??"", accessoryCompartments: _hasCompartments ,accessoryMaterial: _accessoryMaterial??"" , numberOfCompartments: _numberOfCompartments??0, accessoryDimensions: _accessoryDimensions??"", occasion: _occasion??"", accessoryHardware: _hardware, accessoryHeaviness: _accessoryweight??"", accessoryType: _accessoryType??"",accessoryStyle: _style,season: _season??"", sustainability: _sustainability??"", careInstructions: _careInstructions??"");
        if(widget.clothingItem != null){
          accessoryItem.id = widget.clothingItem!.accessory!.id ?? 0;
          _dbContext!.updateAccessory(accessoryItem);
        }
        else{
          _dbContext!.insertAccessory(accessoryItem);
          accessoryItem.id = await _dbContext!.getLastAccessoryItemId();
        }
        widget.onSave(accessoryItem);
        print(accessoryItem);
      }
      else if(_category == 'Lingrie'){
        UnderGarmentModel underGarmentItem = new UnderGarmentModel(userId: widget.userId??0, primaryColor: _primaryColor, secondaryColor: _secondaryColor??"", coverage: _lingerieCoverage??"", lingerieFabricType: _lingerieFabricType??"" ,lingerieType: _lingerieType??"" , padding: _lingeriePadding??"", patternDetails: _lingeriePatternDetails??"", size: _size??"", strapType: _lingerieStrapType??"", supportType: _lingerieSupportType??"",waistbandStyle: _lingerieWaistbandStyle??"",season: _season??"", sustainability: _sustainability??"", careInstructions: _careInstructions??"");
        if(widget.clothingItem != null){
          underGarmentItem.id = widget.clothingItem!.underGarment!.id ?? 0;
          _dbContext!.updateUnderGarment(underGarmentItem);
        }
        else{
          _dbContext!.insertUnderGarment(underGarmentItem);
          underGarmentItem.id = await _dbContext!.getLastUnderGarmentItemId();
        }
        widget.onSave(underGarmentItem);
        print(underGarmentItem);
      }
      else if(_category == 'SwimWear'){
        SwimWearModel swimWearItem = new SwimWearModel(userId: widget.userId??0, primaryColor: _primaryColor, secondaryColor: _secondaryColor??"", swimwearCoverage: swimwearCoverage??"", swimwearMaterial: swimwearMaterial??"" ,swimwearType: swimwearType??"" , swimwearFastening: swimwearFastening??"", swimwearStrapType: swimwearStrapType??"", size: _size??"", swimwearSupportType: swimwearSupportType??"" , season: _season??"", sustainability: _sustainability??"", careInstructions: _careInstructions??"");
        if(widget.clothingItem != null){
          swimWearItem.id = widget.clothingItem!.swimWear!.id ?? 0;
          _dbContext!.updateSwimWear(swimWearItem);
        }
        else{
          _dbContext!.insertSwimWear(swimWearItem);
          swimWearItem.id = await _dbContext!.getLastSwimWearItemId();
        }
        widget.onSave(swimWearItem);
        print(swimWearItem);
      }
      else if(_category == 'AthleticWear'){
        AthleticWearModel athleticWearItem = new AthleticWearModel(userId: widget.userId??0, primaryColor: _primaryColor, secondaryColor: _secondaryColor??"", athleticwearBreathability: _athleticWearBreathability??"", athleticwearMaterial: _material??"" ,athleticwearType: _athleticWearType??"" , athleticwearFitType: _athleticWearFit??"", athleticwearWaistType: _athleticWearWaistType??"", size: _size??"",hasPockets: _hasPockets, numberOfPockets: _numberOfPockets??0, pocketStyle: _pocketStyle??"" , season: _season??"", sustainability: _sustainability??"", careInstructions: _careInstructions??"");
        if(widget.clothingItem != null){
          athleticWearItem.id = widget.clothingItem!.athleticWear!.id ?? 0;
          _dbContext!.updateAthleticWear(athleticWearItem);
        }
        else{
          _dbContext!.insertAthleticWear(athleticWearItem);
          athleticWearItem.id = await _dbContext!.getLastAthleticWearItemId();
        }
        widget.onSave(athleticWearItem);
        print(athleticWearItem);
      }
      else if(_category == 'Shoes'){
        FootwearModel footWearItem = new FootwearModel(userId: widget.userId??0, primaryColor: _primaryColor, secondaryColor: _secondaryColor??"", footwearFastening: _footwearfastening??"", footwearMaterial: _footwearmaterial??"" ,footwearType: _footwearType??"" , heelHeight: _heelHeight??"", isWaterResistant: _isWaterResistant, size: _size??"",occasion: _occasion??"", soleType: _soleType??"", toeShape: _toeShape??"" , season: _season??"", sustainability: _sustainability??"", careInstructions: _careInstructions??"");
        if(widget.clothingItem != null){
          footWearItem.id = widget.clothingItem!.footWear!.id ?? 0;
          _dbContext!.updateFootwear(footWearItem);
        }
        else{
          _dbContext!.insertFootwear(footWearItem);
          footWearItem.id = await _dbContext!.getLastFootwearItemId();
        }
        widget.onSave(footWearItem);
        print(footWearItem);
      }
      Navigator.of(context).pop();
    }
  }
}
