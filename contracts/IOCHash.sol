// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IOCBase.sol";

contract IOCHash is IOCBase {
    IOC[] private hashes;

    // Función para añadir un nuevo hash de IOC
    function addHash(string memory _hash) public {
        _addIOC(_hash, hashes);
    }

    // Función para obtener un hash de IOC específico
    function getHash(uint _index) public view returns (string memory, uint) {
        require(_index < hashes.length, "Indice fuera de rango");
        IOC storage hash = hashes[_index];
        return (hash.detail, hash.timestamp);
    }
}
