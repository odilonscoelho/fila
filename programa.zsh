#!/bin/zsh
capture.pid ()
{
	pid=$(awk '{print $2}' <<< $(ps aux |grep "\-\-text=$text"))
}

select.codigo ()
{
	<<< ${${(s:|:)@}[1]}
}
select.nome ()
{
	<<< ${${(s:|:)@}[2]}
}
select.cpf ()
{
	<<< ${${(s:|:)@}[3]}
}
select.cnpj ()
{
	<<< ${${(s:|:)@}[3]}
}
select.ie ()
{
	<<< ${${(s:|:)@}[4]}
}
select.rg ()
{
	<<< ${${(s:|:)@}[4]}
}
select.descricao ()
{
	<<< ${${(s:|:)@}[2]}
}
select.placa ()
{
	<<< ${${(s:|:)@}[1]}
}
select.tpcm ()
{
	<<< ${${(s:|:)@}[2]}
}
select.tpcm.limite ()
{
	<<< ${${(s:|:)@}[1]}
}
select.bruto.limite ()
{
	<<< ${${(s:|:)@}[2]}
}
select.registro ()
{
	<<< ${"$(sed 's/|$//' <<< $@)"[1,8]}
}