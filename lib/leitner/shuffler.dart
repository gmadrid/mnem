/// An abstraction on a method to "shuffle" a List.
///
/// This abstract class is mostly used to provide Dependency Injection on
/// shuffling so that we can use a deterministic shuffle while testing.
abstract class Shuffler {
  void shuffle(List arr);
}

/// A [Shuffler] that will random re-order all of the elements in a List.
class RandomShuffler implements Shuffler {
  void shuffle(List arr) {
    arr.shuffle();
  }
}

/// A [Shuffler] that does nothing.
class NoOpShuffler implements Shuffler {
  void shuffle(List arr) {}
}
