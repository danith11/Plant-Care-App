import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/plant.dart';
import '../providers/plant_provider.dart';

class AddEditScreen extends StatefulWidget {
  final Plant? plant;

  AddEditScreen({this.plant});

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _type;
  late String _wateringFrequency;
  late String _status;

  @override
  void initState() {
    super.initState();
    _name = widget.plant?.name ?? '';
    _type = widget.plant?.type ?? 'Indoor';
    _wateringFrequency = widget.plant?.wateringFrequency ?? 'Daily';
    _status = widget.plant?.status ?? 'Healthy';
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final provider = Provider.of<PlantProvider>(context, listen: false);

      bool success;
      if (widget.plant == null) {
        success = await provider.addPlant(
          Plant(
            name: _name,
            type: _type,
            wateringFrequency: _wateringFrequency,
            status: _status,
          ),
        );
      } else {
        success = await provider.updatePlant(
          Plant(
            id: widget.plant!.id,
            name: _name,
            type: _type,
            wateringFrequency: _wateringFrequency,
            status: _status,
          ),
        );
      }

      if (success) {
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error saving plant.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plant == null ? 'Add Plant' : 'Edit Plant'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Plant Name'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a name' : null,
                onSaved: (value) => _name = value!,
              ),
              DropdownButtonFormField<String>(
                value: _type,
                decoration: InputDecoration(labelText: 'Type'),
                items: ['Indoor', 'Outdoor']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (val) => setState(() => _type = val!),
              ),
              DropdownButtonFormField<String>(
                value: _wateringFrequency,
                decoration: InputDecoration(labelText: 'Watering Frequency'),
                items: ['Daily', 'Weekly']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (val) => setState(() => _wateringFrequency = val!),
              ),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(labelText: 'Status'),
                items: ['Healthy', 'Needs Care']
                    .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                    .toList(),
                onChanged: (val) => setState(() => _status = val!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
