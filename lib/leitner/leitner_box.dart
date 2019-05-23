import 'package:mnem/leitner/question.dart';
import 'package:mnem/leitner/shuffler.dart';

/// An implementation of the Leitner system (https://en.wikipedia.org/wiki/Leitner_system).
///
/// The box has [last_bucket] buckets (numbered `1-[last_bucket]`) plus a "waiting
/// bucket" (numbered `0`).
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
  }

  /// Adds questions to the "waiting bucket."
  void addQuestions(Iterable<Question> questions) {
    _buckets[waiting_bucket].addAll(questions);
    _numQuestions += questions.length;
    this.shuffle(waiting_bucket);
  }

  /// The number of questions in all of the buckets.
  num size() {
    return _numQuestions;
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
    _shuffler.shuffle(_buckets[index]);
  }

  /// Moves the last question in the specified bucket to bucket number `1`.
  ///
  /// This operation is useful in two contexts:
  ///   * A question was answered wrong and needs to be refreshed.
  ///   * Moving a question from the waiting bucket into the first bucket.
  ///
  /// If the specified bucket is empty, this call has no effect.
  ///
  /// @param index The index of the bucket.
  ///     An out-of-range index will panic.
  void moveToFirst(num index) {
    if (bucketSize(index) < 1) return;

    var fromBucket = _buckets[index];
    var q = fromBucket.last;
    fromBucket.removeLast();
    _buckets[first_bucket].insert(0, q);
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
  void moveUp(num index) {
    if (bucketSize(index) < 1) return;

    // TODO: have a way to deal with this case.
    if (index == last_bucket) return;

    var fromBucket = _buckets[index];
    var q = fromBucket.last;
    fromBucket.removeLast();
    _buckets[index + 1].insert(0, q);
  }

  static const num first_bucket = 1;
  static const num last_bucket = 7;
  static const num waiting_bucket = 0;

  static const num _total_buckets = last_bucket + 1;

  Shuffler _shuffler;
  List<List<Question>> _buckets;
  num _numQuestions = 0;
}
