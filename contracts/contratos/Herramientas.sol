// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../interfaces/IHerramientas.sol";

contract Herramientas is IHerramientas {
    mapping(uint256 => Herramienta) private herramientas;
    uint256 private totalHerramientas = 0;

    event HerramientaAdded(uint256 indexed id, string nombre, string descripcion);
    event HerramientaUpdated(uint256 indexed id, string nombre, string descripcion);
    event HerramientaDeleted(uint256 indexed id);

    function agregarHerramienta(string memory nombre, string memory descripcion) public {
        Herramienta memory nuevaHerramienta = Herramienta({
            nombre: nombre,
            descripcion: descripcion,
            reportadoPor: msg.sender,
            fechaReporte: block.timestamp
        });

        herramientas[totalHerramientas] = nuevaHerramienta;
        totalHerramientas++;
        emit HerramientaAdded(totalHerramientas - 1, nombre, descripcion);
    }

    function actualizarHerramienta(uint256 id, string memory nombre, string memory descripcion) public {
        require(id < totalHerramientas, "Herramienta no existe");
        Herramienta storage herramienta = herramientas[id];
        herramienta.nombre = nombre;
        herramienta.descripcion = descripcion;
        emit HerramientaUpdated(id, nombre, descripcion);
    }

    function eliminarHerramienta(uint256 id) public {
        require(id < totalHerramientas, "Herramienta no existe");
        delete herramientas[id];
        emit HerramientaDeleted(id);
    }

    function obtenerHerramienta(uint256 id) public view returns (string memory nombre, string memory descripcion, address reportadoPor, uint256 fechaReporte) {
        require(id < totalHerramientas, "Herramienta no existe");
        Herramienta storage herramienta = herramientas[id];
        return (herramienta.nombre, herramienta.descripcion, herramienta.reportadoPor, herramienta.fechaReporte);
    }

    function obtenerTodasHerramientas() public view returns (Herramienta[] memory) {
        Herramienta[] memory todas = new Herramienta[](totalHerramientas);
        for (uint256 i = 0; i < totalHerramientas; i++) {
            todas[i] = herramientas[i];
        }
        return todas;
    }
}
