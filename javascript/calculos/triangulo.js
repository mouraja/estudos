
function Triangulo(a, b, c) {
    this.lados = {'a':a,'b':b,'c':c};
    this.base = 'c';
    this.TRIANGULO_RETANGULO = false;
    this.TRIANGULO_EQUILATERO = 3;
    this.TRIANGULO_ISOSCELES = 2;
    this.TRIANGULO_ESCALENO = 1;
    this.descricoes = ['Não é um triângulo', 'Triângulo Escaleno', 'Triângulo Isosceles', 'Triângulo Eqüilatero'];
    this.tipo = this.searchTipo();
    this.descricao = this.descricoes[this.tipo];
    this.area = this.calcArea();
    this.perimetro = this.calcPerimetro();
}

Triangulo.prototype.getArea = function() {
	return this.area;
}

Triangulo.prototype.getPerimetro = function() {
	return this.perimetro;
}

Triangulo.prototype.getDescricao = function() {
	return this.descricao;
}

Triangulo.prototype.getLados = function() {
	return this.lados;
}

Triangulo.prototype.getLado = function(lado) {
	return this.lados[lado];
}

Triangulo.prototype.getBase = function() {
	return this.base;
}

Triangulo.prototype.setBase = function(base) {
	this.base = base;
}

Triangulo.prototype.isTriangulo = function() {
	var teste = true;
	for (var i in this.lados) {
		if (this.lados[i] <= 0) {
			teste = false;
			break;
		}
	}
	var p = this.calcPerimetro();
	for (var i in this.lados) {
		if ((p - this.lados[i]) <= this.lados[i]) {
			teste = false;
			break;
		}
	}
	return teste;
}

Triangulo.prototype.searchTipo = function() {
	var lado = this.lados['a'];
	var tipo = 0;
	if (this.isTriangulo()) {
	    for (var i in this.lados) {
		    if (lado == this.lados[i]) {
			    tipo++;
		    }
	    }
    }
    return tipo;
}

Triangulo.prototype.searchRetangulo = function() {
	return this.TRIANGULO_RETANGULO;
}

Triangulo.prototype.calcAltura = function() {
	var altura = this.calcArea() * 2 / this.lados[this.base];
    return altura;
}

Triangulo.prototype.calcArea = function() {
    var S = this.calcSemiPerimetro();
    var valor = S;
    var area = 0;
    for (var i in this.lados) {
        valor *= (S - this.lados[i]);
    }
    area = Math.sqrt(valor);
    return area;
}

Triangulo.prototype.calcPerimetro = function() {
    var p = 0;
    for (var i in this.lados) {
        p += this.lados[i];
    }
    return p;
}

Triangulo.prototype.calcSemiPerimetro = function() {
    var S = 0;
    S = (this.calcPerimetro() / 2);
    return S;
}
/*
Triangulo.prototype.pitagoras = function(hipotenusa, catetoOposto, catetoAdjacente) {
	var valor = 0;
	if (hipotenusa == null) {
		valor = Math.sqrt(Math.pow(catetoOposto, 2) + Math.pow(catetoAdjacente, 2));
	}
	if (catetoOposto == null) {
		valor = Math.sqrt(Math.pow(hipotenusa, 2) - Math.pow(catetoAdjacente, 2));
	}
	if (catetoAdjacente == null) {
		valor = Math.sqrt(Math.pow(hipotenusa, 2) - Math.pow(catetoOposto, 2));
	}
	return valor;
}
*/
Triangulo.prototype.calcCoordenadas = function(boxLargura, boxAltura) {
	var trigonometria = new Trigonometria();
	var coordenadas = [];
	var x = [];
	var y = [];
	var padding = 20;
	var base = this.lados[this.base];
	var altura = this.calcAltura();
	var esquerda = (boxLargura - base) / 2;
	var inferior = ((boxAltura - altura) / 2) + altura; 
    x['A'] = esquerda + base - trigonometria.calcPitagoras(this.lados['b'], altura, null);
    y['A'] = inferior - altura;
    x['B'] = esquerda + base;
    y['B'] = inferior;
    x['C'] = esquerda;
    y['C'] = inferior;
    coordenadas['x'] = x;
    coordenadas['y'] = y;
    return coordenadas;
}
