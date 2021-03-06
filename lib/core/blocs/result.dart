class Result<T> {
  Status status;
  T data;
  String message;
  String tag;

  Result.isUninitialized() : status = Status.UNINITIALIZED;

  Result.isLoading() : status = Status.LOADING;

  Result.isError(this.message) : status = Status.ERROR;

  Result.isSuccess({this.data, this.tag}) : status = Status.SUCCESS;

  Result.isEmpty(this.message) : status = Status.EMPTY;

  @override
  String toString() {
    return 'Resources{status: $status, data: $data, message: $message, tag: $tag}';
  }
}

enum Status { UNINITIALIZED, LOADING, ERROR, SUCCESS, EMPTY }
