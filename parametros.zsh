#!/bin/zsh
menu ()
{
	declare -x columns=1
	declare -x fields=10

	declare -x field[1]="FILA"
	declare -x field[2]="CLIENTES"
	declare -x field[3]="FORNECEDORES"
	declare -x field[4]="TRANSPORTADORES"
	declare -x field[5]="MOTORISTAS"
	declare -x field[6]="PRODUTOS"
	declare -x field[7]="VEICULOS"
	declare -x field[8]="LIMITEBRUTO"
	declare -x field[9]="CONSULTA\ PESSOAS\ E\ ORGANIZACOES"
	declare -x field[10]="CONSULTA\ EQUIPAMENTOS\ E\ LIMITE-BRUTO"

	declare -x tipo[1]=FBTN
	declare -x tipo[2]=FBTN
	declare -x tipo[3]=FBTN
	declare -x tipo[4]=FBTN
	declare -x tipo[5]=FBTN
	declare -x tipo[6]=FBTN
	declare -x tipo[7]=FBTN
	declare -x tipo[8]=FBTN
	declare -x tipo[9]=FBTN
	declare -x tipo[10]=FBTN

	declare -x comando[1]='@zsh -c "nohup fila consulta fila &>/dev/null &"'
	declare -x comando[2]='@zsh -c "nohup fila consulta cliente &>/dev/null &"'
	declare -x comando[3]='@zsh -c "nohup fila consulta fornec &>/dev/null &"'
	declare -x comando[4]='@zsh -c "nohup fila consulta transp &>/dev/null &"'
	declare -x comando[5]='@zsh -c "nohup fila consulta motorista &>/dev/null &"'
	declare -x comando[6]='@zsh -c "nohup fila consulta produto &>/dev/null &"'
	declare -x comando[7]='@zsh -c "nohup fila consulta veiculo &>/dev/null &"'
	declare -x comando[8]='@zsh -c "nohup fila consulta tpcm &>/dev/null &"'
	declare -x comando[9]='@zsh -c "nohup fila consulta.cftm &>/dev/null &"'
	declare -x comando[10]='@zsh -c "nohup fila consulta.veiculos &>/dev/null &"'

	declare -x text="INICIO"
	declare -x geometry=500x600

	form &
}

consulta.cftm ()
{	
	# variáveis obrigatórias em notebook
	declare -x key=$RANDOM
	declare -x plug=$key
	declare -x tabs=4

	declare -x geometry=1200x800
	# NOME DA TAB | NUMERO DA TAB | ENTRADA DADOS
	declare -x tab[1]=CLIENTES
	declare -x tabn=1
	consulta cliente &
	declare -x tab[2]=FORNECEDORES
	declare -x tabn=2
	consulta fornec &
	declare -x tab[3]=TRANSPORTADORES
	declare -x tabn=3
	consulta transp &
	declare -x tab[4]=MOTORISTAS
	declare -x tabn=4
	consulta motorista &
	notebook &
}

consulta.veiculos ()
{
	declare -x key=$RANDOM
	declare -x plug=$key
	declare -x tabs=2

	# Como há geometrias diferentes dos grid individualmente, essa sobscreve a do grid
	declare -x geometry=500x800

	# NOME DA TAB | NUMERO DA TAB | ENTRADA DADOS
	declare -x tab[1]=VEICULOS
	declare -x tabn=1
	consulta veiculo &
	declare -x tab[2]=TPCM
	declare -x tabn=2
	consulta tpcm &
	notebook &
}

