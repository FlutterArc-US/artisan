abstract class Usecase<Input, Output> {
  Future<Output> call(Input input);
}
