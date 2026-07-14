import '../../core/constants/app_assets.dart';
import '../models/course_model.dart';

class CourseRepository {
  static final List<CourseModel> mockCourses = [
    CourseModel(
      id: '1',
      title: 'Flutter Development Masterclass',
      description:
          'Learn Flutter from scratch and build beautiful mobile apps',
      thumbnail: AppAssets.bookFlutter,
      instructorName: 'John Doe',
      instructorAvatar: AppAssets.bookInstructor,
      category: '1',
      price: 49.99,
      rating: 4.8,
      totalLessons: 85,
      totalHours: 24,
      enrolledStudents: 12500,
      isEnrolled: true,
      progress: 0.45,
    ),
    CourseModel(
      id: '2',
      title: 'Python for Data Science',
      description:
          'Master Python programming for data analysis and machine learning',
      thumbnail: AppAssets.bookPython,
      instructorName: 'Jane Smith',
      instructorAvatar: AppAssets.bookInstructor,
      category: '1',
      price: 59.99,
      rating: 4.9,
      totalLessons: 120,
      totalHours: 36,
      enrolledStudents: 28000,
      isEnrolled: false,
      progress: 0.0,
    ),
    CourseModel(
      id: '3',
      title: 'UI/UX Design Fundamentals',
      description:
          'Learn the principles of user interface and experience design',
      thumbnail: AppAssets.bookDesign,
      instructorName: 'Mike Johnson',
      instructorAvatar: AppAssets.bookInstructor,
      category: '3',
      price: 39.99,
      rating: 4.7,
      totalLessons: 65,
      totalHours: 18,
      enrolledStudents: 8500,
      isEnrolled: true,
      progress: 0.72,
    ),
    CourseModel(
      id: '4',
      title: 'Digital Marketing Strategy',
      description: 'Build effective digital marketing campaigns from scratch',
      thumbnail: AppAssets.bookMarketing,
      instructorName: 'Sarah Williams',
      instructorAvatar: AppAssets.bookInstructor,
      category: '4',
      price: 44.99,
      rating: 4.6,
      totalLessons: 55,
      totalHours: 15,
      enrolledStudents: 6200,
      isEnrolled: false,
      progress: 0.0,
    ),
    CourseModel(
      id: '5',
      title: 'JavaScript Complete Guide',
      description: 'From basics to advanced - become a JavaScript expert',
      thumbnail: AppAssets.bookJavascript,
      instructorName: 'David Brown',
      instructorAvatar: AppAssets.bookInstructor,
      category: '1',
      price: 54.99,
      rating: 4.8,
      totalLessons: 150,
      totalHours: 42,
      enrolledStudents: 35000,
      isEnrolled: false,
      progress: 0.0,
    ),
    CourseModel(
      id: '6',
      title: 'Business Analytics',
      description: 'Learn to make data-driven business decisions',
      thumbnail: AppAssets.bookBusiness,
      instructorName: 'Emily Davis',
      instructorAvatar: AppAssets.bookInstructor,
      category: '2',
      price: 0,
      rating: 4.5,
      totalLessons: 40,
      totalHours: 12,
      enrolledStudents: 4500,
      isFree: true,
      isEnrolled: false,
      progress: 0.0,
    ),
    CourseModel(
      id: '7',
      title: 'Machine Learning Basics',
      description: 'Introduction to machine learning algorithms and models',
      thumbnail: AppAssets.bookMl,
      instructorName: 'Alex Chen',
      instructorAvatar: AppAssets.bookInstructor,
      category: '1',
      price: 64.99,
      rating: 4.9,
      totalLessons: 90,
      totalHours: 28,
      enrolledStudents: 18000,
      isEnrolled: false,
      progress: 0.0,
    ),
  ];

  Future<List<CourseModel>> getPopularCourses() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockCourses;
  }

  Future<List<CourseModel>> getCoursesByCategory(String categoryId) async {
    await Future.delayed(const Duration(seconds: 1));
    return mockCourses.where((c) => c.category == categoryId).toList();
  }

  Future<List<CourseModel>> getEnrolledCourses() async {
    await Future.delayed(const Duration(seconds: 1));
    return mockCourses.where((c) => c.isEnrolled).toList();
  }

  Future<List<CourseModel>> searchCourses(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    if (query.isEmpty) return [];
    return mockCourses
        .where((c) =>
            c.title.toLowerCase().contains(query.toLowerCase()) ||
            c.description.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
