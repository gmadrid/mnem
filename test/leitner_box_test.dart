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

//  test("simple next", () {
//    var size = 3;
//    var lb = simpleTestSet(size);
//
//    // The questions start in waiting.
//    var q = lb.next(0);
//    expect(q, equals(null));
//
//    lb.
//
//    expect(q.q, equals(Q(size - 1)));
//  });
//
//  test("simple moves", () {
//    var size = 5;
//    var lb = simpleTestSet(size);
//    expect(lb.bucketSize(0), equals(size));
//
//    var q0 = lb.next(0);
//    lb.moveToFirst(0);
//    expect(lb.bucketSize(0), equals(size - 1));
//    expect(lb.bucketSize(1), equals(1));
//
//    var q1 = lb.next(0);
//    expect(q1, isNot(equals(q0)));
//
//    var q2 = lb.next(1);
//    expect(q2, equals(q0));
//  });
//
//  test("deeper moves", () {
//    var size = 11;
//    var lb = simpleTestSet(size);
//    expect(lb.bucketSize(0), equals(size));
//
//    lb.moveToFirst(0);
//    lb.moveToFirst(0);
//    lb.moveToFirst(0);
//    lb.moveToFirst(0);
//    lb.moveToFirst(0);
//    lb.moveToFirst(0);
//
//    lb.moveUp(1);
//    lb.moveUp(1);
//    lb.moveUp(1);
//
//    lb.moveUp(2);
//
//    // TODO: you should check that the correct questions are in the right buckets.
//
//    expect(lb.bucketSize(0), equals(5));
//    expect(lb.bucketSize(1), equals(3));
//    expect(lb.bucketSize(2), equals(2));
//    expect(lb.bucketSize(3), equals(1));
//  });
}