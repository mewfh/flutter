import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const appTitle = 'form';
    return MaterialApp(
      title: appTitle,
      home: const MyForm(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  // MyFormState createState() {
  //   return MyFormState();
  // }
  State<MyForm> createState() => MyFormState();
}

class MyFormState extends State<MyForm> {
  //const MyForm({super.key});
  final _formkey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final myIdController = TextEditingController();
  final myEmailController = TextEditingController();

  @override
  void dispose(){
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retrieve Text Input'),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: TextFormField(
                controller: myController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Enter your name',
                ),
              )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: TextFormField(
                controller: myIdController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter student id';
                  }
                  else if (value.length != 11){
                    return 'student id is in wrong format';
                  }
                  
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Enter your student id',
                ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              child: TextFormField(
                controller: myEmailController,
                validator: (value) {
                  final isEmail = RegExp(r'^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$');
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  else if (!isEmail.hasMatch(value)){
                    return 'email is in wrong format';
                  }
                  
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Enter your email',
                ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    
                    showDialog(
                      context: context, 
                      builder: (BuildContext context){
                        return AlertDialog(
                          title: const Text('Input'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name: ${myController.text}'),
                              Text('Student ID: ${myIdController.text}'),
                              Text('Email: ${myEmailController.text}'),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: const Text('Submit'),
              ),
              
            ),
          ]
        ),
      ),
    );   
  }
}
