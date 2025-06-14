class PostItemModel {
  int? postId;
  int? UserId;
  bool IsUnknownPost;
  int? Likes;
  DateTime? postDateTime;
  String? ScreenCaption;

  // item attributes
  int? shirtId;
  int? pantId;
  int? outerwearId;
  int? dressId;
  int? swimWearId;
  int? AccessoryId;
  int? athleticWearId;
  int? undergarmentId;
  int? footWearId;

  PostItemModel({
    this.postId,
    this.UserId,
    required this.IsUnknownPost,
    this.Likes,
    this.postDateTime,
    this.ScreenCaption,
    this.shirtId,
    this.pantId,
    this.outerwearId,
    this.dressId,
    this.swimWearId,
    this.AccessoryId,
    this.athleticWearId,
    this.undergarmentId,
    this.footWearId,
  });

  PostItemModel.fromMap(Map<String, dynamic> res)
      : postId = res['postId'],
        UserId = res['UserId'],
        IsUnknownPost = res['IsUnknownPost'] == 1,
        Likes = res['Likes'],
        postDateTime = DateTime.parse(res['postDateTime']),
        ScreenCaption = res['ScreenCaption'],
  // Initialize new attributes from map
        shirtId = res['shirtId'],
        pantId = res['pantId'],
        outerwearId = res['outerwearId'],
        dressId = res['dressId'],
        swimWearId = res['swimWearId'],
        AccessoryId = res['AccessoryId'],
        athleticWearId = res['athleticWearId'],
        undergarmentId = res['undergarmentId'],
        footWearId = res['footWearId'];

  Map<String, Object?> toMap() {
    return {
      "postId": postId,
      "UserId": UserId,
      "IsUnknownPost": IsUnknownPost ? 1 : 0,
      "Likes": Likes,
      "postDateTime": postDateTime?.toIso8601String(),
      "ScreenCaption": ScreenCaption,
      // Add new attributes to map
      "shirtId": shirtId,
      "pantId": pantId,
      "outerwearId": outerwearId,
      "dressId": dressId,
      "swimWearId": swimWearId,
      "AccessoryId": AccessoryId,
      "athleticWearId": athleticWearId,
      "undergarmentId": undergarmentId,
      "footWearId": footWearId,
    };
  }

  @override
  String toString() {
    return 'PostItemModel{postId: $postId, UserId: $UserId, IsUnknownPost: $IsUnknownPost, Likes: $Likes, postDateTime: $postDateTime, ScreenCaption: $ScreenCaption, shirtId: $shirtId, pantId: $pantId, outerwearId: $outerwearId, dressId: $dressId, swimWearId: $swimWearId, AccessoryId: $AccessoryId, athleticWearId: $athleticWearId, undergarmentId: $undergarmentId, footWearId: $footWearId}';
  }
}
