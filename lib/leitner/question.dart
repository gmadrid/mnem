/// Associates a question with an answer.
class Question {
  String _q;
  String _a;

  /// Creates a question with a question and an answer.
  Question(this._q, this._a);

  /// Gets the question.
  String get q => _q;
  /// Gets the answer.
  String get a => _a;

  @override
  bool operator ==(dynamic other) {
    if (other is! Question) return false;
    Question rhs = other;

    return (_q == rhs._q && _a == rhs._a);
  }

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + _q.hashCode;
    result = 37 * result + _a.hashCode;
    return result;
  }

  /// Matches a string with the question's answer ignoring case.
  bool match(String answer) {
    return _a.toUpperCase() == answer.toUpperCase();
  }
}

