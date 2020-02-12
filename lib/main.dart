import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

/// https://medium.com/flutter-community/flutter-video-player-3a2f4f8562a3

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyPage(),);
  }
}


class MyPage extends StatefulWidget {

  const MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  void playVideo(String atUrl) {
    if (kIsWeb) {
      final v = html.window.document.getElementById('videoPlayer');
      if (v != null) {
        v.setInnerHtml('<source type="video/mp4" src="$atUrl">',
            validator: html.NodeValidatorBuilder()..allowElement('source', attributes: ['src', 'type']));
        final a = html.window.document.getElementById('triggerVideoPlayer');
        if (a != null) {
          a.dispatchEvent(html.MouseEvent('click'));
        }
      }
    } else {
      // we're not on the web platform
      // and should use the video_player package
    }
  }

  void playHostedVideo(String withId, [bool isVimeo = false]) {
    if (kIsWeb) {
      final v = html.window.document.getElementById('videoPlayer');
      if (v != null) {
        if (isVimeo) {
          v.setAttribute("data-vimeo-id", withId);
        } else {
          v.setAttribute("data-youtube-id", withId);
        }
        final a = html.window.document.getElementById('triggerVideoPlayer');
        if (a != null) {
          a.dispatchEvent(html.MouseEvent('click'));
        }
      }
    } else {
      // we're not on the web platform
      // and should use the video_player package
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(height: 300, width: 400, child: Text('hello')),
      floatingActionButton: Row(
        children: <Widget>[
          RaisedButton(
            child: Text('basico'),
            onPressed: () {
              playVideo('http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_30fps_normal.mp4');
            },
          ),
          RaisedButton(
            child: Text('Youtube'),
            onPressed: () {
              // for playing YouTube video
              playHostedVideo('aqz-KE-bpKQ');
            },
          ),
          RaisedButton(
            child: Text('Vimeo'),
            onPressed: () {
              //playVideo('http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_30fps_normal.mp4');

              // or for playing Vimeo video
              playHostedVideo('1084537', true);
            },
          ),
        ],
      ),
    );
  }
}
