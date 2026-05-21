class ProductModel {
  final int id;
  final String title;
  final double price;
   int stock;
  final String category;
  final List<String> images;
  final List<Review> reviews;
  int selectedCount;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.stock,
    required this.category,
    required this.images,
    required this.reviews,
    required this.selectedCount
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      price: double.parse(json['price'].toString() ?? '0') ?? 0,
        stock: json['stock'] ?? 0,
      category: json['category'] ?? '',
        images:json['images'] != null
            ? List<String>.from(json['images'])
            : [],
        reviews:  json['reviews'] != null
            ? (json['reviews'] as List)
            .map((e) => Review.fromJson(e))
            .toList()
            : [],
      selectedCount: json['selectedCount'] ?? 1
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'stock': stock,
      'category': category,
      'images': images,
      'reviews': reviews.map((e) => e.toJson()).toList(), // convert Review objects
      'selectedCount' : selectedCount
    };
  }
}

class Review {
  final int rating;
  final String comment;
  final DateTime date;
  final String reviewerName;
  final String reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      rating: json['rating'],
      comment: json['comment'],
      date: DateTime.parse(json['date']),
      reviewerName: json['reviewerName'],
      reviewerEmail: json['reviewerEmail'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'rating': rating,
      'comment': comment,
      'date': date.toIso8601String(), // convert DateTime to String
      'reviewerName': reviewerName,
      'reviewerEmail': reviewerEmail,
    };
  }
}