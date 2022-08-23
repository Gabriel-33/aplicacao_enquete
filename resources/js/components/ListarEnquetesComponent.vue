<template>
    <vue-bootstrap4-table :rows="dados" :columns="columns" :config="config":actions="actions" @on-exluirEnquete="exluir_enquete" class="table table-bordered">
            <template slot="pagination-info" slot-scope="props">
                Total de enquetes: {{props.currentPageRowsLength}}
            </template>
            <template slot="empty-results">
                Nenhuma enquete encontrada
            </template>
            <template slot="paginataion-previous-button">
                Anterior
            </template>
            <template slot="paginataion-next-button">
                Próximo
            </template>
            <template slot="editar" slot-scope="dados">
                <i>
                    <notifications group="foo" position="top center" width="400" style="margin-top:15px"/>
                    <b-modal v-bind:id="String(dados.row.id_enquete)" hide-footer>
                        <form v-on:submit="salvar_edicao(dados)">
                            <div class="form-group">
                                <input type="hidden" class="form-control" v-bind:value="dados.row.id_enquete">
                            </div>
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <center><h5>ATUALIZAR ENQUETE</h5></center>
                                        <div class="mb-3">
                                          <label for="formGroupExampleInput" class="form-label">Titulo enquete:</label>
                                          <input type="text" v-model:value="$v.dados.$each[indice_pergunta].titulo_enquete.$model" class="form-control" id="formGroupExampleInput" placeholder="Titulo da enquete">
                                            <div class="text-danger mb-1" v-if="!$v.dados.$each[indice_pergunta].titulo_enquete.required" style="margin-top:10px"><strong>*Campo obrigatório</strong></div>
                                        </div>
                                        <div class="col-6 mb-3">
                                          <label for="formGroupExampleInput2" class="form-label">Data inicial:</label>
                                          <input type="date" v-model:value="$v.dados.$each[indice_pergunta].data_inicial.$model" class="form-control" id="formGroupExampleInput2" placeholder="Another input placeholder">
                                          <div class="text-danger mb-1" v-if="!$v.dados.$each[indice_pergunta].data_inicial.required" style="margin-top:10px"><strong>*Campo obrigatório</strong></div>
                                        </div>
                                        <div class="col-6 mb-3">
                                          <label for="formGroupExampleInput2" class="form-label">Data Final:</label>
                                          <input type="date" v-model:value="$v.dados.$each[indice_pergunta].data_final.$model" class="form-control" id="formGroupExampleInput2" placeholder="Another input placeholder">
                                          <div class="text-danger mb-1" v-if="!$v.dados.$each[indice_pergunta].data_final.required" style="margin-top:10px"><strong>*Campo obrigatório</strong></div>
                                        </div>
                                        <div class="col-6 mb-3">
                                          <label for="formGroupExampleInput2" class="form-label">Horário inicial:</label>
                                          <input type="time" v-model:value="$v.dados.$each[indice_pergunta].horario_inicial.$model" class="form-control" id="formGroupExampleInput2" placeholder="Another input placeholder">
                                          <div class="text-danger mb-1" v-if="!$v.dados.$each[indice_pergunta].horario_inicial.required" style="margin-top:10px"><strong>*Campo obrigatório</strong></div>
                                        </div>
                                        <div class="col-6 mb-3">
                                          <label for="formGroupExampleInput2" class="form-label">Horário final:</label>
                                          <input type="time" v-model:value="$v.dados.$each[indice_pergunta].horario_final.$model" class="form-control" id="formGroupExampleInput2" placeholder="Another input placeholder">
                                          <div class="text-danger mb-1" v-if="!$v.dados.$each[indice_pergunta].horario_final.required" style="margin-top:10px"><strong>*Campo obrigatório</strong></div>
                                        </div>
                                        <div v-for="(campo, index) in campo" :key="index">
                                            <div class="row mb-4" v-if="campo.tipo_pergunta == 1">
                                                <div class="col-9">
                                                  <input v-model:value="campo.pergunta" type="text" placeholder="Insira a pergunta" class="form-control">
                                                </div>
                                                <div class="col-2">
                                                  <button type="button" class="btn btn-danger" @click="remover_campo(index)">
                                                    Remover
                                                  </button>
                                                </div>
                                                <div class="col-12 md-3 mt-3">
                                                    <label>Resposta:</label>
                                                    <hr></hr>
                                                </div>
                                            </div>
                                            <div class="row mb-4" v-if="campo.tipo_pergunta == 2">
                                                <div class="col-9">
                                                  <input v-model:value="campo.pergunta" type="text" placeholder="Insira a pergunta" class="form-control">
                                                </div>
                                                <div class="col-2">
                                                  <button type="button" class="btn btn-danger" @click="remover_campo(index)">
                                                    Remover
                                                  </button>
                                                </div>
                                                <div class="col-9 col-sm-6">
                                                  <div class="form-check">
                                                    <input v-model="campo.pergunta" class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1" disabled>
                                                    <label class="form-check-label" for="flexRadioDefault1">
                                                    Sim
                                                    </label>
                                                    </div>
                                                    <div class="form-check">
                                                    <input v-model="campo.valor" class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" checked disabled>
                                                    <label class="form-check-label" for="flexRadioDefault2">
                                                        Não
                                                    </label>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mb-4" v-if="campo.tipo_pergunta == 3">
                                                <div class="col-9">
                                                  <input v-model="campo.pergunta" type="text" placeholder="Insira a pergunta" class="form-control">
                                                </div>
                                                <div class="col-2">
                                                  <button type="button" class="btn btn-danger" @click="remover_campo(index)">
                                                    Remover
                                                  </button>
                                                </div>
                                                <div class="col-12 md-3 mt-3">
                                                    <input type="number" placeholder="Resposta em valor númerico" class="form-control" disabled>
                                                </div>
                                            </div>
                                        </div>
                                        </div>
                                        <div class="row mx-auto">
                                            <div class="col mb-3">
                                              <button class="btn btn-primary" type="button" v-on:click="adicionar_campo(1)" title="resposta sim/não">Novo campo de texto</button>
                                            </div>
                                            <div class="col mb-3">
                                              <button class="btn btn-warning" type="button" v-on:click="adicionar_campo(2)" title="Resposta texto">Novo campo rádio</button>
                                            </div>
                                            <div class="col mb-3">
                                              <button class="btn btn-danger" type="button" v-on:click="adicionar_campo(3)" title="Resposta checkbox">Novo campo númerico</button>
                                            </div>
                                        </div>
                                        <div class="d-grid gap-2">
                                          <b-button type="submit" class="btn btn-success mt-3" block>Salvar alterações</b-button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </b-modal>
                </i>
               <button class="btn btn-primary" v-on:click="editar_enquete(dados)">
                    <i class="fas fa-edit"></i>
                </button>
            </template>
            <template slot="excluir" slot-scope="dados">
                <i>
                    <input type="checkbox" v-bind:value="dados.row.id_enquete" v-model="selecao" :v-bind-key="dados.row.id_enquete">
                </i>
            </template>
    </vue-bootstrap4-table>
