extension ExtendedIterable<E> on Iterable<E> {
  Iterable<T> mapIndex<T>(T f(E e, int i)) {
    var i = 0;
    return this.map((e) => f(e, i++));
  }

  Iterable<E> whereIndex<T>(bool f(E e, int i)) {
    var i = 0;
    return this.where((e) => f(e, i++));
  }
}
