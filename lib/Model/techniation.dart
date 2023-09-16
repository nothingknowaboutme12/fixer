class Technicians {
  final String techniationName;
  final String techniationEmail;
  final String techniationPhone;

  Technicians({
    required this.techniationName,
    required this.techniationEmail,
    required this.techniationPhone,
  });

  factory Technicians.fromMap(Map<String, dynamic> map) {
    return Technicians(
      techniationName: map['techniationName'] ?? '',
      techniationEmail: map['techniationEmail'] ?? '',
      techniationPhone: map['techniationPhone'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'techniationName': techniationName ?? '',
      'techniationEmail': techniationEmail ?? '',
      'techniationPhone': techniationPhone ?? '',
    };
  }
}
