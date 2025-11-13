class MyUserEntity {
  final String userId;
  final String name;
  final String email;
  bool hasActiveCart;

  MyUserEntity({
    required this.userId,
    required this.name,
    required this.email,
    required this.hasActiveCart,
  });

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'hasActiveCart': hasActiveCart,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userId: doc['userId'],
      name: doc['name'],
      email: doc['email'],
      hasActiveCart: doc['hasActiveCart'],
    );
  }
}