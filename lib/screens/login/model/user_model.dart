class UserModel {
  final int id;
  final String name;
  final String image; // url OR local path
  final String role;
  final String token;

  UserModel({
    required this.id,
    required this.name,
    required this.image,
    required this.role,
    required this.token
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json['name'],
      image: json['image'],
      role: json['role'],
      token: json['token']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'role': role,
      'token': token
    };
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? image,
    String? role,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      role: role ?? this.role,
      token: token ?? this.token,
    );
  }
}
