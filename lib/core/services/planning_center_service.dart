class PlanningCenterService {
  Future<void> warmUp() async {
    // Preload tokens, headers, or cached data later
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
