// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IOCBase {
    // Estructura básica de un IOC
    struct IOC {
        string detail;
        uint timestamp;
    }

    // Evento para la adición de un nuevo IOC
    event IOCAdded(string detail, uint timestamp);

    // Función interna para añadir un nuevo IOC
    function _addIOC(string memory _detail, IOC[] storage iocArray) internal {
        iocArray.push(IOC(_detail, block.timestamp));
        emit IOCAdded(_detail, block.timestamp);
    }
}
