class Resources<T> {
  Status status;
  T data;
  String message;
  String tag;

  Resources.uninitialized() : status = Status.UNINITIALIZED;

  Resources.loading() : status = Status.LOADING;

  Resources.error(this.message) : status = Status.ERROR;

  Resources.success({this.data, this.tag}) : status = Status.SUCCESS;

  Resources.empty(this.message) : status = Status.EMPTY;

  @override
  String toString() {
    return 'Resources{status: $status, data: $data, message: $message, tag: $tag}';
  }
}

enum Status { UNINITIALIZED, LOADING, ERROR, SUCCESS, EMPTY }
