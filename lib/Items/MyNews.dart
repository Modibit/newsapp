class MyNews {
  String sourceName, description, content, url, urlToImage;
  late String title;

  late DateTime time;
  MyNews(this.sourceName, String title, this.description, this.content,
      this.url, this.urlToImage, String time) {
    time.replaceRange(11, 11, " ");
    this.time = DateTime.parse(time);
    if (title.length > 50) {
      title = title.replaceRange(50, title.length, " . . .");
    }
    this.title = title;
  }
}
List<MyNews> myNews = [];
