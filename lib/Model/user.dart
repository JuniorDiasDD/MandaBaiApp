class User {
 String? name,
      nickname,
      email,
      telefone,
      senha,
      username,
      avatar,
      country,
      city;
  User(
      { this.name,
       this.email,
       this.telefone,
       this.senha,
       this.username,
       this.nickname,
       this.avatar,
       this.city,
       this.country});
  static Map<String, dynamic> toMap(User item) => {
        'name': item.name,
        'nickname': item.nickname,
        'email': item.email,
        'telefone': item.telefone,
        'country': item.country,
        'city': item.city,
      };
}
