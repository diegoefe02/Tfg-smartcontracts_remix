const provider = new ethers.providers.Web3Provider(window.ethereum);
let signer;
let contract;

document.getElementById('connectWallet').addEventListener('click', async () => {
    await provider.send("eth_requestAccounts", []);
    signer = provider.getSigner();
    contract = new ethers.Contract('Dirección_del_contrato_Manager', ABI_del_contrato_Manager, signer);
});

async function agregarIOC() {
    const tipo = document.getElementById('tipo').value;
    const valor = document.getElementById('valor').value;
    try {
        const transactionResponse = await contract.agregarIOC(tipo, valor);
        await transactionResponse.wait();
        console.log('IOC agregado con éxito');
    } catch (error) {
        console.error('Error al agregar IOC:', error);
    }
}
const provider = new ethers.providers.Web3Provider(window.ethereum);
let signer;
let contract;

document.getElementById('connectWallet').addEventListener('click', async () => {
    await provider.send("eth_requestAccounts", []);
    signer = provider.getSigner();
    contract = new ethers.Contract('Dirección_del_contrato_Manager', ABI_del_contrato_Manager, signer);
});

async function agregarIOC() {
    const tipo = document.getElementById('tipo').value;
    const valor = document.getElementById('valor').value;
    try {
        const transactionResponse = await contract.agregarIOC(tipo, valor);
        await transactionResponse.wait();
        console.log('IOC agregado con éxito');
    } catch (error) {
        console.error('Error al agregar IOC:', error);
    }
}
