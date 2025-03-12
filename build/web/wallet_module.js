const { VersionedTransaction } = solanaWeb3;

let pubKey = '';

function isBackpackInstalled() {
    return window.backpack?.solana?.isBackpack;
}

async function connect() {
    const resp = await window.backpack?.solana.connect();
    pubKey = resp.publicKey.toString();
}

function address() {
    return pubKey;
}

function disconnect() {
    window.backpack?.solana.disconnect();
}

async function sendTransaction(tx) {
    const deserializedTx = VersionedTransaction.deserialize(tx);
    const transaction = await window.backpack?.solana.signAndSendTransaction(deserializedTx);
    return transaction.signature;
}

window.walletModule = { 
    isBackpackInstalled,
    connect,
    address,
    disconnect,
    sendTransaction
};
