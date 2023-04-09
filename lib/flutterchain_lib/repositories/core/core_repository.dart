abstract class Repository<T> {
  Future<void> save(T item);
  Future<void> saveAll(List<T> items);
  Future<T> read(String id);
  Future<List<T>> readAll();
  Future<void> update(String id, T item);
  Future<void> delete(String id);
  Future<void> deleteAll();
}
