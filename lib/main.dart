import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udemy_section5/widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 95, 8, 110));

var kDarkColorScheme = ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 5, 99, 125),
brightness: Brightness.dark,
);

void main(){
  //WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations([
    //DeviceOrientation.portraitUp,
  //]).then((fn){
       runApp(
     MaterialApp(
      //for dark theme
      darkTheme: ThemeData.dark().copyWith(useMaterial3: true,
      colorScheme: kDarkColorScheme,
    //    cardTheme: CardTheme().copyWith(
    //   color: kDarkColorScheme.primaryContainer,
    //   margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
    //  ),
     elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
      backgroundColor: kDarkColorScheme.primaryContainer,
      foregroundColor: kDarkColorScheme.onPrimaryContainer,
     )),
      
      ),
      //for light theme
       theme: ThemeData().copyWith(useMaterial3: true, // to style indivisualy use .copywith
     //scaffoldBackgroundColor: Color.fromARGB(255, 112, 3, 88),
     //colorScheme: kColorScheme, 
     appBarTheme: AppBarTheme().copyWith(
      backgroundColor: kColorScheme.onPrimaryContainer,
     // foregroundColor: kColorScheme.primaryContainer
     foregroundColor: Colors.white
     ),
    //  cardTheme: CardTheme().copyWith(
    //   color: kColorScheme.primaryContainer,
    //   margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
    //  )  ,
     elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(
      backgroundColor: kColorScheme.primaryContainer
     )),
     textTheme: ThemeData().textTheme.copyWith(
      titleLarge: TextStyle(fontWeight: FontWeight.normal, 
      color: kColorScheme.onSecondaryContainer,
     // color: Colors.blue,
      fontSize: 20
      ),
     ),
     ),
     themeMode: ThemeMode.system,
     debugShowCheckedModeBanner: false,
    home: Expenses(),
  ));
 // });
}

