class TestData {
  final dynamic expectedOutput;
  final dynamic input;
  final String name;
  final bool skip;

  TestData({
    required this.name,
    required this.input,
    required this.expectedOutput,
    this.skip = false,
  });
}
