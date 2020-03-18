#!/bin/zsh

erro ()
{
	case $@ in
		argumento.invalido ) 
					yad --borders=$borders \
					--text="

							ARGUMENTO INVÁLIDO!!
							Use:
							fila
							fila cadastro transp > grid individual
							fila cadastro fornec > grid individual
							fila cadastro cliente > grid individual
							fila cadastro motorista > grid individual
							fila cadastro veiculo > grid individual
							fila cadastro produto > grid individual
							fila cadastro.pessoas > notebook transp fornec cliente motorista
							fila cadastro.veiculos > notebook veiculos e tipo de veiculos
							fila menus principal > menu principal
							fila menus cadastros > menu de cadastro diretamente


																										";;
		* ) yad --borders=$borders \
			--text="			
						$@			

										";;
	esac
}