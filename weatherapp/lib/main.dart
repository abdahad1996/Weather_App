import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demoss',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const EmptyWidget(),
    );
  }
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[Center(child: Text('text'))],
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return 
//     MultiBlocProvider(
//           providers: [
//             BlocProvider<WeeklyForcastBloc>(
//               create: (BuildContext context) => WeeklyForcastBloc(RemoteLoadWeeklyForcast(url: "",client: APIClient())),
//             ),
           
//           ],
//           child: MyApp(),
//         )
//   }
// }