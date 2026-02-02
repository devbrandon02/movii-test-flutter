class HomeState {
  final bool isLoading;
  final String? message;
  final List<String> words;

  HomeState({
    this.isLoading = false,
    this.message,
    this.words = const [],
  });

  HomeState copyWith({bool? isLoading, String? message, List<String>? words}) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      message: message,
      words: words ?? this.words,
    );
  }
}