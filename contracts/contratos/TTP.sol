// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../interfaces/ITTP.sol";

contract TTP is ITTP {
    mapping(uint256 => TTP) private ttps;
    uint256 private totalTTPs = 0;

    event TTPAdded(uint256 indexed id, string descripcion, string categoria);
    event TTPUpdated(uint256 indexed id, string descripcion, string categoria);
    event TTPDeleted(uint256 indexed id);

    // Agregar un nuevo TTP
    function agregarTTP(string memory descripcion, string memory categoria) public {
        TTP memory nuevoTTP = TTP({
            descripcion: descripcion,
            categoria: categoria,
            reportadoPor: msg.sender,
            fechaReporte: block.timestamp
        });

        ttps[totalTTPs] = nuevoTTP;
        totalTTPs++;
        emit TTPAdded(totalTTPs - 1, descripcion, categoria);
    }

    // Actualizar un TTP existente
    function actualizarTTP(uint256 id, string memory descripcion, string memory categoria) public {
        require(id < totalTTPs, "TTP no existe");
        TTP storage ttp = ttps[id];
        ttp.descripcion = descripcion;
        ttp.categoria = categoria;
        emit TTPUpdated(id, descripcion, categoria);
    }

    // Eliminar un TTP
    function eliminarTTP(uint256 id) public {
        require(id < totalTTPs, "TTP no existe");
        delete ttps[id];
        emit TTPDeleted(id);
    }

    // Obtener detalles de un TTP
    function obtenerTTP(uint256 id) public view returns (string memory descripcion, string memory categoria, address reportadoPor, uint256 fechaReporte) {
        require(id < totalTTPs, "TTP no existe");
        TTP storage ttp = ttps[id];
        return (ttp.descripcion, ttp.categoria, ttp.reportadoPor, ttp.fechaReporte);
    }

    // Obtener todos los TTPs registrados
    function obtenerTodosTTPs() public view returns (TTP[] memory) {
        TTP[] memory todos = new TTP[](totalTTPs);
        for (uint256 i = 0; i < totalTTPs; i++) {
            todos[i] = ttps[i];
        }
        return todos;
    }
}
