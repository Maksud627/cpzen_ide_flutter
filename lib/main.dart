// import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:code_text_field/code_text_field.dart';
// Import the language & theme
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/brainfuck.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:flutter_highlight/themes/vs.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_highlight/themes/darcula.dart';
import 'package:dio/dio.dart';
import 'dart:convert';


void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CodeEditor(),
  ));
}

class CodeEditor extends StatefulWidget {
  const CodeEditor({Key? key}) : super(key: key);

  @override
  _CodeEditorState createState() => _CodeEditorState();
}


//start
class _CodeEditorState extends State<CodeEditor> {
  bool _isLoading = false;
  CodeController? _codeController;
  Map<String, TextStyle>? theme = monokaiSublimeTheme;
  String lang = '';
  String temp = "";
  int statCode = 0;
  String memUsed = '';
  String cpuTime = '';


  // @override
  // void initState() {
  //   super.initState();
  //   final source = "void main() {\n    print(\"Hello, world!\");\n}";
  //   // Instantiate the CodeController
  //   _codeController = CodeController(
  //     text: source,
  //     language: dart,
  //     theme: monokaiSublimeTheme,
  //   );
  // }

  // @override
  // void dispose() {
  //   _codeController?.dispose();
  //   super.dispose();
  // }

  onSubmit() async{

    // compile
    // void _compile() async {
    //   setState(() {
    //     _isLoading = true;
    //   });
    // }

    // requesting to api
    var response = await Dio().post('https://api.jdoodle.com/v1/execute', data: {
      "clientId": "3fb44d94b7b8811e6bf35d13997f39d0",
      "clientSecret":
      "e059300a8f5c9ace0c756d85843151d2b4ede26ca97b61619dbbfb29f262a8ad",
      "script": _codeController!.text,
      "language": lang,
    });

    // json to string conversion
    var jsonResponse = jsonDecode(response.toString());

    // setState(() {
    //   _isLoading = false;
    // });

    // compiler output box
    debugPrint(jsonResponse.toString());

    temp = jsonResponse['output'];
    statCode = jsonResponse['statusCode'];
    memUsed = jsonResponse['memory'];
    cpuTime = jsonResponse['cpuTime'];
    // CupertinoAlertDialog(
    //   title: Text('Output'),
    //   content: Text(temp),
    //   // backgroundColor: Colors.yellowAccent,
    //   actions: <Widget>[
    //     ElevatedButton(
    //       onPressed: () => Navigator.pop(context), child: Text('OK')
    //     ),
    //   ],
    // );
    //
    // await showDialog(
    //   context: context,
    //   builder: (context) {
    //     return CupertinoAlertDialog();
    //   }
    // );

    // await show_Output();
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return Dialog(
    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    //       elevation: 16,
    //       child: Container(
    //         child: ListView(
    //           shrinkWrap: true,
    //           children: <Widget>[
    //             SizedBox(height: 20),
    //             Center(child: Text('Compiled Result!', style: TextStyle(fontWeight: FontWeight.bold),)),
    //             SizedBox(height: 20),
    //             Center(child: Text("Output: "+temp),),
    //             SizedBox(height: 40),
    //             Center(child: Text("Memory: "+memUsed.toString()+"  || CPU: "+cpuTime.toString())),
    //             SizedBox(height: 10),
    //             // Center(child: Text("Memory Used: "+memUsed.toString())),
    //             // Center(child: Text("CPU Time: "+cpuTime.toString())),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );


    // _showOutput(String output, int statusCode) {
    //   AlertDialog alert = AlertDialog(
    //     title: Text('Output'),
    //     content: Text(output),
    //     actions: [
    //       ElevatedButton(
    //           onPressed: () => Navigator.pop(context), child: Text('OK'))
    //     ],
    //   );
    //
    //   _showOutput(jsonResponse['output'], jsonResponse['statusCode']);
    //
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return alert;
    //     }
    //   );
    // }
  }

  String dropdownValue = 'C';
  String selected_theme = 'Atom';
  // List listThemes = ['Atom', 'Monokai-sublime', 'VS', 'Darcula'];
  // List listLanguages = ['C', 'C++', 'Python', 'Java'];
  @override
  Widget build(BuildContext context) {

    final source = "print('hello')";

    // Instantiate the CodeController
    _codeController = CodeController(
      text: source,
      language: dart,
      theme: theme,
    );



    return Scaffold(
      appBar: AppBar(
        title: Text("CpZen IDE", style: TextStyle(color: Colors.black54),),
        centerTitle: true,
        backgroundColor: Colors.teal,
        // actions: [
        //   DropdownButtonHideUnderline(
        //     child: DropdownButton<String>(
        //       dropdownColor: Colors.yellowAccent,
        //       elevation: 20,
        //       icon: Icon(Icons.arrow_drop_down_circle_sharp),
        //       iconEnabledColor: Colors.black,
        //       items: <String>['C', 'C++', 'Python', 'Java']
        //           .map((String value) {
        //         return DropdownMenuItem<String>(
        //           onTap: () {
        //             setState(() {
        //               if (value == "C") {
        //                 lang = "c";
        //               } else if (value == "C++") {
        //                 lang = "cpp";
        //               } else if (value == "Python") {
        //                 lang = "python3";
        //               } else if (value == "Java") {
        //                 lang = "java";
        //               }
        //             });
        //           },
        //           value: value,
        //           child: Text(
        //             value,
        //             style: TextStyle(color: Colors.black),
        //           ),
        //         );
        //       }).toList(),
        //
        //
        //       onChanged: (_) {},
        //     ),
        //   ),
        //   DropdownButtonHideUnderline(
        //     child: DropdownButton<String>(
        //       dropdownColor: Colors.yellowAccent,
        //       elevation: 20,
        //       icon: Icon(Icons.arrow_drop_down_circle_sharp),
        //       iconEnabledColor: Colors.black,
        //       items: <String>['Atom', 'Monokai-sublime', 'VS', 'Darcula']
        //           .map((String value) {
        //         return DropdownMenuItem<String>(
        //           onTap: () {
        //             setState(() {
        //               if (value == "Monokai-sublime") {
        //                 theme = monokaiSublimeTheme;
        //               } else if (value == "Atom") {
        //                 theme = atomOneDarkTheme;
        //               } else if (value == "VS") {
        //                 theme = vsTheme;
        //               } else if (value == "Darcula") {
        //                 theme = darculaTheme;
        //               }
        //             });
        //           },
        //           value: value,
        //           child: Text(
        //             value,
        //             style: TextStyle(color: Colors.black),
        //           ),
        //         );
        //       }).toList(),
        //       onChanged: (_) {},
        //     ),
        //   ),
        // ],
      ),



      body: Column(

        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 60, 0),
                child: Text("Select Language: ", style: TextStyle(fontWeight: FontWeight.bold,),),
              ),

              DropdownButton<String>(

                hint: Text("Select Language: "),
                icon: const Icon(Icons.arrow_downward),
                iconSize: 16,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),

                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    if (dropdownValue == "C") {
                      lang = "c";
                    } else if (dropdownValue == "C++") {
                      lang = "cpp";
                    } else if (dropdownValue == "Python") {
                      lang = "python3";
                    } else if (dropdownValue == "Java") {
                      lang = "java";
                    }
                  });
                },


                items: <String>['C', 'C++', 'Python', 'Java']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),


              ),
            ],
          ),

          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(50, 20, 60, 0),
                child: Text("Select Theme: ", style: TextStyle(fontWeight: FontWeight.bold,),),
              ),

              DropdownButton<String>(

                hint: Text("Select: "),
                icon: const Icon(Icons.arrow_downward),
                iconSize: 16,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),

                value: selected_theme,
                onChanged: (String? newValue) {
                  setState(() {
                    selected_theme = newValue!;
                    if (selected_theme == "Monokai-sublime") {
                      theme = monokaiSublimeTheme;
                    } else if (selected_theme == "Atom") {
                      theme = atomOneDarkTheme;
                    } else if (selected_theme == "VS") {
                      theme = vsTheme;
                    } else if (selected_theme == "Darcula") {
                      theme = darculaTheme;
                    }

                  });
                },


                items: <String>['Atom', 'Monokai-sublime', 'VS', 'Darcula']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),

                  );
                }).toList(),


              ),
            ],
          ),



          // DropdownButtonHideUnderline(
          //   child: DropdownButton<String>(
          //     dropdownColor: Colors.yellowAccent,
          //     iconSize: 30,
          //     elevation: 20,
          //     icon: Icon(Icons.arrow_drop_down_circle_sharp),
          //     iconEnabledColor: Colors.black,
          //     items: <String>['C', 'C++', 'Python', 'Java']
          //         .map<DropdownMenuItem<String>>((String value) {
          //       return DropdownMenuItem<String>(
          //         onTap: () {
          //           setState(() {
          //             if (value == "C") {
          //               lang = "c";
          //             } else if (value == "C++") {
          //               lang = "cpp";
          //             } else if (value == "Python") {
          //               lang = "python3";
          //             } else if (value == "Java") {
          //               lang = "java";
          //             }
          //           });
          //         },
          //         value: value,
          //         child: Text(
          //           value,
          //           style: TextStyle(color: Colors.black),
          //         ),
          //       );
          //     }).toList(),
          //
          //
          //     onChanged: (_) {},
          //   ),
          // ),

          // main editor 2

          Flexible(
            flex: 2,
            child: SingleChildScrollView(
              child: Container(
                child: CodeField(
                  controller: _codeController!,
                  textStyle: TextStyle(fontFamily: 'SourceCode', fontSize: 15),
                ),
              ),
            ),
          ),

          // output


          Flexible(
            flex: 2,
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Container(

                    margin: EdgeInsets.all(20),
                    // color: Colors.grey,

                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Center(child: Text('Compiled Result!', style: TextStyle(fontWeight: FontWeight.bold),)),
                        SizedBox(height: 20),
                        Center(child: Text("Output: "+temp),),
                        SizedBox(height: 40),
                        Center(child: Text("Memory: "+memUsed.toString()+"  || CPU: "+cpuTime.toString())),
                        SizedBox(height: 10),
                        // Center(child: Text("Memory Used: "+memUsed.toString())),
                        // Center(child: Text("CPU Time: "+cpuTime.toString())),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // child: Container(
            //   child: CodeField(
            //     controller: _codeController!,
            //     textStyle: TextStyle(fontFamily: 'SourceCode', fontSize: 15),
            //   ),
            // ),
          ),

          // main editor
          // SingleChildScrollView(
          //   child: Container(
          //     child: CodeField(
          //       controller: _codeController!,
          //       textStyle: TextStyle(fontFamily: 'SourceCode', fontSize: 15),
          //     ),
          //   ),
          // ),
        ],
      ),

      // SingleChildScrollView(
      //   child: Container(
      //     child: CodeField(
      //       controller: _codeController!,
      //       textStyle: TextStyle(fontFamily: 'SourceCode', fontSize: 20),
      //     ),
      //   ),
      // ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          onSubmit();
        },
        child: Icon(
          Icons.play_arrow_sharp,
        ),
      ),



      // jdoodle api calling
    //     void _compile() async {
    //   setState(() {
    //     _isLoading = true;
    //   });
    //   var response =
    //       await Dio().post('https://api.jdoodle.com/v1/execute', data: {
    //     "clientId": "3fb44d94b7b8811e6bf35d13997f39d0",
    //     "clientSecret":
    //     "8088f6005eb4799f4f52bd42314b6101e31ded962adb8cf21de44635b809d82b",
    //     "script": _code,
    //     "language": _language
    //   });
    //
    //   var jsonResponse = jsonDecode(response.toString());
    //
    //   setState(() {
    //     _isLoading = false;
    //   });
    //
    //   debugPrint(jsonResponse.toString());
    //
    //   _showOutput(jsonResponse['output'], jsonResponse['statusCode']);
    // }

      // output show
    //     _showOutput(String output, int statusCode) {
    // AlertDialog alert = AlertDialog(
    // title: Text('Output'),
    // content: Text(output),
    // actions: [
    // ElevatedButton(
    // onPressed: () => Navigator.pop(context), child: Text('OK'))
    // ],
    // );
    //
    // showDialog(
    // context: context,
    // builder: (context) {
    // return alert;
    // });
    // }
    );

  }
}

