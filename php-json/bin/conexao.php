<?php
public class Conexao() {
    private $servidor;
    private $banco_dados;
    private $usuario;
    private $senha;
    private $porta;
    private $socket;
    private $conn;
    private const $config = "../conf/config.ini";
    
    public function __Construct() {
        $this-conn = $this->conectar();
    }
    
    public function __Construct($servidor,$banco,$usuario,$chave,$porta=3306) {
        $this->conn = $conectar(
            $servidor,
            $porta,
            $banco_dados,
            $usuario,
            $senha);
    }
    
    private function conectar() {
        $ini = parse_ini_file($config, true)
        $this->servidor = $ini['mysql-aluno']['server'];
        $this->banco_dados = $ini['mysql-aluno']['base'];
        $this->usuario = $ini['mysql-aluno']['user'];
        $this->senha = $ini['mysql-aluno']['chave'];        
        $this->porta = $ini['mysql-aluno']['porta'];        
        $this->conn = $this->conectar_mysql();
    }
    
    private function conectar($servidor,$banco,$usuario,$chave,$porta=3306) {
        $this->servidor = $servidor;
        $this->banco_dados = $banco;
        $this->usuario = $usuario;
        $this->senha = $chave;
        $this->porta = $porta;
        $this->conn = $this->conectar_mysql();
        return $conn;
    }
    
    private function conectar_mysql() {
        $mysql = $null;
        try {
            $mysql = new mysqli($this->servidor,
                $this->usuario,
                $this->chave,
                $this->banco,
                $this->porta);
        } catch (Exception $ex) {
            die("Erro: Não foi possível fazer conexão ao " . $servidor . ". (" . 
                $conn->connect_errno . " - " . 
                $conn->connect_error . ")");
        }
        return $mysql;
    }
    
    public info() {
        $info = array();
        if ($conn != $null) {
            $info = {"Servidor"=>$this->servidor,
            "Banco de Dados"=>$this->banco_dados,
            "Usuario"=>$this->usuario,
            "Socket"=>$this->socket,
            "Informacoes"=>$conn->host_info()};
        }
        return $info;
    }
    
    public consultar($query) {
        return $conn->query($query);
    }
    
    public __destruct() {
        $conn->close();
        $conn = $null;
    }
}
?>