// Obtenemos el input de búsqueda cortesia de GPT4
const searchInput = document.getElementById('search');

// Escuchamos el evento de entrada en el campo de búsqueda
searchInput.addEventListener('input', function() {
  // Obtenemos el valor de la búsqueda y lo convertimos a minúsculas para comparar sin distinción de mayúsculas
  const searchValue = searchInput.value.toLowerCase();

  // Obtenemos todos los divs que tienen alguna clase relacionada con la búsqueda
  const allDivs = document.querySelectorAll('div');

  // Recorremos todos los divs
  allDivs.forEach(function(div) {
    // Comprobamos si el div tiene alguna clase que contenga el valor de búsqueda
    const divClasses = div.className.toLowerCase();
    
    // Si el valor de búsqueda está dentro del nombre de la clase, mostramos el div
    if (divClasses.includes(searchValue)) {
      div.style.display = ''; // Mostrar el div
    } else {
      div.style.display = 'none'; // Ocultar el div
    }
  });
});


