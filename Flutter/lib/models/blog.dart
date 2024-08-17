class Blog {
  final int blogId;
  final String blogImage;
  final String blogTitle;
  final String blogDescription;

  Blog({
    this.blogId = 0,
    this.blogImage = '',
    this.blogTitle = '',
    this.blogDescription = '',
  });

  static List<Blog> convertToBlogList(List<Map<String, dynamic>> serverData) {
    return serverData.map((item) {
      return Blog(
        blogId: item['id'],
        blogImage: item['image'], // Default or transformed path
        blogTitle: item['title'],
        blogDescription: item['description'],
      );
    }).toList();
  }
}
