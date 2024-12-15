import 'package:comenta_ai/core/models/movie.dart';
import 'package:comenta_ai/core/service/auth/auth_service.dart';
import 'package:comenta_ai/core/service/review/reviewService.dart';
import 'package:flutter/material.dart';

class Reviewform extends StatefulWidget {
  const Reviewform({super.key});

  @override
  State<Reviewform> createState() => _ReviewformState();
}

class _ReviewformState extends State<Reviewform> {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  Future<void> _submitForm() async {
    final user = AuthService().currentUser;
    final isValid = _formKey.currentState?.validate() ?? false;

    _formData['userId'] = user!.id;
    _formData['userImage'] = user.imageUrl;

    if (!isValid) return;
    _formKey.currentState?.save();
    ReviewService().save(_formData);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    _formData['movieTitle'] = movie.title;
    _formData['movieId'] = movie.id;
    _formData['date'] = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Minha avaliação',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${movie.title}:',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Theme.of(context).colorScheme.onPrimary,
                    decoration: InputDecoration(
                      constraints: const BoxConstraints.expand(height: 100),
                      alignLabelWithHint: true,
                      floatingLabelAlignment: FloatingLabelAlignment.start,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: 'Deixe sua opinião...',
                      labelStyle: const TextStyle(color: Colors.white54),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 71, 71, 71),
                    ),
                    maxLines: 30,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                    onSaved: (newValue) => _formData['review'] = newValue ?? '',
                  ),
                ),
                Text(
                  'Avaliação:',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onPrimary),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          movie.setStars(1);
                        });
                        _formData['avaliation'] = 1;
                      },
                      icon: Icon(
                        movie.countStar > 0 ? Icons.star : Icons.star_border,
                      ),
                      color: const Color.fromARGB(255, 146, 132, 4),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          movie.setStars(2);
                        });
                        _formData['avaliation'] = 2;
                      },
                      icon: Icon(
                        movie.countStar > 1 ? Icons.star : Icons.star_border,
                      ),
                      color: const Color.fromARGB(255, 146, 132, 4),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          movie.setStars(3);
                        });
                        _formData['avaliation'] = 3;
                      },
                      icon: Icon(
                        movie.countStar > 2 ? Icons.star : Icons.star_border,
                      ),
                      color: const Color.fromARGB(255, 146, 132, 4),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          movie.setStars(4);
                        });
                        _formData['avaliation'] = 4;
                      },
                      icon: Icon(
                        movie.countStar > 3 ? Icons.star : Icons.star_border,
                      ),
                      color: const Color.fromARGB(255, 146, 132, 4),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          movie.setStars(5);
                        });
                        _formData['avaliation'] = 5;
                      },
                      icon: Icon(
                        movie.countStar > 4 ? Icons.star : Icons.star_border,
                      ),
                      color: const Color.fromARGB(255, 146, 132, 4),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 114, 113, 113),
                  ),
                  child: const Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
