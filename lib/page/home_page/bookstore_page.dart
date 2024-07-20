import 'dart:io';

import 'package:anx_reader/models/server_book.dart';
import 'package:anx_reader/utils/toast/common.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../service/book.dart';
import '../../utils/server/server_api.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  late Future<Map<String, dynamic>> _indexDataFuture;

  @override
  void initState() {
    super.initState();
    _indexDataFuture = getIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('书库')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _indexDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('加载失败: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data!['success']) {
            var data = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection('随机推荐', _buildBookList(data['randomBooks'])),
                  _buildSection('新书推荐', _buildBookList(data['newBooks'])),
                  _buildButtonSection(),
                ],
              ),
            );
          } else {
            return Center(child: Text('数据加载失败'));
          }
        },
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        content,
      ],
    );
  }

  Widget _buildBookList(List<ServerBook> books) {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: books.length,
        itemBuilder: (context, index) {
          return _buildBookItem(books[index], context);
        },
      ),
    );
  }

  Widget _buildBookItem(ServerBook book, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showBookDetailDialog(context, book);
      },
      child: Container(
        width: 100,
        margin: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(book.img),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBookDetailDialog(BuildContext context, ServerBook book) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(book.title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Image.network(book.img, height: 200, fit: BoxFit.fitHeight),
                SizedBox(height: 10),
                Text('作者: ${book.author}'),
                Text('评分: ${book.rating}'),
                Text('出版日期: ${book.pubdate}'),
                Text('出版社: ${book.publisher}'),
                SizedBox(height: 10),
                Text('简介: ${book.comments}', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('关闭'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            ElevatedButton(
              child: Text('添加到书架'),
              onPressed: () async {
                Navigator.of(dialogContext).pop();
                // 使用一个稳定的context
                final overlayContext = Navigator.of(context).overlay!.context;
                // 显示加载指示器
                showDialog(
                  context: overlayContext,
                  barrierDismissible: false,
                  builder: (BuildContext loadingContext) {
                    return Center(child: CircularProgressIndicator());
                  },
                );
                try {
                  await addToBookshelf(book);
                  Navigator.of(overlayContext).pop(); // 关闭加载指示器
                  // ScaffoldMessenger.of(overlayContext).showSnackBar(
                  //   SnackBar(content: Text('${book.title} 已添加到书架')),
                  // );
                } catch (e) {
                  Navigator.of(overlayContext).pop(); // 关闭加载指示器
                  ScaffoldMessenger.of(overlayContext).showSnackBar(
                    SnackBar(content: Text('添加失败: $e')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addToBookshelf(ServerBook book) async {
      // 1. 下载文件
      File downloadedFile = await downloadBook(book.id);

      // 2. 导入书籍
      await importServerBook(book, downloadedFile);

      try {
        // 3. 删除临时文件
        await downloadedFile.delete();

        // AnxToast.show('${book.title} 已成功添加到书架');
      } catch (e) {
        // AnxToast.show('添加书籍到书架失败: $e');
        // 在这里处理错误，例如显示一个错误提示
      }
  }

  Widget _buildButtonSection() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(onPressed: () {}, child: Text('全部')),
          ElevatedButton(onPressed: () {}, child: Text('作者')),
          ElevatedButton(onPressed: () {}, child: Text('标签')),
        ],
      ),
    );
  }
}

// Book 类和 getIndex 函数的定义（与之前的实现相同）