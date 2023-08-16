// Instagram Clone App
//
// This Flutter app is a simplified clone of the Instagram mobile app. It mimics the
// Instagram Reels section, allowing users to scroll through vertical videos. The app
// features video playback, user interaction icons, and a bottom navigation bar.

// Dependencies
//
// The app utilizes the following packages:
// - `bootstrap_icons`: Provides access to Bootstrap Icons, including Instagram-like icons.
// - `video_player`: Allows video playback for the reels.
// - `google_fonts`: Provides custom fonts for text styling.

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Controllers for handling video playback and page index
  PageController controller = PageController();
  List<VideoPlayerController?> _controllers = [];
  late int index;
  // List of video URLs
  var videolis = [
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4"
  ];

  @override
  void initState() {
    super.initState();
    index = 0;
    // Initialize video controllers
    for (int i = 0; i < videolis.length; i++) {
      _controllers.add(VideoPlayerController.network(videolis[i]));
    }
    // Play the first video
    _controllers[index]!.initialize().then((_) {
      setState(() {
        _controllers[index]!.play();
      });
    });
    // Listen for page changes to handle video playback
    controller.addListener(() {
      int newPageIndex = controller.page!.round();
      if (newPageIndex != index) {
        _controllers[index]!.pause();
        index = newPageIndex;
        if (!_controllers[index]!.value.isInitialized) {
          _controllers[index]!.initialize().then((_) {
            setState(() {
              _controllers[index]!.play();
            });
          });
        } else {
          _controllers[index]!.play(); // Resume playback on the new page
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create a list of widgets for each video
    var reel = List<Widget>.generate(videolis.length, (i) {
      return Stack(
        children: [
          // Video Player
          SizedBox.expand(
            child: _controllers[i]!.value.isInitialized
                ? FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controllers[i]!.value.size.width,
                height: _controllers[i]!.value.size.height,
                child: VideoPlayer(_controllers[i]!),
              ),
            )
                : Container(
              width: _controllers[i]!.value.size.width,
              height: _controllers[i]!.value.size.height,
              color: Color(0xFF000000),
              child: Center(
                child: CircularProgressIndicator(color: Colors.white,),
              ),
            ),
          ),

          // Icons on the side
          Positioned(
            top: 500,
            right: 10,

            child:
            Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(BootstrapIcons.heart, color: Colors.white, size: MediaQuery. of(context). size. height *0.035),
                  ],
                ),
                SizedBox(height: MediaQuery. of(context). size. height*0.01),
                Text('230',style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 15,
                    color: Colors.white
                ),)
              ],
            ),
          ),
          Positioned(
            top: 570,
            right: 10,

            child:
            Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(BootstrapIcons.chat_right, color: Colors.white, size: MediaQuery. of(context). size. height *0.035),
                  ],
                ),
                SizedBox(height: MediaQuery. of(context). size. height*0.01),
                Text('230',style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 15,
                    color: Colors.white
                ),)
              ],
            ),
          ),
          Positioned(
            top: 640,
            right: 10,

            child:
            Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(BootstrapIcons.send, color: Colors.white, size: MediaQuery. of(context). size. height *0.035),
                  ],
                ),
                SizedBox(height: MediaQuery. of(context). size. height*0.01),
                Text('96',style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w500,
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 15,
                    color: Colors.white
                ),)
              ],
            ),
          ),
          Positioned(
            top: 710,
            right: 10,

            child:
            Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(BootstrapIcons.three_dots, color: Colors.white, size: MediaQuery. of(context). size. height *0.035),
                  ],
                ),
                SizedBox(height: MediaQuery. of(context). size. height*0.01),
              ],
            ),
          ),
          Positioned(
            top: 675,
            left: 10,

            child:
            Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.end, mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 65,
                      height: 65,
                      child: Stack(
                        children: [
                          // Gradient Border
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Colors.purple, Colors.orange], // Define your gradient colors
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),

                          // Profile Picture
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.transparent,
                                  width: 10.0,
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    'https://instagram.ftun2-2.fna.fbcdn.net/v/t51.2885-19/358773201_2546060468874490_5011151768366502087_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.ftun2-2.fna.fbcdn.net&_nc_cat=110&_nc_ohc=-s1D-VDgpx4AX8SdKkg&edm=ACWDqb8BAAAA&ccb=7-5&oh=00_AfCJGFJZzGV3D1pexUFOmrnQ_E51n7eA4gWKx8aQ3vixLQ&oe=64DCD8B3&_nc_sid=ee9879',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          Text('Motezz___',style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              textStyle: Theme.of(context).textTheme.displayLarge,
                              fontSize: 15,
                              color: Colors.white
                          ),),
                          SizedBox(height: 20,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        children: [
                          ElevatedButton(onPressed: (){}, child: Text('Follow',style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              textStyle: Theme.of(context).textTheme.displayLarge,
                              fontSize: 12,
                              color: Colors.white
                          ),),style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent, // Background color
                            elevation: 0, // No shadow
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Border radius
                              side: BorderSide(
                                color: Colors.white54, // Border color
                                width: 2, // Border width
                              ),
                            ),
                          ),),
                          SizedBox(height: 5,)
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: MediaQuery. of(context). size. height*0.01),
              ],
            ),
          ),
          Positioned(
            top: 750,
            left: 20,
            child:
                Text('Newest reels have been discovered',style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  textStyle: Theme.of(context).textTheme.displayLarge,
                  fontSize: 15,
                  color: Colors.white
                ),)
          ),

        ],
      );
    });

    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Container(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround, // Space around the icons
            children: [
              IconButton(
                onPressed: () {},
                icon:Icon(Icons.home,color: Colors.white,),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search,color: Colors.white,),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add_box,color: Colors.white,),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.movie,color: Colors.white,),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.account_circle,color: Colors.white,),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: PageView(
          controller: controller,
          scrollDirection: Axis.vertical,
          children: reel,
        ),
      ),
    );
  }
}