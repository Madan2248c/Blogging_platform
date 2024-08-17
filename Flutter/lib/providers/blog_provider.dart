import 'package:blogging_platform/models/blog.dart';
import 'package:blogging_platform/services/blog_service.dart';
import 'package:http/http.dart' as http;

class BlogProvider {
  final BlogService blogService = BlogService();
  List<Blog> allBlogs = [];

  Future<List<Blog>> getBlogs() async {
    if (allBlogs.isNotEmpty) {
      return allBlogs;
    }
    allBlogs = await blogService.fetchBlogsFromServer();
    return allBlogs;
  }

  Future<Blog> getBlogById(int id) async {
    if (allBlogs.isEmpty) {
      await getBlogs();
    }
    return allBlogs.firstWhere((blog) => blog.blogId == id);
  }

  Future<http.StreamedResponse> createBlog(Blog blog) async {
    var response = blogService.createBlog(blog);
    return response;
  }
}
