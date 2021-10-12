import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:dose_care/router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

int? isViewed;

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ValueNotifier<bool>>.value(
          value: ValueNotifier<bool>(false),
        ),
      ],
      child: Sizer(
        builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
          Future.wait([
            precachePicture(
              ExactAssetPicture(
                  SvgPicture.svgStringDecoder, 'images/medicalIntro.svg'),
              null,
            ),
            precachePicture(
              ExactAssetPicture(
                  SvgPicture.svgStringDecoder, 'images/bloodIntro.svg'),
              null,
            ),
          ]);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Dose Tracker",
            theme: ThemeData(
              brightness: Brightness.light,
              fontFamily: 'WorkSans',
            ),
            initialRoute: isViewed != 0 ? '/onboarding' : '/',
            // initialRoute: '/onboarding',
            onGenerateRoute: RouteGenerator.generateRoute,
          );
        },
      ),
    );
  }
}
