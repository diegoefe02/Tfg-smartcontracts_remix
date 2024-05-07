// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "./interfaces/IIndicador.sol";
import "./interfaces/ITTP.sol";
import "./interfaces/IHerramientas.sol";


contract Manager {
    address public owner;
    IIndicador public indicadorContract;
    ITTP public ttpContract;
    IHerramientas public herramientasContract;


    constructor(address _indicadorAddress, address _ttpAddress, address _herramientasAddress) {
        owner = msg.sender;
        indicadorContract = IIndicador(_indicadorAddress);
        ttpContract = ITTP(_ttpAddress);
        herramientasContract = IHerramientas(_herramientasAddress);

    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Solo el propietario puede realizar esta accion");
        _;
    }

    // Función para actualizar la dirección del contrato de Indicadores
    function setIndicadorContract(address _newAddress) public onlyOwner {
        indicadorContract = IIndicador(_newAddress);
    }

    // Función para actualizar la dirección del contrato de TTPs
    function setTTPContract(address _newAddress) public onlyOwner {
        ttpContract = ITTP(_newAddress);
    }

    // Métodos para interactuar con el contrato de Herramientas
    function setHerramientasContract(address _newAddress) public onlyOwner {
        herramientasContract = IHerramientas(_newAddress);
    }

    /////////////////////////////////////////////////////////////////////////////////////
    /////////////////////// Delegar llamadas al contrato Indicador///////////////////////
    /////////////////////////////////////////////////////////////////////////////////////


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


    /////////////////////////////////////////////////////////////////////////////////////
    ///////////////////////// Delegar llamadas al contrato TTP //////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////

    function agregarTTP(string memory descripcion, string memory categoria) public onlyOwner {
        ttpContract.agregarTTP(descripcion, categoria);
    }

    function actualizarTTP(uint256 id, string memory descripcion, string memory categoria) public onlyOwner {
        ttpContract.actualizarTTP(id, descripcion, categoria);
    }

    function eliminarTTP(uint256 id) public onlyOwner {
        ttpContract.eliminarTTP(id);
    }

    function obtenerTTP(uint256 id) public view returns (string memory descripcion, string memory categoria, address reportadoPor, uint256 fechaReporte) {
        return ttpContract.obtenerTTP(id);
    }

    /////////////////////////////////////////////////////////////////////////////////////
    //////////////////// Delegar llamadas al contrato Herramientas //////////////////////
    /////////////////////////////////////////////////////////////////////////////////////

    function agregarHerramienta(string memory nombre, string memory descripcion) public onlyOwner {
        herramientasContract.agregarHerramienta(nombre, descripcion);
    }

    function actualizarHerramienta(uint256 id, string memory nombre, string memory descripcion) public onlyOwner {
        herramientasContract.actualizarHerramienta(id, nombre, descripcion);
    }

    function eliminarHerramienta(uint256 id) public onlyOwner {
        herramientasContract.eliminarHerramienta(id);
    }

    function obtenerHerramienta(uint256 id) public view returns (string memory nombre, string memory descripcion, address reportadoPor, uint256 fechaReporte) {
        return herramientasContract.obtenerHerramienta(id);
    }
}
