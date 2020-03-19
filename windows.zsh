#!/bin/zsh
form ()
{
	# verifica a quantidade de campos
	[[ -z $fields ]]&& erro "Quantidade de campos 'fields'
						não declarada na origem!" && exit 0
	[[ -z geometry ]]&& geometry=500x800

	[[ -z $columns ]]&& columns=1

	# atribui o campos declarados na origem
 	for (( i = 1; i <= $fields; i++ )); do
		fds[$i]=" --field=$field[$i]:$tipo[$i] '$comando[$i]'"
	done

	base="yad \
	--no-buttons \
	--date-format=%d/%m/%Y \
	--columns=$columns \
	--borders=$borders \
	--title=$title \
	--text=$text \
	--text-align=center \
	--geometry=$geometry \
	--mouse \
	--align=center \
	--form"

	zsh -c "$base $fds" &
}

grid ()
{
	#garante que todas as variáveis necessárias estão criadas, caso não, as declara:
	# Quantidade de colunas é obrigatória , para listagem simples criar uma clase de listas.
	[[ -z $#column[@] ]] && \
		erro "Erro ao construir o grid, é necessário 
		declarar pelo menos uma coluna 'column[1]' na origem!" && exit 0

	[[ -z $file ]] && \
		erro "Erro ao construir o grid, é necessário 
			declarar '$file' se o valor de entrada for
			proviniente de uma variável, a escreva em um 
			arquivo	e declare a variável como 
			'export -x file=$(<file)'
			onde file é arquivo em que escreveu o conteudo da
			variável" && exit 0

	#se não declarada definir como 0 para não ter pesquisa em nenhuma coluna
	[[ -z $searchcolumn ]]&& searchcolumn=0
	# se uma geometria não foi declarada para grid usar essa:
	[[ -z $geometry ]]&& geometry="1000x800"
	# se~não declarado um texto a ser exibido '$text' usar esse:
	[[ -z $text ]]&& tit="GRID AVULSO"
	#de acorco com a quantidade de colunas declaradas em $columns define quantas colunas 
	#vai entrar no comando
	for (( i = 1; i <= $#column[@]; i++ )); do
		[[ -z $column[$i] ]]&& column[$i]=column[$i]
		cols+=" --column=$column[$i]" #note espaço no inicio
	done
	#Verfica se há botoes definidos
	if [[ -n $button[@] ]];then
		for (( i = 1; i <= $#button[@]; i++ )); do
			bts[$i]=" --button=$button[$i]" #note espaço no inicio
		done
		base="yad --list \
		--text-align=center \
		--borders=$borders \
		--text=$text \
		--geometry=$geometry \
		--search-column=$searchcolumn \
		--mouse \
		--grid-horizontal \
		--grid-vertical \
		--regex-search \
		--expand-column=0 \
		--selectable-labels \
		--multiple \
		--editable \
		--buttons-layout=center \
		$bts"
		#--dclick-action=$CMD #--editable \ --multiple \
	else
		base="yad --list \
		--no-buttons \
		--text-align=center \
		--borders=$borders \
		--text=$text \
		--geometry=$geometry \
		--search-column=$searchcolumn \
		--mouse \
		--grid-horizontal \
		--grid-vertical \
		--regex-search \
		--expand-column=0 \
		--selectable-labels \
		--multiple \
		--editable"	
	fi

	#Monta a linha de comando do yad e executa e executa 
	if [[ -n $tabs ]]; then #valida se é parte de um notebook
		basedados=$(grep -Ev '^$' <<< $(sed 's/|/\n/g' <<< $(<$file)))
		notebk="--tabnum=$tabn --plug=$key" #adicional para montar notebook
		zsh -c "$base $notebk $cols" <<< "$basedados" &
	else #caso seja um grid simples
		basedados=$(grep -Ev '^$' <<< $(sed 's/|/\n/g' <<< $(<$file)))
		zsh -c "$base $cols" <<< "$basedados" &
	fi
}

notebook ()
{
	#Quantidade de tabs precisa ser informada como variável declarada na origem da requisição.
	[[ -z $tabs ]]&& erro "A Quantidade de tabs 
					'tabs' deve ser declarada na origem"
	[[ -z $geometry ]]&& geometry=1000x800

	[[ -z $key ]]&& erro "Chave 'key' 
					não declarada na origem!"
	#Origem deve informar as tabs por variáveis declaradas $tab1......$tabn
	for (( i = 1; i <= $tabs; i++ )); do
		[[ -z $tab[$i] ]] && declare -x tab[$i]=tab$i
		tbs+=" --tab=$tab[$i]"
	done

	base="yad --notebook --expand \
	--mouse \
	--tab-borders=$borders \
	--active-tab=1 \
	--tab-pos=bottom \
	--geometry=$geometry \
	--key=$key"

	zsh -c "$base $tbs" &
}

input.form ()
{
	yad --mouse --borders=$borders --no-buttons --separator="" --form --field=$@:CE ''
}

input.cbe ()
{
	yad --mouse --borders=$borders --no-buttons --separator="" --form --field=$2:CBE "$1"	
}

input.ce ()
{
	yad --mouse --borders=$borders --no-buttons --separator="" --form --field=$2:CE "$1"
}