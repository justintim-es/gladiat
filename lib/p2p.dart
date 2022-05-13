import 'dart:io';
import 'dart:convert';
import 'dart:isolate';
import 'package:nofifty/gladiator.dart';
import 'package:crypto/crypto.dart';
import 'package:hex/hex.dart';
import 'package:nofifty/pera.dart';
import 'package:nofifty/obstructionum.dart';
import 'package:nofifty/constantes.dart';
import 'package:nofifty/utils.dart';
import 'package:nofifty/transaction.dart';
import 'package:ecdsa/ecdsa.dart';
import 'package:elliptic/elliptic.dart';
class P2PMessage {
  String type;
  P2PMessage(this.type);
  P2PMessage.fromJson(Map<String, dynamic> jsoschon):
    type = jsoschon['type'];
  Map<String, dynamic> toJson() => {
    'type': type
  };
}
class SingleSocketP2PMessage extends P2PMessage {
  String socket;
  SingleSocketP2PMessage(this.socket, String type): super(type);
  SingleSocketP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    socket = jsoschon['socket'],
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'socket': socket,
    'type': type,
  };
}
class ConnectBootnodeP2PMessage extends P2PMessage {
  String socket;
  ConnectBootnodeP2PMessage(this.socket, String type): super(type);
  ConnectBootnodeP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    socket = jsoschon['socket'],
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'socket': socket,
    'type': type
  };
}
class OnConnectP2PMessage extends P2PMessage {
  List<String> sockets;
  List<Propter> propters;
  List<Transaction> liberTxs;
  List<Transaction> fixumTxs;
  OnConnectP2PMessage(this.sockets, this.propters, this.liberTxs, this.fixumTxs, String type): super(type);
  OnConnectP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    sockets = List<String>.from(jsoschon['sockets']),
    propters = List<Propter>.from(jsoschon['propters'].map((x) => Propter.fromJson(x))),
    liberTxs = List<Transaction>.from(jsoschon['liberTxs'].map((x) => Transaction.fromJson(x))),
    fixumTxs = List<Transaction>.from(jsoschon['fixumTxs'].map((x) => Transaction.fromJson(x))),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'sockets': sockets,
    'propters': propters.map((p) => p.toJson()).toList(),
    'liberTxs': liberTxs.map((liber) => liber.toJson()).toList(),
    'fixumTxs': fixumTxs.map((liber) => liber.toJson()).toList(),
    'type': type
  };
}
class SocketsP2PMessage extends P2PMessage {
  List<String> sockets;
  SocketsP2PMessage(this.sockets, String type): super(type);
  SocketsP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    sockets = List<String>.from(jsoschon['sockets']),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'type': type,
    'sockets': sockets
  };
}
class PropterP2PMessage extends P2PMessage {
  Propter propter;
  PropterP2PMessage(this.propter, String type): super(type);
  PropterP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    propter = Propter.fromJson(jsoschon['propter']),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'propter': propter.toJson(),
    'type': type
  };
}
class RemoveProptersP2PMessage extends P2PMessage {
  List<String> ids;
  RemoveProptersP2PMessage(this.ids, String type): super(type);
  RemoveProptersP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    ids = List<String>.from(jsoschon['ids']),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'ids': ids,
    'type': type
  };
}
class TransactionP2PMessage extends P2PMessage {
  Transaction tx;
  TransactionP2PMessage(this.tx, String type): super(type);
  TransactionP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    tx = Transaction.fromJson(jsoschon['tx']),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'tx': tx.toJson(),
    'type': type
  };
}
class RemoveTransactionsP2PMessage extends P2PMessage {
  List<String> ids;
  RemoveTransactionsP2PMessage(this.ids, String type): super(type);
  RemoveTransactionsP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    ids = List<String>.from(jsoschon['ids']),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'ids': ids,
    'type': type
  };
}
class ObstructionumP2PMessage extends P2PMessage {
  Obstructionum obstructionum;
  List<List<String>> hashes;
  ObstructionumP2PMessage(this.obstructionum, this.hashes, String type): super(type);
  ObstructionumP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    obstructionum = Obstructionum.fromJson(jsoschon['obstructionum']),
    hashes = List<List<String>>.from(jsoschon['hashes'].map((x) => List<String>.from(x))),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'obstructionum': obstructionum.toJson(),
    'hashes': hashes,
    'type': type
  };
}
class RequestObstructionumP2PMessage extends P2PMessage {
  List<int> numerus;
  RequestObstructionumP2PMessage(this.numerus, String type): super(type);
  RequestObstructionumP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    numerus = List<int>.from(jsoschon['numerus']),
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'numerus': numerus,
    'type': type
  };
}
class RequestObstructionumProbationemP2PMessage extends P2PMessage {
  int index;
  String probationem;
  RequestObstructionumProbationemP2PMessage(this.index, this.probationem, String type): super(type);

