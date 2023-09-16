class MangerDetail {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;

  MangerDetail({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id ?? "",
      'firstName': firstName ?? "",
      'lastName': lastName ?? "",
      'phoneNumber': phoneNumber ?? "",
    };
  }

  factory MangerDetail.fromMap(Map<String, dynamic> map) {
    return MangerDetail(
      id: map['id'] ?? "",
      firstName: map['firstName'] ?? "",
      lastName: map['lastName'] ?? "",
      phoneNumber: map['phone'] ?? "",
    );
  }
}
