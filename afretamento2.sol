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
        uint dataChegada;
        bool pago;
    }
    
    modifier somenteArmador() {
        require (msg.sender == nomeArmador, "operação exclusiva do Armador");
        _;
    }
    
    constructor()
        public payable;
    
    event pagamentoRealizado (uint precoFrete);
    
    Frete[] public listaFretes;
    mapping(string => Frete) public livroClientes;
    
    function registraFrete(string memory paramNomeCliente, string memory paramPortoPartida, string memory paramPortoDestino, uint paramPrecoFrete) public {
        Frete memory novoFrete = Frete(paramNomeCliente, paramPortoPartida, paramPortoDestino, paramPrecoFrete);
        
        listaFretes.push(novoFrete);
        livroClientes[paramNomeCliente] = novoFrete;
    }
    
    function saldoNoContrato () public view returns (uint) {
        return address(this).balance;
    }
    
    function chegadaPortoDestino () 
        public nomeArmador payable {
        require (dataChegada == uint now); 
        require (msg.value = precoFrete);
        pago = true;
        
        }
        emit pagamentoRealizado(msg.value);
