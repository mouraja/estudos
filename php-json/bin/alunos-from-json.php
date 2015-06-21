<?php
header("content", "text/plain");
require_once 'conexao.php';
$mysql = new Conexao();
$resultado = $mysql->query("select * from estudo.aluno");
$registros = array();
while ($registro = $resultado->fetch_assoc()) {
    $registros[] = $registro;
}
$mysql = $null;
echo json_encode($registros, JSON_PRETTY_PRINT);
?>