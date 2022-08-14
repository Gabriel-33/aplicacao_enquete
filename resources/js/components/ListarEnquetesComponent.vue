<template>
    <vue-bootstrap4-table :rows="dados" :columns="columns" :config="config" :actions="actions" @on-download="onDownload" class="table table-bordered">
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
                    <b-button variant="primary" v-on:click="modal_editar_user(dados)"><i class="fas fa-pen-square"></i></b-button>
                    <notifications group="foo" v-bind:id="String(dados.row.id_user)" position="top center" width="500px"/>
                    <b-modal v-bind:id="String(dados.row.id_user)" hide-footer>
                        <div slot="modal-title" class="modal-title w-100 font-weight-bold">
                            <h5>Editar usuário</h5>
                        </div>
                        <form v-on:submit="salvar_edicao(dados)">
                            <div class="form-group">
                                <input type="hidden" class="form-control" v-bind:value="dados.row.id_user">
                            </div>
                            <div class="form-group">
                                <label>Nome:</label>
                                <input type="text" class="form-control" v-model="dados.row.nome_user" maxlength="45">
                                <div class="error text text-danger" v-if="!$v.nome_user.required">
                                    <ul class="col-md-12">
                                      <li class="text-danger">  
                                        Campo obrigatório
                                      </li> 
                                    </ul>
                                </div>
                                <div class="error" v-if="!$v.nome_user.maxLength">
                                <div class="error text text-danger">
                                    <ul class="col-md-12">
                                      <li class="text-danger">  
                                        Este campo deve ter no máximo {{$v.nome_user.$params.maxLength.max}} caracteres.
                                      </li> 
                                    </ul>
                                </div>
                              </div>
                            </div>
                            <div class="form-group">
                                <label>Email:</label>
                                <input type="email" class="form-control" v-model="dados.row.email_user" maxlength="60">
                                <div class="error text text-danger" v-if="!$v.email_user.required">
                                    <ul class="col-md-12">
                                      <li class="text-danger">  
                                        Campo obrigatório
                                      </li> 
                                    </ul>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Nivel:</label>
                                <i class="col-md-2" data-title="1 = usuário estudante; 2 = usuário organizador; 3 = usuário root">
                                    <span class="fa fa-info"></span>
                                </i>
                                <div>
                                  <select class="select-form form-control" v-model="dados.row.tipo_user">
                                    <option selected disabled value="">Selecione uma opção</option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                  </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Status:</label>
                                <i class="col-md-2" data-title="1 = usuário ativo; 2 = usuário inativo">
                                    <span class="fa fa-info"></span>
                                </i>
                                <div>
                                  <select class="select-form form-control" v-model="dados.row.status_user">
                                    <option selected disabled value="">Selecione uma opção</option>
                                    <option value="0">0</option>
                                    <option value="1">1</option>
                                  </select>
                                </div>
                            </div>
                          <b-button type="submit" class="btn btn-success mt-3" block>Salvar alterações</b-button>
                        </form>
                    </b-modal>
                </i>
            </template>
            <template slot="excluir" slot-scope="dados">
                <i>
                    <notifications group="foo2" v-bind:id="String(dados.row.id_user)" position="top center" width="500px"/>
                    <button class="btn btn-danger" v-on:click="excluir_user(dados)">
                        <i class="fa fa-trash-alt"></i>
                    </button>
                </i>
            </template>
    </vue-bootstrap4-table>
</template>
<script>
import VueBootstrap4Table from 'vue-bootstrap4-table'
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
            dados:[],
            id_user:'',
            tipo_user:'',
            status_user:'',
            nome_user:true,
            email_user:true,
            texto:'',
            type:'',
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
            columns: [
                {
                label: "id enquete",
                    name: "id_user",
                    filter: {
                        type: "simple",
                        placeholder: "id"
                    },
                    sort: true,
                },
                {
                    label: "Titulo enquete",
                    name: "nome_user",
                    filter: {
                        type: "simple",
                        placeholder: "Nome"
                    },
                    sort: true,
                },
                {
                    label: "Data inicial",
                    name: "tipo_user",
                    sort: true,
                    filter: {
                        type: "simple",
                        placeholder: "Tipo de usuário"
                    },
                    sort: true,
                },
                {
                    label: "Data final",
                    name: "status_user",
                    sort: true,
                    filter: {
                        type: "simple",
                        placeholder: "Status de usuário"
                    },
                    sort: true,
                },
                {
                    label: "Horário inicial",
                    name: "email_user",
                    sort: true,
                    filter: {
                        type: "simple",
                        placeholder: "Status de usuário"
                    },
                    sort: true,
                },
                {
                    label: "Horário final",
                    name: "email_user",
                    sort: true,
                    filter: {
                        type: "simple",
                        placeholder: "Status de usuário"
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
            config: {
                per_page_options: [5, 10, 15, 20],
                show_refresh_button: false,
                show_reset_button: false,
                checkbox_rows: false,
                rows_selectable: true,
                card_title: "Enquetes",
                aligncard_title: 'center',
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
        nome_user:{
            required,
            minLength: minLength(1),
            maxLength: maxLength(45),
            $each: true,  
        },
        email_user:{
          required,
          $each: true
        },
    },
    methods:{
        onDownload(payload) {
            console.log(payload);
        },
        excluir_user(e){    
            axios.get('/excluirUser/'+e.row.id_user).then(resposta => {this.texto = resposta.data;this.socket.emit('atualizar');Event.$emit('excluido')});
        },
        modal_editar_user(e){
            this.$bvModal.show(''+e.row.id_user);
        },
        listar_users(){
            axios.post('/listarUsers').then(resposta => this.dados = resposta.data);
        },
        salvar_edicao(e){
            event.preventDefault();
            this.nome_user = e.row.nome_user;
            this.$v.nome_user.$touch();
            this.email_user = e.row.email_user;
            this.$v.email_user.$touch();
            if(this.$v.$anyError == false){
                axios.post('/editarUser',{
                    'nome_user':e.row.nome_user,
                    'email_user':e.row.email_user,
                    'tipo_user':e.row.tipo_user,
                    'status_user':e.row.status_user,
                    'id_user':e.row.id_user,
                }).then(resposta => {this.texto = resposta.data;this.socket.emit('atualizar');Event.$emit('editado')});
                this.$bvModal.hide(''+e.row.id_user);
            }
        },
    },
    created(){  
        this.socket.on('atualizar', () => {  
            axios.post('/listarUsers').then(resposta => {this.dados = resposta.data});
        });
        this.$on('excluido', () => {
            axios.post('/listarUsers').then(resposta => this.dados = resposta.data);
            this.$notify({  
                group: 'foo2',
                type: 'error',
                text: '<center>'+this.texto+'</center>',
            });
        });
        this.$on('UserCadastrado', () => {
            axios.post('/listarUsers').then(resposta => this.dados = resposta.data);
        });
        this.$on('editado', () => {
            this.$notify({
                group: 'foo',
                type: 'success',
                text: '<center>'+this.texto+'</center>',
            });
        });
    },
    mounted(){
        this.listar_users();
    },
}
</script>