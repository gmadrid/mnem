import 'package:mnem/leitner/leitner_box.dart';
import 'package:mnem/leitner/question.dart';
import 'package:mnem/leitner/shuffler.dart';
import 'package:flutter_test/flutter_test.dart';

String Q(num index) {
  return "Question $index";
}

String A(num index) {
  return "Answer $index";
}

LeitnerBox simpleTestSet(num size) {
  var questions = List<Question>();

  for (var i = 0; i < size; ++i) {
    questions.add(Question(Q(i), A(i)));
  }

  // Shuffling makes things untestable.
  var lb = LeitnerBox(shuffler: NoOpShuffler());
  lb.addQuestions(questions);
  return lb;
}

void main() {
  test("empty", () {
    var lb = LeitnerBox();

    expect(lb.totalSize, equals(0));
    expect(lb.activeSize, equals(0));
    expect(lb.waitingSize, equals(0));
    expect(lb.knownSize, equals(0));

    // boxes are empty even after shuffling.
    for (var i = 0; i <= lb.numBuckets - 1; ++i) {
      lb.shuffle(i);
      expect(lb.bucketSize(i), equals(0));
    }

    // basic operations don't crash when a bucket is empty.
    lb.demote(0);
    lb.promote(0);
    lb.makeActive(5);
  });

  test("starts in waiting", () {
    var size = 34;
    var lb = simpleTestSet(size);
    expect(lb.totalSize, equals(size));
    expect(lb.activeSize, equals(0));
    expect(lb.waitingSize, equals(size));
    expect(lb.knownSize, equals(0));
  });

  test("make active", () {
    var size = 3;
    var lb = simpleTestSet(size);

    // The questions start in waiting.
    var q = lb.next(0);
    expect(q, equals(null));

    lb.makeActive(size - 1);
    expect(lb.totalSize, equals(size));
    expect(lb.activeSize, equals(size - 1));
    expect(lb.waitingSize, equals(1));
    expect(lb.knownSize, equals(0));

    q = lb.next(0);
    expect(q.q, equals(Q(size - 1)));
  });

  test("simple next", () {
    var size = 3;
    var lb = simpleTestSet(size);
    lb.makeActive(size);

    var q = lb.next(0);
    expect(q.q, equals(Q(size - 1)));
  });

  test("simple moves", () {
    var size = 5;
    var lb = simpleTestSet(size);
    lb.makeActive(size);

    var q0 = lb.next(0);
    lb.promote(0);
    expect(lb.totalSize, equals(size));
    expect(lb.activeSize, equals(size));
    expect(lb.waitingSize, equals(0));
    expect(lb.knownSize, equals(0));

    var q1 = lb.next(1);
    var q2 = lb.next(0);
    expect(q1, equals(q0));
    expect(q2, isNot(equals(q0)));

    lb.promote(1);
    lb.promote(0);
    var q4 = lb.next(0);
    var q5 = lb.next(1);
    var q6 = lb.next(2);
    var n0 = lb.next(3);
    expect(q5, equals(q2));
    expect(q6, equals(q1));
    expect(n0, isNull);

    var size0 = lb.bucketSize(0);
    lb.demote(2);
    var size1 = lb.bucketSize(0);
    var q7 = lb.next(0);
    var n1 = lb.next(2);
    expect(n1, isNull);
    expect(q7, equals(q4));
    expect(size0, equals(size1 - 1));
  });
}