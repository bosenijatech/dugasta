class Apartment {
  final String imagePath;
  final String title;
  final String location;
  final double price = 0;

  Apartment(this.imagePath, this.title, this.location, price);

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'title': title,
        'location': location,
        'price': price,
      };

  static Apartment fromJson(Map<String, dynamic> json) => Apartment(
      json['imagePath'],
      json['title'].toString(),
      json['location'].toString(),
      json['price']);
}
