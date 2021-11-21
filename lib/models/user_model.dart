class UserModel {
  int id;
  String name;
  String email;
  String username;
  String profilePhotoUrl;
  String address;
  String token;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    required this.profilePhotoUrl,
    required this.address,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id : json['id'],
    name: json['name'],
    email: json['email'],
    username: json['username'],
    profilePhotoUrl: json['profile_photo_url'],
    address: json['address'],
    token: json['token']
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'profile_photo_url': profilePhotoUrl,
      'address': address,
      'token': token,
    };
  }
}
