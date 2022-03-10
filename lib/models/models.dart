class Uuser {
  final String name;
  final String phone;

  Uuser({
    required this.name,
    required this.phone,
  });
}

class UserPremiumBool {
  final bool premium;

  UserPremiumBool({required this.premium});
}

class PremiumDataModel {
  final String houseName;
  final int length;
  final int bredth;
  final int area;
  final String type;
  final String city;
  final String state;

  PremiumDataModel({
    required this.houseName,
    required this.length,
    required this.bredth,
    required this.area,
    required this.type,
    required this.city,
    required this.state,
  });
}

class UserHousePlanModel {
  String name;
  UserHousePlanModel({required this.name});
}

class UserProfilePicModel {
  String url;
  UserProfilePicModel({required this.url});
}

class SuperviserModel {
  String name;
  String age;
  String image;
  SuperviserModel({required this.name, required this.age, required this.image});
}

class UserAmountModel {
  int total;
  UserAmountModel({required this.total});
}