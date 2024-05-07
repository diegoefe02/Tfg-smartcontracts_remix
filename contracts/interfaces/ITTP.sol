// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITTP {
    struct TTP {
        string descripcion;
        string categoria;
        address reportadoPor;
        uint256 fechaReporte;
    }
    
    function agregarTTP(string memory descripcion, string memory categoria) external;
    function actualizarTTP(uint256 id, string memory descripcion, string memory categoria) external;
    function eliminarTTP(uint256 id) external;
    function obtenerTTP(uint256 id) external view returns (string memory descripcion, string memory categoria, address reportadoPor, uint256 fechaReporte);
    function obtenerTodosTTPs() external view returns (TTP[] memory);
}