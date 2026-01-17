import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:northpoint_church_app/core/providers/supabase_provider.dart';

enum ReportStatus { idle, submitting, success, error }

class ProblemReportState {
  final ReportStatus status;
  final String? error;

  const ProblemReportState({this.status = ReportStatus.idle, this.error});

  ProblemReportState copyWith({ReportStatus? status, String? error}) {
    return ProblemReportState(status: status ?? this.status, error: error);
  }
}

class ProblemReportController extends Notifier<ProblemReportState> {
  @override
  ProblemReportState build() => const ProblemReportState();

  Future<void> submit(String message) async {
    if (message.trim().isEmpty) {
      state = state.copyWith(
        status: ReportStatus.error,
        error: 'Please describe the problem.',
      );
      return;
    }

    state = state.copyWith(status: ReportStatus.submitting, error: null);

    final supabase = GetIt.instance<SupabaseProvider>();

    try {
      final user = await supabase.currentUser();

      await supabase.submitProblemReport(user.id, message);

      state = state.copyWith(status: ReportStatus.success);
    } catch (e) {
      state = state.copyWith(
        status: ReportStatus.error,
        error: 'Failed to submit report. Please try again.',
      );
    }
  }

  void reset() {
    state = const ProblemReportState();
  }
}

final problemReportControllerProvider =
    NotifierProvider<ProblemReportController, ProblemReportState>(
      ProblemReportController.new,
    );
