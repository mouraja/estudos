//<!--
var http_request = null;
function loadAjax() {
    http_request = new XMLHttpRequest();
    try {
        // Opera 8.0+, Firefox, Chrome, Safari
        http_request = new XMLHttpRequest();
    } catch (e) {
        // Internet Explorer Browsers
        try {
            http_request = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
            try {
                http_request = new ActiveXObject("Microsoft.XMLHTTP");
            } catch (e) {
                // Something went wrong
                alert("Atenção: Ajax não funciona no seu browser.");
                return false;
            }
        }
    }
    return true;
}
function listenJSON() {
    http_request.onreadystatechange = function () {
        if (http_request.readyState === 4)
        {
            fillJSON(JSON.parse(http_request.responseText));
        }
    };
}
function loadJSON(urlJSON) {
    if (loadAjax()) {
        listenJSON();
        http_request.open("GET", urlJSON, true);
        http_request.send();
    } else {
        alert("Erro: não carregado");
    }
}
//-->