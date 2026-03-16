import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:usercrudapis/models/user.dart';
import 'package:usercrudapis/user_services.dart';

void main() {
  runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("User Crud Operations with APIs")),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(users[index].name),
            subtitle: Text(users[index].age.toString()),
            trailing: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              UpdateUser(user: users[index]),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () async {
                      await UserServices.deleteuser(users[index].id);
                      fetchuser();
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddUser(fetchusers: fetchuser),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddUser extends StatelessWidget {
  final Function fetchusers;

  AddUser({required this.fetchusers, super.key});

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController agecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add User")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: namecontroller,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: agecontroller,
              decoration: const InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final name = namecontroller.text;
                final age1 = int.parse(agecontroller.text);

                await UserServices.adduser(name, age1);
                fetchusers();
                Navigator.pop(context);
              },
              child: const Text("Add User"),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdateUser extends StatelessWidget {
  final User user;

  UpdateUser({required this.user, super.key});

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController agecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    namecontroller.text = user.name;
    agecontroller.text = user.age.toString();

    return Scaffold(
      appBar: AppBar(title: const Text("Update User")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: namecontroller,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: agecontroller,
              decoration: const InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final name = namecontroller.text;
                final age1 = int.parse(agecontroller.text);

                await UserServices.updateuser(user.id, name, age1);
                Navigator.pop(context);
              },
              child: const Text("Update User"),
            ),
          ],
        ),
      ),
    );
  }
}