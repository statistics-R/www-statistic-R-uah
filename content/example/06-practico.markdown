---
title: "Transformar variables"
linktitle: "6: Transformar variables"
date: "2021-08-30"
menu:
  example:
    parent: Ejemplos
    weight: 6
type: docs
toc: true
editor_options: 
  chunk_output_type: console
---

## 0. Objetivo de la práctica

El objetivo del práctico, es avanzar en el procesamiento de los datos a través de la transformación de las variables a utilizar. Para ello revisaremos procedimientos básicos para el manejo de datos con RStudio, profundizando específicamente en la función `mutate` de `dplyr`.

## 1. Recursos de la práctica

En este práctico utilizaremos la base de datos de la [**Encuesta de Caracterización Socioeconómica (CASEN)**](http://observatorio.ministeriodesarrollosocial.gob.cl/encuesta-casen-en-pandemia-2020), la cual fue procesada en el [Práctico anterior]().Recuerden siempre consultar el [**manual/libro de códigos**](http://observatorio.ministeriodesarrollosocial.gob.cl/storage/docs/casen/2020/Libro_de_codigos_Base_de_Datos_Casen_en_Pandemia_2020.pdf) antes de trabajar una base de datos.


## 2. Librerias a utilizar

En este práctico utilizaremos cuatro paquetes

1. `pacman`: este facilita y agiliza la lectura de los paquetes a utilizar en R

2. `sjmisc`: explorar datos

3. `car()`: recodificar manteniendo las etiquetas

4. `tidyverse`: colección de paquetes, del cuál utilizaremos `dplyr` y `forcats`

5. `dplyr`: para manipular datos

6. `forcats`: para transformar variables en factores 

# Pasos del procesamiento

## 1. Cargar librerías

Primero instalamos `pacman` por única vez


```r
install.packages("pacman")
library (pacman)
```

Luego cargaremos así los paquetes. Les recordamos que cuando luego de un paquete ponemos `::` esto se refiere a que se *"fuerza"* que esa función provenga de *ese paquete*


```r
pacman::p_load(tidyverse,
               haven, 
               forcats,
               car,
               sjmisc)
```


## 2. Cargar base de datos




```r
datos <- read_dta("input/Casen en Pandemia 2020 STATA.dta") 
```

En el panel **Environment**, visualizamos el nuevo objeto, que posee 1.816 observaciones (o filas), y 11 variables (columnas)


```r
head(datos)
```

```
## # A tibble: 6 x 11
##          folio sexo    edad ocupacion  ytoth tot_per    ife     o2     o3     o4
##          <dbl> <fct>  <dbl> <dbl+lbl>  <dbl>   <dbl> <dbl+> <dbl+> <dbl+> <dbl+>
## 1 110110030201 Hombre    56    2 [No] 3.02e5       2 1 [Sí] 2 [No] 2 [No] 1 [Sí]
## 2 110110110101 Mujer     66    2 [No] 2.14e5       1 1 [Sí] 2 [No] 2 [No] 1 [Sí]
## 3 110110170101 Mujer     65    2 [No] 3.85e5       1 1 [Sí] 2 [No] 2 [No] 2 [No]
## 4 110110290701 Mujer     76    2 [No] 1.48e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
## 5 110110310601 Mujer     27    2 [No] 4.35e5       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
## 6 110110402001 Mujer     35    2 [No] 1.30e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
## # ... with 1 more variable: o6 <dbl+lbl>
```


## 3. `mutate()` para transformación de  variables

La función de `mutate()` permite hacer operaciones para crear nuevas variables o transformar las ya existentes. 

{{< div "note" >}}
mutate(datos, nueva_variable = cálculo o condición)
{{< /div >}}

#### `mutate()` en base a cálculo

Calcularemos una nueva variable llamada `nueva_variable` que proviene de la suma de 2+3. También una variable `ingreso_percapita` que proviene de la división del ingreso total del hogar y el número de personas que residen en el hogar 


```r
mutate(datos, nueva_variable = 3+2)
```

```
## # A tibble: 1,816 x 12
##           folio sexo    edad ocupacion  ytoth tot_per    ife     o2     o3     o4
##           <dbl> <fct>  <dbl> <dbl+lbl>  <dbl>   <dbl> <dbl+> <dbl+> <dbl+> <dbl+>
##  1 110110030201 Hombre    56    2 [No] 3.02e5       2 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  2 110110110101 Mujer     66    2 [No] 2.14e5       1 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  3 110110170101 Mujer     65    2 [No] 3.85e5       1 1 [Sí] 2 [No] 2 [No] 2 [No]
##  4 110110290701 Mujer     76    2 [No] 1.48e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  5 110110310601 Mujer     27    2 [No] 4.35e5       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  6 110110402001 Mujer     35    2 [No] 1.30e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  7 110110440501 Mujer     43    2 [No] 3.76e5       4 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  8 110110450401 Mujer     56    2 [No] 1.32e6       4 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  9 110111021801 Mujer     64    2 [No] 1.17e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
## 10 110111021801 Mujer     45    2 [No] 1.17e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
## # ... with 1,806 more rows, and 2 more variables: o6 <dbl+lbl>,
## #   nueva_variable <dbl>
```

```r
mutate(datos, nueva_variable = 3+2,
       ingreso_percapita = ytoth/tot_per)
```

```
## # A tibble: 1,816 x 13
##           folio sexo    edad ocupacion  ytoth tot_per    ife     o2     o3     o4
##           <dbl> <fct>  <dbl> <dbl+lbl>  <dbl>   <dbl> <dbl+> <dbl+> <dbl+> <dbl+>
##  1 110110030201 Hombre    56    2 [No] 3.02e5       2 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  2 110110110101 Mujer     66    2 [No] 2.14e5       1 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  3 110110170101 Mujer     65    2 [No] 3.85e5       1 1 [Sí] 2 [No] 2 [No] 2 [No]
##  4 110110290701 Mujer     76    2 [No] 1.48e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  5 110110310601 Mujer     27    2 [No] 4.35e5       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  6 110110402001 Mujer     35    2 [No] 1.30e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  7 110110440501 Mujer     43    2 [No] 3.76e5       4 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  8 110110450401 Mujer     56    2 [No] 1.32e6       4 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  9 110111021801 Mujer     64    2 [No] 1.17e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
## 10 110111021801 Mujer     45    2 [No] 1.17e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
## # ... with 1,806 more rows, and 3 more variables: o6 <dbl+lbl>,
## #   nueva_variable <dbl>, ingreso_percapita <dbl>
```

#### `recode()` y `mutate()`

Muchas veces, los valores originales no se ajustan a los análisis que queramos hacer, o a la forma en que deseamos presentar nuestros análisis. Por ello, en el código de procesamiento **recodificaremos** frecuentemente los valores que alcanzan nuestras variables, especialmente cuando trabajamos con variables categóricas. 

En el siguiente ejemplo recodificamos las categorías de respuesta de Mujer a Femenino y de Hombre a Masculino


```r
datos %>% 
  mutate(sexo = dplyr::recode(sexo, "Mujer" = "Femenino", "Hombre" = "Masculino"))
```

```
## # A tibble: 1,816 x 11
##        folio sexo    edad ocupacion   ytoth tot_per     ife     o2     o3     o4
##        <dbl> <fct>  <dbl> <dbl+lbl>   <dbl>   <dbl> <dbl+l> <dbl+> <dbl+> <dbl+>
##  1   1.10e11 Mascu~    56    2 [No]  302083       2  1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  2   1.10e11 Femen~    66    2 [No]  213838       1  1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  3   1.10e11 Femen~    65    2 [No]  384907       1  1 [Sí] 2 [No] 2 [No] 2 [No]
##  4   1.10e11 Femen~    76    2 [No] 1478196       5  1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  5   1.10e11 Femen~    27    2 [No]  434783       5  1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  6   1.10e11 Femen~    35    2 [No] 1298426       5  1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  7   1.10e11 Femen~    43    2 [No]  375509       4  1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  8   1.10e11 Femen~    56    2 [No] 1317526       4  1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  9   1.10e11 Femen~    64    2 [No] 1171840       5  1 [Sí] 2 [No] 2 [No] 1 [Sí]
## 10   1.10e11 Femen~    45    2 [No] 1171840       5  1 [Sí] 2 [No] 2 [No] 1 [Sí]
## # ... with 1,806 more rows, and 1 more variable: o6 <dbl+lbl>
```

El problema de la función `recode()` de `dplyr` es que, si recodifico números etiquetados, se perderá la etiqueta, conservándose el nuevo valor. Esto es un problema recurrente si, por ejemplo, sólo deseo recodificar valores nulos (por ejemplo, transformar los valores `88` y `99` como `NA`). 

Frente a ello, con el tiempo nos hemos convencido de que la mejor solución hasta ahora es ocupar `recode()` del paquete `car`. Si recuerdan, dos funciones con el mismo nombre podrían producir *conflictos* y, por ello, especificaremos con `car::recode()` que la función `recode()` que ocupamos proviene del paquete `car`

{{< div "note" >}}
datos %$% 
 car::recode(.$variable, c('valor_orig1=nuevo_valor1;valor_org2=nuevo_valor2'))
 
*Ojo: %$% es el primo hermano de %>% (básicamente funcionan igual, por lo que podemos emplear tranquilamente %>% si nos encontramos trabajando con `mutate`)*
{{< /div >}}

¡Recodifiquemos caracteres! incluso: podemos transformar inmediatamente en `factor`, y asignar un orden específico a los niveles que alcanza la variable. Incluyamos la recodificación en `mutate()`


```r
datos %>% 
  mutate(sexo = car::recode(.$sexo, c('"Mujer"="Femenino";"Hombre"= "Masculino"'), 
              as.factor = T, # Transformar en factor
              levels = c("Masculino", "Femenino"))) #Ordenamos los niveles del factor
```

```
## # A tibble: 1,816 x 11
##        folio sexo    edad ocupacion   ytoth tot_per     ife     o2     o3     o4
##        <dbl> <fct>  <dbl> <dbl+lbl>   <dbl>   <dbl> <dbl+l> <dbl+> <dbl+> <dbl+>
##  1   1.10e11 Mascu~    56    2 [No]  302083       2  1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  2   1.10e11 Femen~    66    2 [No]  213838       1  1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  3   1.10e11 Femen~    65    2 [No]  384907       1  1 [Sí] 2 [No] 2 [No] 2 [No]
##  4   1.10e11 Femen~    76    2 [No] 1478196       5  1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  5   1.10e11 Femen~    27    2 [No]  434783       5  1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  6   1.10e11 Femen~    35    2 [No] 1298426       5  1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  7   1.10e11 Femen~    43    2 [No]  375509       4  1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  8   1.10e11 Femen~    56    2 [No] 1317526       4  1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  9   1.10e11 Femen~    64    2 [No] 1171840       5  1 [Sí] 2 [No] 2 [No] 1 [Sí]
## 10   1.10e11 Femen~    45    2 [No] 1171840       5  1 [Sí] 2 [No] 2 [No] 1 [Sí]
## # ... with 1,806 more rows, and 1 more variable: o6 <dbl+lbl>
```

Notemos que los *`character` siempre van entre comillas*

### `ifelse()` para construir variables condicionales

La función `ifelse()` permite construir variables en base a condiciones lógicas. Su estructura es la siguiente

{{< div "note" >}}
if_else(condición,TRUE,FALSE)
Donde dice `TRUE` es el valor que se obtiene si la condición es verdadera, mientras que `FALSE` es todo el resto de las opciones (o cuando es FALSA)
{{< /div >}}

Crearemos una variable que *dummy* que indica si el informante accedió al Ingreso Familiar de Emergencia (IFE) o no


```r
datos %>% 
 		 mutate(ife_d= ifelse(ife == 1, 1, 0))
```

```
## # A tibble: 1,816 x 12
##           folio sexo    edad ocupacion  ytoth tot_per    ife     o2     o3     o4
##           <dbl> <fct>  <dbl> <dbl+lbl>  <dbl>   <dbl> <dbl+> <dbl+> <dbl+> <dbl+>
##  1 110110030201 Hombre    56    2 [No] 3.02e5       2 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  2 110110110101 Mujer     66    2 [No] 2.14e5       1 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  3 110110170101 Mujer     65    2 [No] 3.85e5       1 1 [Sí] 2 [No] 2 [No] 2 [No]
##  4 110110290701 Mujer     76    2 [No] 1.48e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  5 110110310601 Mujer     27    2 [No] 4.35e5       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  6 110110402001 Mujer     35    2 [No] 1.30e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  7 110110440501 Mujer     43    2 [No] 3.76e5       4 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  8 110110450401 Mujer     56    2 [No] 1.32e6       4 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  9 110111021801 Mujer     64    2 [No] 1.17e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
## 10 110111021801 Mujer     45    2 [No] 1.17e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
## # ... with 1,806 more rows, and 2 more variables: o6 <dbl+lbl>, ife_d <dbl>
```

Recordemos que usamos 1 porque `ife` es una variable de tipo haven_labelled, por lo que es un número etiquetado. Ahora asignemos 1 a las **mujeres que accedieron al IFE**


```r
datos %>% 
 		 mutate(ife_d= ifelse(ife == 1 & sexo == 'Mujer', 1, 0))
```

```
## # A tibble: 1,816 x 12
##           folio sexo    edad ocupacion  ytoth tot_per    ife     o2     o3     o4
##           <dbl> <fct>  <dbl> <dbl+lbl>  <dbl>   <dbl> <dbl+> <dbl+> <dbl+> <dbl+>
##  1 110110030201 Hombre    56    2 [No] 3.02e5       2 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  2 110110110101 Mujer     66    2 [No] 2.14e5       1 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  3 110110170101 Mujer     65    2 [No] 3.85e5       1 1 [Sí] 2 [No] 2 [No] 2 [No]
##  4 110110290701 Mujer     76    2 [No] 1.48e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  5 110110310601 Mujer     27    2 [No] 4.35e5       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  6 110110402001 Mujer     35    2 [No] 1.30e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  7 110110440501 Mujer     43    2 [No] 3.76e5       4 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  8 110110450401 Mujer     56    2 [No] 1.32e6       4 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  9 110111021801 Mujer     64    2 [No] 1.17e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
## 10 110111021801 Mujer     45    2 [No] 1.17e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
## # ... with 1,806 more rows, and 2 more variables: o6 <dbl+lbl>, ife_d <dbl>
```

También podemos ocupar esta función como validador, por ejemplo, rellenando con valores lógicos como `FALSE` cuando no hay información válida en `ytoth`. Luego esos `FALSE` podrían ser contados en otros procesos estadísticos


```r
datos %>% 
  mutate(validador_ingreso = ifelse(is.na(ytoth), FALSE, TRUE))
```

```
## # A tibble: 1,816 x 12
##           folio sexo    edad ocupacion  ytoth tot_per    ife     o2     o3     o4
##           <dbl> <fct>  <dbl> <dbl+lbl>  <dbl>   <dbl> <dbl+> <dbl+> <dbl+> <dbl+>
##  1 110110030201 Hombre    56    2 [No] 3.02e5       2 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  2 110110110101 Mujer     66    2 [No] 2.14e5       1 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  3 110110170101 Mujer     65    2 [No] 3.85e5       1 1 [Sí] 2 [No] 2 [No] 2 [No]
##  4 110110290701 Mujer     76    2 [No] 1.48e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  5 110110310601 Mujer     27    2 [No] 4.35e5       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  6 110110402001 Mujer     35    2 [No] 1.30e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  7 110110440501 Mujer     43    2 [No] 3.76e5       4 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  8 110110450401 Mujer     56    2 [No] 1.32e6       4 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  9 110111021801 Mujer     64    2 [No] 1.17e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
## 10 110111021801 Mujer     45    2 [No] 1.17e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
## # ... with 1,806 more rows, and 2 more variables: o6 <dbl+lbl>,
## #   validador_ingreso <lgl>
```

### `case_when()` para construir variable en base a múltiples condiciones

Una función que se utiliza frecuentemente para *colapsar* categorías o construir categorías en base a varias condiciones es `case_when()` por lo lógico y *fácil* que es de entender

{{< div "note" >}}
case_when(variable == condicion ~ valor1,
          variable == condicion ~ valor2,
          TRUE ~ NA_real_)
- Donde, TRUE indica "todo el resto", y el NA dependerá de la clase del valor de recodificación. En general, usaremos `NA_character_` para variables categóricas, y `NA_real_` para variables numéricas.
{{< /div >}}

Un ejemplo claro es cuando queremos construir *categorías de edad*


```r
datos %>% 
  mutate(edad_tramo = case_when(edad <=39 ~  "Joven",
                                edad > 39 & edad <=59 ~ "Adulto",
                                edad > 59 ~ "Adulto mayor",
                                TRUE ~ NA_character_)) %>% 
  select(edad, edad_tramo)
```

```
## # A tibble: 1,816 x 2
##     edad edad_tramo  
##    <dbl> <chr>       
##  1    56 Adulto      
##  2    66 Adulto mayor
##  3    65 Adulto mayor
##  4    76 Adulto mayor
##  5    27 Joven       
##  6    35 Joven       
##  7    43 Adulto      
##  8    56 Adulto      
##  9    64 Adulto mayor
## 10    45 Adulto      
## # ... with 1,806 more rows
```

Como se puede ver, no solamente indicamos tramos de la variable edad, sino que utilizamos operadores lógicos (`&`). Podríamos ocupar el que necesitemos, y sobre todo, también combinar variables (por ejemplo, crear una variable `sexo-edad`)


```r
datos %>% 
  mutate(sexo_edad_tramo = case_when(sexo == "Hombre" & edad <=39 ~  "Hombre joven",
                                sexo == "Mujer" & edad <=39 ~  "Mujer joven",
                                sexo == 'Hombre' & (edad > 39 & edad <=59) ~ "Hombre adulto",
                                sexo == 'Mujer' & (edad > 39 & edad <=59) ~ "Mujer adulta",
                                sexo == 'Hombre' & edad > 59 ~ "Adulto mayor",
                                sexo == 'Mujer' & edad > 59 ~ "Adulta mayor",
                                TRUE ~ NA_character_)) %>% 
  select(sexo, edad, sexo_edad_tramo)
```

```
## # A tibble: 1,816 x 3
##    sexo    edad sexo_edad_tramo
##    <fct>  <dbl> <chr>          
##  1 Hombre    56 Hombre adulto  
##  2 Mujer     66 Adulta mayor   
##  3 Mujer     65 Adulta mayor   
##  4 Mujer     76 Adulta mayor   
##  5 Mujer     27 Mujer joven    
##  6 Mujer     35 Mujer joven    
##  7 Mujer     43 Mujer adulta   
##  8 Mujer     56 Mujer adulta   
##  9 Mujer     64 Adulta mayor   
## 10 Mujer     45 Mujer adulta   
## # ... with 1,806 more rows
```

### Calcular índices con `rowwise()`

Como sabemos, la librería `dplyr` de `tidyverse` provee diversas herramientas que nos permiten manipular los datos con los cuales nos encontramos trabajando. Una de ellas es su función `rowwise()`, que posibilita **agrupar los datos en razón de las filas**. Esto es particularmente útil cuando, por ejemplo, queremos construir algún índice. En este caso, utilizaremos las variables ytoth y tot_per para determinar cuál es el ingreso per cápita de cada hogar


```r
datos %>% #Especificamos que trabajaremos con el dataframe datos
  rowwise() %>% #Especificamos que agruparemos por filas
  mutate(ing_pc = ytoth/tot_per) %>% #Creamos una nueva variable llamada ing_tot, sumando los valores de ss_t, svar_t y reg_t para cada fila 
  ungroup() # Desagrupamos (dejamos de trabajar en razón de filas)
```

```
## # A tibble: 1,816 x 12
##           folio sexo    edad ocupacion  ytoth tot_per    ife     o2     o3     o4
##           <dbl> <fct>  <dbl> <dbl+lbl>  <dbl>   <dbl> <dbl+> <dbl+> <dbl+> <dbl+>
##  1 110110030201 Hombre    56    2 [No] 3.02e5       2 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  2 110110110101 Mujer     66    2 [No] 2.14e5       1 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  3 110110170101 Mujer     65    2 [No] 3.85e5       1 1 [Sí] 2 [No] 2 [No] 2 [No]
##  4 110110290701 Mujer     76    2 [No] 1.48e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  5 110110310601 Mujer     27    2 [No] 4.35e5       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  6 110110402001 Mujer     35    2 [No] 1.30e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  7 110110440501 Mujer     43    2 [No] 3.76e5       4 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  8 110110450401 Mujer     56    2 [No] 1.32e6       4 1 [Sí] 2 [No] 2 [No] 1 [Sí]
##  9 110111021801 Mujer     64    2 [No] 1.17e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
## 10 110111021801 Mujer     45    2 [No] 1.17e6       5 1 [Sí] 2 [No] 2 [No] 1 [Sí]
## # ... with 1,806 more rows, and 2 more variables: o6 <dbl+lbl>, ing_pc <dbl>
```

## 4. Las variantes de `mutate()`

Con lo que ya hemos revisado serán capaces de realizar un procesamiento completo y acabado de sus variables. Sin embargo, hay otras funciones hermanas de mutate() que les recomendamos en caso de querer agilizar procedimientos de procesamiento de datos.

### a) mutate_at()

Imaginemos que deseamos trabajar al mismo tiempo con todas nuestras variables cuyos valores son 1 == Si y 2 == No. En el caso de las variables `ocupacion` e `ife`, que son números etiquetados, podemos desear realizar esa recodificación al mismo tiempo (recordemos que, para recodificar números etiquetados como factores, primero debemos transformar esas variables en `numeric`). Empleando `mutate()`, lo haríamos de la siguiente manera 


```r
datos %>% 
  mutate(ocupacion = as.numeric(.$ocupacion),
         ife = as.numeric(.$ife)) %>% 
  mutate(ocupacion = car::recode(.$ocupacion, c("1 = 'Si'; 2 = 'No'"), as.factor = T),
         ife = car::recode(.$ife, c("1 = 'Si'; 2 = 'No'"), as.factor = T))
```

```
## # A tibble: 1,816 x 11
##           folio sexo    edad ocupacion   ytoth tot_per ife       o2     o3     o4
##           <dbl> <fct>  <dbl> <fct>       <dbl>   <dbl> <fct> <dbl+> <dbl+> <dbl+>
##  1 110110030201 Hombre    56 No         302083       2 Si    2 [No] 2 [No] 1 [Sí]
##  2 110110110101 Mujer     66 No         213838       1 Si    2 [No] 2 [No] 1 [Sí]
##  3 110110170101 Mujer     65 No         384907       1 Si    2 [No] 2 [No] 2 [No]
##  4 110110290701 Mujer     76 No        1478196       5 Si    2 [No] 2 [No] 1 [Sí]
##  5 110110310601 Mujer     27 No         434783       5 Si    2 [No] 2 [No] 1 [Sí]
##  6 110110402001 Mujer     35 No        1298426       5 Si    2 [No] 2 [No] 1 [Sí]
##  7 110110440501 Mujer     43 No         375509       4 Si    2 [No] 2 [No] 1 [Sí]
##  8 110110450401 Mujer     56 No        1317526       4 Si    2 [No] 2 [No] 1 [Sí]
##  9 110111021801 Mujer     64 No        1171840       5 Si    2 [No] 2 [No] 1 [Sí]
## 10 110111021801 Mujer     45 No        1171840       5 Si    2 [No] 2 [No] 1 [Sí]
## # ... with 1,806 more rows, and 1 more variable: o6 <dbl+lbl>
```

¿Un poco largo, no? `mutate_at()` nos permite realizar el mismo procedimiento de recodificación a ambas variables, lo cual hace posible un código más eficiente. Tenemos que incorporar dos argumentos: 

- `vars =` : indica qué variables vamos a trabajar. 
- `~()` : indica la función que aplicaremos a las variables especificadas en vars


```r
datos %>% 
  mutate_at(vars(ocupacion, ife), ~(as.numeric(.))) %>% 
  mutate_at(vars(ocupacion, ife), ~(car::recode(., c("1 = 'Si'; 2 = 'No'"), as.factor = T)))
```

```
## # A tibble: 1,816 x 11
##           folio sexo    edad ocupacion   ytoth tot_per ife       o2     o3     o4
##           <dbl> <fct>  <dbl> <fct>       <dbl>   <dbl> <fct> <dbl+> <dbl+> <dbl+>
##  1 110110030201 Hombre    56 No         302083       2 Si    2 [No] 2 [No] 1 [Sí]
##  2 110110110101 Mujer     66 No         213838       1 Si    2 [No] 2 [No] 1 [Sí]
##  3 110110170101 Mujer     65 No         384907       1 Si    2 [No] 2 [No] 2 [No]
##  4 110110290701 Mujer     76 No        1478196       5 Si    2 [No] 2 [No] 1 [Sí]
##  5 110110310601 Mujer     27 No         434783       5 Si    2 [No] 2 [No] 1 [Sí]
##  6 110110402001 Mujer     35 No        1298426       5 Si    2 [No] 2 [No] 1 [Sí]
##  7 110110440501 Mujer     43 No         375509       4 Si    2 [No] 2 [No] 1 [Sí]
##  8 110110450401 Mujer     56 No        1317526       4 Si    2 [No] 2 [No] 1 [Sí]
##  9 110111021801 Mujer     64 No        1171840       5 Si    2 [No] 2 [No] 1 [Sí]
## 10 110111021801 Mujer     45 No        1171840       5 Si    2 [No] 2 [No] 1 [Sí]
## # ... with 1,806 more rows, and 1 more variable: o6 <dbl+lbl>
```

¡Podemos intearctuar también con otras funciones que ya hemos utilizado, como `starts_with()`!

**Atención**: como pueden fijarse, utilizamos un punto (.) en el argumento donde usualmente iría esepcificada la variable que estamos trabajando. Tal punto indica **recursividad**, es decir, que la operación especificada en `~()` será ejecutada (en orden) a cada una de las variables que especificamos en `vars =`. 

### b) mutate_if()

También podemos utilizar `mutate()` a un conjunto de variables seleccionadas a partir de una condición. Por ejemplo, transformemos en `factor` con `forcats::as_factor()` a todas las variables que sean números etiquetados


```r
datos %>% 
  mutate_if(is.labelled, ~(forcats::as_factor(.)))
```

```
## # A tibble: 1,816 x 11
##         folio sexo   edad ocupacion  ytoth tot_per ife   o2    o3    o4    o6   
##         <dbl> <fct> <dbl> <fct>      <dbl>   <dbl> <fct> <fct> <fct> <fct> <fct>
##  1    1.10e11 Homb~    56 No        3.02e5       2 Sí    No    No    Sí    No   
##  2    1.10e11 Mujer    66 No        2.14e5       1 Sí    No    No    Sí    No   
##  3    1.10e11 Mujer    65 No        3.85e5       1 Sí    No    No    No    No   
##  4    1.10e11 Mujer    76 No        1.48e6       5 Sí    No    No    Sí    No   
##  5    1.10e11 Mujer    27 No        4.35e5       5 Sí    No    No    Sí    Sí   
##  6    1.10e11 Mujer    35 No        1.30e6       5 Sí    No    No    Sí    No   
##  7    1.10e11 Mujer    43 No        3.76e5       4 Sí    No    No    Sí    No   
##  8    1.10e11 Mujer    56 No        1.32e6       4 Sí    No    No    Sí    Sí   
##  9    1.10e11 Mujer    64 No        1.17e6       5 Sí    No    No    Sí    No   
## 10    1.10e11 Mujer    45 No        1.17e6       5 Sí    No    No    Sí    No   
## # ... with 1,806 more rows
```

### c) mutate_all()

Por último, puede suceder que queramos emplear el mismo procedimiento a **todas las variables** incluidas en nuestros datos. Por ejemplo, supongamos que (por algún motivo) deseamos transformar todas las variables en `character`


```r
datos %>% 
  mutate_all(~(as.character(.)))
```

```
## # A tibble: 1,816 x 11
##    folio      sexo  edad  ocupacion ytoth  tot_per ife   o2    o3    o4    o6   
##    <chr>      <chr> <chr> <chr>     <chr>  <chr>   <chr> <chr> <chr> <chr> <chr>
##  1 110110030~ Homb~ 56    2         302083 2       1     2     2     1     2    
##  2 110110110~ Mujer 66    2         213838 1       1     2     2     1     2    
##  3 110110170~ Mujer 65    2         384907 1       1     2     2     2     2    
##  4 110110290~ Mujer 76    2         14781~ 5       1     2     2     1     2    
##  5 110110310~ Mujer 27    2         434783 5       1     2     2     1     1    
##  6 110110402~ Mujer 35    2         12984~ 5       1     2     2     1     2    
##  7 110110440~ Mujer 43    2         375509 4       1     2     2     1     2    
##  8 110110450~ Mujer 56    2         13175~ 4       1     2     2     1     1    
##  9 110111021~ Mujer 64    2         11718~ 5       1     2     2     1     2    
## 10 110111021~ Mujer 45    2         11718~ 5       1     2     2     1     2    
## # ... with 1,806 more rows
```

Como podrán darse cuenta, en este caso no especificamos el argumento `vars =`, pues con `mutate_all()` estamos considerando a **todas las variables**. 

## 5. Resumen con procesamiento de las variables

Hasta ahora, solo hemos creado una base de datos que selecciona variables. Ahora nos resta incorporar en un nuevo objeto los cambios que nos parezcan relevantes para la base de datos procesada que utilizaremos en nuestros análisis. 

Como ya conocemos operadores que permiten concatenar procesos ( `%>%`  y `%$%`) este procedimiento será mucho más fácil. 


```r
datos %>% 
  mutate(sexo = car::recode(.$sexo, c('"Mujer"="Femenino";"Hombre"= "Masculino"'), 
              as.factor = T, # Transformar en factor
              levels = c("Masculino", "Femenino")),
         ife_d= ifelse(ife == 1 & sexo == 'Mujer', 1, 0),
         sexo_edad_tramo = case_when(sexo == "Masculino" & edad <=39 ~  "Hombre joven",
                                sexo == "Femenino" & edad <=39 ~  "Mujer joven",
                                sexo == 'Masculino' & (edad > 39 & edad <=59) ~ "Hombre adulto",
                                sexo == 'Femenino' & (edad > 39 & edad <=59) ~ "Mujer adulta",
                                sexo == 'Masculino' & edad > 59 ~ "Adulto mayor",
                                sexo == 'Femenino' & edad > 59 ~ "Adulta mayor",
                                TRUE ~ NA_character_)) %>% 
  mutate_if(is.labelled, ~(forcats::as_factor(.))) %>% 
  rowwise() %>% 
  mutate(ing_pc = ytoth/tot_per) %>%  
  ungroup() 
```

```
## # A tibble: 1,816 x 14
##        folio sexo    edad ocupacion  ytoth tot_per ife   o2    o3    o4    o6   
##        <dbl> <fct>  <dbl> <fct>      <dbl>   <dbl> <fct> <fct> <fct> <fct> <fct>
##  1   1.10e11 Mascu~    56 No        3.02e5       2 Sí    No    No    Sí    No   
##  2   1.10e11 Femen~    66 No        2.14e5       1 Sí    No    No    Sí    No   
##  3   1.10e11 Femen~    65 No        3.85e5       1 Sí    No    No    No    No   
##  4   1.10e11 Femen~    76 No        1.48e6       5 Sí    No    No    Sí    No   
##  5   1.10e11 Femen~    27 No        4.35e5       5 Sí    No    No    Sí    Sí   
##  6   1.10e11 Femen~    35 No        1.30e6       5 Sí    No    No    Sí    No   
##  7   1.10e11 Femen~    43 No        3.76e5       4 Sí    No    No    Sí    No   
##  8   1.10e11 Femen~    56 No        1.32e6       4 Sí    No    No    Sí    Sí   
##  9   1.10e11 Femen~    64 No        1.17e6       5 Sí    No    No    Sí    No   
## 10   1.10e11 Femen~    45 No        1.17e6       5 Sí    No    No    Sí    No   
## # ... with 1,806 more rows, and 3 more variables: ife_d <dbl>,
## #   sexo_edad_tramo <chr>, ing_pc <dbl>
```

¡Ahora que estamos seguras/os sobre-escribimos la base!

```r
datos_proc <- datos %>% 
  mutate(sexo = car::recode(.$sexo, c('"Mujer"="Femenino";"Hombre"= "Masculino"'), 
              as.factor = T, # Transformar en factor
              levels = c("Masculino", "Femenino")),
         ife_d= ifelse(ife == 1 & sexo == 'Mujer', 1, 0),
         sexo_edad_tramo = case_when(sexo == "Masculino" & edad <=39 ~  "Hombre joven",
                                sexo == "Femenino" & edad <=39 ~  "Mujer joven",
                                sexo == 'Masculino' & (edad > 39 & edad <=59) ~ "Hombre adulto",
                                sexo == 'Femenino' & (edad > 39 & edad <=59) ~ "Mujer adulta",
                                sexo == 'Masculino' & edad > 59 ~ "Adulto mayor",
                                sexo == 'Femenino' & edad > 59 ~ "Adulta mayor",
                                TRUE ~ NA_character_)) %>% 
  mutate_if(is.labelled, ~(forcats::as_factor(.))) %>% 
  rowwise() %>% 
  mutate(ing_pc = ytoth/tot_per) %>%  
  ungroup() 
```

Podemos visualizar la base resultante a partir de `view_df()` de `sjPlot`

```r
sjPlot::view_df(datos)
```

```
## Registered S3 methods overwritten by 'parameters':
##   method                           from      
##   as.double.parameters_kurtosis    datawizard
##   as.double.parameters_skewness    datawizard
##   as.double.parameters_smoothness  datawizard
##   as.numeric.parameters_kurtosis   datawizard
##   as.numeric.parameters_skewness   datawizard
##   as.numeric.parameters_smoothness datawizard
##   print.parameters_distribution    datawizard
##   print.parameters_kurtosis        datawizard
##   print.parameters_skewness        datawizard
##   summary.parameters_kurtosis      datawizard
##   summary.parameters_skewness      datawizard
```

```
## Warning in sprintf("%i", as.integer(range(x[[index]], na.rm = T))): NAs
## introduced by coercion to integer range
```

<table style="border-collapse:collapse; border:none;">
<caption>Data frame: datos</caption>
<tr>
<th style="border-bottom:double; font-style:italic; font-weight:normal; padding:0.2cm; text-align:left; vertical-align:top;">ID</th><th style="border-bottom:double; font-style:italic; font-weight:normal; padding:0.2cm; text-align:left; vertical-align:top;">Name</th><th style="border-bottom:double; font-style:italic; font-weight:normal; padding:0.2cm; text-align:left; vertical-align:top;">Label</th><th style="border-bottom:double; font-style:italic; font-weight:normal; padding:0.2cm; text-align:left; vertical-align:top;">Values</th><th style="border-bottom:double; font-style:italic; font-weight:normal; padding:0.2cm; text-align:left; vertical-align:top;">Value Labels</th>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">1</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">folio</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">IdentificaciÃ³n hogar (comuna area seg viv hogar)</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;" colspan="2"><em>range: NA-NA</em></td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">2</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">sexo</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">Sexo</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee"></td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">Hombre<br>Mujer</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">3</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">edad</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">Edad</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;" colspan="2"><em>range: 18-98</em></td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">4</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">ocupacion</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">o1. La semana pasada, Â¿trabajÃ³ al menos una hora?</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">1<br>2</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">SÃ­<br>No</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">5</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">ytoth</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">Ingreso total del hogar</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;" colspan="2"><em>range: 0-8332378</em></td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">6</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">tot_per</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">Total de personas en el hogar</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee" colspan="2"><em>range: 1-6</em></td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">7</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">ife</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">y26d_hog. Ãšltimos 12 meses, Â¿alguien recibiÃ³<br>Ingreso Familiar de Emergencia?</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">1<br>2<br>9</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">SÃ­<br>No<br>No sabe</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">8</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">o2</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">o2. Aunque no trabajÃ³ la semana pasada, Â¿realizÃ³<br>alguna actividad?</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">1<br>2</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">SÃ­<br>No</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">9</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">o3</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">o3. Aunque no trabajÃ³, Â¿tenÃ­a algÃºn empleo del<br>cual estuvo ausente temporalmente</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">1<br>2</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">SÃ­<br>No</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">10</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">o4</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">o4. Â¿Ha trabajado alguna vez?</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">1<br>2</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">SÃ­<br>No</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">11</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">o6</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">o6. Â¿BuscÃ³ trabajo remunerado o cuenta propia en<br>las Ãºltimas cuatro semanas?</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">1<br>2</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">SÃ­<br>No</td>
</tr>

</table>

## 6. Guardar base procesada

Para guardar la base de datos procesada, debes dirigir la ruta hacia tu Rproject


```r
saveRDS(datos_proc, file = "output/datos_proc.rds")
```

# Resumen

En este práctico aprendimos a 

1. Utilizar la función `mutate()` de `dplyr` (¡y sus variantes!)
1. Construir variables condicionales con `ifelse()` y `case_when()`
1. Construir índices agrupando por filas con `rowwise()`
