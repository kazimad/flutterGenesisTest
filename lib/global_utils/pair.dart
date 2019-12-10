// this class is used not only for responses, but for work with persistence as well. so I'll keep it's name
class Pair {
  dynamic data;
  Exception exception;

  Pair(this.data, this.exception);

  Pair.withExpectedResult(dynamic expectedResult)
      : data = expectedResult,
        exception = null;

  Pair.withError(Exception exceptionValue)
      : data = null,
        exception = exceptionValue;
}
