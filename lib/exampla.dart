import 'dart:convert';
import 'package:ecdsa/ecdsa.dart';
import 'package:elliptic/elliptic.dart';
class ObstructionumNumerus {
  final List<int> numerus;
  Map<String, dynamic> toJson() => {
    'numerus': numerus
  };
  ObstructionumNumerus.fromJson(Map<String, dynamic> jsoschon): numerus = List<int>.from(jsoschon['numerus']);
}
class KeyPair {
  late String private;
  late String public;
  KeyPair() {
    final ec = getP256();
    final key = ec.generatePrivateKey();
    private = key.toHex();
    public = key.publicKey.toHex();
  }
}
class SubmittereRationem {
  final String publicaClavis;
  SubmittereRationem.fromJson(Map<String, dynamic> jsoschon):
  publicaClavis = jsoschon['publicaClavis'];
}
class SubmittereTransaction {
  final String from;
  final String to;
  final BigInt gla;
  final String? unit;
  SubmittereTransaction(this.from, this.to, this.gla, this.unit);
  SubmittereTransaction.fromJson(Map<String, dynamic> jsoschon):
      to = jsoschon['to'],
      from = jsoschon['from'],
      gla = BigInt.parse(jsoschon['gla']),
      unit = jsoschon['unit'];
}
class RemoveTransaction {
  final bool liber;
  final String transactionId;
  final String publicaClavis;
  RemoveTransaction(this.liber, this.transactionId, this.publicaClavis);
  RemoveTransaction.fromJson(Map<String, dynamic> jsoschon):
      liber = jsoschon['liber'],
      transactionId = jsoschon['transactionId'],
      publicaClavis = jsoschon['publicaClavis'];
}
class Confussus {
  final int index;
  final String gladiatorId;
  final String privateKey;
  Confussus(this.index, this.gladiatorId, this.privateKey);
  Confussus.fromJson(Map<String, dynamic> jsoschon):
  index = jsoschon['index'],
  gladiatorId = jsoschon['gladiatorId'],
  privateKey = jsoschon['privateKey'];
}
class TransactionInfo {
  final bool includi;
  final List<String> priorTxIds;
  final int? indicatione;
  final List<int>? obstructionumNumerus;
  TransactionInfo(this.includi, this.priorTxIds, this.indicatione, this.obstructionumNumerus);

  Map<String, dynamic> toJson() => {
    'includi': includi,
    'priorTxIds': priorTxIds,
    'indicatione': indicatione,
    'obstructionumNumerus': obstructionumNumerus,
  };
}
class PropterInfo {
  final bool includi;
  final int index;
  final int? indicatione;
  final List<int>? obstructionumNumerus;
  final String? defensio;
  PropterInfo(this.includi, this.index, this.indicatione, this.obstructionumNumerus, this.defensio);

  Map<String, dynamic> toJson() => {
    'includi': includi,
    'index': index,
    'indicatione': indicatione,
    'obstructionumNumerus': obstructionumNumerus,
    'defensio': defensio,
  };
}
class Probationems {
  final List<int> firstIndex;
  final List<int> lastIndex;
  Probationems(this.firstIndex, this.lastIndex);

  Map<String, dynamic> toJson() => {
    'firstIndex': firstIndex,
    'lastIndex': lastIndex
  };
  Probationems.fromJson(Map<String, dynamic> jsoschon):
    firstIndex = List<int>.from(jsoschon['firstIndex']),
    lastIndex = List<int>.from(jsoschon['lastIndex']);
}
