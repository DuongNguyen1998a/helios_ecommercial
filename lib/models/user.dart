class User {
  final int customerID;
  final int companyID;
  final String customerName;
  final String address;
  final String taxCode;
  final String email;
  final String userName;
  final String token;

  User(
      {required this.customerID,
        required this.companyID,
        required this.customerName,
        required this.address,
        required this.taxCode,
        required this.email,
        required this.userName,
        required this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      customerID: json['customerID'],
      companyID: json['companyID'],
      customerName: json['customerName'],
      address: json['address'],
      taxCode: json['taxCode'],
      email: json['email'],
      userName: json['userName'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customerID'] = customerID;
    data['companyID'] = companyID;
    data['customerName'] = customerName;
    data['address'] = address;
    data['taxCode'] = taxCode;
    data['email'] = email;
    data['userName'] = userName;
    data['token'] = token;
    return data;
  }
}
