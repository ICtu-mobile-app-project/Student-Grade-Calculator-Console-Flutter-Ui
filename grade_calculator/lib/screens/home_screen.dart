import 'package:flutter/material.dart';
import '../models/student.dart';
import '../widgets/gradient_header.dart';
import '../widgets/student_form.dart';
import '../widgets/student_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Student> _students = [];

  void _addStudent(Student s) {
    setState(() => _students.add(s));
  }

  void _clearAll() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Clear all students?'),
        content: const Text(
            'This will remove all students from the list.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => _students.clear());
            },
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Gradient header ──────────────────────────────────────────
          SliverToBoxAdapter(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // The header banner
                GradientHeader(
                  studentCount: _students.length,
                  onClearAll: _clearAll,
                ),
                // The form card overlapping the header at the bottom
                Positioned(
                  bottom: -32,
                  left: 0,
                  right: 0,
                  child: StudentForm(onAdd: _addStudent),
                ),
              ],
            ),
          ),

          // Spacer to account for the overlapping card
          const SliverToBoxAdapter(child: SizedBox(height: 52)),

          // ── Results list (or empty state) ─────────────────────────
          _students.isEmpty
              ? SliverFillRemaining(
                  hasScrollBody: false,
                  child: _EmptyState(),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      child: StudentCard(
                        key: ValueKey('${_students[index].name}_$index'),
                        student: _students[index],
                        index: index,
                      ),
                    ),
                    childCount: _students.length,
                  ),
                ),

          // Bottom padding
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }
}

// ── Empty state illustration ───────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        Icon(Icons.school_outlined, size: 72, color: Colors.grey.shade300),
        const SizedBox(height: 16),
        Text(
          'No students yet',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade400,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Fill in the form above to add a student',
          style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
        ),
      ],
    );
  }
}
