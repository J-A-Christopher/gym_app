import 'package:flutter/material.dart';
import 'package:gym_app/providers/practice_provider.dart';
import 'package:gym_app/widgets/bar_chart_widget2.dart';
import 'package:provider/provider.dart';
import '../providers/back_provider.dart';
import '../widgets/back_practice_widget.dart';

class BackScreen extends StatefulWidget {
  const BackScreen({super.key});

  @override
  State<BackScreen> createState() => _BackScreenState();
}

class _BackScreenState extends State<BackScreen> {
  final _form = GlobalKey<FormState>();
  void _saveForm() {
    _form.currentState!.save();
    Provider.of<BackProvider>(context, listen: false).addPractice(
      _editedPractices,
    );
  }

  var _editedPractices = PracticeProvider(
      kgs: 0,
      id: '',
      reps: 0,
      sets: 0,
      subType: '',
      type: '',
      time: DateTime.now());

  @override
  Widget build(BuildContext context) {
    void _showModalBottomSheet() {
      showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
          isScrollControlled: true,
          context: context,
          builder: ((context) => Form(
              key: _form,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 15),
                        child: Center(
                            child: Text(
                          'Practice Details',
                          style: TextStyle(fontSize: 20),
                        ))),
                    TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          hintText: 'Exercise type e.g Back'),
                      onSaved: (value) {
                        _editedPractices = PracticeProvider(
                            time: DateTime.now(),
                            kgs: _editedPractices.kgs,
                            id: '',
                            reps: _editedPractices.reps,
                            sets: _editedPractices.sets,
                            subType: _editedPractices.subType,
                            type: value!);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Exercise sub-type e.g Lower Back',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                      onSaved: (value) {
                        _editedPractices = PracticeProvider(
                            time: DateTime.now(),
                            kgs: _editedPractices.kgs,
                            id: '',
                            reps: _editedPractices.reps,
                            sets: _editedPractices.sets,
                            subType: value!,
                            type: _editedPractices.type);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Reps done',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                      onSaved: (value) {
                        _editedPractices = PracticeProvider(
                            time: DateTime.now(),
                            kgs: _editedPractices.kgs,
                            id: '',
                            reps: int.parse(value!),
                            sets: _editedPractices.sets,
                            subType: _editedPractices.subType,
                            type: _editedPractices.type);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Sets accomplished',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                      onSaved: (value) {
                        _editedPractices = PracticeProvider(
                            time: DateTime.now(),
                            kgs: _editedPractices.kgs,
                            id: '',
                            reps: _editedPractices.reps,
                            sets: int.parse(value!),
                            subType: _editedPractices.subType,
                            type: _editedPractices.type);
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Kilograms lifted',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                      onSaved: (value) {
                        _editedPractices = PracticeProvider(
                            kgs: double.parse(value!),
                            id: '',
                            reps: _editedPractices.reps,
                            sets: _editedPractices.sets,
                            subType: _editedPractices.subType,
                            type: _editedPractices.type,
                            time: DateTime.now());
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_editedPractices.kgs == '' ||
                              _editedPractices.reps == '' ||
                              _editedPractices.sets == '' ||
                              _editedPractices.subType == '' ||
                              _editedPractices.type == '') {
                            return;
                          }
                          _saveForm();
                          Navigator.pop(context);
                          Provider.of<BackProvider>(context, listen: false)
                              .fetchAndSetPractice1();
                        },
                        child: const Text('Update..')),
                  ],
                ),
              ))));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Back'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showModalBottomSheet,
        child: const Icon(Icons.add),
      ),
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.0, top: 15.0),
            child: Text(
              'Current Weight',
              style: TextStyle(fontSize: 15),
            ),
          ),
          Text(''),
          BarChartWidget2(),
          BackPracticeWidget()
        ],
      ),
    );
  }
}
