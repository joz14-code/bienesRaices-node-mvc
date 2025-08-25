(function() {
    
    const lat = document.querySelector('#lat').value || 4.807151;
    const lng = document.querySelector('#lng').value || -75.6862467;
    const mapa = L.map('mapa').setView([lat, lng ], 131);
    let marker;

    //Utilizar Provider y Geocoder
    const geocodeService = L.esri.Geocoding.geocodeService();
    

    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(mapa);

    //El Pin
    marker = new L.marker([lat, lng],{

        draggable: true,   
        autoPan: true     
        
    })
    .addTo(mapa)

    //Detectar el movimiento del pin y detectar longitud y latitud
    marker.on('moveend', function(e){

        marker = e.target
        //console.log(marker)
        const posicion = marker.getLatLng();
       //console.log(posicion)
        mapa.panTo(new L.LatLng(posicion.lat, posicion.lng))

        //Obtener la info de las calles al soltar el pin
        geocodeService.reverse().latlng(posicion, 13).run(function(error, resultado){
            //console.log(resultado)

            marker.bindPopup(resultado.address.LongLabel)

            //Llenar los campos
            document.querySelector('.calle').textContent = resultado?.address?.Address ?? '';
            document.querySelector('#calle').value = resultado?.address?.Address ?? '';
            document.querySelector('#lat').value = resultado?.latlng?.lat ?? '';
            document.querySelector('#lng').value = resultado?.latlng?.lng ?? '';
        })
    })



})()