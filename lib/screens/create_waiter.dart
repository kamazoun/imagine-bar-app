import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:imagine_bar/controllers/employee_controller.dart';
import 'package:imagine_bar/models/condiment.dart';
import 'package:imagine_bar/models/waiter.dart';

class CreateWaiter extends StatefulWidget {
  @override
  State<CreateWaiter> createState() => _CreateWaiterState();
}

class _CreateWaiterState extends State<CreateWaiter> {
  final TextEditingController nameController = TextEditingController();

  bool _gender = false;

  @override
  Widget build(BuildContext context) {
    final EmployeeController employeeController =
        Get.find<EmployeeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a waiter to the team'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () => createItem(context, employeeController))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 5, horizontal: MediaQuery.of(context).size.width / 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                keyboardType: TextInputType.name,
                controller: nameController,
                decoration:
                    InputDecoration(labelText: 'Please enter Waiter name'),
              ),
              SwitchListTile(
                value: _gender,
                title: Text('Gender'),
                subtitle: Text('The waiter is ${_gender ? 'male' : 'female'}'),
                onChanged: (val) {
                  setState(() {
                    _gender = val;
                  });
                },
                selected: _gender,
              ),
              const Divider(
                indent: 25.0,
                endIndent: 25.0,
              ),
              OutlinedButton(
                  onPressed: () => createItem(context, employeeController),
                  child: Text('Ok'))
            ],
          ),
        ),
      ),
    );
  }

  createItem(context, EmployeeController employeeController) {
    if (nameController.text.isEmpty) {
      return;
    }

    final newItem = Waiter(
        name: nameController.text.trim(),
        since: DateTime.now(),
        gender: _gender);

    employeeController.createWaiter(newItem);

    Navigator.pop(context);
  }
}
