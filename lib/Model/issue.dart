class IssueModel {
  final String id;
  final String apartmentName;
  final String issue;
  final String priority;
  final String dateReported;
  final String reportedBy;
  final String project;
  final String apartment;
  final List<String> issuesList;
  final String assignedTo;
  final bool fixed;
  final String discriptions;
  final String imageUrl;
  final String issueNumber;
  final String techniationId;
  final String techniationName;
  final String techniationEmail;
  final String techniationPhone;
  final String userName;
  final String userEmail;
  final String userPhone;
  final String fixedDate;
  IssueModel({
    required this.id,
    required this.apartmentName,
    required this.issue,
    required this.priority,
    required this.dateReported,
    required this.reportedBy,
    required this.project,
    required this.apartment,
    required this.issuesList,
    required this.assignedTo,
    required this.fixed,
    required this.discriptions,
    required this.imageUrl,
    required this.issueNumber,
    required this.techniationId,
    required this.techniationName,
    required this.techniationEmail,
    required this.techniationPhone,
    required this.userName,
    required this.userEmail,
    required this.userPhone,
    required this.fixedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'apartmentName': apartmentName,
      'issue': issue,
      'priority': priority,
      'dateReported': dateReported,
      'reportedBy': reportedBy,
      'project': project,
      'apartment': apartment,
      'issuesList': issuesList,
      'assignedTo': assignedTo,
      'fixed': fixed,
      'discriptions': discriptions,
      'imageUrl': imageUrl,
      'maintainer_id': techniationId,
      'maintainerName': techniationName,
      'maintainerEmail': techniationEmail,
      'maintainerPhone': techniationPhone,
      'userName': userName,
      'userPhone': userPhone,
      'userEmail': userEmail,
    };
  }

  // You can also define a factory constructor to create an Issue object from a map
  factory IssueModel.fromMap(Map<String, dynamic> map) {
    return IssueModel(
      id: map['id'] ?? '',
      apartmentName: map['apartmentName'] ?? '',
      issue: map['issue'] ?? '',
      priority: map['periority'] ?? '',
      dateReported: map['dateReported'].toString().split(' ')[0] ?? '',
      reportedBy: map['reportedBy'] ?? '',
      project: map['projectName'] ?? '',
      apartment: map['apartmentName'],
      issuesList: List<String>.from(map['issuesList']) ?? [],
      assignedTo: map['assignedTo'] ?? '',
      discriptions: map['discriptions'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      fixed: map['fixed'] ?? false,
      issueNumber: map['issueNumber'] ?? "",
      techniationId: map['techniationId'] ?? "",
      techniationName: map['techniationName'] ?? "",
      techniationEmail: map['techniationEmail'] ?? "",
      techniationPhone: map['techniationPhone'] ?? "",
      userName: map['userName'] ?? "",
      userPhone: map['userPhone'] ?? "",
      userEmail: map['userEmail'] ?? "",
      fixedDate: map['fixedDate'].toString().split(' ')[0] ?? '',
    );
  }
}
