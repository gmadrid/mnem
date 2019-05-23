import 'dart:math';

import 'package:mnem/leitner/question.dart';
import 'package:mnem/leitner/shuffler.dart';

/// An implementation of the Leitner system (https://en.wikipedia.org/wiki/Leitner_system).
///
/// The box has [numBuckets] buckets (numbered `0-[numBuckets - 1]`) plus a "waiting
/// bucket" and a "known bucket". In the language of the Leitner system, the questions
/// in box 0 should be asked every session, those in box 1 should be asked every
/// two sessions, and so on.
///
/// As a question is answered correctly, it gets "promoted" to the next bucket.
/// If a question is answered incorrectly, it gets "demoted" all the way back
/// to the first bucket so that it can be refreshed in the user's memory.
///
/// Once a question in the last bucket is answered correctly, it should graduate
/// into the class of "known" questions which are never asked again.
///
/// This class simulates the physical box. In other words, it provides
/// methods to _use_ the box (get the next question, promote or demote a
/// question), but none of the logic to play the game (tracking which box is
/// "active," asking the questions, when to promote or demote, etc.).
class LeitnerBox {
  /// Creates a new, empty Leitner box.
  ///
  /// @param shuffler Dependency-injected [Shuffler]. Mostly useful for testing.
  ///     If no shuffler is specified, uses a [RandomShuffler].
  LeitnerBox({Shuffler shuffler}) : _shuffler = shuffler ?? RandomShuffler() {
    _buckets = List();
    for (var i = 0; i < _total_buckets; ++i) {
      _buckets.add(List());
    }
    _known = List();
    _waiting = List();
  }

  /// The total number of Questions in all of the buckets including waiting and known.
  num get totalSize => _numQuestions;

  /// The number of Questions in the waiting bucket.
  num get waitingSize => _waiting.length;

  /// The number of Questions in the known bucket.
  num get knownSize => _known.length;

  /// The number of "active" Questions, that is [totalSize] - ([waitingSize] + [knownSize]).
  num get activeSize => totalSize - (waitingSize + knownSize);

  /// The number of buckets in this box.
  num get numBuckets => _total_buckets;

  /// Adds questions to the "waiting bucket."
  void addQuestions(Iterable<Question> questions) {
    _waiting.addAll(questions);
    _numQuestions += questions.length;
    this._shuffleList(_waiting);
  }

  /// The number of questions in a particular bucket.
  ///
  /// An out-of-range index will panic.
  num bucketSize(num index) {
    return _buckets[index].length;
  }

  /// Gets the "next" question in the specified bucket.
  ///
  /// Returns `null` if the bucket is empty.
  ///
  /// @param index The index of the bucket.
  ///     An out-of-range index will panic.
  Question next(num index) {
    if (bucketSize(index) == 0) return null;
    return _buckets[index].last;
  }

  /// Shuffles the specified bucket.
  ///
  /// Uses the shuffler specified when this box was created.
  ///
  /// @param index The index of the bucket.
  ///     An out-of-range index will panic.
  void shuffle(num index) {
    _shuffleList(_buckets[index]);
  }

  /// Shuffles the list.
  ///
  /// Uses the shuffler specified when this box was created.
  ///
  /// @param list The list to be shuffled.
  void _shuffleList(List<Question> list) {
    _shuffler.shuffle(list);
  }

  /// Moves questions from the 'waiting' list to the first bucket.
  ///
  /// If there are fewer than [numQuestions] questions in the waiting bucket,
  /// then all questions in the waiting bucket will be moved.
  ///
  /// @param numQuestions The number of questions to move.
  void makeActive(num numQuestions) {
    var numToMove = min(numQuestions, waitingSize);
    for (var i = 0; i < numToMove; ++i) {
      var q = _waiting.last;
      _waiting.removeLast();
      _buckets.first.insert(0, q);
    }
  }

  /// Demotes the last question in the specified bucket to the first bucket.
  ///
  /// This operation is useful in two contexts:
  ///   * A question was answered wrong and needs to be refreshed.
  ///   * Moving a question from the waiting bucket into the first bucket.
  ///
  /// If the specified bucket is empty, this call has no effect.
  ///
  /// @param index The index of the bucket.
  ///     An out-of-range index will panic.
  void demote(num index) {
    if (bucketSize(index) < 1) return;

    var fromBucket = _buckets[index];
    var q = fromBucket.last;
    fromBucket.removeLast();
    _buckets[_first_bucket].insert(0, q);
  }

  /// Moves the last question in the specifed bucket into the `[index] + 1`
  /// bucket.
  ///
  /// This is useful when a question is answered correctly and gets promoted.
  ///
  /// If the specified bucket is empty, this has no effect.
  ///
  /// NOTE: if `[index] == [last_bucket]`, we currently take no action. This will
  /// cause questions to accumulate in the last bucket and never be removed.
  /// We need to fix this.
  ///
  /// @param index The index of the bucket.
  ///     An out-of-range index will panic.
  void promote(num index) {
    if (bucketSize(index) < 1) return;

    var fromBucket = _buckets[index];
    var q = fromBucket.last;
    fromBucket.removeLast();

    if (index == _last_bucket) {
      _waiting.add(q);
    } else {
      _buckets[index + 1].insert(0, q);
    }
  }

  static const num _first_bucket = 0;
  static const num _last_bucket = 6;
  static const num _total_buckets = _last_bucket + 1;

  Shuffler _shuffler;
  List<List<Question>> _buckets;
  List<Question> _waiting;
  List<Question> _known;
  num _numQuestions = 0;
}