consulta ()
{	
	case $1 in
		cliente ) declare -x tipo=CFTM
			declare -x text=CLIENTES;;
		fornec ) declare -x tipo=CFTM
			declare -x text=FORNECEDORES;;
		transp ) declare -x tipo=CFTM
			declare -x text=TRANSPORTADORES;;
		motorista ) declare -x tipo=CFTM
			declare -x text=MOTORISTAS;;
		tpcm ) tipo=TPCM
			declare -x text=TPCM;;
		veiculo ) tipo=VEICU
			declare -x text=VEICULOS;;
		produto ) tipo=PRODUTOS
			declare -x text=PRODUTOS;;
		fila ) tipo=FILA
			declare -x text=FILA;;
	esac
	#Particularidades de cada requisição específica
	#de acordo com o cabeçalho
	case $tipo in
		CFTM )  eval file='$'"$@"
				declare -x file
				declare -x column[1]="COD"
				declare -x column[2]="NOME"
				declare -x column[3]="CNPJ/CPF"
				declare -x column[4]="IE/RG"
				declare -x geometry=800x800
				declare -x searchcolumn=2
				declare -x button[1]="Incluir:fila\ inclusao\ FILA"
				declare -x button[2]="Excluir:fila\ exclusao\ FILA"
				declare -x button[3]="Sair:0";;
		VEICU ) eval file='$'"$@"
				declare -x file
				declare -x column[1]="PLACA"
				declare -x column[2]="TPCM"
				declare -x geometry=300x800
				declare -x searchcolumn=1
				declare -x button[1]="Incluir:fila\ inclusao\ VEICU"
				declare -x button[2]="Excluir:fila\ exclusao\ VEICU"
				declare -x button[3]="Sair:0";;
		TPCM )  eval file='$'"$@"
				declare -x file
				declare -x column[1]="TP_CM"
				declare -x column[2]="BRUTO"
				declare -x column[3]="TARA"
				declare -x column[4]="LIQUIDO"
				declare -x geometry=500x800
				declare -x searchcolumn=1
				declare -x button[1]="Incluir:fila\ inclusao\ TPCM"
				declare -x button[2]="Excluir:fila\ exclusao\ TPCM"
				declare -x button[3]="Sair:0";;
		PRODUTOS ) eval file='$'"$@" 
				declare -x file
				declare -x geometry=400x600
				declare -x searchcolumn=2
				declare -x column[1]=COD
				declare -x column[2]=DESCRICAO
				declare -x button[1]="Incluir:fila\ inclusao\ PRODUTOS"
				declare -x button[2]="Excluir:fila\ exclusao\ PRODUTOS"
				declare -x button[3]="Sair:0";;
		FILA )  eval file='$'"$@"
				declare -x file
				declare -x column[1]="REC/EXP"
				declare -x column[2]="POSICAO"
				declare -x column[3]="DATA"
				declare -x column[4]="HORA"
				declare -x column[5]="PLACA"
				declare -x column[6]="MOTORISTA"
				declare -x column[7]="TP_CM"
				declare -x column[8]="TRANSP"
				declare -x column[9]="FORNEC/CLIENTE"
				declare -x column[10]="PRODUTO"
				declare -x column[11]="BRUTO"
				declare -x column[12]="TARA"
				declare -x column[13]="LIQUIDO"				
				declare -x geometry=1650x300
				declare -x button[1]="Incluir:fila\ inclusao\ FILA"
				declare -x button[2]="Excluir:fila\ exclusao\ FILA"
				declare -x button[3]="Sair:0";;
	esac

	grid &
} 

busca ()
{	
	case $1 in
		cliente ) declare -x tipo=CFTM
			declare -x text="SELECIONE\ O\ CLIENTE";;
		fornec ) declare -x tipo=CFTM
			declare -x text="SELECIONE\ O\ FORNECEDOR";;
		transp ) declare -x tipo=CFTM
			declare -x text="SELECIONE\ O\ TRANSPORTADOR";;
		motorista ) declare -x tipo=CFTM
			declare -x text="SELECIONE\ O\ MOTORISTA";;
		tpcm ) tipo=TPCM
			declare -x text="SELECIONE\ O\ TPCM";;
		veiculo ) tipo=VEICU
			declare -x text="SELECIONE\ O\ VEICULO";;
		produto ) tipo=PRODUTOS
			declare -x text="SELECIONE\ O\ PRODUTO";;
		fila ) tipo=FILA
			declare -x text="REGISTROS";;
	esac
	#Particularidades de cada requisição específica
	#de acordo com o cabeçalho
	case $tipo in
		CFTM )  eval file='$'"$@"
				declare -x file
				declare -x column[1]="COD"
				declare -x column[2]="NOME"
				declare -x column[3]="CNPJ/CPF"
				declare -x column[4]="IE/RG"
				declare -x geometry=800x800
				declare -x searchcolumn=2;;
		VEICU ) eval file='$'"$@"
				declare -x file
				declare -x column[1]="PLACA"
				declare -x column[2]="TPCM"
				declare -x geometry=300x800
				declare -x searchcolumn=1;;
		TPCM )  eval file='$'"$@"
				declare -x file
				declare -x column[1]="TP_CM"
				declare -x column[2]="BRUTO"
				declare -x column[3]="TARA"
				declare -x column[4]="LIQUIDO"
				declare -x geometry=500x800
				declare -x searchcolumn=1;;
		PRODUTOS ) eval file='$'"$@" 
				declare -x file
				declare -x geometry=400x600
				declare -x searchcolumn=2
				declare -x column[1]=COD
				declare -x column[2]=DESCRICAO;;
		FILA)  eval file='$'"$@"
				declare -x file
				declare -x column[1]="REC/EXP"
				declare -x column[2]="POSICAO"
				declare -x column[3]="DATA"
				declare -x column[4]="HORA"
				declare -x column[5]="PLACA"
				declare -x column[6]="MOTORISTA"
				declare -x column[7]="TP_CM"
				declare -x column[8]="TRANSP"
				declare -x column[9]="FORNEC/CLIENTE"
				declare -x column[10]="PRODUTO"
				declare -x column[11]="BRUTO"
				declare -x column[12]="TARA"
				declare -x column[13]="LIQUIDO"				
				declare -x geometry=1650x300;;
	esac

	grid &
} 

