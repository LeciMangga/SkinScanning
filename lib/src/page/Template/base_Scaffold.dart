import 'package:skinscanning/src/core/base_import.dart';

class BaseScaffold extends StatelessWidget {

  final Widget? body;

  const BaseScaffold({
    super.key,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: SvgPicture.asset('assets/images/Logo.svg'),
      ),
      body: body,
    );
  }
}
