class ServerBook {
  final int id;
  final String title;
  final double rating;
  final String pubdate;
  final String author;
  final List<String> authors;
  final List<String> tags;
  final String path;
  final String createTime;
  final String publisher;
  final String comments;
  final String? series;
  final String? language;
  final String? isbn;
  final String img;
  final String thumb;
  final String collector;
  final int countVisit;
  final int countDownload;

  ServerBook.fromJson(String baseUrl, Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        rating = (json['rating'] ?? 0).toDouble(),
        pubdate = json['pubdate'],
        author = json['author'],
        authors = List<String>.from(json['authors']),
        tags = List<String>.from(json['tags']),
        path = json['path'],
        createTime = json['create_time'],
        publisher = json['publisher'],
        comments = json['comments'],
        series = json['series'],
        language = json['language'],
        isbn = json['isbn'],
        img = baseUrl + json['img'],
        thumb = json['thumb'],
        collector = json['collector'],
        countVisit = json['count_visit'],
        countDownload = json['count_download'];
}