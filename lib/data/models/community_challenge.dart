class CommunityChallenge {
  const CommunityChallenge({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.target,
    required this.reward,
    required this.tagline,
  });

  final String id;
  final String title;
  final String description;
  final double progress;
  final double target;
  final String reward;
  final String tagline;

  double get completionRatio => target == 0 ? 0 : (progress / target).clamp(0, 1);
}
