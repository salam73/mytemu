import 'package:flutter/material.dart';
import 'package:rive/rive.dart' as rive;
import 'package:video_player/video_player.dart';

void main() => runApp(
  MaterialApp(debugShowCheckedModeBanner: false, home: MyRiveAnimation()),
);

class MyRiveAnimation extends StatefulWidget {
  @override
  _MyRiveAnimationState createState() => _MyRiveAnimationState();
}

class _MyRiveAnimationState extends State<MyRiveAnimation> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    // Initialize the video player controller
    //https://drive.google.com/file/d/1mYR1S3XSUBM5qCRyn_TrpOv5-nczxmJ9/view?usp=drive_link
    //https://drive.google.com/file/d/1mYR1S3XSUBM5qCRyn_TrpOv5-nczxmJ9/view?usp=drive_link
    //https://drive.google.com/file/d/1bZh5FD6qrsXnrvboifyXolbKiPOjxx4h/view?usp=drive_link
    _videoController =
        VideoPlayerController.networkUrl(
            Uri.parse(
              'https://drive.google.com/uc?export=download&id=1bZh5FD6qrsXnrvboifyXolbKiPOjxx4h',
            ),
          )
          ..initialize().then((_) {
            setState(() {}); // Update the UI when the video is ready
          })
          ..setLooping(true)
          ..play(); // Start playing the video
  }

  @override
  void dispose() {
    _videoController.dispose(); // Dispose of the video controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child:
                    _videoController.value.isInitialized
                        ? AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          child: VideoPlayer(_videoController),
                        )
                        : const Center(child: CircularProgressIndicator()),
              ),
              myImage(
                url:
                    'https://drive.google.com/uc?export=download&id=1AWn2j-pU1zt6ADctA8Ap9F4lL1fpBTuH',
              ),
              // Rive Animation 2
              SizedBox(
                height: 300,
                child: rive.RiveAnimation.network(
                  "https://drive.google.com/uc?export=download&id=1gqdSHpH-HDyvIwnT3-lz99IWIMyG8zcK",
                  fit: BoxFit.contain,
                ),
              ),
              // Image 1

              // Image 2
              Image.network(
                "https://drive.google.com/uc?export=download&id=1AWn2j-pU1zt6ADctA8Ap9F4lL1fpBTuH",
              ),
              // Image 3
              Image.network(
                "https://drive.google.com/uc?export=download&id=1Q_rglz4JvC4l2RSfZkWerJnuonfu4LRp",
              ),
              // Image 4
              Image.network(
                "https://drive.google.com/uc?export=download&id=1CrINw5Qx_sTvpkSNoV8iJTBFLkOJ5hbk",
              ),
              // Image 5
              Image.network(
                "https://drive.google.com/uc?export=download&id=1yyN32nkq0NQltJUWLFrpiv8xPcCYQD0_",
              ),
              // Video Player
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_videoController.value.isPlaying) {
              _videoController.pause();
            } else {
              _videoController.play();
            }
          });
        },
        child: Icon(
          _videoController.value.isPlaying ||
                  _videoController.value.position ==
                      _videoController.value.duration
              ? Icons.pause
              : Icons.play_arrow,
        ),
      ),
    );
  }
}

class myImage extends StatelessWidget {
  final String url;

  const myImage({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.network(
          url,
          loadingBuilder: (
            BuildContext context,
            Widget child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress == null) {
              return child;
            } else {
              return Center(
                child: CircularProgressIndicator(
                  value:
                      loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class RiveFromNetwork extends StatefulWidget {
  @override
  _RiveFromNetworkState createState() => _RiveFromNetworkState();
}

class _RiveFromNetworkState extends State<RiveFromNetwork> {
  late Future<void> _riveLoadFuture;

  @override
  void initState() {
    super.initState();
    _riveLoadFuture =
        Future.value(); // Replace with a valid initialization if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rive from Network")),
      body: Center(
        child: FutureBuilder(
          future: _riveLoadFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading indicator
            } else if (snapshot.hasError) {
              return Text("Error loading animation");
            } else {
              return rive.RiveAnimation.network(
                "https://drive.google.com/uc?export=download&id=1gqdSHpH-HDyvIwnT3-lz99IWIMyG8zcK",
                fit: BoxFit.contain,
              );
            }
          },
        ),
      ),
    );
  }
}
