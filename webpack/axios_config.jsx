import axios from 'axios'

let csrfToken = document.querySelector('meta[name=csrf-token]').getAttribute('content')

axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
axios.defaults.headers.common['X-Requested-With'] = 'XMLHttpRequest'
axios.defaults.headers.common['Content-Type'] = 'application/json'
axios.defaults.headers.common['Accept'] = 'application/json'
