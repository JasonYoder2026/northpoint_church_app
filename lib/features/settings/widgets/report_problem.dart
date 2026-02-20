import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'report_problem_controller.dart';

class ReportProblemSection extends ConsumerStatefulWidget {
  const ReportProblemSection({super.key});

  @override
  ConsumerState<ReportProblemSection> createState() =>
      _ReportProblemSectionState();
}

class _ReportProblemSectionState extends ConsumerState<ReportProblemSection> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(problemReportControllerProvider);
    final controller = ref.read(problemReportControllerProvider.notifier);

    final isSubmitting = state.status == ReportStatus.submitting;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Report a Problem',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.headlineLarge?.color,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'If something isn\'t working, let us know and we\'ll look into it.',
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _controller,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Describe the issue...',
            border: OutlineInputBorder(),
          ),
        ),

        // Error message
        if (state.status == ReportStatus.error && state.error != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              state.error!,
              style: const TextStyle(color: Colors.red),
            ),
          ),

        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isSubmitting
                ? null
                : () async {
                    await controller.submit(_controller.text);

                    // Check if widget is still mounted before using context/ref
                    if (!mounted) return;

                    final result = ref.read(problemReportControllerProvider);

                    if (result.status == ReportStatus.success) {
                      _controller.clear();
                      if (!mounted) return; // Check again before using context
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Problem report submitted. Thank you!'),
                        ),
                      );
                      controller.reset();
                    }
                  },
            child: isSubmitting
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Submit'),
          ),
        ),
      ],
    );
  }
}