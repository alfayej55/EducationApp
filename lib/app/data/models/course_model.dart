class CourseModel {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final String instructorName;
  final String instructorAvatar;
  final String category;
  final double price;
  final double rating;
  final int totalLessons;
  final int totalHours;
  final int enrolledStudents;
  final bool isFree;
  final bool isEnrolled;
  final double progress;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.instructorName,
    this.instructorAvatar = '',
    required this.category,
    required this.price,
    required this.rating,
    required this.totalLessons,
    required this.totalHours,
    required this.enrolledStudents,
    this.isFree = false,
    this.isEnrolled = false,
    this.progress = 0.0,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      instructorName: json['instructor_name'] ?? '',
      instructorAvatar: json['instructor_avatar'] ?? '',
      category: json['category'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      rating: (json['rating'] ?? 0).toDouble(),
      totalLessons: json['total_lessons'] ?? 0,
      totalHours: json['total_hours'] ?? 0,
      enrolledStudents: json['enrolled_students'] ?? 0,
      isFree: json['is_free'] ?? false,
      isEnrolled: json['is_enrolled'] ?? false,
      progress: (json['progress'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'thumbnail': thumbnail,
      'instructor_name': instructorName,
      'instructor_avatar': instructorAvatar,
      'category': category,
      'price': price,
      'rating': rating,
      'total_lessons': totalLessons,
      'total_hours': totalHours,
      'enrolled_students': enrolledStudents,
      'is_free': isFree,
      'is_enrolled': isEnrolled,
      'progress': progress,
    };
  }
}
