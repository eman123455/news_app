/// News API v2 category values (`category` query & source metadata).
class NewsTopicOption {
  final String apiCategory;
  final String label;

  const NewsTopicOption({required this.apiCategory, required this.label});
}

const List<NewsTopicOption> kNewsTopicOptions = [
  NewsTopicOption(apiCategory: 'general', label: 'General'),
  NewsTopicOption(apiCategory: 'business', label: 'Business'),
  NewsTopicOption(apiCategory: 'entertainment', label: 'Entertainment'),
  NewsTopicOption(apiCategory: 'health', label: 'Health'),
  NewsTopicOption(apiCategory: 'science', label: 'Science'),
  NewsTopicOption(apiCategory: 'sports', label: 'Sports'),
  NewsTopicOption(apiCategory: 'technology', label: 'Technology'),
];
