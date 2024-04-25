// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ThreatIntelligence {
    struct IOC {
        string tipo;
        string valor;
        address reportadoPor;
        uint256 fechaReporte;
    }

    mapping(uint256 => IOC) private iocs;
    uint256 private totalIOCs = 0;

    // Una lista de tipos de IOC permitidos
    string[] private tiposPermitidos;

    constructor() {
        // Inicializar la lista con algunos tipos comunes
        tiposPermitidos.push("IP");
        tiposPermitidos.push("URL");
        tiposPermitidos.push("Hash");
        tiposPermitidos.push("Email");
        // Puedes añadir más tipos aquí
    }

    function agregarTipoPermitido(string memory _nuevoTipo) public {
        // Aquí puedes agregar controles de acceso si es necesario
        tiposPermitidos.push(_nuevoTipo);
    }

    function esTipoPermitido(string memory _tipo) private view returns (bool) {
        for (uint i = 0; i < tiposPermitidos.length; i++) {
            if (keccak256(abi.encodePacked(_tipo)) == keccak256(abi.encodePacked(tiposPermitidos[i]))) {
                return true;
            }
        }
        return false;
    }

    function validarFormato(string memory _tipo, string memory _valor) private pure returns (bool) {
        bytes memory valor = bytes(_valor);

        if (keccak256(abi.encodePacked(_tipo)) == keccak256(abi.encodePacked("IP"))) {
            // Validación básica de IP: verificar la presencia de puntos como un ejemplo simple
            return contarCaracteres(valor, '.') == 3;
        } else if (keccak256(abi.encodePacked(_tipo)) == keccak256(abi.encodePacked("URL"))) {
            // Validación básica de URL: verificar la presencia de "http://" o "https://"
            return contieneSubcadena(_valor, "http://") || contieneSubcadena(_valor, "https://");
        } else if (keccak256(abi.encodePacked(_tipo)) == keccak256(abi.encodePacked("Hash"))) {
            // Validación básica de Hash: longitud fija, por ejemplo, para un hash SHA-256
            return valor.length == 64;
        } else if (keccak256(abi.encodePacked(_tipo)) == keccak256(abi.encodePacked("Email"))) {
            // Validación básica de Email: verificar la presencia de '@'
            return contarCaracteres(valor, '@') == 1;
        }

        return false;
    }

    function contarCaracteres(bytes memory fuente, bytes1 caracter) private pure returns (uint256) {
        uint256 contador = 0;
        for (uint256 i = 0; i < fuente.length; i++) {
            if (fuente[i] == caracter) {
                contador++;
            }
        }
        return contador;
    }

    function contieneSubcadena(string memory cadena, string memory subcadena) private pure returns (bool) {
        bytes memory cadenaBytes = bytes(cadena);
        bytes memory subcadenaBytes = bytes(subcadena);

        if (cadenaBytes.length < subcadenaBytes.length) {
            return false;
        }

        for (uint256 i = 0; i <= cadenaBytes.length - subcadenaBytes.length; i++) {
            bool subcadenaEncontrada = true;
            for (uint256 j = 0; j < subcadenaBytes.length; j++) {
                if (cadenaBytes[i + j] != subcadenaBytes[j]) {
                    subcadenaEncontrada = false;
                    break;
                }
            }
            if (subcadenaEncontrada) {
                return true;
            }
        }

        return false;
    }


    // Eventos para registrar acciones
    event IOCAdded(uint256 indexed id, string tipo, string valor);
    event IOCUpdated(uint256 indexed id, string tipo, string valor);
    event IOCDeleted(uint256 indexed id);

    // Agregar un nuevo IOC
    function agregarIOC(string memory _tipo, string memory _valor) public {
        require(esTipoPermitido(_tipo), "Tipo de IOC no permitido");
        require(validarFormato(_tipo, _valor), "Formato de IOC invalido");
        require(!esIOCReportado(_valor), "IOC ya reportado");
        IOC memory nuevoIOC = IOC({
            tipo: _tipo,
            valor: _valor,
            reportadoPor: msg.sender,
            fechaReporte: block.timestamp
        });

        iocs[totalIOCs] = nuevoIOC;
        totalIOCs++;
    }

    // Actualizar un IOC existente
    function actualizarIOC(uint256 _id, string memory _tipo, string memory _valor) public {
        require(_id < totalIOCs, "IOC no existe");
        require(esTipoPermitido(_tipo), "Tipo de IOC no permitido");
        require(validarFormato(_tipo, _valor), "Formato de IOC invalido");
        require(!esIOCReportado(_valor), "IOC ya reportado");
        IOC storage ioc = iocs[_id];
        ioc.tipo = _tipo;
        ioc.valor = _valor;
        emit IOCUpdated(_id, _tipo, _valor);
    }

    // Eliminar un IOC
    function eliminarIOC(uint256 _id) public {
        require(_id < totalIOCs, "IOC no existe");
        delete iocs[_id];
        emit IOCDeleted(_id);
    }

    // Obtener un IOC por su ID
    function obtenerIOC(uint256 _id) public view returns (IOC memory) {
        require(_id < totalIOCs, "IOC no existe");
        return iocs[_id];
    }

    function obtenerTodosIOCs() public view returns (IOC[] memory) {
    IOC[] memory todos = new IOC[](totalIOCs);
    for (uint256 i = 0; i < totalIOCs; i++) {
        IOC storage ioc = iocs[i];
        if (ioc.reportadoPor != address(0)) { // Verificar si el IOC existe
            todos[i] = ioc;
        }
    }
        return todos;
    }

    // Función para verificar si un IOC ha sido reportado anteriormente
    function esIOCReportado(string memory _valor) public view returns (bool) {
        for (uint256 i = 0; i < totalIOCs; i++) {
            if (keccak256(abi.encodePacked(iocs[i].valor)) == keccak256(abi.encodePacked(_valor))) {
                return true;
            }
        }
        return false;
    }
}
