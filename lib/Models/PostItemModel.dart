import 'package:outfitly/Models/ClothingItemModel.dart';

class CompletePostItemModel {
  final int? PostId;
  final String? UserName;
  final String? Caption;
  final DateTime? PostDateTime;
  final dynamic Item;

  CompletePostItemModel({
    required this.PostId,
    required this.UserName,
    required this.Item,
    required this.Caption,
    required this.PostDateTime
  });
}
