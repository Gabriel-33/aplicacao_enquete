<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
class adminController extends Controller{
    public $id_dados_inseridos;
    public $mensagem_retorno;
    public $i;
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
}
