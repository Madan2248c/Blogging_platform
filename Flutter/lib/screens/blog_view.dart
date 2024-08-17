import 'package:blogging_platform/models/blog.dart';
import 'package:blogging_platform/providers/blog_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogView extends StatefulWidget {
  final int id;
  const BlogView({
    super.key,
    required this.id,
  });

  @override
  State<BlogView> createState() => _BlogViewState();
}

class _BlogViewState extends State<BlogView> {
  late Blog currentBlog =
      Blog(blogId: -1, blogDescription: '', blogImage: '', blogTitle: '');

  @override
  void initState() {
    _getCurrentBlog(widget.id);
    print(currentBlog.blogId);
    super.initState();
  }

  _getCurrentBlog(int id) async {
    BlogProvider blogProvider = BlogProvider();
    currentBlog = (await blogProvider.getBlogById(widget.id))!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            child: Icon(CupertinoIcons.back),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text(currentBlog.blogTitle),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            Image.network(
                'http://10.0.2.2:3000/uploads/${currentBlog.blogImage}'),
            Text(currentBlog.blogDescription)
          ],
        ),
      ),
    );
  }
}
