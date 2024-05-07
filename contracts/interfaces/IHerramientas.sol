// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IHerramientas {
    struct Herramienta {
        string nombre;
        string descripcion;
        address reportadoPor;
        uint256 fechaReporte;
    }
    
    function agregarHerramienta(string memory nombre, string memory descripcion) external;
    function actualizarHerramienta(uint256 id, string memory nombre, string memory descripcion) external;
    function eliminarHerramienta(uint256 id) external;
    function obtenerHerramienta(uint256 id) external view returns (string memory nombre, string memory descripcion, address reportadoPor, uint256 fechaReporte);
    function obtenerTodasHerramientas() external view returns (Herramienta[] memory);
}
