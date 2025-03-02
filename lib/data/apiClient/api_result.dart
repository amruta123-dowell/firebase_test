class ApiResult<T> {
  final T? data;
  final String? error;

  ApiResult._({this.data, this.error});

  // Factory constructor for success case
  factory ApiResult.success(T data) {
    return ApiResult._(data: data);
  }

  // Factory constructor for failure case
  factory ApiResult.failure(String error) {
    return ApiResult._(error: formatFirebaseError(error));
  }

  // Check if the result is successful
  bool get isSuccess => data != null;

  // Check if the result is a failure
  bool get isFailure => error != null;
}

//
String formatFirebaseError(String errorMessage) {
  // Extract text after "] " to remove the error code
  return errorMessage.contains("] ")
      ? errorMessage.split("] ")[1]
      : errorMessage;
}
