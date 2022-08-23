<template>
    <vue-bootstrap4-table :rows="dados" :columns="columns" :config="config" class="table table-bordered">
            <template slot="pagination-info" slot-scope="props">
                Total de enquetes: {{props.currentPageRowsLength}}
            </template>
            <template slot="empty-results">
                Nenhuma enquete encontrada
            </template>
            <template slot="paginataion-previous-button">
                Anterior
            </template>
            <template slot="votar" slot-scope="dados">
                <i>
                    <notifications group="foo" position="top center" width="400" style="margin-top:15px"/>
                    <b-modal v-bind:id="'a'+String(dados.row.id_enquete)" hide-footer>
                        <form v-on:submit="votar_enquete(dados)">
                            <div class="form-group">
                                <input type="hidden" class="form-control" v-bind:value="1">
                            </div>
                            <div class="card">
                                <div class="card-body">
                                    <div class="row">
                                        <center><h5>PREENCHA OS CAMPOS ABAIXO</h5></center>
                                        <div v-for="(campo, index) in campo" :key="index">
                                            <div class="row mb-4" v-if="campo.tipo_pergunta == 1">
                                                <div class="col-12 md-3 mt-3">
                                                    <label>{{campo.pergunta}}</label>
                                                </div>
                                                <div class="col-12">
                                                  <input v-model:value="campo.resposta" type="text" placeholder="Insira a resposta" class="form-control">
                                                </div>
                                                <hr></hr>
                                            </div>
                                            <div class="row mb-4" v-if="campo.tipo_pergunta == 2">
                                                <div class="col-12 md-3 mt-3">
                                                    <label>{{campo.pergunta}}</label>
                                                </div>
                                                <div class="col-9 col-sm-6">
                                                  <div class="form-check">
                                                    <input v-model="campo.resposta" class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1">
                                                    <label class="form-check-label" for="flexRadioDefault1">
                                                    Sim
                                                    </label>
                                                    </div>
                                                    <div class="form-check">
                                                    <input v-model="campo.valor" class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault2" checked>
                                                    <label class="form-check-label" for="flexRadioDefault2">
                                                        Não
                                                    </label>
                                                    </div>
                                                </div>
                                                <hr></hr>
                                            </div>
                                            <div class="row mb-4" v-if="campo.tipo_pergunta == 3">
                                                <div class="col-12 md-3 mt-3">
                                                    <label>{{campo.pergunta}}</label>
                                                </div>
                                                <div class="col-12 md-3 mt-3">
                                                    <input type="number" v-model="campo.resposta" placeholder="Resposta em valor númerico" class="form-control">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-grid gap-2">
                                          <b-button type="submit" class="btn btn-success mt-3" block>Salvar resposta</b-button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </b-modal>
                </i>
                <button class="btn btn-primary" v-on:click="votar_enquete(dados)" :disabled="new Date(dados.row.data_final).getTime() < new Date().getTime() || parseInt(dados.row.horario_final) < new Date().getHours()">
                    <i class="fas fa-vote-yea"></i>
                </button>
            </template>
    </vue-bootstrap4-table>
</template>
<script>
import VueBootstrap4Table from 'vue-bootstrap4-table'
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
import moment from 'moment';
import 'moment/locale/pt-br';
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
            tempo:{
                data_inicial:'',
                data_final:'',
            },
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
                  resposta:"",
                },
            ],
            columns: [
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
                    label: "Votar",
                    name: "votar",
                    sort: true,
                    actions:"actions", 
                },
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
        modal_editar_user(e){
            this.$bvModal.show('1');
        },
        listar_enquete(){
            axios.post('listar_enquetes').then(resposta => {this.dados = resposta.data});
        },
        votar_enquete(e){
            moment.locale('pt-br');
            console.log(parseInt(e.row.horario_final))
            console.log(new Date().getHours())
            if(moment(e.row.data_final).format('X') < moment().format('X')){
                console.log("data válida!")
            }
            axios.get('editar_enquete/'+e.row.id_enquete).then(resposta => {this.campo = resposta.data});
            this.$bvModal.show('a'+e.row.id_enquete);
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