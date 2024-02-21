class Swipe {
  // Who is doing the swiping
  final int swiperID;

  // Who is swiped upon
  final int swipeeID;
  
  final bool liked;

  const Swipe({
    required this.swiperID,
    required this.swipeeID,
    required this.liked,
  });
}