import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db_app/bloc/network_connection/network_bloc.dart';
import 'package:movie_db_app/screens/home/home_page.dart';
import 'package:movie_db_app/utils/constant.dart';
import 'package:movie_db_app/utils/shades.dart';
import 'package:palette_generator/palette_generator.dart';
import 'dart:math' as math;
void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   MyApp({Key? key}) : super(key: key);
//   final connectivity = Connectivity();
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         appBarTheme: const AppBarTheme(
//             color: primaryColor
//         ),
//         primaryColor: primaryColor
//
//       ),
//       home: MultiBlocProvider(
//         providers: [
//           BlocProvider<NetworkBloc>(
//               create: (context) => NetworkBloc(connectivity: connectivity)
//                 ..add(ListenConnection())),
//         ],
//         child: HomePage(),
//       ),
//     );
//   }
// }

/// The main Application class.
class MyApp extends StatelessWidget {
  /// Creates the main Application class.
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Colors',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),

      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> images = ['assets/demo.jpeg','assets/landscape.png'];
  late List<PaletteColor?> bgColors;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
    _updatePalette();
  }

  _updatePalette() async {
    bgColors = [];
    for(String image in images) {
      PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
        AssetImage(image),
        size: Size(200, 100),
      );
      palette.darkMutedColor != null ? bgColors.add(palette.darkMutedColor) : bgColors.add(PaletteColor(Colors.red,3));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beautiful Nepal'),
        elevation: 0,
        backgroundColor: bgColors.length > 0 ? bgColors[_currentIndex]?.color : Theme.of(context).primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            color: bgColors.length > 0 ? bgColors[_currentIndex]?.color : Colors.white,
            child: PageView(
              onPageChanged: (index){
                setState(() {
                  _currentIndex = index;
                });
              },
              children: images.map((image)=>Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover
                  ),
                ),
              )).toList(),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: bgColors.length > 0 ? bgColors[_currentIndex]?.color : Colors.white
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Nepal, The 8th Wonder",style: TextStyle(
                      color: bgColors.isNotEmpty ? bgColors[_currentIndex]?.titleTextColor : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0
                  ),),
                  const SizedBox(height: 10.0),
                  Text("Lorem ipsum dolor sit amet consectetur adipisicing elit. Id obcaecati tenetur enim et dolore aut dolorum! Fugiat omnis amet atque quos sapiente similique, tempore, vitae eos perferendis cupiditate libero odit.",textAlign: TextAlign.justify,style: TextStyle(
                      color: bgColors.isNotEmpty ? bgColors[_currentIndex]?.bodyTextColor : Colors.black,
                      fontSize: 20.0
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}