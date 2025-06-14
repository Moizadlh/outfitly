import 'package:outfitly/Models/AccessoryClothItemModel.dart';
import 'package:outfitly/Models/AthleticWearClothItemModel.dart';
import 'package:outfitly/Models/DressClothItemModel.dart';
import 'package:outfitly/Models/FootwearClothItemModel.dart';
import 'package:outfitly/Models/OutWearClothItemModel.dart';
import 'package:outfitly/Models/PantClothItemModel.dart';
import 'package:outfitly/Models/ShirtClothItemModel.dart';
import 'package:outfitly/Models/SwimWearClothItemModel.dart';
import 'package:outfitly/Models/UndergarmentsClothItemModel.dart';

class ClothingItemModel {
  ShirtModel? shirt;
  PantModel? pant;
  OuterWearModel? outerWear;
  DressModel? dress;
  FootwearModel? footWear;
  AccessoryModel? accessory;
  UnderGarmentModel? underGarment;
  SwimWearModel? swimWear;
  AthleticWearModel? athleticWear;

  // Constructor
  ClothingItemModel({
    this.shirt,
    this.pant,
    this.outerWear,
    this.dress,
    this.footWear,
    this.accessory,
    this.underGarment,
    this.swimWear,
    this.athleticWear,
  });

  @override
  String toString() {
    return 'ClothingItemModel{shirt: $shirt, pant: $pant, outerWear: $outerWear, dress: $dress, footWear: $footWear, accessory: $accessory, underGarment: $underGarment, swimWear: $swimWear, athleticWear: $athleticWear}';
  }
}

