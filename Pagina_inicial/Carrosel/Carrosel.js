let Radio = document.querySelector('Manual-btn')
let Contador = 1

document.getElementById('radio-1').checked = true

setInterval(() => {
    ProximaImg()
}, 5000)

function ProximaImg(){
    Contador++

    if (Contador == 1){
        document.getElementById('radio-1').checked = true
        document.getElementById('radio-2').checked = false
        document.getElementById('radio-3').checked = false
    }
    if (Contador == 2){
        document.getElementById('radio-1').checked = false
        document.getElementById('radio-2').checked = true
        document.getElementById('radio-3').checked = false
    }
    if(Contador == 3){
        document.getElementById('radio-1').checked = false
        document.getElementById('radio-2').checked = false
        document.getElementById('radio-3').checked = true
        Contador = 0
    }
}