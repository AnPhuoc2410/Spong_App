class User{
  final String id;
  final String username;
  final String fullName; // Combined first + last name from API
  final String email;

  User({required this.id, required this.username, required this.fullName, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    final nameData = json['name'];
    String fullName = '';
    if (nameData is Map) {
      final first = nameData['firstname'] ?? '';
      final last = nameData['lastname'] ?? '';
      fullName = [first, last].where((e) => (e ?? '').toString().isNotEmpty).join(' ').trim();
    } else if (json['fullName'] != null) {
      fullName = json['fullName'];
    } else if (json['name'] is String) {
      fullName = json['name'];
    }
    return User(
      id: json['id'].toString(),
      username: json['username']?.toString() ?? '',
      fullName: fullName,
      email: json['email']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'fullName': fullName,
      'email': email,
    };
  }
}