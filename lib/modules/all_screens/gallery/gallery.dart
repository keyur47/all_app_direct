import 'dart:async';
import 'dart:io';
import 'package:all_app_direct/helper/app_color.dart';
import 'package:all_app_direct/modules/appbar/appbar.dart';
import 'package:all_app_direct/utils/app_color.dart';
import 'package:all_app_direct/utils/size_utils.dart';
import 'package:all_app_direct/utils/string_utils.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';


class GalleryFileImage extends StatefulWidget {
  @override
  _GalleryFileImageState createState() => _GalleryFileImageState();
}

class _GalleryFileImageState extends State<GalleryFileImage> {
  List<Album>? _albums;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    initAsync();
  }

  Future<void> initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums =
      await PhotoGallery.listAlbums(mediumType: MediumType.image);
      setState(() {
        _albums = albums;
        _loading = false;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS &&
        await Permission.storage.request().isGranted &&
        await Permission.photos.request().isGranted ||
        Platform.isAndroid && await Permission.storage.request().isGranted) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:ColorRes.backgroundColor(context),
      body: Column(
          children: [
            customAppbar(
              text: StringsUtils.instagramDirects,
              icon: Icons.photo,
              top: SizeUtils.horizontalBlockSize * 0.5,
              bottom: SizeUtils.horizontalBlockSize * 0.6,
              right: SizeUtils.horizontalBlockSize * 0.6,
              left: SizeUtils.horizontalBlockSize * 0.6,
              size: SizeUtils.horizontalBlockSize * 12,
              directText: StringsUtils.galleryDirects,
            ),
            _loading
                ? Center(
              child: CircularProgressIndicator(),
            )
                : Expanded(
                  child: LayoutBuilder(
                  builder: (context, constraints) {
                  double gridWidth = (constraints.maxWidth - 20) / 3;
                  double gridHeight = gridWidth + 33;
                  double ratio = gridWidth / gridHeight;
                  return Container(
                    padding: EdgeInsets.all(5),
                    child: GridView.count(
                      childAspectRatio: ratio,
                      crossAxisCount: 3,
                      mainAxisSpacing: 7.0,
                      crossAxisSpacing: 5.0,
                      children: <Widget>[
                        ...?_albums?.map(
                              (album) => GestureDetector(
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => AlbumPage(album))),
                            child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                        // border: Border.all(width: 2,color: )
                                    ),
                                    height: gridWidth,
                                    width: gridWidth,
                                    child: FadeInImage(
                                      fit: BoxFit.cover,
                                      placeholder:
                                      MemoryImage(kTransparentImage),
                                      image: AlbumThumbnailProvider(
                                        albumId: album.id,
                                        mediumType: album.mediumType,
                                        highQuality: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 2.0),
                                  child: Text(
                                    album.name ?? "Unnamed Album",
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      height: 1.2,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.only(left: 2.0),
                                  child: Text(
                                    album.count.toString(),
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      height: 1.2,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
              },
            ),
                ),
          ],
        ),
      );
  }
}

class AlbumPage extends StatefulWidget {
  final Album album;

  AlbumPage(Album album) : album = album;

  @override
  State<StatefulWidget> createState() => AlbumPageState();
}

class AlbumPageState extends State<AlbumPage> {
  List<Medium>? _media;

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  void initAsync() async {
    MediaPage mediaPage = await widget.album.listMedia();
    setState(() {
      _media = mediaPage.items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(widget.album.name ?? "Unnamed Album"),
        ),
        body: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          children: <Widget>[
            ...?_media?.map(
                  (medium) => GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewerPage(medium))),
                child: Container(
                  color: Colors.grey[300],
                  child: FadeInImage(
                    fit: BoxFit.cover,
                    placeholder: MemoryImage(kTransparentImage),
                    image: ThumbnailProvider(
                      mediumId: medium.id,
                      mediumType: medium.mediumType,
                      highQuality: true,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewerPage extends StatelessWidget {
  final Medium medium;

  ViewerPage(Medium medium) : medium = medium;

  @override
  Widget build(BuildContext context) {
    DateTime? date = medium.creationDate ?? medium.modifiedDate;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: date != null ? Text(date.toLocal().toString()) : null,
        ),
        body: Container(
          alignment: Alignment.center,
          child: medium.mediumType == MediumType.image
              ? FadeInImage(
            fit: BoxFit.cover,
            placeholder: MemoryImage(kTransparentImage),
            image: PhotoProvider(mediumId: medium.id),
          )
              : VideoProvider(
            mediumId: medium.id,
          ),
        ),
      ),
    );
  }
}

class VideoProvider extends StatefulWidget {
  final String mediumId;

  const VideoProvider({
    required this.mediumId,
  });

  @override
  _VideoProviderState createState() => _VideoProviderState();
}

class _VideoProviderState extends State<VideoProvider> {
  VideoPlayerController? _controller;
  File? _file;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAsync();
    });
    super.initState();
  }

  Future<void> initAsync() async {
    try {
      _file = await PhotoGallery.getFile(mediumId: widget.mediumId);
      _controller = VideoPlayerController.file(_file!);
      _controller?.initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    } catch (e) {
      print("Failed : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return _controller == null || !_controller!.value.isInitialized
        ? Container()
        : Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AspectRatio(
          aspectRatio: _controller!.value.aspectRatio,
          child: VideoPlayer(_controller!),
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              _controller!.value.isPlaying
                  ? _controller!.pause()
                  : _controller!.play();
            });
          },
          child: Icon(
            _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ],
    );
  }
}