import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:usercrudapis/models/user.dart';
import 'package:usercrudapis/user_services.dart';

void main() {
  runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
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
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> users = [];
  @override
  void initState() {
    super.initState();
    fetchuser();
  }

  Future<void> fetchuser() async {
    final user = await UserServices.fetchusers();
    setState(() {
      users = user;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Crud Operations with Apis")),
      body: ListView.builder(itemCount: users.length,itemBuilder: (context,index){
      return ListTile(
        leading: CircleAvatar(child: Icon(Icons.person),),
        title: Text(users[index].name)  ,
        subtitle: Text("${users[index].age}"),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(onPressed: () {},icon: Icon(Icons.edit),),
              IconButton(onPressed: (){}, icon: Icon(Icons.delete),),
            ],
          ),
        ),
      );
   },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        
      },
      child: Icon(Icons.add),
    ),
    );
  }
}
