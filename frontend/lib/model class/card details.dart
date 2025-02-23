class CardModel {
  final String title; // Title of the card
  final String foodSpot; // Associated food spot
  final String image; // Image URL
  final String location; // Location of the food spot
  // double compatibilityScore; // Compatibility score based on user preferences
  bool isLiked; // User's swipe action (like or dislike)

  CardModel({
    required this.title,
    required this.foodSpot,
    required this.image,
    required this.location,
    // this.compatibilityScore = 0.0, // Default score is 0
    this.isLiked = false, // Default swipe state is not liked
  });
}
