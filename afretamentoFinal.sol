pragma solidity 0.5.8;

contract Afretamento {
    
    address payable armador;
    uint numeroNavio; 
    string public nomeCliente;
    uint public precoFrete; 
    uint public quantidadeContainers;
    
    
    struct Frete {
        string nomeCliente;
        uint CNPJ;
        uint quantidadeContainers;
        string portoDestino;
        string portoPartida;
        uint dataChegada;
        uint valorFreteContratado;
        bool pago;
    }
    
    modifier somenteArmador() {
        require (msg.sender == armador, "operação exclusiva do Armador");
        _;
    }
    
    constructor(uint _precoFrete, uint _quantidadeContainers) public {
        armador = msg.sender;
        precoFrete = _precoFrete;
        quantidadeContainers = _quantidadeContainers;
    } 
    
    function calculoFreteContratado(uint _quantidadeContainers) 
    public view returns (uint256 valorFreteContratado) {
    valorFreteContratado = (precoFrete*_quantidadeContainers);   
    }
    
    Frete[] public listaFretes;
    mapping(string => Frete) public livroClientes;
    
    function registraFrete(string memory paramNomeCliente, uint paramCNPJ, uint paramQuantidadeContainers, string memory paramPortoDestino, string memory paramPortoPartida, uint paramDataChegada) public payable {
        require (calculoFreteContratado(paramQuantidadeContainers)==msg.value, "Valor Incorreto");
        
        Frete memory valorFreteContratado = Frete(paramNomeCliente, paramCNPJ, paramQuantidadeContainers, paramPortoDestino, paramPortoPartida, paramDataChegada, msg.value, true);
    
        listaFretes.push(valorFreteContratado);
        livroClientes[paramNomeCliente] = valorFreteContratado;
    
    emit pagamentoRealizado (msg.value);
    
   }
    
    event pagamentoRealizado (uint valorFreteContratado);
    
    
    function saldoNoContrato () public view returns (uint) {
        return address(this).balance;
    }
    
    function chegadaPortoDestino (uint CNPJ) public somenteArmador payable {
        for (uint i=0; i<listaFretes.length; i+1) {
            if (CNPJ == listaFretes[i].CNPJ) {
                armador.transfer(listaFretes[i].valorFreteContratado);
             
             emit freteRecebido (listaFretes[i].valorFreteContratado);
                
            }
        }
        
        
    }
        event freteRecebido (uint freteRecebido);