  RequestObstructionumProbationemP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    index = jsoschon['index'],
    probationem = jsoschon['probationem'],
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'index': index,
    'probationem': probationem,
    'type': type
  };
}
class RequestProbationemP2PMessage extends P2PMessage {
  int index;
  RequestProbationemP2PMessage(this.index, String type): super(type);
  RequestProbationemP2PMessage.fromJson(Map<String, dynamic> jsoschon):
    index = jsoschon['index'],
    super.fromJson(jsoschon);
  @override
  Map<String, dynamic> toJson() => {
    'index': index,
    'type': type
  };

}
class P2P {
  int maxPeers;
  List<String> sockets = [];
  List<Propter> propters = [];
  List<Transaction> liberTxs = [];
  List<Transaction> fixumTxs = [];
  List<Transaction> expressieTxs = [];
  List<Isolate> syncBlocks = [];
  Directory dir;
  ReceivePort efectusRp = ReceivePort();
  ReceivePort confussusRp = ReceivePort();
  ReceivePort expressiRp = ReceivePort();
  bool isEfectusActive = false;
  bool isConfussusActive = false;
  bool isExpressiActive = false;

  List<int> summaNumerus;
  P2P(this.maxPeers, this.dir, this.summaNumerus);
  listen(String internalIp, int port) async {
    ServerSocket serverSocket = await ServerSocket.bind(internalIp, port);
    print(serverSocket.address);
    print(serverSocket.port);
    serverSocket.listen((client) {
      client.listen((data) async {
        print(client.address.address);
        print(client.port);
        P2PMessage msg = P2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
        if(msg.type == 'connect-bootnode') {
          ConnectBootnodeP2PMessage cbp2pm = ConnectBootnodeP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
          client.write(json.encode(OnConnectP2PMessage(sockets, propters, liberTxs, fixumTxs, 'on-connect').toJson()));
          // client.destroy();
          for(String socket in sockets) {
            Socket s = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
            s.write(json.encode(SingleSocketP2PMessage(cbp2pm.socket, 'single-socket')));
          }
          if(sockets.length < maxPeers && !sockets.contains(cbp2pm.socket) && cbp2pm.socket != '$internalIp:$port') {
            sockets.add(cbp2pm.socket);
          }
        } else if (msg.type == 'single-socket') {
          SingleSocketP2PMessage ssp2pm = SingleSocketP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
          if(sockets.length < maxPeers && ssp2pm.socket != '$internalIp:$port') {
            sockets.add(ssp2pm.socket);
          }
          client.destroy();
        } else if(msg.type == 'propter') {
          PropterP2PMessage pp2pm = PropterP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
          if(pp2pm.propter.probationem == HEX.encode(sha256.convert(utf8.encode(json.encode(pp2pm.propter.interioreRationem.toJson()))).bytes)) {
            if(propters.any((p) => p.interioreRationem.id == pp2pm.propter.interioreRationem.id)) {
              propters.removeWhere((p) => p.interioreRationem.id == pp2pm.propter.interioreRationem.id);
            }
            propters.add(pp2pm.propter);
            client.destroy();
          }
        } else if (msg.type == 'remove-propters') {
          RemoveProptersP2PMessage rpp2pm = RemoveProptersP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
          propters.removeWhere((p) => rpp2pm.ids.any((id) => id == p.interioreRationem.id));
          client.destroy();
        } else if (msg.type == 'expressi-tx') {
          TransactionP2PMessage tp2pm = TransactionP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
          //maby some validation
          expressieTxs.add(tp2pm.tx);
        } else if (msg.type == 'liber-tx') {
          TransactionP2PMessage tp2pm = TransactionP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
          List<Obstructionum> obs = await Obstructionum.getBlocks(dir);
          if (await tp2pm.tx.validateLiber(dir)) {
              if (liberTxs.any((tx) => tx.interioreTransaction.id == tp2pm.tx.interioreTransaction.id)) {
                liberTxs.removeWhere((tx) => tx.interioreTransaction.id == tp2pm.tx.interioreTransaction.id);
              }
              liberTxs.add(tp2pm.tx);
          } else {
            client.write(json.encode(RemoveProptersP2PMessage(List<String>.from([tp2pm.tx.interioreTransaction.id]), 'remove-liber-txs').toJson()));
          }
        } else if (msg.type == 'fixum-tx') {
          TransactionP2PMessage tp2pm = TransactionP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
          List<Obstructionum> obs = await Obstructionum.getBlocks(dir);
          if (await tp2pm.tx.validateFixum(dir)) {
              if (fixumTxs.any((tx) => tx.interioreTransaction.id == tp2pm.tx.interioreTransaction.id)) {
                fixumTxs.removeWhere((tx) => tx.interioreTransaction.id == tp2pm.tx.interioreTransaction.id);
              }
              fixumTxs.add(tp2pm.tx);
          } else {
            client.write(json.encode(RemoveProptersP2PMessage(List<String>.from([tp2pm.tx.interioreTransaction.id]), 'remove-fixum-txs').toJson()));
          }
        } else if (msg.type == 'remove-liber-txs') {
          RemoveTransactionsP2PMessage rtp2pm = RemoveTransactionsP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
          liberTxs.removeWhere((l) => rtp2pm.ids.any((id) => id == l.interioreTransaction.id));
          client.destroy();
        } else if (msg.type == 'remove-fixum-txs') {
          RemoveTransactionsP2PMessage rtp2pm = RemoveTransactionsP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
          fixumTxs.removeWhere((l) => rtp2pm.ids.any((id) => id == l.interioreTransaction.id));
          client.destroy();
        } else if (msg.type == 'obstructionum') {
          print('recieved obstructionum');
          ObstructionumP2PMessage op2pm = ObstructionumP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
          if (dir.listSync().isEmpty && op2pm.obstructionum.interioreObstructionum.generare == Generare.INCIPIO) {
            await op2pm.obstructionum.salvareIncipio(dir);
            client.write(json.encode(RequestObstructionumP2PMessage([1], 'request-obstructionum').toJson()));
          } else if (dir.listSync().isEmpty && op2pm.obstructionum.interioreObstructionum.generare != Generare.INCIPIO) {
              client.write(json.encode(RequestObstructionumP2PMessage([0], 'request-obstructionum').toJson()));
          } else {
            Obstructionum obs = await Utils.priorObstructionum(dir);
            summaNumerus = obs.interioreObstructionum.obstructionumNumerus;
            if (!op2pm.obstructionum.isProbationem()) {
              print('invalid probationem');
              return;
            }
            if (op2pm.obstructionum.interioreObstructionum.summaObstructionumDifficultas > obs.interioreObstructionum.summaObstructionumDifficultas) {
              List<Obstructionum> obss = await Obstructionum.getBlocks(dir);
              List<String> probationums = obss.map((ob) => ob.probationem).toList();
              if (
                obs.probationem == op2pm.obstructionum.interioreObstructionum.priorProbationem
              ) {
                if (op2pm.obstructionum.interioreObstructionum.forumCap != await Obstructionum.accipereForumCap(dir)) {
                  print("Corrumpere forum cap");
                  return;
                }
                List<Transaction> transformInputs = [];
                for (Transaction tx in op2pm.obstructionum.interioreObstructionum.fixumTransactions) {
                    transformInputs.add(tx);
                  if (tx.probationem == 'transform') {
                  } else {
                    if (!await tx.validateFixum(dir) || !tx.validateProbationem()) {
                      print("Corrumpere negotium in obstructionum");
                    }
                  }
                }
                List<Transaction> transformOutputs = [];
                for (Transaction tx in op2pm.obstructionum.interioreObstructionum.liberTransactions) {
                  switch(tx.probationem) {
                    case 'ardeat': {
                      if (!await tx.validateBurn(dir)) {
                        print("irritum ardeat");
                        return;
                      }
                      break;
                    }
                    case 'transform': {
                      transformOutputs.add(tx);
                      break;
                    }
                    case 'obstructionum praemium': {
                      if (!tx.validateBlockreward()) {
                        print('irritum obstructionum praemium');
                        return;
                      }
                      break;
                    }
                    default: {
                      if (!await tx.validateLiber(dir) || !tx.validateProbationem())  {
                        print("irritum tx");
                        return;
                      };
                      break;
                    }
                  }
                }
                BigInt transformAble = BigInt.zero;
                for (List<TransactionInput> inputs in transformInputs.map((tx) => tx.interioreTransaction.inputs)) {
                  for (TransactionInput input in inputs) {
                      Obstructionum obstructionum = obss.singleWhere((ob) => ob.interioreObstructionum.liberTransactions.any((tx) => tx.interioreTransaction.id == input.transactionId));
                      Transaction tx = obstructionum.interioreObstructionum.liberTransactions.singleWhere((liber) => liber.interioreTransaction.id == input.transactionId);
                      if (!Utils.cognoscere(PublicKey.fromHex(Pera.curve(), tx.interioreTransaction.outputs[input.index].publicKey), Signature.fromCompactHex(input.signature), tx.interioreTransaction.outputs[input.index])) {
                        print("irritum tx");
                        return;
                      } else {
                        transformAble += tx.interioreTransaction.outputs[input.index].gla;
                      }
                  }
                }
                BigInt transformed = BigInt.zero;
                for (List<TransactionOutput> outputs in transformOutputs.map((tx) => tx.interioreTransaction.outputs)) {
                  for (TransactionOutput output in outputs) {
                    transformed += output.gla;
                  }
                }
                if (transformAble != transformed) {
                  print("irritum transform");
                  return;
                }
                if(op2pm.obstructionum.interioreObstructionum.generare == Generare.EFECTUS) {
                  if(isEfectusActive) expressiRp.sendPort.send(true);
                  for (GladiatorOutput output in op2pm.obstructionum.interioreObstructionum.gladiator.outputs) {
                    for (Propter propter in output.rationem) {
                      if (!propter.isProbationem()) {
                        print('invalidum probationem pro ratione');
                        return;
                      }
                    }
                  }
                  if(op2pm.obstructionum.interioreObstructionum.liberTransactions.where((liber) => liber.probationem == Constantes.txObstructionumPraemium).length != 1) {
                    print("Insufficient obstructionum munera");
                    return;
                  }
                  if (op2pm.obstructionum.interioreObstructionum.liberTransactions.where((liber) => liber.probationem == Constantes.transform).isNotEmpty) {
                    print("Insufficient transforms");
                    return;
                  }
                  if (!op2pm.obstructionum.probationem.startsWith('0' * op2pm.obstructionum.interioreObstructionum.obstructionumDifficultas)) {
                    print("Insufficient leading zeros");
                  }
                } else if (op2pm.obstructionum.interioreObstructionum.generare == Generare.CONFUSSUS) {
                  String gladiatorId = op2pm.obstructionum.interioreObstructionum.gladiator.input!.gladiatorId;
                  int index = op2pm.obstructionum.interioreObstructionum.gladiator.input!.index;
                  if (op2pm.obstructionum.interioreObstructionum.gladiator.outputs.isNotEmpty) {
                    print("outputs arent liceat ad confossum");
                    return;
                  } else if (
                    await Obstructionum.gladiatorConfodiantur(op2pm.obstructionum.interioreObstructionum.gladiator.input!.gladiatorId, op2pm.obstructionum.interioreObstructionum.producentis, dir)
                  ) {
                    print('clausus potest non oppugnare publica clavem');
                    print("block can't attack the same public key");
                    return;
                  }
                  Defensio turpiaDefensio = await Pera.turpiaGladiatoriaDefensione(index, gladiatorId, dir);
                  List<Defensio> deschefLiber = await Pera.maximeDefensiones(true, index, gladiatorId, dir);
                  List<Defensio> deschefFixum = await Pera.maximeDefensiones(false, index, gladiatorId, dir);
                  List<String> defensionesLiber = deschefLiber.map((x) => x.defensio).toList();
                  List<String> defensionesFixum = deschefFixum.map((x) => x.defensio).toList();
                  List<String> defensiones = [];
                  defensiones.add(turpiaDefensio.defensio);
                  defensiones.addAll(defensionesLiber);
                  defensiones.addAll(defensionesFixum);
                  bool coschon =  false;
                  for (int i = 0; i < defensiones.length; i++) {
                      if (op2pm.obstructionum.probationem.contains(defensiones[i])) {
                        coschon = true;
                      } else {
                        coschon = false;
                        break;
                      }
                  }
                  if (!coschon) {
                    print('gladiator non defeaten');
                    return;
                  }
                  int ardet = 0;
                  for (GladiatorOutput output in obs.interioreObstructionum.gladiator.outputs) {
                    for (String propter in output.rationem.map((x) => x.interioreRationem.publicaClavis)) {
                      final balance = await Pera.statera(true, propter, dir);
                      if (balance > BigInt.zero) {
                        ardet += 1;
                      }
                    }
                  }
                  if (op2pm.obstructionum.interioreObstructionum.liberTransactions.where((liber) => liber.probationem == Constantes.ardeat).length != ardet) {
                    print("Insufficiens ardet");
                    return;
                  }
                  if (op2pm.obstructionum.interioreObstructionum.liberTransactions.where((liber) => liber.probationem == Constantes.transform).length != 1) {
                    print("Insufficiens transforms");
                    return;
                  }
                  Obstructionum utCognoscereObstructionum = obss.singleWhere((o) => o.interioreObstructionum.gladiator.id == op2pm.obstructionum.interioreObstructionum.gladiator.input!.gladiatorId);
                  GladiatorOutput utCognoscere = utCognoscereObstructionum.interioreObstructionum.gladiator.outputs[op2pm.obstructionum.interioreObstructionum.gladiator.input!.index];
                  if(
                    !Utils.cognoscereVictusGladiator(
                      PublicKey.fromHex(Pera.curve(), op2pm.obstructionum.interioreObstructionum.producentis), 
                      Signature.fromASN1Hex(op2pm.obstructionum.interioreObstructionum.gladiator.input!.signature), 
                      utCognoscere
                    )) {
                      print('invalidum confossus gladiator');
                      print('invalid stabbed gladiator');
                    }
                } else if (op2pm.obstructionum.interioreObstructionum.generare == Generare.EXPRESSI) {
                  expressiRp.sendPort.send(false);                  
                  String gladiatorId = op2pm.obstructionum.interioreObstructionum.gladiator.input!.gladiatorId;
                  int index = op2pm.obstructionum.interioreObstructionum.gladiator.input!.index;
                  if (op2pm.obstructionum.interioreObstructionum.gladiator.outputs.isNotEmpty) {
                    print("outputs arent liceat ad confossum");
                    return;
                  } else if (
                    await Obstructionum.gladiatorConfodiantur(op2pm.obstructionum.interioreObstructionum.gladiator.input!.gladiatorId, op2pm.obstructionum.interioreObstructionum.producentis, dir)
                  ) {
                    print('clausus potest non oppugnare publica clavem');
                    print("block can't attack the same public key");
                    return;
                  }
                  Defensio turpiaDefensio = await Pera.turpiaGladiatoriaDefensione(index, gladiatorId, dir);
                  List<Defensio> deschefLiber = await Pera.maximeDefensiones(true, index, gladiatorId, dir);
                  List<Defensio> deschefFixum = await Pera.maximeDefensiones(false, index, gladiatorId, dir);
                  List<String> defensionesLiber = deschefLiber.map((x) => x.defensio).toList();
                  List<String> defensionesFixum = deschefFixum.map((x) => x.defensio).toList();
                  List<String> defensiones = [];
                  defensiones.add(turpiaDefensio.defensio);
                  defensiones.addAll(defensionesLiber);
                  defensiones.addAll(defensionesFixum);
                  bool coschon =  false;
                  for (int i = 0; i < defensiones.length; i++) {
                      if (op2pm.obstructionum.probationem.contains(defensiones[i])) {
                        coschon = true;
                      } else {
                        coschon = false;
                        break;
                      }
                  }
                  if (!coschon) {
                    print('gladiator non defeaten');
                    return;
                  }
                  int ardet = 0;
                  for (GladiatorOutput output in obs.interioreObstructionum.gladiator.outputs) {
                    for (String propter in output.rationem.map((x) => x.interioreRationem.publicaClavis)) {
                      final balance = await Pera.statera(true, propter, dir);
                      if (balance > BigInt.zero) {
                        ardet += 1;
                      }
                    }
                  }
                  if (op2pm.obstructionum.interioreObstructionum.liberTransactions.where((liber) => liber.probationem == Constantes.ardeat).length != ardet) {
                    print("Insufficiens ardet");
                    return;
                  }
                  if (op2pm.obstructionum.interioreObstructionum.liberTransactions.where((liber) => liber.probationem == Constantes.transform).length != 1) {
                    print("Insufficiens transforms");
                    return;
                  }
                  Obstructionum utCognoscereObstructionum = obss.singleWhere((o) => o.interioreObstructionum.gladiator.id == op2pm.obstructionum.interioreObstructionum.gladiator.input!.gladiatorId);
                  GladiatorOutput utCognoscere = utCognoscereObstructionum.interioreObstructionum.gladiator.outputs[op2pm.obstructionum.interioreObstructionum.gladiator.input!.index];
                  if(
                    !Utils.cognoscereVictusGladiator(
                      PublicKey.fromHex(Pera.curve(), op2pm.obstructionum.interioreObstructionum.producentis), 
                      Signature.fromASN1Hex(op2pm.obstructionum.interioreObstructionum.gladiator.input!.signature), 
                      utCognoscere
                    )) {
                      print('invalidum confossus gladiator');
                      print('invalid stabbed gladiator');
                    }
                  if (!op2pm.obstructionum.probationem.startsWith('0' * (op2pm.obstructionum.interioreObstructionum.obstructionumDifficultas / 2).floor())) {
                    print('Insufficient leading zxeros');
                    return;
                  } else if (!op2pm.obstructionum.probationem.endsWith('0' * (op2pm.obstructionum.interioreObstructionum.obstructionumDifficultas / 2).floor())) {
                    print('Insufficient trailing zeros');
                    return;
                  } else if (op2pm.obstructionum.interioreObstructionum.liberTransactions.where((liber) => liber.probationem == Constantes.txObstructionumPraemium).isNotEmpty) {
                    print("Insufficient obstructionum praemium");
                    return;
                  } else if (obs.interioreObstructionum.generare == Generare.EXPRESSI) {
                    print('non duo expressi cursus sustentabatur');
                    print('cannot produce two expressi blocks in a row');
                    return;
                  } else if (await Obstructionum.gladiatorConfodiantur(op2pm.obstructionum.interioreObstructionum.gladiator.input!.gladiatorId, op2pm.obstructionum.interioreObstructionum.producentis, dir)) {
                    print('clausus potest non oppugnare publica clavem');
                    print("block can't attack the same public key");
                    return;
                  }
                }
                await op2pm.obstructionum.salvare(dir);
                print('synced block ${op2pm.obstructionum.interioreObstructionum.obstructionumNumerus}');
                print('synced obstructionum ${op2pm.obstructionum.interioreObstructionum.obstructionumNumerus}');
                if (isEfectusActive) {
                  efectusRp.sendPort.send("");
                }
                if (isConfussusActive) {
                  confussusRp.sendPort.send("");
                }

                P2P.syncBlock(List<dynamic>.from([op2pm.obstructionum, sockets.length > 1 ? sockets.skip(sockets.indexOf('${client.address.address}:${client.port}')) : sockets, dir]));
                // for (ReceivePort rp in efectusMiners) {
                //
                // }
                // sp.send("yupdate miner");

                // obs = await Utils.priorObstructionum(dir);
                if (summaNumerus.last < Constantes.maximeCaudicesFile) {
                  summaNumerus[summaNumerus.length-1] = summaNumerus.last + 1;
                } else {
                  summaNumerus.add(0);
                }

                client.write(json.encode(RequestObstructionumP2PMessage(summaNumerus, 'request-obstructionum').toJson()));
                print('requested block $summaNumerus');
                // await syncBlock(obs);
              } else if(
                op2pm.obstructionum.interioreObstructionum.obstructionumNumerus.length >= obs.interioreObstructionum.obstructionumNumerus.length  &&
                op2pm.obstructionum.interioreObstructionum.obstructionumNumerus.last > obs.interioreObstructionum.obstructionumNumerus.last
              )  {
                await Utils.removeObstructionumsUntilProbationem(obs.probationem, dir);
                print('remota obstructionum cum probationem ${obs.probationem}');
                client.write(json.encode(RequestObstructionumProbationemP2PMessage(0, obs.probationem, 'request-obstructionum-probationem').toJson()));
              } 
            }
          }
        } else if (msg.type == 'request-probationem') {
          RequestProbationemP2PMessage rpp2pm = RequestProbationemP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
          String prior = await Utils.priorObstructionumIndex(rpp2pm.index, dir);
          int index = rpp2pm.index + 1;
          client.write(json.encode(RequestObstructionumProbationemP2PMessage(index, prior, 'request-obstructionum-probationem').toJson()));
        }
      });
    });
  }
  connect(String bootnode, String me) async {
    sockets.add(bootnode);
    Socket socket = await Socket.connect(bootnode.split(':')[0], int.parse(bootnode.split(':')[1]));
    socket.write(json.encode(ConnectBootnodeP2PMessage(me, 'connect-bootnode').toJson()));
    socket.listen((data) async {
      OnConnectP2PMessage ocp2pm = OnConnectP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
      if(sockets.length < maxPeers) {
        sockets.addAll(ocp2pm.sockets.take((maxPeers - sockets.length)));
      }
      propters.addAll(ocp2pm.propters);
      liberTxs.addAll(ocp2pm.liberTxs);
      fixumTxs.addAll(ocp2pm.fixumTxs);
    });
  }
  syncPropter(Propter propter) async {
    if(propters.any((p) => p.interioreRationem.id == propter.interioreRationem.id)) {
      propters.removeWhere((p) => p.interioreRationem.id == propter.interioreRationem.id);
    }
    propters.add(propter);
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      soschock.write(json.encode(PropterP2PMessage(propter, 'propter').toJson()));
    }
  }
  syncLiberTx(Transaction tx) async {
    if (liberTxs.any((t) => t.interioreTransaction.id == tx.interioreTransaction.id)) {
      liberTxs.removeWhere((t) => t.interioreTransaction.id == tx.interioreTransaction.id);
    }
    liberTxs.add(tx);
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      soschock.write(json.encode(TransactionP2PMessage(tx, 'liber-tx').toJson()));
      soschock.listen((data) async {
        RemoveTransactionsP2PMessage rtp2pm = RemoveTransactionsP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
        liberTxs.removeWhere((liber) => rtp2pm.ids.contains(liber.interioreTransaction.id));
      });
    }
  }
  syncExpressiTx(Transaction tx) async {
    expressieTxs.add(tx);
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      soschock.write(json.encode(TransactionP2PMessage(tx, 'expressi-tx').toJson()));
    }
  }
  syncFixumTx(Transaction tx) async {
    if (fixumTxs.any((t) => t.interioreTransaction.id == tx.interioreTransaction.id)) {
      fixumTxs.removeWhere((t) => t.interioreTransaction.id == tx.interioreTransaction.id);
    }
    fixumTxs.add(tx);
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      soschock.write(json.encode(TransactionP2PMessage(tx, 'fixum-tx').toJson()));
      soschock.listen((data) async {
        RemoveTransactionsP2PMessage rtp2pm = RemoveTransactionsP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
        fixumTxs.removeWhere((fixum) => rtp2pm.ids.contains(fixum.interioreTransaction.id));
      });
    }
  }
  removePropters(List<String> ids) async {
    propters.removeWhere((p) => ids.any((i) => i == p.interioreRationem.id));
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      soschock.write(json.encode(RemoveProptersP2PMessage(ids, 'remove-propters').toJson()));
    }
  }
  removeLiberTxs(List<String> ids) async {
    liberTxs.removeWhere((l) => ids.any((i) => i == l.interioreTransaction.id));
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      soschock.write(json.encode(RemoveTransactionsP2PMessage(ids, 'remove-liber-txs').toJson()));
    }
  }
  removeFixumTxs(List<String> ids) async {
    fixumTxs.removeWhere((f) => ids.contains(f.interioreTransaction.id));
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      soschock.write(json.encode(RemoveTransactionsP2PMessage(ids, 'remove-fixum-txs').toJson()));
    }
  }
  static syncBlock(List<dynamic> args) async {
    Obstructionum obs = args[0];
    List<String> sockets = args[1];
    Directory dir = args[2];
    // if(obs.interioreObstructionum.generare == Generare.EFECTUS || obs.interioreObstructionum.generare == Generare.EXPRESSI) {
    //   expressieTxs = [];
    // }
    for (String socket in sockets) {
      Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
      List<List<String>> hashes = [];
      int idx = 0;
      int total = 0;
      // for (int i = 0; i < dir.listSync().length; i++) {
      //   hashes.add([]);
      //   List<String> lines = await Utils.fileAmnis(File('${dir.path}/${Constantes.fileNomen}$i.txt')).toList();
      //   for (String line in lines) {
      //     if (total < 100) {
      //       hashes[idx].add(Obstructionum.fromJson(json.decode(line)).probationem);
      //       total++;
      //     }
      //   }
      //   idx++;
      // }
      soschock.write(json.encode(ObstructionumP2PMessage(obs, hashes, 'obstructionum').toJson()));
      print('sended ${obs.interioreObstructionum.obstructionumNumerus}');
      soschock.listen((data) async {
        // List<List<String>> lines = [];
        // for (int i = dir.listSync().length-1; i > -1 ; i--) {
        //   List<String> lines = await Utils.fileAmnis(File('${dir.path}/${Constantes.fileNomen}$i.txt')).toList();
        //   lines.addAll(lines);
        // }
        P2PMessage p2pm = P2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
        if(p2pm.type == 'request-obstructionum') {
          RequestObstructionumP2PMessage rop2pm = RequestObstructionumP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
          print(rop2pm.numerus.length);
          File caudices = File('${dir.path}/${Constantes.fileNomen}${rop2pm.numerus.length-1}.txt');

        // if (await Utils.fileAmnis(caudices).length > rop2pm.numerus.last) {
          if (rop2pm.numerus.last <= Constantes.maximeCaudicesFile) {
            String obs = await Utils.fileAmnis(caudices).elementAt(rop2pm.numerus.last);
            Obstructionum obsObs = Obstructionum.fromJson(json.decode(obs));
            soschock.write(json.encode(ObstructionumP2PMessage(obsObs, hashes, 'obstructionum').toJson()));
            print('sended block ${rop2pm.numerus}');
          } else {
            rop2pm.numerus.add(0);
            String obs = await Utils.fileAmnis(caudices).elementAt(rop2pm.numerus.last);
            Obstructionum obsObs = Obstructionum.fromJson(json.decode(obs));
            soschock.write(json.encode(ObstructionumP2PMessage(obsObs, hashes, 'obstructionum').toJson()));
            print('sended block ${rop2pm.numerus}');
          }
        } else if (p2pm.type == 'request-obstructionum-probationem') {
          RequestObstructionumProbationemP2PMessage ropp2pm = RequestObstructionumProbationemP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim())); 
          print('recieved probationem ${ropp2pm.probationem}');
          print('obstructionums post ${ropp2pm.index}');
          Obstructionum? obst = await Utils.accipereObstructionumPriorProbationem(ropp2pm.probationem, dir);
          if (obst == null) {
            soschock.write(json.encode(RequestProbationemP2PMessage(ropp2pm.index, 'request-probationem').toJson()));
            print('couldnt find block with probationem request previous probationem');
          } else {
            soschock.write(json.encode(ObstructionumP2PMessage(obst, hashes, 'obstructionum').toJson()));
            print('sended block ${obst.interioreObstructionum.obstructionumNumerus}');
          }
        }
      });
    }
  }
}

