import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../data/models/course_model.dart';
import '../../data/repositories/course_repository.dart';
import '../../local_database/services/saved_courses_local_service.dart';
import '../../widgets/app_image.dart';

class CourseDetailView extends StatefulWidget {
  const CourseDetailView({super.key});

  @override
  State<CourseDetailView> createState() => _CourseDetailViewState();
}

class _CourseDetailViewState extends State<CourseDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late CourseModel course;
  final SavedCoursesLocalService _savedCoursesService =
      SavedCoursesLocalService();
  late bool _isSaved;

  @override
  void initState() {
    super.initState();
    course = Get.arguments as CourseModel? ?? CourseRepository.mockCourses.first;
    _isSaved = _savedCoursesService.isSaved(course.id);
    _tabController = TabController(length: 3, vsync: this);
  }

  Future<void> _toggleSaved() async {
    await _savedCoursesService.toggleSaved(course.id);
    setState(() {
      _isSaved = _savedCoursesService.isSaved(course.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Image
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.white, size: 18),
              ),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                onPressed: _toggleSaved,
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.share, color: Colors.white, size: 20),
                ),
                onPressed: () {},
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  AppImage(
                    imagePath: course.thumbnail,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),
                  // Play Button
                  Center(
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Tag
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Development',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Title
                  Text(course.title, style: AppTextStyles.h2),
                  const SizedBox(height: 16),

                  // Stats Row
                  Row(
                    children: [
                      _buildStat(Icons.star, '${course.rating}', AppColors.warning),
                      const SizedBox(width: 20),
                      _buildStat(Icons.play_circle_outline,
                          '${course.totalLessons} lessons', AppColors.textSecondary),
                      const SizedBox(width: 20),
                      _buildStat(Icons.timer_outlined, '${course.totalHours}h',
                          AppColors.textSecondary),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Instructor
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                          backgroundImage: course.instructorAvatar.isNotEmpty
                              ? AssetImage(course.instructorAvatar)
                              : null,
                          child: course.instructorAvatar.isEmpty
                              ? const Icon(Icons.person, color: AppColors.primary)
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(course.instructorName,
                                  style: AppTextStyles.bodyLarge
                                      .copyWith(fontWeight: FontWeight.w600)),
                              Text('Senior Flutter Developer',
                                  style: AppTextStyles.caption),
                            ],
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          child: const Text('Follow'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Tab Bar
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.scaffoldBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.textSecondary,
                      indicator: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                      padding: const EdgeInsets.all(4),
                      tabs: const [
                        Tab(text: 'About'),
                        Tab(text: 'Lessons'),
                        Tab(text: 'Reviews'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Tab Content
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAboutTab(),
                _buildLessonsTab(),
                _buildReviewsTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildStat(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: AppTextStyles.bodySmall.copyWith(
            color: color == AppColors.warning ? color : AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About This Course', style: AppTextStyles.h4),
          const SizedBox(height: 12),
          Text(
            course.description,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 24),
          Text('What You\'ll Learn', style: AppTextStyles.h4),
          const SizedBox(height: 12),
          _buildLearningPoint('Build complete Flutter applications from scratch'),
          _buildLearningPoint('Master Dart programming language'),
          _buildLearningPoint('Implement state management with GetX'),
          _buildLearningPoint('Work with REST APIs and Firebase'),
          _buildLearningPoint('Create beautiful UI with custom animations'),
          _buildLearningPoint('Deploy apps to App Store and Play Store'),
          const SizedBox(height: 24),
          Text('Requirements', style: AppTextStyles.h4),
          const SizedBox(height: 12),
          _buildRequirement('Basic programming knowledge'),
          _buildRequirement('A computer (Mac, Windows, or Linux)'),
          _buildRequirement('No Flutter experience required'),
        ],
      ),
    );
  }

  Widget _buildLearningPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: AppColors.success, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: AppTextStyles.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.arrow_right, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(text, style: AppTextStyles.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildLessonsTab() {
    final sections = [
      {'title': 'Getting Started', 'lessons': 5, 'duration': '45 min'},
      {'title': 'Dart Fundamentals', 'lessons': 12, 'duration': '2h 30min'},
      {'title': 'Flutter Basics', 'lessons': 15, 'duration': '3h 15min'},
      {'title': 'State Management', 'lessons': 10, 'duration': '2h 45min'},
      {'title': 'API Integration', 'lessons': 8, 'duration': '2h'},
      {'title': 'Advanced Topics', 'lessons': 20, 'duration': '5h'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: sections.length,
      itemBuilder: (context, index) {
        final section = sections[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ExpansionTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  '${index + 1}',
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            title: Text(section['title'] as String, style: AppTextStyles.bodyMedium),
            subtitle: Text(
              '${section['lessons']} lessons • ${section['duration']}',
              style: AppTextStyles.caption,
            ),
            children: List.generate(
              3,
              (i) => ListTile(
                leading: Icon(
                  i == 0 ? Icons.play_circle : Icons.lock_outline,
                  color: i == 0 ? AppColors.primary : AppColors.textHint,
                ),
                title: Text('Lesson ${i + 1}', style: AppTextStyles.bodySmall),
                trailing: Text('${5 + i * 3} min', style: AppTextStyles.caption),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildReviewsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating Summary
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      '4.8',
                      style: AppTextStyles.h1.copyWith(color: AppColors.primary),
                    ),
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          i < 4 ? Icons.star : Icons.star_half,
                          color: AppColors.warning,
                          size: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('12,500 reviews', style: AppTextStyles.caption),
                  ],
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Column(
                    children: [
                      _buildRatingBar(5, 0.7),
                      _buildRatingBar(4, 0.2),
                      _buildRatingBar(3, 0.05),
                      _buildRatingBar(2, 0.03),
                      _buildRatingBar(1, 0.02),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Reviews List
          Text('Recent Reviews', style: AppTextStyles.h4),
          const SizedBox(height: 16),
          _buildReviewItem(
            name: 'Sarah Johnson',
            rating: 5,
            date: '2 days ago',
            review:
                'Excellent course! The instructor explains everything clearly and the projects are very practical.',
          ),
          _buildReviewItem(
            name: 'Mike Chen',
            rating: 4,
            date: '1 week ago',
            review:
                'Great content and well-structured. Would love more advanced topics in future updates.',
          ),
          _buildReviewItem(
            name: 'Emily Davis',
            rating: 5,
            date: '2 weeks ago',
            review:
                'This course changed my career! I landed my first Flutter job after completing it.',
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int stars, double percentage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text('$stars', style: AppTextStyles.caption),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: AppColors.border,
                valueColor: const AlwaysStoppedAnimation(AppColors.warning),
                minHeight: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem({
    required String name,
    required int rating,
    required String date,
    required String review,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                child: Text(
                  name[0],
                  style: AppTextStyles.bodyLarge.copyWith(color: AppColors.primary),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyles.bodyMedium),
                    Row(
                      children: [
                        ...List.generate(
                          rating,
                          (i) => const Icon(Icons.star,
                              color: AppColors.warning, size: 14),
                        ),
                        const SizedBox(width: 8),
                        Text(date, style: AppTextStyles.caption),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            review,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Price', style: AppTextStyles.caption),
              Text(
                '\$${course.price}',
                style: AppTextStyles.h3.copyWith(color: AppColors.primary),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Enroll Now'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