</template>
<script>
import VueBootstrap4Table from 'vue-bootstrap4-table'
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
Vue.use(BootstrapVue)
import Vuelidate from 'vuelidate'
Vue.use(Vuelidate)
import { required, minLength, maxLength} from 'vuelidate/lib/validators'
import io from "socket.io-client"
export default {
    name: 'ListarEnquetes',
    components: {
        VueBootstrap4Table
    },
    data: function() {
        return {
            socket:io("localhost:5000",{
              withCredentials: false,
              transportOptions: {
                polling: {
                  extraHeaders: {
                    "my-custom-header": "abcd"
                  }
                }
              }
            }),
            dados:[],
            perguntas:[],
            selecao:[],
            quantidade_questoes:0, 
            resposta:'',
            titulo_enquete:'',
            data_inicial:'',
            data_final:'',
            horario_inicial:'',
            horario_final:'',
            enviado:false,
            indice_pergunta:0,             
            campo: [
                {
                  pergunta: "",
                  tipo_pergunta:1,
                },
            ],
            columns: [
                {
                filter: {
                    type: "select",
                    mode: "single",
                    closeDropdownOnSelection: true,
                    placeholder: "Select options",
                    options: [{
                            "name": "option one",
                            "value": "option one"
                        },
                        {
                            "name": "option two",
                            "value": "option two"
                        },
                        {
                            "name": "option three",
                            "value": "option three"
                        }
                    ],
                    init: {
                        value : 2
                    }
                },
                label: "id enquete",
                    name: "id_enquete",
                    filter: {
                        type: "simple",
                        placeholder: "id"
                    },
                    sort: true,
                },
                {
                    label: "Titulo enquete",
                    name: "titulo_enquete",
                    filter: {
                        type: "simple",
                        placeholder: "Titulo enquete"
                    },
                    sort: true,
                },
                {
                    label: "Data inicial",
                    name: "data_inicial",
                    sort: true,
                    filter: {
                        type: "simple",
                        placeholder: "Data inicial"
                    },
                    sort: true,
                },
                {
                    label: "Data final",
                    name: "data_final",
                    sort: true,
                    filter: {
                        type: "simple",
                        placeholder: "Data final"
                    },
                    sort: true,
                },
                {
                    label: "Horário inicial",
                    name: "horario_inicial",
                    sort: true,
                    filter: {
                        type: "simple",
                        placeholder: "Horário inicial"
                    },
                    sort: true,
                },
                {
                    label: "Horário final",
                    name: "horario_final",
                    sort: true,
                    filter: {
                        type: "simple",
                        placeholder: "Horário final"
                    },
                    sort: true,
                },
                {
                    label: "Editar",
                    name: "editar",
                    sort: true,
                    actions:"actions", 
                },
                {
                    label: "Excluir",
                    name: "excluir",
                    sort: true,
                    actions:"actions", 
                },
            ],
            actions: [
                {
                    btn_text: "Excluir enquete(s) selecionada(s)",
                    event_name: "on-exluirEnquete",
                    class: "btn btn-danger",
                    event_payload: {
                        'valores':this.selecao,
                    }
                }
            ],
            config: {
                per_page_options: [5, 10, 15, 20],
                show_refresh_button: false,
                show_reset_button: false,
                checkbox_rows: false,
                rows_selectable: true,
                card_title: "Enquetes",
                aligncard_title: 'center',
                show_reset_button:false,
                global_search: {
                    placeholder: "Pesquisar...",
                    visibility: true,
                    case_sensitive: false,
                    showClearButton: false,
                    searchOnPressEnter: false,
                    searchDebounceRate: 0,
                },
            },
        }
    },
    validations: {
        dados:{
            required,
            $each:{
                titulo_enquete:{
                    required
                },
                data_inicial:{
                    required
                },
                data_final:{
                    required
                },
                horario_inicial:{
                    required
                },
                horario_final:{
                    required
                }

            }
        },
        titulo_enquete: {
          required,
        },
        data_inicial: {
          required,
        },
        data_final: {
          required,
        },
        horario_inicial: {
          required,
        },
        horario_final: {
          required,
        },
    },
    methods:{
        exluir_enquete(e) {
            for(let i in this.selecao){
                axios.post('excluirEnquete',{
                    'valores':this.selecao[i],
                }).then(resposta => {this.texto = resposta.data;this.socket.emit('atualizar');console.log(this.texto)})
            }
            this.selecao.splice(0)           
        },
        adicionar_campo:function(tipo){
        this.quantidade_questoes = this.campo.length;
            if(this.quantidade_questoes < 5){
                this.quantidade_questoes +=1;
                this.campo.push({
                    pergunta:"",
                    tipo_pergunta:tipo,
                });
            }else{
                alert("A enquete aceita a inserção de até 5 campos!");
            }
        },
        remover_campo(index_campo) {
          this.campo.splice(index_campo, 1);
          this.quantidade_questoes -=1;
        },
        editar_enquete(e){
            this.indice_pergunta = e.row.vbt_id-1;  
            axios.get('editar_enquete/'+e.row.id_enquete).then(resposta => {this.campo = resposta.data});
            this.$bvModal.show(''+e.row.id_enquete);
        },
        modal_editar_user(e){
            this.$bvModal.show('1');
        },
        listar_enquete(){
            axios.post('listar_enquetes').then(resposta => {this.dados = resposta.data});
        },
        salvar_edicao(e){
            event.preventDefault();
            if(this.$v.$anyError == false){
                axios.post('salvar_alteracoes_enquete',{
                    'fk_enquete':e.row.id_enquete,
                    'titulo_enquete':e.row.titulo_enquete,
                    'data_inicial':e.row.data_inicial,
                    'data_final':e.row.data_final,
                    'horario_inicial':e.row.horario_inicial,
                    'horario_final':e.row.horario_final, 
                    'campo':this.campo,
                }).then(response => {this.resposta = response.data;console.log(this.resposta);this.$emit('retornar_mensagem');this.socket.emit('atualizar')}).catch(error => {    
                    console.log(error.message);
                })
            }else{
                console.log(this.$v.$anyError)
            }
            this.$bvModal.hide(''+e.row.id_enquete);           
        },
    },
    created(){  
        this.socket.on('atualizar', () => {  
            console.log("atualizar")
            axios.post('listar_enquetes').then(resposta => {this.dados = resposta.data});
        }),
        this.$on('retornar_mensagem', () => {
            this.$notify({  
                group: 'foo',
                type: 'success',
                text: '<center><h5>'+this.resposta+'</h5></center>',
            });
        });
    },
    mounted(){
        this.listar_enquete();
    },
}
</script>