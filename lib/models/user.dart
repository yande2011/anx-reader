

class User {
  int id;
  String username;
  String name;
  String email;
  String avatar;
  bool isAdmin;
  bool isActive;
  String permission;
  String createdAt;
  String updatedAt;
  String extra;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.avatar,
    required this.isAdmin,
    required this.isActive,
    required this.permission,
    required this.createdAt,
    required this.updatedAt,
    required this.extra,
  });


}