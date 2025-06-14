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
import 'package:outfitly/Screens/MakePostScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'AddEditClosetScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class ClosetScreen extends StatefulWidget {
  final int? userId;
  const ClosetScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _ClosetScreenState createState() => _ClosetScreenState();
}

class _ClosetScreenState extends State<ClosetScreen>{
  // List<ClothingItem> _closetItems = [];
  List<ClothingItemModel> allClothItems = [];

  DbContext? _dbContext;
  final Map<String,Color> _myColors =
    {'Red': Colors.red,
    'Blue': Colors.blue,
    'Green': Colors.green,
    'Black': Colors.black,
    'White': Colors.white,
    'Yellow': Colors.yellow,
    'Pink': Colors.pink,
    'Gray': Colors.grey,
    'Purple': Colors.purple,
    'Brown': Colors.brown.shade800};

  @override
  void initState() {
    super.initState();
    _dbContext = DbContext();
    LoadData();
  }

  Future<void> LoadData() async {
    try {
      if (_dbContext == null) {
        throw Exception("DbContext is not initialized");
      }
      await LoadAllLists();
    } catch (e) {
      print("Error loading data: $e");
    } finally {
      setState(() {});
    }
  }

  Future<void> LoadAllLists() async {
    try {
      if (_dbContext == null) {
        throw Exception("DbContext is not initialized");
      }
      List<ShirtModel> allShirtItems = await _dbContext!.getAllShirts();
      for (var item in allShirtItems){
        if(item.userId == widget.userId){
          allClothItems.add(ClothingItemModel(shirt: item));
        }
      }
      List<PantModel> allPantItems = await _dbContext!.getAllPants();
      for (var item in allPantItems){
        if(item.userId == widget.userId){
          allClothItems.add(ClothingItemModel(pant: item));
        }
      }
      List<DressModel> allDressItems = await _dbContext!.getAllDresses();
      for (var item in allDressItems){
        if(item.userId == widget.userId){
          allClothItems.add(ClothingItemModel(dress: item));
        }
      }
      List<OuterWearModel> allOutWearItems = await _dbContext!.getAllOuterwear();
      for (var item in allOutWearItems){
        if(item.userId == widget.userId){
          allClothItems.add(ClothingItemModel(outerWear: item));
        }
      }
      List<AccessoryModel> allAccessoryItems = await _dbContext!.getAllAccessories();
      for (var item in allAccessoryItems){
        if(item.userId == widget.userId){
          allClothItems.add(ClothingItemModel(accessory: item));
        }
      }
      List<UnderGarmentModel> allUnderGarmentItems = await _dbContext!.getAllUnderGarments();
      for (var item in allUnderGarmentItems){
        if(item.userId == widget.userId){
          allClothItems.add(ClothingItemModel(underGarment: item));
        }
      }
      List<SwimWearModel> allSwimWearItems = await _dbContext!.getAllSwimWear();
      for (var item in allSwimWearItems){
        if(item.userId == widget.userId){
          allClothItems.add(ClothingItemModel(swimWear: item));
        }
      }
      List<AthleticWearModel> allAthleticWearItems = await _dbContext!.getAllAthleticWear();
      for (var item in allAthleticWearItems){
        if(item.userId == widget.userId){
          allClothItems.add(ClothingItemModel(athleticWear: item));
        }
      }
      List<FootwearModel> allFootWearItems = await _dbContext!.getAllFootwear();
      for (var item in allFootWearItems){
        if(item.userId == widget.userId){
          allClothItems.add(ClothingItemModel(footWear: item));
        }
      }
      // _closetItems = await _dbContext!.getAllClothingItems();
    } catch (e) {
      print("Error loading data: $e");
      // _closetItems = []; // Set to an empty list in case of error
    } finally {
      setState(() {}); // Update the UI regardless of success or error
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      (allClothItems.isEmpty)
          ? Center(child: Text('No items in your closet'))
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                "Your Closets",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          _buildAllClosets(context),
        ],
      ),
        floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: FloatingActionButton(
          backgroundColor: Colors.black54,
          child: Icon(Icons.add,color: Colors.white,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEditClosetScreen(
                  userId: widget.userId,
                  onSave: (newItem) {
                    setState(() {
                      if(newItem is ShirtModel){
                       allClothItems.add(ClothingItemModel(shirt: newItem));
                      }
                      else if(newItem is PantModel){
                        allClothItems.add(ClothingItemModel(pant: newItem));
                      }
                      else if(newItem is DressModel){
                        allClothItems.add(ClothingItemModel(dress: newItem));
                      }
                      else if(newItem is OuterWearModel){
                        allClothItems.add(ClothingItemModel(outerWear: newItem));
                      }
                      else if(newItem is AccessoryModel){
                        allClothItems.add(ClothingItemModel(accessory: newItem));
                      }
                      else if(newItem is AthleticWearModel){
                        allClothItems.add(ClothingItemModel(athleticWear: newItem));
                      }
                      else if(newItem is UnderGarmentModel){
                        allClothItems.add(ClothingItemModel(underGarment: newItem));
                      }
                      else if(newItem is SwimWearModel){
                        allClothItems.add(ClothingItemModel(swimWear: newItem));
                      }
                      else if(newItem is FootwearModel){
                        allClothItems.add(ClothingItemModel(footWear: newItem));
                      }
                    });
                  },
                ),
              ),
            );
          },
        ),
      ),
      backgroundColor: Colors.white10,
    );
  }

  Widget _buildAllClosets(BuildContext context) {
    return allClothItems.isEmpty ? Text('') :
      Expanded(
        child: ListView.builder(
          // shrinkWrap: true, // Important: Set shrinkWrap to true
          // physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(
            bottom: 140.0, top: 0, left: 10, right: 10,
          ),
          itemCount: allClothItems.length,
          itemBuilder: (context, index) {
            final initial =  allClothItems[index];
            late dynamic finalItem;
            if(initial.shirt != null){
              finalItem = initial.shirt;
            }
            else if(initial.pant != null){
              finalItem = initial.pant;
            }
            else if(initial.dress != null){
              finalItem = initial.dress;
            }
            else if(initial.outerWear != null){
              finalItem = initial.outerWear;
            }
            else if(initial.accessory != null){
              finalItem = initial.accessory;
            }
            else if(initial.underGarment != null){
              finalItem = initial.underGarment;
            }
            else if(initial.athleticWear != null){
              finalItem = initial.athleticWear;
            }
            else if(initial.swimWear != null){
              finalItem = initial.swimWear;
            }
            else if(initial.footWear != null){
              finalItem = initial.footWear;
            }
            final item = finalItem;

            return Dismissible(
              key: Key(item.id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                color: Colors.redAccent,
                child: Icon(Icons.delete, color: Colors.white, size: 50),
              ),
              onDismissed: (direction) async {
                //
                if(item is ShirtModel){
                  await _dbContext!.deleteShirt(item);
                }
                else if(item is PantModel){
                  await _dbContext!.deletePants(item);
                }
                else if(item is DressModel){
                  await _dbContext!.deleteDress(item);
                }
                else if(item is OuterWearModel){
                  await _dbContext!.deleteOuterwear(item);
                }
                else if(item is AccessoryModel){
                  await _dbContext!.deleteAccessory(item);
                }
                else if(item is UnderGarmentModel){
                  await _dbContext!.deleteUnderGarment(item);
                }
                else if(item is SwimWearModel){
                  await _dbContext!.deleteSwimWear(item);
                }
                else if(item is AthleticWearModel){
                  await _dbContext!.deleteAthleticWear(item);
                }
                else if(item is FootwearModel){
                  await _dbContext!.deleteFootwear(item);
                }
                await _removeItem(index);
                setState(() {
                  // Remove the item from the list by its index
                  print(index);
                  print(allClothItems[index]);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        "${item is ShirtModel || item is PantModel || item is DressModel
                            ? item.subcategory
                            : item is SwimWearModel
                            ? item.swimwearType
                            : item is AthleticWearModel
                            ? item.athleticwearType
                            : item is FootwearModel
                            ? item.footwearType
                            : item is UnderGarmentModel
                            ? item.lingerieType
                            : item is OuterWearModel
                            ? item.closureType
                            : item.accessoryClosure} dismissed"),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 20.0,
                      offset: Offset(12, 15),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: SvgPicture.network(
                          generateIcon(item),
                          width: 100,
                          height: 100,
                          color: _myColors[item.primaryColor],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item is ShirtModel || item is PantModel || item is DressModel ? item.subcategory :
                            item is SwimWearModel ? item.swimwearType :
                            item is AthleticWearModel ? item.athleticwearType:
                            item is FootwearModel ? item.footwearType :
                            item is UnderGarmentModel ? item.lingerieType:
                            item is OuterWearModel ? item.closureType:
                            item.accessoryType,
                            style: GoogleFonts.merriweather(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            "${item is SwimWearModel ? item.swimwearMaterial :
                            item is AthleticWearModel ? item.athleticwearMaterial:
                            item is UnderGarmentModel ? item.lingerieFabricType :
                            item is AccessoryModel ? item.accessoryMaterial:
                            item is FootwearModel ? item.footwearMaterial:
                            item.material} | ${item.primaryColor}",
                            style: GoogleFonts.merriweather(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            (item is PantModel)?
                            "Waist: ${item.waistType}":
                            (item is AccessoryModel)?
                            "Dimensions: ${item.accessoryDimensions}":
                            "Size: ${item.size}",
                            style: GoogleFonts.merriweather(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            (item is PantModel) ? '${item.legStyle} | ${item.fit} | ${item.occasion}' :
                            (item is AccessoryModel) ? '${item.accessoryStyle} | ${item.accessoryHeaviness} | ${item.occasion}' :
                            (item is UnderGarmentModel) ? '${item.patternDetails} | ${item.waistbandStyle} | ${item.supportType}' :
                            (item is SwimWearModel) ? '${item.swimwearStrapType} | ${item.swimwearSupportType} | Swimming' :
                            (item is AthleticWearModel) ? '${item.athleticwearWaistType} | ${item.athleticwearFitType} | Athletics' :
                            (item is FootwearModel) ? '${item.toeShape} | ${item.soleType} | ${item.occasion}' :
                            '${item.pattern} | ${item.fit} | ${item.occasion}',
                            style: GoogleFonts.merriweather(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Season: ${item.season}",
                            style: GoogleFonts.merriweather(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '${item.sustainability} | ${item.careInstructions}',
                            style: GoogleFonts.merriweather(
                              fontSize: 11,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 1, color: Colors.brown),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              print(item);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MakePostScreen(
                                    userId: widget.userId,
                                    item: item,
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.post_add, color: Colors.white, size: 30),
                            label: Text(
                              'Post',
                              style: const TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown.shade700,
                              minimumSize: const Size(30, 35),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.black, size: 25),
                            onPressed: () {
                              ClothingItemModel? editingItem;
                              if(item is ShirtModel){
                                editingItem = ClothingItemModel(shirt: item);
                              }
                              else if(item is PantModel){
                                editingItem = ClothingItemModel(pant: item);
                              }
                              else if(item is DressModel){
                                editingItem = ClothingItemModel(dress: item);
                              }
                              else if(item is OuterWearModel){
                                editingItem = ClothingItemModel(outerWear: item);
                              }
                              else if(item is AccessoryModel){
                                editingItem = ClothingItemModel(accessory: item);
                              }
                              else if(item is UnderGarmentModel){
                                editingItem = ClothingItemModel(underGarment: item);
                              }
                              else if(item is SwimWearModel){
                                editingItem = ClothingItemModel(swimWear: item);
                              }
                              else if(item is AthleticWearModel){
                                editingItem = ClothingItemModel(athleticWear: item);
                              }
                              else if(item is FootwearModel){
                                editingItem = ClothingItemModel(footWear: item);
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddEditClosetScreen(
                                    userId: widget.userId,
                                    clothingItem: editingItem,
                                    onSave: (editedItem) {
                                      setState(() {
                                        if(editedItem is ShirtModel){
                                          allClothItems[index].shirt = editedItem;
                                        }
                                        else if(editedItem is PantModel){
                                          allClothItems[index].pant = editedItem;
                                        }
                                        else if(editedItem is DressModel){
                                          allClothItems[index].dress = editedItem;
                                        }
                                        else if(editedItem is OuterWearModel){
                                          allClothItems[index].outerWear = editedItem;
                                        }
                                        else if(editedItem is AccessoryModel){
                                          allClothItems[index].accessory = editedItem;
                                        }
                                        else if(editedItem is AthleticWearModel){
                                          allClothItems[index].athleticWear = editedItem;
                                        }
                                        else if(editedItem is UnderGarmentModel){
                                          allClothItems[index].underGarment = editedItem;
                                        }
                                        else if(editedItem is SwimWearModel){
                                          allClothItems[index].swimWear = editedItem;
                                        }
                                        else if(editedItem is FootwearModel){
                                          allClothItems[index].footWear = editedItem;
                                        }
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
  }

  String generateIcon(dynamic item) {
    String itemType;
    if(item is ShirtModel || item is PantModel || item is DressModel){
      itemType = item.subcategory ?? "";
    }
    else{
      itemType = "";
    }
    String color = item . primaryColor;
    // print(itemType + color);
    String iconSvg;

    // if(item.category == 'Shirt' || item.category == 'Pant' ||
    //     item.category == 'Dress' || item.category == 'Skirt'){
    //   itemType = item.subcategory ?? "";
    // }
    // else{
    //   itemType = item.category;
    // }
    switch (itemType) {
      case 'T_Shirt':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/4454/t-shirt.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/127530/tshirt-with-pocket.svg';
        }
        break;

      case 'Full Sleeve':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/482554/y-shirt-6.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/275032/shirt.svg';
        }
        break;

      case 'Half Sleeve':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/275017/shirt.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/275019/shirt.svg';
        }
        break;

      case 'Polo':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/506962/clo-polo.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/507016/clo-polo.svg';
        }
        break;

      case 'Button-Down':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/297933/shirt.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/346341/shirt-fill.svg';
        }
        break;

      case 'Blouse':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/128688/blouse.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/128688/blouse.svg';
        }
        break;

      case 'Tank Top':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/323430/tank-top.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/323430/tank-top.svg';
        }
        break;

      case 'Jeans':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/275023/jeans-garment.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/275018/jeans.svg';
        }
        break;

      case 'Cargo':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/260982/pants.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/275005/jeans-pants.svg';
        }
        break;

      case 'Trousers':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/274925/trousers.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/275004/trousers.svg';
        }
        break;

      case 'Sweatpants':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/274929/trousers-pants.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/275007/trousers-pants.svg';
        }
        break;

      case 'Leggings':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/278189/trousers-pants.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/278189/trousers-pants.svg';
        }
        break;

      case 'Shorts':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/513346/shorts.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/513248/shorts.svg';
        }
        break;

      case 'Casual Dress':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/308544/dress-clothes-gown.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/308544/dress-clothes-gown.svg';
        }
        break;

      case 'Formal Dress':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/320091/dress.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/320091/dress.svg';
        }
        break;

      case 'Maxi':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/409424/dress-3.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/409424/dress-3.svg';
        }
        break;

      case 'Midi':
        if(!(item.hasPockets)){
          iconSvg = 'https://www.svgrepo.com/show/482607/dress-3.svg';
        }
        else{
          iconSvg = 'https://www.svgrepo.com/show/482607/dress-3.svg';
        }
        break;

      case 'Cocktail Dress':
        iconSvg = '''
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="70">
          <rect width="50" height="70" fill="#D2B48C"/> <!-- Light brown background -->
          <path d="M10 10 H40 L35 40 H15 Z" fill="$color"/> <!-- Cocktail Dress shape -->
          <path d="M10 40 Q25 60 40 40 Z" fill="$color"/> <!-- Cocktail Dress Bottom -->
        </svg>
      ''';
        break;

      case 'Sundress':
        iconSvg = '''
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="70">
          <rect width="50" height="70" fill="#D2B48C"/> <!-- Light brown background -->
          <path d="M10 10 H40 L35 40 H15 Z" fill="$color"/> <!-- Sundress shape -->
          <path d="M10 40 Q25 60 40 40 Z" fill="$color"/> <!-- Sundress Bottom -->
        </svg>
      ''';
        break;

      case 'Mini Skirt':
        iconSvg = '''
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="30">
          <rect width="50" height="30" fill="#D2B48C"/> <!-- Light brown background -->
          <path d="M10 0 H40 L35 30 H15 Z" fill="$color"/> <!-- Mini Skirt shape -->
        </svg>
      ''';
        break;

      case 'Midi Skirt':
        iconSvg = '''
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="40">
          <rect width="50" height="40" fill="#D2B48C"/> <!-- Light brown background -->
          <path d="M10 0 H40 L35 40 H15 Z" fill="$color"/> <!-- Midi Skirt shape -->
        </svg>
      ''';
        break;

      case 'Maxi Skirt':
        iconSvg = '''
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="60">
          <rect width="50" height="60" fill="#D2B48C"/> <!-- Light brown background -->
          <path d="M10 0 H40 L35 60 H15 Z" fill="$color"/> <!-- Maxi Skirt shape -->
        </svg>
      ''';
        break;

      case 'Pencil Skirt':
        iconSvg = '''
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50">
          <rect width="50" height="50" fill="#D2B48C"/> <!-- Light brown background -->
          <path d="M10 0 H40 L35 50 H15 Z" fill="$color"/> <!-- Pencil Skirt shape -->
        </svg>
      ''';
        break;

      case 'A-Line Skirt':
        iconSvg = '''
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50">
          <rect width="50" height="50" fill="#D2B48C"/> <!-- Light brown background -->
          <path d="M10 0 H40 L35 50 H15 Z" fill="$color"/> <!-- A-Line Skirt shape -->
        </svg>
      ''';
        break;

      case 'Jacket':
        iconSvg = '''
        <svg xmlns="http://www.w3.org/2000/svg" width="50" height="50">
          // <rect width="100" height="100" fill="#D2B48C"/> <!-- Light brown background -->
          <path d="M10 10 H40 L35 40 H15 Z" fill="$color"/> <!-- Jacket shape -->
          <path d="M5 10 L15 0 L15 10 Z" fill="$color"/> <!-- Left Sleeve -->
          <path d="M35 10 L45 0 L45 10 Z" fill="$color"/> <!-- Right Sleeve -->
        </svg>
      ''';
        break;

      default:
        iconSvg ="https://www.svgrepo.com/show/163823/landscape-photo.svg";
        break;
    }

    return iconSvg;
  }

  Future<void> _removeItem(int index) async {
    final item = allClothItems[index];
    // await _dbContext!.deleteClothingItem(item);
    setState(() {
      allClothItems.removeAt(index);
    });
  }
}
