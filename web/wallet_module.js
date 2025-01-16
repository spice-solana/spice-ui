const { VersionedTransaction } = solanaWeb3;

let pubKey = '';

function isPhantomInstalled() {
    return window.solana && window.solana.isPhantom;
}

async function connect() {
    const resp = await window.solana.connect();
    pubKey = resp.publicKey.toString();
}

function address() {
    return pubKey;
}

function disconnect() {
    window.solana.disconnect();
}

async function signTransaction(tx) {
    const deserializedTx = VersionedTransaction.deserialize(tx);
    const signedTransaction = await window.solana.signTransaction(deserializedTx);
    return signedTransaction.serialize();
}

window.walletModule = { 
    isPhantomInstalled,
    connect,
    address,
    disconnect,
    signTransaction
};
