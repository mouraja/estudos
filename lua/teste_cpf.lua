#!/usr/bin/env lua

local cpf = require "valida_cpf";

if ( arg[1] == "-h" ) then
    cpf.print_usage();
else
    if ( cpf.valida_cpf( arg[1] ) ) then
        cpf.formata( arg[1] );
    else
        print("Falha: cpf "..arg[1].." é inválido.");
    end
end
