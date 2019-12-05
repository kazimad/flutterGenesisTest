class Pair {
  dynamic expectedResult;
  Exception exception;

  Pair(this.expectedResult, this.exception);

  Pair.withExpectedResult(dynamic expectedResult)
      : expectedResult = expectedResult,
        exception = null;

  Pair.withError(Exception exceptionValue)
      : expectedResult = null,
        exception = exceptionValue;
}
