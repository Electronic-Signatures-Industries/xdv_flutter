import 'package:wallet/src/wallet_base.dart';
import 'package:restio/restio.dart';

// https://github.com/tiagohm/restio/blob/master/client/README.md
class IPFS {
  final client = Restio();
  var URL = 'https://ipfs-api.xdv.digital/api/v0';
  constructor() {}

// https://github.com/ipfs/js-ipfs/blob/master/docs/core-api/FILES.md#ipfsadddata-options
  addFile() async {
    final request = Request(
      uri: RequestUri.parse('$URL/add'),
      method: HttpMethod.post,
    );
    final call = client.newCall(request);
    final response = await call.execute();
    await response.close();
  }

// https://github.com/ipfs/js-ipfs/blob/master/docs/core-api/PIN.md#ipfspinaddipfspath-options
  pin() async {
    final request = Request(
      uri: RequestUri.parse('$URL/pin/add'),
      method: HttpMethod.post,
    );
    final call = client.newCall(request);
    final response = await call.execute();
    await response.close();
  }

// https://github.com/ipfs/js-ipfs/blob/master/docs/core-api/NAME.md#ipfsnamepublishvalue-options
  publish() async {
    final request = Request(
      uri: RequestUri.parse('$URL/name/publish'),
      method: HttpMethod.post,
    );
    final call = client.newCall(request);
    final response = await call.execute();
    await response.close();
  }

  // https://github.com/ipfs/js-ipfs/blob/master/docs/core-api/FILES.md#ipfsadddata-options
  addTar() async {
    final request = Request(
      uri: RequestUri.parse('$URL/tar/add'),
      method: HttpMethod.post,
    );
    final call = client.newCall(request);
    final response = await call.execute();
    await response.close();
  }

  // https://github.com/ipfs/js-ipfs/blob/master/docs/core-api/FILES.md#ipfsadddata-options
  fetch() async {
    final request = Request(
      uri: RequestUri.parse('https://ipfs-api.xdv.digital/api/v0'),
      method: HttpMethod.post,
    );
    final call = client.newCall(request);
    final response = await call.execute();
    await response.close();
  }

  // DAG
  // https://github.com/ipfs/js-ipfs/blob/master/docs/core-api/DAG.md

  // resolve

  // tree

  // get

  // put
}
