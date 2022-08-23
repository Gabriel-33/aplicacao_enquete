/**
 * First we will load all of this project's JavaScript dependencies which
 * includes Vue and other libraries. It is a great starting point when
 * building robust, powerful web applications using Vue and Laravel.
 */

require('./bootstrap');

window.Vue = require('vue');

/**
 * The following block of code may be used to automatically register your
 * Vue components. It will recursively scan this directory for the Vue
 * components and automatically register them with their "basename".
 *
 * Eg. ./components/ExampleComponent.vue -> <example-component></example-component>
 */

// const files = require.context('./', true, /\.vue$/i)
// files.keys().map(key => Vue.component(key.split('/').pop().split('.')[0], files(key).default))

import Vue from 'vue'
import Vuelidate from 'vuelidate'
import Notifications from 'vue-notification'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
Vue.component('enquete-component', require('./components/EnqueteComponent.vue').default);
Vue.component('listar-enquete-component', require('./components/ListarEnquetesComponent.vue').default);
Vue.component('votar-enquete-component', require('./components/votarEnqueteComponent.vue').default);
Vue.use(Vuelidate)
Vue.use(Notifications)  
/**
 * Next, we will create a fresh Vue application instance and attach it to
 * the page. Then, you may begin adding components to this application
 * or customize the JavaScript scaffolding to fit your unique needs.
 */

const app = new Vue({
    el: '#app',
    data:{
        opc:'cadastrar_enquete',
    },
    methods:{
        chamar_opc:function(enquete){
            this.opc = enquete
            //alert(this.opc)
        },
    },
});
