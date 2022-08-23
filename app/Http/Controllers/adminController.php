<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
class adminController extends Controller{
    public $id_dados_inseridos;
    public $mensagem_retorno;
    public $i;
    public $listar_enquetes;
    public $listar_perguntas_enquete;
    public $atualizar_enquete;
    public $excluir_perguntas;
    public $excluir_enquete;
    public function cadastrar_enquete(Request $dados){
        $this->id_dados_inseridos = DB::table('enquete')->insertGetId(  
            ['titulo_enquete' => $dados->input('titulo_enquete'), 'data_inicial' => $dados->input('data_inicial'), 'data_final'=>$dados->input('data_final'), 'horario_inicial'=> $dados->input('horario_inicial'), 'horario_final' => $dados->input('horario_final')]
        );
        $this->i = 0;
        foreach($dados->input('campo') as $campo_texto){
            if($this->i > 0){
                DB::table('perguntas_enquete')->insert(
                    ['fk_enquete' => $this->id_dados_inseridos,'pergunta'=> $dados['campo'][$this->i]['valor'], 
                    'tipo_pergunta' => $dados['campo'][$this->i]['tipo']]
                );
            }
            $this->i++;
        }
        return "ENQUETE CADASTRADA!";
    }
    public function listar_enquetes(){
        $this->listar_enquetes = DB::table('enquete')->get();
        return json_encode($this->listar_enquetes);
    }
    public function editar_enquete($id_enquete){
        $this->listar_perguntas_enquete = DB::table('perguntas_visao')->select('pergunta','tipo_pergunta')->where('id_enquete',$id_enquete)->get();
        return json_encode($this->listar_perguntas_enquete);
    }
    public function salvar_alteracoes_enquete(Request $dados){
        $this->excluir_perguntas = DB::table('perguntas_enquete')->where('fk_enquete', '=', (int)$dados->input('fk_enquete'))->delete();
        $this->i = 0;
        DB::table('enquete')->where('id_enquete','=',(int)$dados->input('fk_enquete'))
                ->update(['titulo_enquete' => $dados->input('titulo_enquete'),'data_inicial'=>$dados->input('data_inicial'),'data_final'=>$dados->input('data_final'),'horario_inicial'=>$dados->input('horario_inicial'),'horario_final'=>$dados->input('horario_final')]);
        foreach($dados->input('campo') as $campo_texto){
            DB::table('perguntas_enquete')->insert(
                ['fk_enquete' => (int)$dados->input('fk_enquete'),'pergunta'=> $dados['campo'][$this->i]['pergunta'], 
                'tipo_pergunta' =>  $dados['campo'][$this->i]['tipo_pergunta']]
            );
            $this->i++;
        }
        return "Enquete atualizada com sucesso!";
    }
    public function excluirEnquete(Request $dados){
        if(!empty($dados)){
            $this->excluir_perguntas = DB::table('perguntas_enquete')->where('fk_enquete', '=', $dados->input('valores'))->delete();
            $this->excluir_enquete = DB::table('enquete')->where('id_enquete', '=', $dados->input('valores'))->delete();
        }
    }
}
