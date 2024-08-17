import 'dart:convert';

import 'package:blogging_platform/models/blog.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class BlogService {
  late List<Blog> allBlogs;

  Future<List<Blog>> fetchBlogsFromServer() async {
    try {
      var url = Uri.parse('http://10.0.2.2:3000/blog/allBlogs');
      var response = await http.get(url);
      List<Map<String, dynamic>> blogList =
          List<Map<String, dynamic>>.from(jsonDecode(response.body));
      List<Blog> FinalBlogList = Blog.convertToBlogList(blogList);
      return FinalBlogList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<http.StreamedResponse> createBlog(Blog blog) async {
    var url = Uri.parse('http://10.0.2.2:3000/blog/newblog');
    var request = http.MultipartRequest('POST', url);
    request.fields['title'] = blog.blogTitle;
    request.fields['content'] = blog.blogDescription;
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        blog.blogImage,
        contentType: MediaType('image', 'jpg'),
      ),
    );
    var response = await request.send();
    return response;
  }
}
