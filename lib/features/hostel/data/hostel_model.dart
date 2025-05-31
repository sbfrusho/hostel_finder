class HostelModel {
  final List<String> images;
  final String price;
  final String roomType;
  final String description;
  final double roomScore;
  final int cleanlinessStars;

  HostelModel({
    required this.images,
    required this.price,
    required this.roomType,
    required this.description,
    this.roomScore = 5.0,
    this.cleanlinessStars = 3,
  });
}
