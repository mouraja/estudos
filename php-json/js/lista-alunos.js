//<!--
/**
* Esta UDF implementa a criação de linhas em uma tabela html,
*    a partir de uma entrada de objetos JSON.
*
* @author João Augusto de Moura
* @version 1.0.0
* @argument {object} conteudo Objeto do tipo JSON, contendo
*   o retorno da consulta ao banco de dados.
* @return o valor a quantidade de linhas recebidas, 
*   se nenhuma linha recebida retorna 0.
*/
function fillJSON(conteudo) {
	//alert(conteudo);
	var tabela = head = foot = '';
	if (conteudo.length === 0) {
		return 0;
	}
	head = '<tr>';
	legendas = Object.keys(conteudo[0]);
	for (var chave in legendas) {
		head += '<th>' + legendas[chave] + '</th>';
	}
	head += '</tr>';
	for (var linha in conteudo) {
            tabela += '<tr>';
            for (var coluna in conteudo[linha]) {
                //alert(linha);
                //alert(conteudo[linha].length;
                tabela += '<td>' + conteudo[linha][coluna] + '</td>';
            }
            tabela += '</tr>';
	}
	foot += "<tr><td>Total de Alunos</td>";
        foot += "<td>" + conteudo.length + "</td></tr>";
	//	alert(tabela);
	document.getElementById("cabecalho").innerHTML = head;
	document.getElementById("tabela").innerHTML = tabela;
	document.getElementById("rodape").innerHTML = foot;
	return content.length;
}
//-->