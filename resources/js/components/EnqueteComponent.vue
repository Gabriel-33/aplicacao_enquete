<template>
    <div class="card col-md-8 mx-auto">
    <notifications group="foo" position="top center" width="800px" style="margin-top:15px"/>
      <div class="card-body">
        <div class="row">
            <center><h5>NOVA ENQUETE</h5></center>
            <div class="mb-3">
              <label for="formGroupExampleInput" class="form-label">Titulo enquete:</label>
              <input type="text" v-model:value="titulo_enquete" class="form-control" id="formGroupExampleInput" placeholder="Titulo da enquete" v-model.trim="$v.titulo_enquete.$model">
                <div class="text-danger mb-1" v-if="!$v.titulo_enquete.required && this.enviado === true" style="margin-top:10px"><strong>*Campo obrigatório</strong></div>
            </div>
            <div class="col-6 mb-3">
              <label for="formGroupExampleInput2" class="form-label">Data inicial:</label>
              <input type="date" v-model:value="data_inicial" class="form-control" id="formGroupExampleInput2" placeholder="Another input placeholder" v-model.trim="$v.data_inicial.$model">
              <div class="text-danger mb-1" v-if="!$v.data_inicial.required && this.enviado === true" style="margin-top:10px"><strong>*Campo obrigatório</strong></div>
            </div>
            <div class="col-6 mb-3">
              <label for="formGroupExampleInput2" class="form-label">Data Final:</label>
              <input type="date" v-model:value="data_final" class="form-control" id="formGroupExampleInput2" placeholder="Another input placeholder" v-model.trim="$v.data_final.$model">
              <div class="text-danger mb-1" v-if="!$v.data_final.required && this.enviado === true" style="margin-top:10px"><strong>*Campo obrigatório</strong></div>
            </div>
            <div class="col-6 mb-3">
              <label for="formGroupExampleInput2" class="form-label">Horário inicial:</label>
              <input type="time" v-model:value="horario_inicial" class="form-control" id="formGroupExampleInput2" placeholder="Another input placeholder" v-model.trim="$v.horario_inicial.$model">
              <div class="text-danger mb-1" v-if="!$v.horario_inicial.required && this.enviado === true" style="margin-top:10px"><strong>*Campo obrigatório</strong></div>
            </div>
            <div class="col-6 mb-3">
              <label for="formGroupExampleInput2" class="form-label">Horário final:</label>
              <input type="time" v-model:value="horario_final" class="form-control" id="formGroupExampleInput2" placeholder="Another input placeholder" v-model.trim="$v.horario_final.$model">
              <div class="text-danger mb-1" v-if="!$v.horario_final.required && this.enviado === true" style="margin-top:10px"><strong>*Campo obrigatório</strong></div>
            </div>
            <div v-for="(campo, index) in campo" :key="index" v-show="index !=0">
                <div class="row mb-4" v-if="campo.tipo == 1">
                    <div class="col-10">
                      <input v-model:value="campo.valor" type="text" placeholder="Insira a pergunta" class="form-control">
                    </div>
                    <div class="col-2">
                      <button type="button" class="btn btn-danger" @click="remover_campo(index)" v-show="index != 0">
                        Remover
                      </button>
                    </div>
                    <div class="col-12 md-3 mt-3">
                        <label>Resposta:</label>
                        <hr></hr>
                    </div>
                </div>
                <div class="row mb-4" v-if="campo.tipo == 2">
                    <div class="col-10">
                      <input v-model:value="campo.valor" type="text" placeholder="Insira a pergunta" class="form-control">
                    </div>
                    <div class="col-2">
                      <button type="button" class="btn btn-danger" @click="remover_campo(index)" v-show="index != 0">
                        Remover
                      </button>
                    </div>
                    <div class="col-10 col-sm-6">
                      <div class="form-check">
                        <input v-model="campo.valor" class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1" disabled>
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
                <div class="row mb-4" v-if="campo.tipo == 3">
                    <div class="col-10">
                      <input v-model="campo.valor" type="text" placeholder="Insira a pergunta" class="form-control">
                    </div>
                    <div class="col-2">
                      <button type="button" class="btn btn-danger" @click="remover_campo(index)" v-show="index != 0">
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
              <button class="btn btn-success" type="button" v-on:click="salvar_enquete()">Salvar enquete</button>
            </div>
        </div>
      </div>
    </div>
</template>

<script>
    import { required, minLength, between } from 'vuelidate/lib/validators'
    import io from "socket.io-client"
    export default {
        name:"CadastrarEnquete",
        mounted() {
            console.log('Component mounted.')
        }, 
        data(){
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
                quantidade_questoes:0, 
                resposta:'',
                titulo_enquete:'',
                data_inicial:'',
                data_final:'',
                horario_inicial:'',
                horario_final:'',
                enviado:false,             
                campo: [
                    {
                      valor: "",
                      tipo:1,
                    },
                ],
            };
        },
        validations: {
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
            adicionar_campo:function(tipo){
                if(this.quantidade_questoes < 5){
                    this.quantidade_questoes +=1;
                    this.campo.push({
                        valor:"",
                        tipo:tipo,
                    });
                }else{
                    alert("A enquete aceita a inserção de até 5 campos!");
                }
            },
            remover_campo(index_campo) {
              this.campo.splice(index_campo, 1);
              this.quantidade_questoes -=1;
            },
            salvar_enquete(){
                //console.log(this.campo_texto)
                this.enviado = true
                event.preventDefault();
                if(this.$v.$invalid == false){
                    axios.post('cadastrar_enquete',{
                        'titulo_enquete':this.titulo_enquete,
                        'data_inicial':this.data_inicial,
                        'data_final':this.data_final,
                        'horario_inicial':this.horario_inicial,
                        'horario_final':this.horario_final, 
                        'campo':this.campo,
                    }).then(response => {this.resposta = response.data;console.log(this.resposta);this.$emit('enquete_cadastrada');this.socket.emit('atualizar')}).catch(error => {    
                        console.log(error.message);
                    })
                }else{
                    console.log(this.$v)
                }
            }
        },
        created(){
            this.$on('enquete_cadastrada', () => {  
                this.campo.splice(1),
                this.campo.splice(1),
                this.campo.splice(1),
                this.titulo_enquete = null,
                this.data_inicial = null,
                this.data_final = null,
                this.horario_inicial = null,
                this.horario_final = null,
                this.enviado = false,
                this.quantidade_questoes = 0,
                this.$notify({
                    group: 'foo',
                    type: 'success',
                    text: '<center><h6>'+this.resposta+'</h6></center>',
                });
            }); 
        }
    }
</script>
