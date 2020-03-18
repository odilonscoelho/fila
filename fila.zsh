#!/bin/zsh
declare -x project=/home/losao/hdbkp/projetos/shell/fila
declare -x transp=$project/transp
declare -x fornec=$project/fornec
declare -x cliente=$project/cliente
declare -x motorista=$project/motorista
declare -x veiculo=$project/veiculo
declare -x tpcm=$project/tpcm
declare -x produto=$project/produto
declare -x fila=$project/fila

#parametros globais de conf do yad
declare -x borders=45
declare -x title="FILA\ BETA"

import.programa () { . $project/programa.zsh; declare -x programa=$project/programa.zsh }
import.parametros () { . $project/parametros.zsh; declare -x parametros=$project/parametros.zsh }
import.windows () { . $project/windows.zsh; declare -x windows=$project/windows.zsh }
import.erro () { . $project/erro.zsh; declare -x erro=$project/erro.zsh }

import.programa
import.parametros
import.windows
import.erro

if [[ -z $@ ]];then	
	menu
else
	$@
fi
