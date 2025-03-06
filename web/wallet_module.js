const { VersionedTransaction } = solanaWeb3;

let pubKey = '';

function isPhantomInstalled() {
    return window.phantom?.solana?.isPhantom;
}

async function connect() {
    const resp = await window.phantom?.solana.connect();
    pubKey = resp.publicKey.toString();
}

function address() {
    return pubKey;
}

function disconnect() {
    window.phantom?.solana.disconnect();
}

async function sendTransaction(tx) {
    const deserializedTx = VersionedTransaction.deserialize(tx);
    const transaction = await window.phantom?.solana.signAndSendTransaction(deserializedTx);
    return transaction.signature;
}

window.walletModule = { 
    isPhantomInstalled,
    connect,
    address,
    disconnect,
    sendTransaction
};
