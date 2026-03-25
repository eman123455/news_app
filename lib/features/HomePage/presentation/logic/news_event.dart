abstract class NewsEvent {

} class FetchNews extends NewsEvent{
  final String? category;
  FetchNews({required this.category});

}