class Box<T> {
  void Function(T value) callback;
  T value;

  Box(this.value, this.callback);
}
