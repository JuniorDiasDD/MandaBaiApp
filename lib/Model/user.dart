class User {
  String name,
      nickname,
      email,
      telefone,
      senha,
      username,
      avatar,
      country,
      city;
  User(
      {required this.name,
      required this.email,
      required this.telefone,
      required this.senha,
      required this.username,
      required this.nickname,
      required this.avatar,
      required this.city,
      required this.country});
  static Map<String, dynamic> toMap(User item) => {
        'name': item.name,
        'nickname': item.nickname,
        'email': item.email,
        'telefone': item.telefone,
        'country': item.country,
        'city': item.city,
      };
}
