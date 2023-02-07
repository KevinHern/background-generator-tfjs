class Result {
  final bool _success;
  final String? _message;
  final dynamic object;
  const Result({required bool success, required String? message, this.object})
      : _success = success,
        _message = message;

  // Getters
  bool get success => _success;
  String? get message => _message;
}
