// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./IIndicador.sol";

contract Manager {
    address public owner;
    IIndicador public indicadorContract;


    constructor(address _indicadorAddress) {
        owner = msg.sender;
        indicadorContract = IIndicador(_indicadorAddress);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Solo el propietario puede realizar esta accion");
        _;
    }

    // Función para actualizar la dirección del contrato de Indicadores
    function setIndicadorContract(address _newAddress) public onlyOwner {
        indicadorContract = IIndicador(_newAddress);
    }

    // Delegar llamadas al contrato Indicador
    function agregarIOC(string memory tipo, string memory valor) public onlyOwner {
        indicadorContract.agregarIOC(tipo, valor);
    }

    function actualizarIOC(uint256 id, string memory tipo, string memory valor) public onlyOwner {
        indicadorContract.actualizarIOC(id, tipo, valor);
    }

    function eliminarIOC(uint256 id) public onlyOwner {
        indicadorContract.eliminarIOC(id);
    }

    function obtenerIOC(uint256 id) public view returns (string memory tipo, string memory valor, address reportadoPor, uint256 fechaReporte) {
        return indicadorContract.obtenerIOC(id);
    }
    
}
