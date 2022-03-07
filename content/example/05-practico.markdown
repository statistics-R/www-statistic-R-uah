---
title: "Tidydata y manipulación de datos"
linktitle: "5: Tidydata y manipulación de datos"
date: "2021-08-13"
menu:
  example:
    parent: Ejemplos
    weight: 5
type: docs
toc: true
editor_options: 
  chunk_output_type: console
---



## 0. Objetivo del práctico

El objetivo del presente práctico es aprender a manipular datos, en particular, agrupar datos según alguna(s) columna(s) o filas en particular,  pivotando sets de datos, y uniendo y/o separando datos. 

## 1. Recursos de la práctica

Los datos a utilizar provienen de la [Encuesta Suplementaria de Ingresos (ESI) en su versión 2020](https://www.ine.cl/estadisticas/sociales/ingresos-y-gastos/encuesta-suplementaria-de-ingresos), módulo de la Encuesta Nacional de Empleo (ENE), levantada una vez al año para caracterizar los ingresos laborales de quienes son clasificadas/os como ocupadas/os en la ENE, y otras fuentes de ingresos de los hogares. No olvides que, cuando trabajes con datos, debes revisar la **documentación anexa**, como el [**libro de códigos**](https://www.ine.cl/docs/default-source/encuesta-suplementaria-de-ingresos/bbdd/manual-y-guía-de-variables/2020/personas-esi-2020.pdf?sfvrsn=f196cb4e_4).

## 2. Librerías a utilizar

En este práctico utilizaremos las siguientes librerías

1. `pacman`: este facilita y agiliza la lectura de los paquetes a utilizar en R

2. `tidyverse`: colección de librerías, de la cual utilizaremos `tidyr`, `haven` y `dplyr`

3. `tidyr`: permite pivotear los set de datos con los cuales estamos trabajando

4. `dplyr`: para manipular datos

5. `sjmisc`: para explorar datos


# Procesamiento de datos

## 1. Cargar librerías

Lo primero es _cargar las librerías_ a utilizar. Para ello, acudimos a la función `p_load` del paquete `pacman`. Asumimos que ya está instalado, así que sólo lo cargaremos con la función `library()`


```r
library(pacman)
```

```
## Warning: package 'pacman' was built under R version 4.1.2
```

```r
pacman::p_load(tidyverse, #Universo de librerías para manipular datos
               tidyr, #Para pivotear la estructura de los datos
               dplyr,#Para manipular datos 
               sjmisc)#Para explorar datos
```

## 2. Importar bases de datos

Cargaremos los datos 


```r
datos <- readRDS(gzcon(url("https://github.com/learn-R/05-class/blob/main/input/data/ESI2020.rds?raw=true")))
```

En el panel **Environment**, visualizamos los nuevos objetos, que poseen 18.985 observaciones (o filas) y 9 variables (columnas).

## 3. Explorar datos

A continuación, utilizaremos la función `View()` del paquete `base`, para revisar el set de datos.  



Ocupamos, además, la función `frq()` de la librería `sjmisc`, para explorar las categorías de las variables de clase factor:


```r
frq(datos$sector)
```

```
## 
## x <categorical>
## # total N=18985  valid N=18985  mean=1.12  sd=0.44
## 
## Value                    |     N | Raw % | Valid % | Cum. %
## -----------------------------------------------------------
## Sector formal            | 17576 | 92.58 |   92.58 |  92.58
## Sector informal          |   593 |  3.12 |    3.12 |  95.70
## Hogares como empleadores |   816 |  4.30 |    4.30 | 100.00
## <NA>                     |     0 |  0.00 |    <NA> |   <NA>
```

```r
frq(datos$sexo)
```

```
## 
## x <categorical>
## # total N=18985  valid N=18985  mean=1.43  sd=0.50
## 
## Value  |     N | Raw % | Valid % | Cum. %
## -----------------------------------------
## Hombre | 10810 | 56.94 |   56.94 |  56.94
## Mujer  |  8175 | 43.06 |   43.06 | 100.00
## <NA>   |     0 |  0.00 |    <NA> |   <NA>
```

```r
frq(datos$prevision)
```

```
## 
## x <categorical>
## # total N=18985  valid N=18985  mean=1.14  sd=0.34
## 
## Value |     N | Raw % | Valid % | Cum. %
## ----------------------------------------
## Si    | 16366 | 86.20 |   86.20 |  86.20
## No    |  2619 | 13.80 |   13.80 | 100.00
## <NA>  |     0 |  0.00 |    <NA> |   <NA>
```

```r
frq(datos$salud)
```

```
## 
## x <categorical>
## # total N=18985  valid N=18985  mean=1.12  sd=0.32
## 
## Value |     N | Raw % | Valid % | Cum. %
## ----------------------------------------
## Si    | 16761 | 88.29 |   88.29 |  88.29
## No    |  2224 | 11.71 |   11.71 | 100.00
## <NA>  |     0 |  0.00 |    <NA> |   <NA>
```

```r
frq(datos$contrato_dur)
```

```
## 
## x <categorical>
## # total N=18985  valid N=18985  mean=1.72  sd=0.45
## 
## Value      |     N | Raw % | Valid % | Cum. %
## ---------------------------------------------
## Definido   |  5263 | 27.72 |   27.72 |  27.72
## Indefinido | 13722 | 72.28 |   72.28 | 100.00
## <NA>       |     0 |  0.00 |    <NA> |   <NA>
```

Podemos darnos cuenta de que la variable `sector` provee información sobre el _sector donde se encuentra ocupado/a el/la trabajador/a_; la variable `sexo` indica el _sexo de las y los trabajadores_; las columnas `prevision` y `salud` proveen información sobre _si el/la empleador/a paga cotizaciones relativas a los sistemas previsional y de salud_ a las y los trabajadores; y la variable `contrato_dur` provee información sobre la _duración del contrato_ de las y los trabajadores. 

Ahora exploremos las variables numéricas con `descr()` de `sjmisc`


```r
descr(datos$ss_t) #Ingresos por sueldo y salarios netos
```

```
## 
## ## Basic descriptive statistics
## 
##  var    type label     n NA.prc     mean       sd      se       md  trimmed
##   dd numeric    dd 18985      0 567520.6 585556.6 4249.75 400526.4 469716.4
##            range      iqr skew
##  9e+06 (0-9e+06) 401607.8 3.57
```

```r
descr(datos$svar_t) #Ingresos por sueldos y salarios variables
```

```
## 
## ## Basic descriptive statistics
## 
##  var    type label     n NA.prc     mean       sd     se md trimmed
##   dd numeric    dd 18985      0 13730.59 78880.74 572.49  0  816.25
##                      range iqr  skew
##  5006580.18 (0-5006580.18)   0 22.33
```

```r
descr(datos$reg_t) #Total ingresos por regalías (beneficios entregados por el empleador)
```

```
## 
## ## Basic descriptive statistics
## 
##  var    type label     n NA.prc    mean       sd     se md trimmed
##   dd numeric    dd 18985      0 8392.62 38868.17 282.09  0       0
##                      range iqr skew
##  1071408.16 (0-1071408.16)   0 9.44
```

Estas variables proveen información sobre _Ingresos por sueldo y salarios netos_ (`ss_t`); _Ingresos por sueldos y salarios variables_ (`svar_t`); y respecto a _Total ingresos por regalías (beneficios entregados por el empleador)_ (`reg_t`).

## 4. Agrupar por filas con `rowwise()`

Como sabemos, la librería `dplyr` de `tidyverse` provee diversas herramientas que nos permiten manipular los datos con los cuales nos encontramos trabajando. Una de ellas es su función `rowwise()`, que posibilita **agrupar los datos en razón de las filas**. Esto es particularmente útil cuando, por ejemplo, queremos construir algún índice. En este caso, utilizaremos las diversas variables de ingresos para construir la variable `ing_tot`, que incluirá los ingresos totales percibidos por las y los trabajadores, en razón de sus sueldos y salarios netos; sus sueldos y salarios variables; y por las regalías entregadas por parte de las y los empleadores. 


```r
datos <- datos %>% #Especificamos que trabajaremos con el dataframe datos
  rowwise() %>% #Especificamos que agruparemos por filas
  mutate(ing_tot = sum(ss_t, svar_t, reg_t)) #Creamos una nueva variable llamada ing_tot, sumando los valores de ss_t, svar_t y reg_t para cada fila 
head(datos)
```

```
## # A tibble: 6 x 10
## # Rowwise: 
##   sector   sexo  prevision salud contrato_dur   ss_t svar_t reg_t     id ing_tot
##   <fct>    <fct> <fct>     <fct> <fct>         <dbl>  <dbl> <dbl>  <dbl>   <dbl>
## 1 Sector ~ Mujer Si        Si    Indefinido   3.20e5      0     0  20256 320421.
## 2 Sector ~ Mujer Si        Si    Definido     7.5 e5      0     0  24592 750000 
## 3 Sector ~ Mujer Si        Si    Indefinido   9   e5      0     0  35136 900000 
## 4 Hogares~ Mujer No        No    Indefinido   3.02e5      0     0 235953 302042.
## 5 Sector ~ Homb~ Si        Si    Indefinido   9   e5      0     0 251187 900000 
## 6 Sector ~ Homb~ Si        Si    Indefinido   0           0     0 318992      0
```

Como vemos, ahora el set de datos pasó de tener 8 a 10 variables (columnas). Sin embargo, la cantidad de filas se mantiene constante, con un total de 18.985.

Sin embargo, como ya no utilizaremos `ss_t`, `svar_t` ni `reg_t` por separado, las des-seleccionaremos con `select()` de `dplyr`


```r
datos <- datos %>% 
  select(-c(ss_t, svar_t, reg_t))
head(datos)
```

```
## # A tibble: 6 x 7
## # Rowwise: 
##   sector                   sexo   prevision salud contrato_dur     id ing_tot
##   <fct>                    <fct>  <fct>     <fct> <fct>         <dbl>   <dbl>
## 1 Sector formal            Mujer  Si        Si    Indefinido    20256 320421.
## 2 Sector formal            Mujer  Si        Si    Definido      24592 750000 
## 3 Sector formal            Mujer  Si        Si    Indefinido    35136 900000 
## 4 Hogares como empleadores Mujer  No        No    Indefinido   235953 302042.
## 5 Sector formal            Hombre Si        Si    Indefinido   251187 900000 
## 6 Sector formal            Hombre Si        Si    Indefinido   318992      0
```


## 5. Agrupar por columnas con `group_by()`

Otra de las funciones de `dplyr` que nos permiten manipular los datos es `group_by`. En este caso, en lugar de agrupar los valores por filas, podremos hacerlo en razón de las **columnas**. Calculemos ahora la media de `ing_tot` con la función `mean()`, agrupando por `sexo`:


```r
datos %>% 
  group_by(sexo) %>% #Espeficicamos que agruparemos por sexo
  summarise(media = mean(ing_tot)) #Creamos una columna llamada media, calculando la media ingresos con la función `mean`
```

```
## # A tibble: 2 x 2
##   sexo     media
##   <fct>    <dbl>
## 1 Hombre 630757.
## 2 Mujer  535278.
```

Es importante destacar que la función `summarise()` (o `summarize()`) de `dplyr` nos permite crear un nuevo data frame con una o más filas para cada combinación y agrupación de variables. En este caso, tenemos dos filas: una para Hombre, y otra para Mujer. En caso de no agrupar variables, sólo tendremos una columna que **resuma** las observaciones especificadas. 

Algo interesante es que podemos combinar `group_by()` con algunas funciones de `sjmisc`. Probemos calculando la frecuencia de hombres y mujeres agrupando por cada sector:


```r
datos %>% 
  group_by(sector) %>% 
  frq(sexo)
```

```
## 
## sexo <categorical>
## # grouped by: Sector formal
## # total N=17576  valid N=17576  mean=1.42  sd=0.49
## 
## Value  |     N | Raw % | Valid % | Cum. %
## -----------------------------------------
## Hombre | 10212 | 58.10 |   58.10 |  58.10
## Mujer  |  7364 | 41.90 |   41.90 | 100.00
## <NA>   |     0 |  0.00 |    <NA> |   <NA>
## 
## 
## sexo <categorical>
## # grouped by: Sector informal
## # total N=593  valid N=593  mean=1.17  sd=0.37
## 
## Value  |   N | Raw % | Valid % | Cum. %
## ---------------------------------------
## Hombre | 493 | 83.14 |   83.14 |  83.14
## Mujer  | 100 | 16.86 |   16.86 | 100.00
## <NA>   |   0 |  0.00 |    <NA> |   <NA>
## 
## 
## sexo <categorical>
## # grouped by: Hogares como empleadores
## # total N=816  valid N=816  mean=1.87  sd=0.34
## 
## Value  |   N | Raw % | Valid % | Cum. %
## ---------------------------------------
## Hombre | 105 | 12.87 |   12.87 |  12.87
## Mujer  | 711 | 87.13 |   87.13 | 100.00
## <NA>   |   0 |  0.00 |    <NA> |   <NA>
```

Obtendremos una tabla por cada una de las categorías de la variable por la cual agrupamos (en este caso, una por cada sector), que señala las frecuencias absolutas y relativas de cada sexo para cada sector. Por supuesto, también podemos hacer el mismo ejercicio con `descr()`. Probemos haciendo un análisis descriptivos de ingresos para cada sexo:


```r
datos %>% 
  group_by(sexo) %>% 
  descr(ing_tot)
```

```
## 
## ## Basic descriptive statistics
## 
## 
## Grouped by: Hombre
## 
##      var    type   label     n NA.prc     mean       sd      se       md
##  ing_tot numeric ing_tot 10810      0 630757.4 665519.9 6401.01 448028.4
##   trimmed                     range    iqr skew
##  515273.1 9312239.14 (0-9312239.14) 419636 3.63
## 
## 
## Grouped by: Mujer
## 
##      var    type   label    n NA.prc     mean       sd      se    md  trimmed
##  ing_tot numeric ing_tot 8175      0 535278.2 512300.3 5666.05 4e+05 455651.4
##                      range      iqr skew
##  6208159.43 (0-6208159.43) 407377.7 3.12
```

En este caso, obtenemos dos tablas: una por cada `sexo`, cada una indicando las estadísticas de resumen para la variable `ing_tot`

## 6. Manipulación de datos (tidydata)

Otra de las librerías de `tidyverse` que resulta de gran utilidad es `tidyr`. En este caso, cada una de las filas de nuestros datos indican a un sujeto (el cual constituye la unidad de análisis). Las funciones `pivot_longer()` y `pivot_wider()` de la librería anteriormente señalada nos permitirán pivotear los datos, para transformarlos a un dataframe de formato **long** (largo) o **wide** (ancho), respectivamente. 

### a) `pivot_longer()`

Como ya se señaló, `pivot_longer()`nos permitirá pivotear los datos de manera tal que estos se transformen a un tabulado en formato **long**. Ello implica que el tabulado tendrá un mayor número de observaciones, reduciendo su cantidad de columnas. En este caso, pivotearemos todas las columnas salvo `sector`, lo cual significa que tales columnas se subsumirán en una sola (en este caso, llamada "variable"), y sus respectivos valores en otra (en este caso, llamada "value"). Luego, la unidad de análisis pasará, de ser sujetos, a ser las variables. Para ello usamos el siguiente código:


```r
long <- datos %>% #Creamos un nuevo objeto a partir de datos
  select(-ing_tot) %>%  #Des-seleccionamos la variable ing_tot, pues es de class numeric
  pivot_longer(cols=-c(1, id), #Pivoteamos a lo largo todas las columnas salvo la primera (sector) 
               names_to = "variable", #Especificamos que la columna "variable" incluirá los nombres de cada una de las columnas pivoteadas
               values_to = "value") #Especificamos que la columna "value" incluirá los valores de cada una de las columnas pivoteadas
head(long)
```

```
## # A tibble: 6 x 4
##   sector           id variable     value     
##   <fct>         <dbl> <chr>        <fct>     
## 1 Sector formal 20256 sexo         Mujer     
## 2 Sector formal 20256 prevision    Si        
## 3 Sector formal 20256 salud        Si        
## 4 Sector formal 20256 contrato_dur Indefinido
## 5 Sector formal 24592 sexo         Mujer     
## 6 Sector formal 24592 prevision    Si
```

Podemos darnos cuenta de que ahora nuestro set de datos sólo contiene 4 columnas, pero 75.940 filas. Podemos darnos cuenta que ahora, cada cuatro columnas, tenemos a un sujeto de la muestra. 

### b) `pivot_wider`

Asimismo, las tablas largas (long) pueden ser transformadas a tablas anchas (wide) con la función `pivot_wider()`, lo cual implica que nuestra tabla reducirá su cantidad de filas y aumentará su número de columnas. Para ello, sólo debemos especificar desde dónde extraeremos los nombres y los valores asociados a las nuevas columnas: 


```r
wide <- long %>% #Creamos un nuevo objeto a partir de los datos de long 
  pivot_wider(names_from = "variable", #Pivoteamos, tomando el nombre de las columnas desde la columna "variable"
              values_from = "value") 
head(wide)
```

```
## # A tibble: 6 x 6
##   sector                       id sexo   prevision salud contrato_dur
##   <fct>                     <dbl> <fct>  <fct>     <fct> <fct>       
## 1 Sector formal             20256 Mujer  Si        Si    Indefinido  
## 2 Sector formal             24592 Mujer  Si        Si    Definido    
## 3 Sector formal             35136 Mujer  Si        Si    Indefinido  
## 4 Hogares como empleadores 235953 Mujer  No        No    Indefinido  
## 5 Sector formal            251187 Hombre Si        Si    Indefinido  
## 6 Sector formal            318992 Hombre Si        Si    Indefinido
```

Los datos se "ensancharon", pasando a tener 18.985 filas y 6 columnas. 

## 7. `separate()`

La función `separate()` de `tidyr` nos permite convertir un character individual de una columna en múltiples columnas. En este caso, crearemos una nueva variable `sobre_prom`, que nos indicará si los ingresos de los sujetos están por sobre o por debajo de la media de ingresos. Luego, separaremos la primera y la segunda palabra (caracteres) de cada unos de los valores en dos columnas distintas.


```r
separate <- datos %>% #Creamos un nuevo objeto desde datos
  mutate(sobre_prom = case_when(ing_tot <= mean(ing_tot) ~ "Bajo media", 
                                ing_tot > mean(ing_tot) ~ "Sobre media")) %>% #Creamos una variable condicional con case_when(), para identificar quienes estan bajo y sobre la media de ingreso
  separate(sobre_prom, #Especificamos la columna que queremos separar
           into = c("sobre_o_bajo", "media")) #Especificamos en cuántas columnas queremos separar los characteres, y cómo se llamarán tales columnas
head(separate)
```

```
## # A tibble: 6 x 9
##   sector    sexo  prevision salud contrato_dur     id ing_tot sobre_o_bajo media
##   <fct>     <fct> <fct>     <fct> <fct>         <dbl>   <dbl> <chr>        <chr>
## 1 Sector f~ Mujer Si        Si    Indefinido    20256 320421. Bajo         media
## 2 Sector f~ Mujer Si        Si    Definido      24592 750000  Bajo         media
## 3 Sector f~ Mujer Si        Si    Indefinido    35136 900000  Bajo         media
## 4 Hogares ~ Mujer No        No    Indefinido   235953 302042. Bajo         media
## 5 Sector f~ Homb~ Si        Si    Indefinido   251187 900000  Bajo         media
## 6 Sector f~ Homb~ Si        Si    Indefinido   318992      0  Bajo         media
```

## 8. `unite()`

También podemos unir caracteres de columnas distintas, con la función `unite()` de `tidyr`. En este caso, volveremos a unir las columnas ¿Sobre o bajo? y Media en una sola, llamada sobre_prom. Por defecto, `unite()` une los caracteres con guiones bajos (_). Podemos especificar un nuevo separador con el argumento `sep`. En este caso, el separador será un espacio (" ")


```r
separate <- separate %>% #Modificamos el objeto separate
  unite(col = sobre_media, #Unimos en una nueva columna llamada sobre_media
        sobre_o_bajo:media, #Especificamos las columnas que deseamos unir
        sep = " ") #Especificamos el separador
head(separate)
```

```
## # A tibble: 6 x 8
##   sector           sexo  prevision salud contrato_dur     id ing_tot sobre_media
##   <fct>            <fct> <fct>     <fct> <fct>         <dbl>   <dbl> <chr>      
## 1 Sector formal    Mujer Si        Si    Indefinido    20256 320421. Bajo media 
## 2 Sector formal    Mujer Si        Si    Definido      24592 750000  Bajo media 
## 3 Sector formal    Mujer Si        Si    Indefinido    35136 900000  Bajo media 
## 4 Hogares como em~ Mujer No        No    Indefinido   235953 302042. Bajo media 
## 5 Sector formal    Homb~ Si        Si    Indefinido   251187 900000  Bajo media 
## 6 Sector formal    Homb~ Si        Si    Indefinido   318992      0  Bajo media
```

## 9. Unir datos 

Otra de las herramientas fundamentales a la hora de trabajar con la estructura de los datos es unir dos tabulados distintos con los cuales estemos trabajando. 

### a) `merge`

Una de las funciones más utilizadas para ello es `merge` del paquete `base` de R. Esta nos permite unir dos tabulados (data frames) que compartan una columna, y que tengan la misma cantidad de filas. 


```r
esi2020_m <- readRDS(gzcon(url("https://github.com/learn-R/05-class/blob/main/input/data/ESI2020m.rds?raw=true"))) #Cargamos los datos que deseamos unir
datos_unidos <- merge(x = datos, #Unimos el dataframe datos
      y = esi2020_m, #con el dataframe esi2020_m
      by = c("sexo", "ing_tot")) #a partir de las columnas "sexo" e "ing_tot"
head(datos_unidos)
```

```
##     sexo ing_tot        sector prevision salud contrato_dur        id efectivas
## 1 Hombre       0 Sector formal        Si    Si   Indefinido 346362449        21
## 2 Hombre       0 Sector formal        Si    Si   Indefinido 346362449        40
## 3 Hombre       0 Sector formal        Si    Si   Indefinido 346362449         0
## 4 Hombre       0 Sector formal        Si    Si   Indefinido 346362449        45
## 5 Hombre       0 Sector formal        Si    Si   Indefinido 346362449        45
## 6 Hombre       0 Sector formal        Si    Si   Indefinido 346362449        45
```

Podemos ver que ahora el tabulado `datos` tiene 7 columnas el lugar de 6, pues se incorporó la columna `efectivas`, que estaba presente en `esi2020_m`, pero no en `datos`.

### b) `bind_cols()`

Otra cosa que podemos hacer es, simplemente, pegar una columna de un dataframe a otro. Para ello recurrimos a la función `bind_cols()` de `dplyr`:


```r
a <- select(datos, 1:5) # Seleccionamos las primeras cinco columnas de datos
b <- select(datos, 3:7) # Seleccionamos las últimas cinco columnas de datos
col_un <- bind_cols(a, b) #Unimos ambos dataframes a partir de sus columnas
```

```
## New names:
## * prevision -> prevision...3
## * salud -> salud...4
## * contrato_dur -> contrato_dur...5
## * prevision -> prevision...6
## * salud -> salud...7
## * ...
```

```r
head(col_un)
```

```
## # A tibble: 6 x 10
## # Rowwise: 
##   sector  sexo  prevision...3 salud...4 contrato_dur...5 prevision...6 salud...7
##   <fct>   <fct> <fct>         <fct>     <fct>            <fct>         <fct>    
## 1 Sector~ Mujer Si            Si        Indefinido       Si            Si       
## 2 Sector~ Mujer Si            Si        Definido         Si            Si       
## 3 Sector~ Mujer Si            Si        Indefinido       Si            Si       
## 4 Hogare~ Mujer No            No        Indefinido       No            No       
## 5 Sector~ Homb~ Si            Si        Indefinido       Si            Si       
## 6 Sector~ Homb~ Si            Si        Indefinido       Si            Si       
## # ... with 3 more variables: contrato_dur...8 <fct>, id <dbl>, ing_tot <dbl>
```

Vemos que simplemente pegó  `a` y `b`. Eso implica que tenemos columnas repetidas. Cuando estemos seguras/os de que hay columnas repetidas entre dos dataframes que queramos unir, emplearemos `merge()` mientras que, si estos no comparten ninguna columna, recurrimos a `bing_cols()`

### c) `bind_rows()`

También podemos unir dos dataframes a partir de sus filas, con la función `bind_rows()` de `dplyr`


```r
a <- a[1:10000,] # Seleccionamos las primeras 10.000 filas de a
b <- b[10001:18985,] # Seleccionamos las últimas 8.985 filas de b
row_un <- bind_rows(a, b)
head(row_un)
```

```
## # A tibble: 6 x 7
## # Rowwise: 
##   sector                   sexo   prevision salud contrato_dur    id ing_tot
##   <fct>                    <fct>  <fct>     <fct> <fct>        <dbl>   <dbl>
## 1 Sector formal            Mujer  Si        Si    Indefinido      NA      NA
## 2 Sector formal            Mujer  Si        Si    Definido        NA      NA
## 3 Sector formal            Mujer  Si        Si    Indefinido      NA      NA
## 4 Hogares como empleadores Mujer  No        No    Indefinido      NA      NA
## 5 Sector formal            Hombre Si        Si    Indefinido      NA      NA
## 6 Sector formal            Hombre Si        Si    Indefinido      NA      NA
```

`bind_rows()` nos permite pegar filas, independientemente si ambos dataframes comparten las mismas columnas. En caso de que ambos dataframes no compartan alguna columna, esta función rellenará con valores nulos (`NA`)

# Resumen

En este práctico aprendimos a

1. Agrupar datos por filas y columnas.
2. Manipular datos (tidydata), transformando la estructura de estos a una ancha o larga. 
3. Separar y unir caracteres de una columna.
4. Unir datos, a partir de filas y columnas. 

# Reporte de progreso

¡No olviden llenar el [reporte de progreso](https://learn-r.formr.org)! En tu correo electrónico está disponible el código mediante al cuál debes acceder para actualizar tu estado de avance del curso.


