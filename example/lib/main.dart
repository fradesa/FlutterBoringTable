// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:boring_table/src/filters/boring_filter.dart';
import 'package:boring_table/boring_table.dart';
import 'package:boring_table/src/filters/boring_filter_style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boring Table example',
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
      home: const Example(),
    );
  }
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Boring Table"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ExampleBody(),
      ),
    );
  }
}

class Person {
  String name;
  String surname;
  Person({
    required this.name,
    required this.surname,
  });
}

enum UserType {
  admin,
  normal;
}

class ExampleBody extends StatelessWidget {
  ExampleBody({super.key});

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed, // Any states you want to affect here
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      // if any of the input states are found in our list
      return Colors.transparent;
    }
    return Colors.red; // default color
  }

  static final List<Person> userList = List.generate(
    10000,
    (index) => Person(name: '$index', surname: '$index'),
  );

  @override
  Widget build(BuildContext context) {
    return BoringTable<Person>.fromList(
      onTap: ((p0) => print("Tapped $p0")),
      headerRow: RowElementClass.tableHeader,
      rowActionsColumnLabel: "More",
      toTableRow: (dynamic user) {
        return [
          Text(user.name),
          Text(user.surname),
        ];
      },
      rawItems: userList,
      decoration: BoringTableDecoration(
          showDivider: true,
          evenRowColor: Colors.purple,
          oddRowColor: Colors.pink),
      groupActions: true,
      groupActionsMenuShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      groupActionsWidget: const Icon(
        Icons.more_vert,
        color: Colors.amber,
      ),
      filterStyle: BoringFilterStyle(
        openFiltersDialogWidget: Icon(Icons.abc),
        titleStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
        hintStyle: TextStyle(color: Colors.amber),
        textInputDecoration: const InputDecoration(
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        ),
        dropdownBoxDecoration: BoxDecoration(
          border: Border.all(color: Colors.red),
        ),
        filterDialogTitle: Text('FILTRIIIIIIII'),
        applyFiltersText: "APPLICA",
        removeFiltersText: "RIMUOVI",
        applyFiltersButtonStyle: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.red),
        ),
        removeFiltersButtonStyle: ButtonStyle(
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Colors.black),
        ),
      ),
      filters: [
        BoringTextFilter(
          //type: BoringFilterType.text
          title: 'Nome',
          where: (element, controller) {
            if (controller.value != null) {
              return (element).name.contains(controller.value);
            }
            return true;
          },
          valueController: BoringFilterValueController<String>(),
          hintText: 'Inserisci nome',
        ),
        BoringDropdownFilter(
          title: 'Cognome',
          values: [
            'asd',
            'qwe',
          ],
          showingValues: [
            'asd',
            'qwe',
          ],
          where: (element, controller) {
            if (controller.value != null) {
              return element.surname.contains(controller.value);
            }
            return true;
          },
          valueController: BoringFilterValueController<String>(),
          hintText: 'Seleziona cognome',
        ),
      ],
      actionGroupTextStyle: TextStyle(color: Colors.red),
      rowActions: [
        BoringRowAction(
            icon: Icon(Icons.add),
            buttonText: "asd",
            onTap: (c) {
              print((c as Person).name);
            }),
      ],
      title: BoringTableTitle(
        actions: [
          ElevatedButton(
              onPressed: () => print("PRESSED"), child: Text("PRESS ME"))
        ],
        title: Text("Titolo"),
      ),
    );
  }
}

class RowElementClass extends BoringTableRowElement {
  RowElementClass(this._user);

  final Person _user;

  static final tableHeader = [
    TableHeaderElement(label: "Column A"),
    TableHeaderElement(label: "Column B"),
  ];

  @override
  List<Widget> toTableRow() {
    return [
      Text(_user.name),
      Text(_user.surname),
    ];
  }
}
