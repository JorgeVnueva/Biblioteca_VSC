/*
Principalmente está Orientado a Objetos
Case sensitive (Sencible a mayusculas y minusculas)
Basado en prototipos
Tipado débil (Puede cambiar de tipo)
Lenguaje Dinámico (La varible se ajusta al dato

Las variables const no se cambian nunca y deben declararse en el momento en que se inicializan
Scope es el alcance de la variable. puede ser global o local
camelCase primera letra en minuscula

arrays
for in muestra posición y algunas características como por ejemplo animales.edad
for of muestra valor

*/
const definiCompra = (n)=>{
    let dinero = prompt(`Dinero de ${n}`);
    if (din >= 0.6 && din < 1) return (`${n}: helado de agua`);
    if (din >= 1) return (`${n}: helado de crema`);
    else return (`${n}: No te alcanza para nada`);     
}
console.log(definiCompra("Pedro"))