class AIModel{

  // Method for the suggested outfits
  // For Now it's just showing a self generated list
  List<Map<String, String>> GetSuggestedOutfits(){
    List<Map<String, String>>? suggestedOutfits = [
      {
        'image': 'assets/images/imagesuggest.jpg', // Dummy image
        'title': 'Casual Summer Look',
        'description': 'Light shirt, beige trousers, and sneakers.',
        'price' : '23'
      },
      {
        'image': 'assets/images/imagesuggest.jpg', // Dummy image
        'title': 'Business Formal',
        'description': 'Dark suit with a red tie and polished shoes.',
        'price' : '35'
      },
      {
        'image': 'assets/images/imagesuggest.jpg', // Dummy image
        'title': 'Sporty Vibes',
        'description': 'Track pants, hoodie, and running shoes.',
        'price' : '37'
      },
      {
        'image': 'assets/images/SplashImage.jpg', // Dummy image
        'title': 'Street Style',
        'description': 'Denim jacket, ripped jeans, and high-top sneakers.',
        'price' : '42'
      },
      {
        'image': 'assets/images/SplashImage.jpg', // Dummy image
        'title': 'Winter Layers',
        'description': 'Cozy sweater, scarf, and boots.',
        'price' : '28'
      },
    ];
    return suggestedOutfits;
  }



  // For Image making through AI I have function in closetScreen and SocialScreen
  //   For Now it generate some svg vectors you need to conclude AI there.
}