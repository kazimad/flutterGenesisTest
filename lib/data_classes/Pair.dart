class Pair {
  dynamic expectedResult;
  String errorParam;

  Pair(this.expectedResult, this.errorParam);

  Pair.withExpectedResult(dynamic expectedResult)
      : expectedResult = expectedResult,
        errorParam = null;

  Pair.withError(String errorValue)
      : expectedResult = null,
        errorParam = errorValue;
}
