import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../../config/shared_preference_provider.dart';
import '../../models/server_book.dart';

Future<Map<String, dynamic>> signIn(Map connectInfo) async {
  var url = connectInfo['url'];
  var username = connectInfo['username'];
  var password = connectInfo['password'];

  // 创建Dio实例
  final dio = Dio();

  // 构建请求URL
  var fullUrl = 'http://$url/api/user/sign_in';

  // 构建请求数据
  var data = {
    'username': username,
    'password': password,
  };

  try {
    // 发送POST请求
    Response response = await dio.post(
      fullUrl,
      data: data,
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    if (response.statusCode == 200) {
      int code = response.data['code'];
      if (code != 0) {
        // 登录失败
        return {
          'success': false,
          'message': response.data['message'] ?? '登录失败',
        };
      }
      String? setCookie = response.headers['set-cookie']?.first;
      if (setCookie != null) {
        // 提取Cookie
        String? cookie = setCookie.split(';').first;
        if (cookie != null) {
          // 保存Cookie
          Prefs().setWebdavCookie(cookie);
        }
      }
      // 登录成功
      return {
        'success': true,
        'message': '登录成功',
        'data': response.data['data'],
      };
    } else {
      // 服务器返回非200状态码
      return {
        'success': false,
        'message': response.data['message'] ?? '登录失败',
      };
    }
  } on DioError catch (e) {
    // Dio特定错误，比如服务器错误或超时
    if (e.response != null) {
      // 服务器返回错误响应
      return {
        'success': false,
        'message': e.response?.data['message'] ?? '登录失败',
      };
    } else {
      // 网络错误或其他Dio错误
      return {
        'success': false,
        'message': '连接失败，请检查网络设置',
      };
    }
  } catch (e) {
    // 其他未预期的错误
    return {
      'success': false,
      'message': '发生未知错误',
    };
  }
}


Future<Map<String, dynamic>> getUserInfo({bool detail = false}) async {
  final dio = Dio();
  final webdavInfo = Prefs().webdavInfo;
  String? url = webdavInfo['url'];
  if (url == null) {
    return {
      'success': false,
      'message': '请先登陆服务器',
    };
  }
  var setCookie = Prefs().webdavCookie;
  final String baseUrl = 'http://$url'; // 替换为实际的基础URL

  try {
    Response response = await dio.get(
      '$baseUrl/api/user/info',
      queryParameters: {'detail': detail},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          // 如果需要认证，在这里添加认证头
          'Cookie': setCookie,
        },
      ),
    );

    if (response.statusCode == 200) {
      var result = response.data;
      if (result['code'] == 0) { // 假设成功的响应code为0
        return {
          'success': true,
          'data': result['data'],
        };
      } else {
        return {
          'success': false,
          'message': result['message'] ?? '获取用户信息失败',
        };
      }
    } else {
      return {
        'success': false,
        'message': '服务器错误',
      };
    }
  } on DioError catch (e) {
    return {
      'success': false,
      'message': e.response?.data['message'] ?? '网络错误',
    };
  } catch (e) {
    return {
      'success': false,
      'message': '发生未知错误',
    };
  }
}


Future<Map<String, dynamic>> getIndex({int randomCount = 8, int recentCount = 10}) async {
  final dio = Dio();
  final webdavInfo = Prefs().webdavInfo;
  String? url = webdavInfo['url'];
  if (url == null) {
    return {
      'success': false,
      'message': '请先登陆服务器',
    };
  }
  var setCookie = Prefs().webdavCookie;
  final String baseUrl = 'http://$url'; // 替换为实际的基础URL

  try {
    Response response = await dio.get(
      '$baseUrl/api/index',
      queryParameters: {
        'randomCount': randomCount,
        'recentCount': recentCount,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          // 如果需要认证，在这里添加认证头
          // 'Authorization': 'Bearer YOUR_TOKEN_HERE',
          'Cookie': setCookie,
        },
      ),
    );

    if (response.statusCode == 200) {
      var data = response.data;
      return {
        'success': true,
        'randomBooksCount': data['random_books_count'],
        'newBooksCount': data['new_books_count'],
        'randomBooks': (data['random_books'] as List).map((book) => ServerBook.fromJson(baseUrl, book)).toList(),
        'newBooks': (data['new_books'] as List).map((book) => ServerBook.fromJson(baseUrl, book)).toList(),
      };
    } else {
      return {
        'success': false,
        'message': '服务器错误',
      };
    }
  } on DioError catch (e) {
    return {
      'success': false,
      'message': e.response?.data['message'] ?? '网络错误',
    };
  } catch (e) {
    return {
      'success': false,
      'message': '发生未知错误',
    };
  }
}


Future<File> downloadBook(int bookId) async {
  final dio = Dio();
  final webdavInfo = Prefs().webdavInfo;
  String? url = webdavInfo['url'];
  if (url == null) {
    throw Exception('请先登陆服务器');
  }
  var setCookie = Prefs().webdavCookie;

  // 获取临时目录
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;

  // 生成临时文件名
  String tempFileName = 'book_$bookId.temp';
  String filePath = '$tempPath/$tempFileName';

  try {
    Response response = await dio.post(
      'http://$url/api/book/$bookId/download',
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        headers: {
          // 如果需要认证，在这里添加认证头
          // 'Authorization': 'Bearer YOUR_TOKEN_HERE',
          'Cookie': setCookie,
        },
      ),
    );

    // 获取文件名
    String? fileName = response.headers.value('content-disposition')?.split('filename=').last;
    fileName = fileName ?? 'book_$bookId';

    // 保存文件
    File file = File(filePath);
    await file.writeAsBytes(response.data);

    return file;
  } catch (e) {
    throw Exception('下载书籍失败: $e');
  }
}


Future<File?> downloadTmpCover(String coverPath) async {
  final dio = Dio();
  final webdavInfo = Prefs().webdavInfo;
  String? url = webdavInfo['url'];
  if (url == null) {
    throw Exception('请先登陆服务器');
  }
  final String baseUrl = 'http://$url'; // 替换为实际的基础URL

  try {
    // 获取临时目录
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    // 生成临时文件名
    String tempFileName = 'cover_${DateTime.now().millisecondsSinceEpoch}.jpg';
    String filePath = '$tempPath/$tempFileName';

    // 发送GET请求下载图片
    Response response = await dio.get(
      '$coverPath',
      options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
      ),
    );

    // 保存文件
    File file = File(filePath);
    await file.writeAsBytes(response.data);

    return file;
  } catch (e) {
    print('下载临时封面失败: $e');
    return null;
  }
}
