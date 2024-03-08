#!/bin/bash
# --------------------------------------
# Cria uma pequena lista de tarefas
# Uso: ./todolist.sh
# Autor: @jeanrafaellourenco
# --------------------------------------

tarefas=()
tafefasFinalizadas=0
tarefasCanceladas=0

function exibirTarefas() {
	unset tarefas[0]
	for tarefa in "${!tarefas[@]}"; do
	  echo -e "\t$tarefa- ${tarefas[$tarefa]}" 
	done
}

function adicionarTarefa() {
	clear
	tarefas[0]=""
	IFS= read -r -p "Digite uma tarefa: "  novatarefa
	tarefas+=("$novatarefa")	
}

function finalizarTarefa() {
	clear
	exibirTarefas
	echo -e "\t________________________________________"
	read -r -p "Escolha a  tarefa a ser finalizada: "  tarefaFinalizar
	tarefas["$tarefaFinalizar"]="\033[09;02;10mFinalizada-${tarefas[$tarefaFinalizar]}\033[00;0m"
	let tafefasFinalizadas++
}

function cancelarTarefa() {
	clear
	exibirTarefas
	echo -e "\t________________________________________"
	read -r -p "Escolha a  tarefa a ser cancelada: "  tarefaCancelar
	tarefas["$tarefaCancelar"]="\033[09;02;31mCancelada-${tarefas[$tarefaCancelar]}\033[00;0m"
	let tarefasCanceladas++
}


function limparLista() {
	clear
	read -r -p "Tem certeza que deseja limpar a lista, s/n? "  resposta
	[ "$resposta" == "s" ] || [ "$resposta" == "S" ] && { unset tarefas[@]; tafefasFinalizadas=0; tarefasCanceladas=0; }
}

function menu {
	clear
	echo -e "\t========================================"
	echo -e "\t\tLISTA DE TAREFAS "
	echo -e "\t========================================\n"
	exibirTarefas
	echo -e "\t________________________________________"
	echo -e "\n\tTarefas concluídas:\t $tafefasFinalizadas"
	echo -e "\tTarefas canceladas:\t $tarefasCanceladas"
	echo -e "\tTotal de tarefas:\t ${#tarefas[@]}"
	echo -e "\t========================================\n"
	echo -e "\n\n"
	echo -e "\t1. Adicionar tarefa"
	echo -e "\t2. Finalizar tarefa"
	echo -e "\t3. Cancelar tarefa"
	echo -e "\t4. Limpar lista"
	echo -e "\t0. Sair\n\n"
	echo -en "\t\tEscolha uma opção: "
	read -n 1 option
}

while [ 1 ]
do
	menu
	case $option in
	0)
	break ;;
	1)
	adicionarTarefa ;;
	2)
	finalizarTarefa ;;
	3)
	cancelarTarefa ;;
	4)
	limparLista ;;
	*)
	clear
	echo "Desculpe, opção inválida";;
	esac
done
clear
