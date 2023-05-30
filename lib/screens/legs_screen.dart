import 'package:flutter/material.dart';
import 'package:gym_app/providers/legs_provider.dart';
import 'package:gym_app/providers/practice_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/bar_chart_widget.dart';
import '../widgets/legs_practice_widget.dart';

class LegsScreen extends StatefulWidget {
  const LegsScreen({super.key});

  @override
  State<LegsScreen> createState() => _LegsScreenState();
}

class _LegsScreenState extends State<LegsScreen> {
  final _form = GlobalKey<FormState>();
  DateTime? _selectedDate;
  void _saveForm() {
    _form.currentState!.save();
    Provider.of<LegsProvider>(context, listen: false).addPractice(
      _editedPractices,
    );
  }

  // void _presentDatePicker() {
  //   showDatePicker(
  //           context: context,
  //           initialDate: DateTime.now(),
  //           firstDate: DateTime(2023),
  //           lastDate: DateTime.now())
  //       .then((pickedDate) {
  //     if (pickedDate == null) {
  //       return;
  //     }
  //     setState(() {
  //       _selectedDate = pickedDate;
  //     });
  //   });
  // }

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
                          hintText: 'Exercise type e.g chest'),
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
                          hintText: 'Exercise sub-type e.g Upper Chest',
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
                      keyboardType: TextInputType.number,
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
                      keyboardType: TextInputType.number,
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
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        _editedPractices = PracticeProvider(
                          kgs: double.parse(value!),
                          id: '',
                          reps: _editedPractices.reps,
                          sets: _editedPractices.sets,
                          subType: _editedPractices.subType,
                          type: _editedPractices.type,
                          time: DateTime.now(),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              // if (_editedPractices.kgs == '' ||
                              //     _editedPractices.reps == '' ||
                              //     _editedPractices.sets == '' ||
                              //     _editedPractices.subType == '' ||
                              //     _editedPractices.type == '' ||
                              //     _selectedDate == '') {
                              //   return;
                              // }
                              _saveForm();
                              Navigator.pop(context);
                              Provider.of<LegsProvider>(context, listen: false)
                                  .fetchAndSetPractice();
                            },
                            child: const Text('Update..')),
                        // Text(_selectedDate == null
                        //     ? 'No Date Chosen'
                        //     : 'PickedDate:  ${DateFormat.yMd().format(_selectedDate!)}'),
                        // TextButton(
                        //     onPressed: _presentDatePicker,
                        //     child: const Text(
                        //       'Choose Date',
                        //       style: TextStyle(
                        //           color: Colors.indigo,
                        //           fontWeight: FontWeight.bold),
                        //     )),
                      ],
                    ),
                  ],
                ),
              ))));
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Legs'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showModalBottomSheet,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15.0, top: 15.0),
            child: Text(
              'Current Weight',
              style: TextStyle(fontSize: 15),
            ),
          ),
          const Text(''),
          const BarChartWidget(),
          LegsPracticeWidget(
            pickedDate: _selectedDate,
          )
        ],
      ),
    );
  }
}
