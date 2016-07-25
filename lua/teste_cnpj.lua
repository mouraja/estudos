#!/usr/bin/env lua

local cnpj = require "valida_cnpj";

if (arg[1] == "-d") then
    cnpj.print_usage();
else
    if ( cnpj.valida_cnpj( arg[1] ) ) then
        cnpj.formata( arg[1] );
    else
        print("Falha: cnpj "..arg[1].." é inválido.");
    end
end
