pragma solidity 0.5.8;

contract Afretamento {
    
    string nomeArmador;
    uint numeroNavio; 
    string public nomeCliente;
    
    struct Frete {
        string nomeCliente;
        uint quantidadeContainers;
        string portoDestino;
        string portoPartida;
        uint precoFrete;
        uint DataChegada;
    }
    
    constructor()
        public payable;
    
    event pagamentoRealizado (uint valorPreco);
    
    Frete[] public listaFretes;
    mapping(string => Frete) public livroClientes;
    
    function registraFrete(string memory paramNomeCliente, string memory paramPortoPartida, string memory paramPortoDestino, uint paramPrecoFrete) public {
        Frete memory novoFrete = Frete(paramNomeCliente, paramPortoPartida, paramPortoDestino, paramPrecoFrete);
        
        listaFretes.push(novoFrete);
        livroClientes[paramNomeCliente] = novoFrete;
    }
    
    function chegadaPortoDestino () public payable nomeArmador {
        require (now <= dataChegada);
        require (msg.value == valorPreco);
        pago = true;
        emit pagamentoRealizado(msg.value);
    }
    
}
