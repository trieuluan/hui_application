class PasswordStrengthResponse {
  final int score;
  final Map<String, dynamic> feedback;
  final bool isStrong;
  final Map<String, dynamic> additionalValidation;
  final Map<String, dynamic> config;

  PasswordStrengthResponse({
    required this.score,
    required this.feedback,
    required this.isStrong,
    required this.additionalValidation,
    required this.config,
  });

  factory PasswordStrengthResponse.fromJson(Map<String, dynamic> json) {
    return PasswordStrengthResponse(
      score: json['score'] as int? ?? 0,
      feedback: json['feedback'] as Map<String, dynamic>? ?? {},
      isStrong: json['isStrong'] as bool? ?? false,
      additionalValidation:
          json['additionalValidation'] as Map<String, dynamic>? ?? {},
      config: json['config'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'feedback': feedback,
      'isStrong': isStrong,
      'additionalValidation': additionalValidation,
      'config': config,
    };
  }

  @override
  String toString() {
    return 'PasswordStrengthResponse(score: $score, isStrong: $isStrong)';
  }
}
