import 'package:flutter/material.dart';

class BlogPreview extends StatefulWidget {
  final String title;
  final String image;
  final int blogId;

  const BlogPreview(
      {Key? key,
      required this.title,
      required this.image,
      required this.blogId})
      : super(key: key);

  @override
  State<BlogPreview> createState() => _BlogPreviewState();
}

class _BlogPreviewState extends State<BlogPreview> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5.0),
      elevation: 5,
      color: Colors.blueGrey,
      child: Column(
        children: [
          ListTile(
            title: Text(widget.title),
          ),
          Image.network(
            'http://10.0.2.2:3000/uploads/${widget.image}',
            width: 500,
            height: 300,
          ),
        ],
      ),
    );
  }
}
