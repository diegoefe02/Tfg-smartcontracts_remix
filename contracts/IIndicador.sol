// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Interfaz para el contrato Indicador
interface IIndicador {
    struct IOC {
        string tipo;
        string valor;
        address reportadoPor;
        uint256 fechaReporte;
    }
    
    function agregarIOC(string memory tipo, string memory valor) external;
    function actualizarIOC(uint256 id, string memory tipo, string memory valor) external;
    function eliminarIOC(uint256 id) external;
    function obtenerIOC(uint256 id) external view returns (string memory tipo, string memory valor, address reportadoPor, uint256 fechaReporte);
    function obtenerTodosIOCs() external view returns (IOC[] memory);

}
