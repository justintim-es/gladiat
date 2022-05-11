import 'package:nofifty/exampla.dart';
import 'package:nofifty/transaction_stagnum.dart';
import 'package:tuple/tuple.dart';
import 'package:nofifty/transaction.dart';
import 'package:nofifty/utils.dart';
import 'dart:io';
import 'package:nofifty/obstructionum.dart';
import 'dart:convert';
import 'package:ecdsa/ecdsa.dart';
import 'package:elliptic/elliptic.dart';
import 'package:nofifty/constantes.dart';
import 'package:nofifty/gladiator.dart';
import 'package:nofifty/errors.dart';
class Defensio {
  final String defensio;
  final String probationem;
  Defensio(this.defensio, this.probationem);
  Map<String, dynamic> toJson() => {
    'defensio': defensio,
    'probationem': probationem
  };
}
class Pera {
   static EllipticCurve curve() => getP256();
   static Future<Defensio> turpiaGladiatoriaDefensione(int index, String gladiatorId, Directory directory) async {
     for (int i = 0; i < directory.listSync().length; i++) {
        await for(String line in Utils.fileAmnis(File(directory.path + Constantes.fileNomen + i.toString() + '.txt'))) {
          Obstructionum obs = Obstructionum.fromJson(json.decode(line));
          if(obs.interioreObstructionum.gladiator.id == gladiatorId) {
            return Defensio(obs.interioreObstructionum.gladiator.outputs[index].defensio, obs.probationem);
          }
        }
     }
     throw Error(code: 0, message: "gladiator non inveni", english: "gladiator not found");

   }
   static Future<bool> isProbationum(String probationum, Directory directory) async {
      List<String> obs = [];
      for (int i = 0; i < directory.listSync().length; i++) {
         await for(String line in Utils.fileAmnis(File(directory.path + Constantes.fileNomen + i.toString() + '.txt'))) {
            obs.add(Obstructionum.fromJson(json.decode(line)).probationem);
         }
      }
      if (obs.contains(probationum)) return true;
      return false;
   }
   static Future<bool> isPublicaClavisDefended(String publicaClavis, Directory directory) async {
     List<GladiatorOutput> gladiatorOutputs = await Obstructionum.utDifficultas(directory);
     for (List<Propter> propters in gladiatorOutputs.map((g) => g.rationem)) {
       for (Propter propter in propters) {
         if (propter.interioreRationem.publicaClavis == publicaClavis) return true;
       }
     }
     return false;
   }
   static Future<String> basisDefensione(String probationem, Directory directory) async {
     for (int i = 0; i < directory.listSync().length; i++) {
       await for (String line in Utils.fileAmnis(File('${directory.path}${Constantes.fileNomen}$i.txt'))) {
         Obstructionum obs = Obstructionum.fromJson(json.decode(line));
         if (obs.probationem == probationem) {
           return obs.interioreObstructionum.defensio!;
         }
       }
     }
     throw Error(code: 0, message: "probationem non inveni", english: "proof not found");
   }
   static Future<BigInt> yourBid(bool liber, int index, String probationem, String gladiatorId, Directory directory) async {
     Map<String, BigInt> bid = await defensiones(liber, index, gladiatorId, directory);
     for (String key in bid.keys) {
       if (key == probationem) {
         return bid[key] ?? BigInt.zero;
       }
     }
     return BigInt.zero;
   }
   static Future<BigInt> summaBid(bool liber, int index, String probationem, Directory directory) async {
     List<Map<String, BigInt>> maschaps = [];
     List<String> gladiatorIds = [];
     for (int i = 0; i < directory.listSync().length; i++) {
       await for (String line in Utils.fileAmnis(File('${directory.path}${Constantes.fileNomen}$i.txt'))) {
         Obstructionum obs = Obstructionum.fromJson(json.decode(line));
         gladiatorIds.add(obs.interioreObstructionum.gladiator.id);
       }
     }
     for (String gid in gladiatorIds) {
       maschaps.add(await defensiones(liber, index, gid, directory));
     }
     for (Map<String, BigInt> maschap in maschaps) {
       print(maschap.keys);

     }
     BigInt highestBid = BigInt.zero;
     for (Map<String, BigInt> maschap in maschaps) {
       for (String key in maschap.keys.where((k) => k == probationem)) {
         if ((maschap[key] ??= BigInt.zero) >= highestBid) {
           highestBid = maschap[key] ?? BigInt.zero;
         }
       }
     }
     return highestBid;
   }
   static Future<List<Defensio>> maximeDefensiones(bool liber, int index, String gladiatorId, Directory directory) async {
      List<Defensio> def = [];
      Map<String, BigInt> ours = Map();
      List<Map<String, BigInt>> others = [];
      List<Obstructionum> obss = [];
      for (int i = 0; i < directory.listSync().length; i++) {
         await for (String line in Utils.fileAmnis(File(directory.path + '/caudices_' + i.toString() + '.txt'))) {
            Obstructionum obs = Obstructionum.fromJson(json.decode(line));
            obss.add(obs);
            if (obs.interioreObstructionum.gladiator.id == gladiatorId) {
               ours = await defensiones(liber, index, gladiatorId, directory);
            } else {
               others.add(await defensiones(liber, index, obs.interioreObstructionum.gladiator.id, directory));
            }
         }
      }
      Map<String, bool> payedMore = Map();
      for(String key in ours.keys) {
        if(others.any((o) => o.keys.contains(key))) {
          for(Map<String, BigInt> other in others.where((e) => e.keys.contains(key))) {
            if((ours[key] ??= BigInt.zero) > (other[key] ??= BigInt.zero)) {
              payedMore[key] = true;
            }
          }
        } else {
          payedMore[key] = true;
        }
      }
      for(String key in payedMore.keys) {
        def.add(Defensio(obss.singleWhere((obs) => obs.probationem == key).interioreObstructionum.defensio!, key));
      }
      return def;
   }
   static Future<Map<String, BigInt>> defensiones(bool liber, int index, String gladiatorId, Directory directory) async {
      List<Obstructionum> obstructionums = [];
      for (int i = 0;  i < directory.listSync().length; i++) {
         await for (String line in Utils.fileAmnis(File(directory.path + '/caudices_' + i.toString() + '.txt'))) {
            obstructionums.add(Obstructionum.fromJson(json.decode(line)));
            // probationems.add(Obstructionum.fromJson(json.decode(line)).probationem);
            // Obstructionum.fromJson(json.decode(line)).interioreObstructionum.liberTransactions.map((e) => e.interioreTransaction.outputs.where((element) => element.publicKey));
         }
      }
      List<String> publicaClavises = [];
      List<String> probationums = [];
      for (Obstructionum obs in obstructionums) {
         probationums.add(obs.probationem);
         if(obs.interioreObstructionum.gladiator.id == gladiatorId) {
           for (GladiatorOutput output in obs.interioreObstructionum.gladiator.outputs) {
             publicaClavises.addAll(output.rationem.map((e) => e.interioreRationem.publicaClavis));
           }
         }
      }
      List<TransactionInput> toDerive = [];
      List<Transaction> txsWithOutput = [];
      for (Iterable<Transaction> obs in obstructionums
          .map((o) => liber ? o.interioreObstructionum.liberTransactions : o.interioreObstructionum.fixumTransactions
          .where((e) => e.interioreTransaction.outputs.any((oschout) => probationums.contains(oschout.publicKey))))) {
         obs.map((e) => e.interioreTransaction.inputs).forEach(toDerive.addAll);
         txsWithOutput.addAll(obs);
      }
      List<String> transactionIds = toDerive.map((to) => to.transactionId).toList();
      List<TransactionOutput> outputs = [];
      for (Iterable<Transaction> obs in obstructionums.map((o) => liber ? o.interioreObstructionum.liberTransactions : o.interioreObstructionum.fixumTransactions).toList()) {
         obs.where((e) => transactionIds.contains(e.interioreTransaction.id)).map((tx) => tx.interioreTransaction.outputs).forEach(outputs.addAll);
      }
      Map<String, BigInt> maschap = Map();
      for (TransactionOutput oschout in outputs.where((oschout) => publicaClavises.contains(oschout.publicKey))) {
         for(Transaction tx in txsWithOutput) {
            for (TransactionInput ischin in tx.interioreTransaction.inputs) {
               if (Utils.cognoscere(PublicKey.fromHex(Pera.curve(), oschout.publicKey), Signature.fromASN1Hex(ischin.signature), oschout)) {
                  for (TransactionOutput oschoutoschout in tx.interioreTransaction.outputs.where((element) => probationums.contains(element.publicKey))) {
                    BigInt prevValue = maschap[oschoutoschout.publicKey] ?? BigInt.zero;
                    maschap[oschoutoschout.publicKey] = prevValue + oschoutoschout.gla;
                  }
               }
            }
         }
      }
      return maschap;
   }
   //left off
   static Future<Tuple2<InterioreTransaction, InterioreTransaction>> transformFixum(String privatus, Directory directory) async {
        String publica = PrivateKey.fromHex(Pera.curve(), privatus).publicKey.toHex();
        List<Tuple3<int, String, TransactionOutput>> outs = await inconsumptusOutputs(true, publica, directory);
        List<TransactionOutput> outputs = [];
        List<TransactionInput> inputs = [];
        for(Tuple3<int, String, TransactionOutput> out in outs) {
          outputs.add(TransactionOutput(publica, out.item3.gla));
          inputs.add(TransactionInput(out.item1, Utils.signum(PrivateKey.fromHex(Pera.curve(), privatus), out.item3), out.item2));
        }
        return Tuple2<InterioreTransaction, InterioreTransaction>(InterioreTransaction(true, inputs, [], Utils.randomHex(32)), InterioreTransaction(false, [], outputs, Utils.randomHex(32)));
   }
   static Future<List<Tuple3<int, String, TransactionOutput>>> inconsumptusOutputs(bool liber, String publicKey, Directory directory) async {
      List<Tuple3<int, String, TransactionOutput>> outputs = [];
      List<TransactionInput> initibus = [];
      List<Transaction> txs = [];
      for (int i = 0; i < directory.listSync().length; i++) {
         await for (var line in await Utils.fileAmnis(File(directory.path + '/caudices_' + i.toString() + '.txt'))) {
               txs.addAll(
               liber ?
               Obstructionum.fromJson(json.decode(line)).interioreObstructionum.liberTransactions :
               Obstructionum.fromJson(json.decode(line)).interioreObstructionum.fixumTransactions);
         }
      }
      Iterable<List<TransactionInput>> initibuses = txs.map((tx) => tx.interioreTransaction.inputs);
      for (List<TransactionInput> init in initibuses) {
         initibus.addAll(init);
      }
      for(Transaction tx in txs.where((tx) => tx.interioreTransaction.outputs.any((e) => e.publicKey == publicKey))) {
        for (int t = 0; t < tx.interioreTransaction.outputs.length; t++) {
            if(tx.interioreTransaction.outputs[t].publicKey == publicKey) {
              outputs.add(Tuple3<int, String, TransactionOutput>(t, tx.interioreTransaction.id, tx.interioreTransaction.outputs[t]));
            }
        }
      }
      outputs.removeWhere((output) => initibus.any((init) => init.transactionId == output.item2 && init.index == output.item1));
      return outputs;
   }
   static Future<BigInt> statera(bool liber, String publicKey, Directory directory) async {
     List<Tuple3<int, String, TransactionOutput>> outputs = await inconsumptusOutputs(liber, publicKey, directory);
     BigInt balance = BigInt.zero;
     for (Tuple3<int, String, TransactionOutput> inOut in outputs) {
        balance += inOut.item3.gla;
     }
     return balance;
   }
   static Future<InterioreTransaction> ardeat(PrivateKey privatus, String publica, String probationum, BigInt value, Directory directory) async {
     List<Tuple3<int, String, TransactionOutput>> outs = await inconsumptusOutputs(true, publica, directory);
     return calculateTransaction(true, false, privatus, probationum, value, outs, null);
   }
   static Future<InterioreTransaction> novamRem(bool liber, String ex, BigInt value, String to, List<Transaction> txStagnum, Directory directory, String? expressiId) async {
      PrivateKey privatusClavis = PrivateKey.fromHex(Pera.curve(), ex);
      List<Tuple3<int, String, TransactionOutput>> inOuts = await inconsumptusOutputs(liber, privatusClavis.publicKey.toHex(), directory);
      for (Transaction tx in txStagnum.where((t) => t.interioreTransaction.liber == liber)) {
         inOuts.removeWhere((element) => tx.interioreTransaction.inputs.any((ischin) => ischin.transactionId == element.item2));
         for (int i = 0; i < tx.interioreTransaction.outputs.length; i++) {
           if (tx.interioreTransaction.outputs[i].publicKey == privatusClavis.publicKey.toHex()) {
             inOuts.add(Tuple3<int, String, TransactionOutput>(i, tx.interioreTransaction.id, tx.interioreTransaction.outputs[i]));
           }
         }
      }
      return calculateTransaction(liber, true, privatusClavis, to, value, inOuts, expressiId);
   }
   static InterioreTransaction calculateTransaction(bool liber, bool tx, PrivateKey privatus, String to, BigInt value, List<Tuple3<int, String, TransactionOutput>> outs, String? expressiId) {
     BigInt balance = BigInt.zero;
     for (Tuple3<int, String, TransactionOutput> inOut in outs) {
        balance += inOut.item3.gla;
     }
     if (tx ? (balance < (value * BigInt.two)) : (balance < value)) {
        throw Error(code: 1, message: "Satis pecunia", english: "Insufficient funds");
     }
     BigInt implere = value;
     List<TransactionInput> inputs = [];
     List<TransactionOutput> outputs = [];
     for (Tuple3<int, String, TransactionOutput> inOut in outs) {
        inputs.add(TransactionInput(inOut.item1, Utils.signum(privatus, inOut.item3), inOut.item2));
        if (inOut.item3.gla < implere) {
           outputs.add(TransactionOutput(to, inOut.item3.gla));
           implere -= inOut.item3.gla;
        } else if (inOut.item3.gla > implere) {
           outputs.add(TransactionOutput(to, implere));
           outputs.add(TransactionOutput(privatus.publicKey.toHex(), inOut.item3.gla - implere));
           break;
        } else {
           outputs.add(TransactionOutput(to, implere));
           break;
        }
     }
     if (expressiId != null) {
       return InterioreTransaction.expressi(liber, inputs, outputs, Utils.randomHex(32), expressiId);
     } else {
       return InterioreTransaction(liber, inputs, outputs, Utils.randomHex(32));
     }
   }

}
