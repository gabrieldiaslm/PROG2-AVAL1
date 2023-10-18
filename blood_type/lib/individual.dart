import 'genotype.dart';

class Individual {
  static int _individualCounter = 1;

  final Genotype genotype;
  late String name;

  Individual(String genotypeString, [String? name])
      : genotype = Genotype(genotypeString),
        name = name ?? _generateName(genotypeString);

  static String _generateName(String genotype) {
    int N = _individualCounter++;
    return "Indiv$N";
  }

  List<String> get alleles {
    return genotype.alleles;
  }

  List<String> get agglutinogens {
    return genotype.agglutinogens;
  }

  List<String> get agglutinins {
    return genotype.agglutinins;
  }

  List<String> get offsprings {
    return genotype.offsprings(genotype);
  }

  @override
  String toString() {
    return "$name(${genotype.bloodType(genotype)})";
  }
}
