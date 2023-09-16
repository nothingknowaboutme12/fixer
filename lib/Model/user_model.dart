UserModel? userModel;

class UserModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String role;
  final String projectName;
  final String floorName;
  final String apartmentName;
  final String email;
  final String maintainerName;
  final String maintainerEmail;
  final String maintainPhone;
  final bool addDetail;
  UserModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.role,
    required this.projectName,
    required this.floorName,
    required this.apartmentName,
    required this.email,
    required this.maintainerName,
    required this.maintainerEmail,
    required this.maintainPhone,
    required this.addDetail,
  });

  // Method to convert a User instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'role': role,
      'projectName': projectName,
      'floorName': floorName,
      'apartmentName': apartmentName,
      'email': email,
    };
  }

  // Factory method to create a User instance from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      role: map['role'] ?? '',
      projectName: map['projectName'] ?? '',
      floorName: map['floorName'] ?? '',
      apartmentName: map['apartmentName'] ?? '',
      email: map['email'] ?? '',
      maintainerName: map['maintainerName'] ?? '',
      maintainerEmail: map['maintainerEmail'] ?? '',
      maintainPhone: map['maintainerPhone'] ?? '',
      addDetail: map['addDetail'] ?? false,
    );
  }
}
