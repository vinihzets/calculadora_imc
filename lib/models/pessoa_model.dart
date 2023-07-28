import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class PessoaModel extends HiveObject {
  @HiveField(0)
  final String peso;
  @HiveField(1)
  final String altura;
  @HiveField(2)
  final double imc;

  PessoaModel({required this.peso, required this.altura, required this.imc});
}

class PessoaModelAdapter extends TypeAdapter<PessoaModel> {
  @override
  final int typeId = 0;

  @override
  PessoaModel read(BinaryReader reader) {
    return PessoaModel(
      peso: reader.readString(),
      altura: reader.readString(),
      imc: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, PessoaModel obj) {
    writer.writeString(obj.peso);
    writer.writeString(obj.altura);
    writer.writeDouble(obj.imc);
  }
}