inclusao ()
{
	capture.pid

	case $1 in
		FILA)  RECEXP=$(fila input.ce "!EXPED!RECEB" "EXPED/RECEB")
				POSICAO=$(( $(tail -1 <<< $(cut -d"|" -f"2" < $file)) + 1 ))
				DATA=$(fila input.ce "$(date +%d/%m/%Y)" "DATA")
				HORA=$(fila input.ce "$(date +%H:%M:%S)" "HORA")
				PLACA=$(fila select.placa $(fila busca veiculo))
				MOTORISTA=$(fila select.nome $(fila busca motorista))
				TP_CM=$(grep $PLACA $veiculo|cut -d"|" -f2)
				TRANSP=$(fila select.nome $(fila consulta transp))
				FORNECCLIENTE=$([[ "$RECEXP" == "EXPED" ]]&& fila select.nome $(fila consulta cliente) || fila select.nome $(fila consulta fornec))
				PRODUTO=$(fila select.nome $(fila consulta produto))
				BRUTO=$(fila input.form "BRUTO\ EM\ TON\ EX:\ 51.200")
				TARA=$(fila input.form "TARA\ EM\ TON\ EX:\ 19.200")
				LIQUIDO=$(bc <<< "scale=3;$BRUTO-$TARA")
				echo "\n$RECEXP|$POSICAO|$DATA|$HORA|$PLACA|$MOTORISTA|$TP_CM|$TRANSP|$FORNECCLIENTE|$PRODUTO|$BRUTO|$TARA|$LIQUIDO" >> $file ;;
		CFTM)  COD=$(( $(tail -1 <<< $(cut -d"|" -f"1" < $file)) + 1 ))
				NOME=$(fila input.form NOME)
				CNPJ=$(fila input.form CNPJ)
				IE=$(fila input.form IE)
				echo "\n$COD|$NOME|$CNPJ|$IE" >> $file ;;
		VEICU) PLACA=$(fila input.form PLACA)
				TPCM=$(fila input.form TPCM)
				echo "\n$PLACA|$TPCM" >> $file ;;
		TPCM) 	TP_CM=$(fila input.form TPCM)
				BRUTO=$(fila input.form BRUTO)
				TARA=$(fila input.form TARA)
				LIQUIDO=$(fila input.form LIQUIDO)
				echo "\n$TPCM|$BRUTO|$TARA|$LIQUIDO" >> $file ;;
		PRODUTOS) COD=$(fila input.form COD)
				DESCRICAO=$(fila input.form DESCRICAO)
				echo "\n$COD|$DESCRICAO" >> $file ;;
	esac

	kill $pid & 
	
	case $text in
		CLIENTES ) fila consulta cliente;;
		FORNECEDORES ) fila consulta fornec;;
		TRANSPORTADORES ) fila consulta transp;;
		MOTORISTAS ) fila consulta motorista;;
		PRODUTOS ) fila consulta produto;;
		VEICULOS ) fila consulta veiculo;;
		TPCM ) fila consulta tpcm;;
		FILA ) fila consulta fila;;
	esac
}

exclusao ()
{
	capture.pid
	case $1 in
		CFTM )  COD=$(fila input.form COD)
				NOME=$(fila input.form NOME)
				sed -i '/'$COD'/d' $file || sed -i '/'$NOME'/d' $file ;;
		VEICU ) PLACA=$(fila input.form PLACA) 
				sed -i '/'$PLACA'/d' $file ;;
		TPCM ) TPCM=$(fila input.form TPCM) 
				sed -i '/'$TPCM'/d' $file ;;
		PRODUTOS ) COD=$(fila input.form COD) 
				sed -i '/'$COD'/d' $file ;;
		FILA ) REGISTRO=$(fila select.registro $(fila busca fila)) 
				sed -i '/'$REGISTRO'/d' $file ;;
	esac

	kill $pid &

	case $text in
		CLIENTES ) fila consulta cliente;;
		FORNECEDORES ) fila consulta fornec;;
		TRANSPORTADORES ) fila consulta transp;;
		MOTORISTAS ) fila consulta motorista;;
		PRODUTOS ) fila consulta produto;;
		VEICULOS ) fila consulta veiculo;;
		TPCM ) fila consulta tpcm;;
		FILA ) fila consulta fila;;
	esac
}