// import 'dart:io';
// import 'dart:convert';
// import 'package:nofifty/gladiator.dart';
//
//
// class P2PMessage {
//   String type;
//   P2PMessage(this.type);
//   P2PMessage.fromJson(Map<String, dynamic> jsoschon):
//     type = jsoschon['type'];
//   Map<String, dynamic> toJson() => {
//     'type': type
//   };
// }
// class PropterP2PMessage extends P2PMessage {
//   Propter propter;
//   PropterP2PMessage(String type, this.propter): super(type);
//   PropterP2PMessage.fromJson(Map<String, dynamic> jsoschon):
//     propter = Propter.fromJson(jsoschon['propter']),
//     super.fromJson(jsoschon);
// }
// class SocketsP2PMessage extends P2PMessage {
//   List<String> sockets;
//   bool broadcast;
//   SocketsP2PMessage(this.broadcast, String type, this.sockets): super(type);
//   SocketsP2PMessage.fromJson(Map<String, dynamic> jsoschon):
//     sockets = List<String>.from(jsoschon['sockets']),
//     broadcast = jsoschon['broadcast'],
//     super.fromJson(jsoschon);
//   Map<String, dynamic> toJson() => {
//     'type': type,
//     'broadcast': broadcast,
//     'sockets': sockets
//   };
// }
//
// class P2P {
//   String listenIp;
//   int listenPort;
//   String externalIp;
//   late ServerSocket serverSocket;
//   final List<String> sockets = [];
//   final List<Propter> propters = [];
//   P2P(this.listenIp, this.listenPort, this.externalIp);
//
//   connect(String bootnode) async {
//     final Socket socket = await Socket.connect(bootnode.split(':')[0], int.parse(bootnode.split(':')[1]));
//     sockets.add(bootnode);
//     List<String> sendSockets = sockets;
//     sendSockets.add('$externalIp:$listenPort');
//     socket.write(json.encode(SocketsP2PMessage(true, 'socket', sendSockets).toJson()));
//   }
//   listen() async {
//     ServerSocket serverSocket = await ServerSocket.bind(listenIp, listenPort);
//     serverSocket.listen((client) {
//       client.listen((data) async {
//         print('data');
//         print(String.fromCharCodes(data).trim());
//         P2PMessage msg = P2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
//         if(msg.type == 'socket') {
//           final s = SocketsP2PMessage.fromJson(json.decode(String.fromCharCodes(data).trim()));
//           print(s.toJson());
//           sockets.addAll(s.sockets.where((ss) => !sockets.contains(ss) && ss != '$externalIp:$listenPort'));
//           print(sockets);
//           for (String soschock in sockets) {
//             if(s.broadcast) {
//               final Socket socket = await Socket.connect(soschock.split(':')[0], int.parse(soschock.split(':')[1]));
//               socket.write(json.encode(SocketsP2PMessage(false, 'socket', sockets).toJson()));
//             }
//           }
//           //client.destroy();
//         } else if (msg is PropterP2PMessage) {
//           propters.removeWhere((p) => p.interioreRationem.id == msg.propter.interioreRationem.id);
//           propters.add(msg.propter);
//           client.destroy();
//         }
//       });
//     });
//   }
//   syncPropter(Propter propter) async {
//     propters.removeWhere((p) => p.interioreRationem.id == propter.interioreRationem.id);
//     propters.add(propter);
//     for (String socket in sockets) {
//       Socket soschock = await Socket.connect(socket.split(':')[0], int.parse(socket.split(':')[1]));
//       soschock.write(json.encode(PropterP2PMessage('propter', propter).toJson()));
//     }
//   }
// }
