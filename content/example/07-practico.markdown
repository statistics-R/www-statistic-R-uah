---
title: "Análisis descriptivo univariado"
linktitle: "7: Análisis descriptivo univariado"
date: "2021-09-13"
menu:
  example:
    parent: Ejemplos
    weight: 7
type: docs
toc: true
editor_options: 
  chunk_output_type: console
---

#  0. Objetivo del práctico

El objetivo del práctico es avanzar en el análisis de los datos a través del uso de **estadísticos descriptivos**. Para esto ya debemos contar con datos previamente [procesados del práctico N°6](https://learn-r-uah.netlify.app/example/04-practico/). Previo a eso, **siempre es importante** que recordemos en qué parte del proceso estamos

![](https://github.com/learn-R/slides/raw/main/img/01/flow-rproject.png)


En este práctico veremos tanto la _estimación puntual_ de estadísticos descriptivos, como su _visualización_ para reportes, ya sea a través de tablas o de gráficos. 


##  Recursos del práctico

En este práctico utilizamos los **datos** procesados *CASEN 2020*, que proviene de los datos originales de la [**Encuesta de Caracterización Socioeconómica (CASEN)**](http://observatorio.ministeriodesarrollosocial.gob.cl/encuesta-casen-en-pandemia-2020). Recuerden _**siempre**_ consultar el [**libro códigos**](http://observatorio.ministeriodesarrollosocial.gob.cl/storage/docs/casen/2020/Libro_de_codigos_Base_de_Datos_Casen_en_Pandemia_2020.pdf) antes de trabajar datos.

No olviden que los archivos asociados a este práctico se pueden descargar aquí:

- [<i class="fas fa-file-archive"></i> `06-class.zip`](https://github.com/learn-R/06-class/raw/main/06-clase.zip)

#  1. Paquetes a utilizar

Para este práctico utilizaremos, principalmente, las librerías `sjmisc` y `sjPlot`. 

`sjmisc`: esta paquete tiene múltiples funciones, desde la transformación de datos y variables. Este paquete suele complementar a `dplyr` de `tidyverse` en sus funciones. 

`sjPlot`: su principal función es la visualización de datos para estadística en ciencias sociales mediante tablas y gráficos.

Cargaremos los paquetes con `pacman`, si aún tienes dudas sobre cómo trabajar con `pacman` puedes [revisar el práctico 2](https://learn-r-uah.netlify.app/example/02-practico/#paso-1-instalaci%C3%B3n-de-paquetes)


```r
pacman::p_load(sjmisc,
               sjPlot,
               tidyverse,
               magrittr)
```

#  2. Importar datos

Una vez cargados los paquetes a utilizar, debemos continuar cargar los datos. Como indicamos al inicio, seguiremos utilizando los datos **CASEN** que fueron procesados en el práctico anterior, pero incorporando una nueva variable.




```r
load("output/data/datos_proc.RData")
```

#  3. Explorar datos

Pero ¿cómo sabremos cuales son las nuevas variables que componen la base de datos procesada?, ¡Simple! usaremos dos códigos que vimos en el [práctico 4](https://learn-r-uah.netlify.app/example/04-practico/#2-cargar-base-de-datos) para conocer los **datos procesados** que usaremos en esta ocasión:

Primero, usaremos el código `names`, que nos entrega los nombres de las variables que componen los datos


```r
names(datos_proc)
```

```
##  [1] "sexo"              "edad_tramo"        "ocupacion"        
##  [4] "o2"                "o3"                "o4"               
##  [7] "o6"                "ingreso_percapita" "ife"              
## [10] "horas_mens"
```

Mientras que la función `head` nos entrega el nombre y las primeras 10 filas que lo componen.


```r
head(datos_proc)
```

```
## # A tibble: 6 x 10
##         sexo edad_tramo ocupacion        o2        o3        o4      o6 ingreso_percapi~
##    <dbl+lbl> <chr>      <fct>     <dbl+lbl> <dbl+lbl> <dbl+lbl> <dbl+l>            <dbl>
## 1 2 [Mujer]  Joven      No           1 [Sí]   NA        NA      NA               195416.
## 2 1 [Hombre] Adulto     Sí          NA        NA        NA      NA               315861 
## 3 2 [Mujer]  Joven      No           1 [Sí]   NA        NA      NA               315861 
## 4 1 [Hombre] Adulto     Sí          NA        NA        NA      NA              1001389 
## 5 1 [Hombre] Joven      No           2 [No]    2 [No]    2 [No]  2 [No]         1001389 
## 6 2 [Mujer]  Adulto     No           2 [No]    2 [No]    1 [Sí]  2 [No]         1001389 
## # ... with 2 more variables: ife <dbl+lbl>, horas_mens <dbl>
```

Estos códigos nos permiten establecer una aproximación a los datos con los cuales trabajaremos, como los posibles valores que pueden adoptar, el tipo de dato para cada variable, entre otros. No obstante, por prácticos anteriores sabemos que podemos explorar nuestros datos con `sjPlot::view_df()`


```r
sjPlot::view_df(datos_proc,
                encoding = "UTF-8")
```

<table style="border-collapse:collapse; border:none;">
<caption>Data frame: datos_proc</caption>
<tr>
<th style="border-bottom:double; font-style:italic; font-weight:normal; padding:0.2cm; text-align:left; vertical-align:top;">ID</th><th style="border-bottom:double; font-style:italic; font-weight:normal; padding:0.2cm; text-align:left; vertical-align:top;">Name</th><th style="border-bottom:double; font-style:italic; font-weight:normal; padding:0.2cm; text-align:left; vertical-align:top;">Label</th><th style="border-bottom:double; font-style:italic; font-weight:normal; padding:0.2cm; text-align:left; vertical-align:top;">Values</th><th style="border-bottom:double; font-style:italic; font-weight:normal; padding:0.2cm; text-align:left; vertical-align:top;">Value Labels</th>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">1</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">sexo</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">Sexo</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">1<br>2</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">Hombre<br>Mujer</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">2</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">edad_tramo</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee"></td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee"></td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">&lt;output omitted&gt;</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">3</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">ocupacion</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">o1. La semana pasada, Â¿trabajÃ³ al menos una hora?</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;"></td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">SÃ­<br>No</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">4</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">o2</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">o2. Aunque no trabajÃ³ la semana pasada, Â¿realizÃ³<br>alguna actividad?</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">1<br>2</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">SÃ­<br>No</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">5</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">o3</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">o3. Aunque no trabajÃ³, Â¿tenÃ­a algÃºn empleo del<br>cual estuvo ausente temporalmente</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">1<br>2</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">SÃ­<br>No</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">6</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">o4</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">o4. Â¿Ha trabajado alguna vez?</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">1<br>2</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">SÃ­<br>No</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">7</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">o6</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">o6. Â¿BuscÃ³ trabajo remunerado o cuenta propia en<br>las Ãºltimas cuatro semanas?</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">1<br>2</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">SÃ­<br>No</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">8</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">ingreso_percapita</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">Ingreso total del hogar</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee" colspan="2"><em>range: 0.0-225200000.0</em></td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">9</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">ife</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">y26d_hog. Ãšltimos 12 meses, Â¿alguien recibiÃ³<br>Ingreso Familiar de Emergencia?</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">1<br>2<br>9</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top;">SÃ­<br>No<br>No sabe</td>
</tr>
<tr>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">10</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">horas_mens</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee">y2_hrs. NÃºmero de horas mensuales pactadas con<br>empleador</td>
<td style="padding:0.2cm; text-align:left; vertical-align:top; background-color:#eeeeee" colspan="2"><em>range: 1-720</em></td>
</tr>

</table>

#  4. Descripción de variables

Una vez conocidas las variables que incluye nuestros datos procesados ¿cómo podemos realizar un análisis descriptivo univariado para algún informe o reporte? Veamos algunas de las más comunes

## 4.1. Medidas de tendencia central

Para conocer las medidas de tendencia central de las variables hay dos opciones. Por una parte, podemos calcular un estadístico directamente a través de código, obteniendo el valor directamente en la consola (o en nuestro .Rmd, si hemos configurado adecuadamente el chunk respectivo). Por otra, podemos generar un código que presente directamente una tabla resumen de los datos.  

### Media

Para conocer la media de una variable se utiliza la función `mean()`, cuya estructura es:


```r
mean(datos$variable, na.rm=TRUE)
```


El argumento `na.rm=TRUE` excluye del cálculo a los casos perdidos. Si deséaramos estimar la media de `ingreso_percapita`, debemos codificar lo siguiente


```r
mean(datos_proc$ingreso_percapita, na.rm=TRUE)
```

```
## [1] 355472.1
```

### Media recortada

Pero, ¿qué pasa si, dada la distribución de los valores de la variable `ingreso_percapita`, su media se ve fuertemente afectadas por casos atípicos o fuera de rango (por ejemplo, que esta adopte un valor más alto producto de una alta concentración de ingresos)? En tal caso, una buena manera de evitar el efecto de casos influyentes en la estimación pasa por calcular la media recortada, incorporando el argumento `trim` para excluir al 5% de la muestra en la estimación (es decir, el 2.5% de cada extremo)


```r
mean(datos_proc$ingreso_percapita, na.rm=TRUE, trim = 0.025)
```

```
## [1] 305707.9
```

¿Ven cómo se modifica el valor que obtenemos a partir de esta estimación? La diferencia entre la media y la media recortada al 5% de los ingresos per cápita es de 4.9764257\times 10^{4}.

Una vez conocemos el valor medio de la variable `ingreso_percapita`, podemos tener una idea más clara de cómo se caracterizan los ingresos per cápita del país a nivel general entre quienes fueron encuestada/os en CASEN. Sin embargo, hay otros estadísticos que nos permitirán generar una representación más clara de los ingresos de los hogares chilenos ¡vamos a estimar la mediana! 

### Mediana

¿Cuál es el ingreso per cápita máximo al que puede acceder el 50% de los hogares chilenos en el momento en que se recolectaron los datos de CASEN 2020? Para el cálculo de la mediana se utiliza la función `median()`, que presenta una estructura similar a la de `mean()`:


```r
median(datos$variable, na.rm =TRUE)
```


```r
median(datos_proc$ingreso_percapita, na.rm =TRUE)
```

```
## [1] 229184.5
```

Ahora ya sabemos que un 50% de los hogares en Chile tiene un ingreso per cápita de **$229.184** o menos.

Ya tenemos los estadísticos principales, pero ¿cómo los reportamos? ¿debemos estimar la media y la mediana de cada todas nuestras variables *una por una*? **¡No!**, para ello `sjmisc` tiene diferentes funciones que nos permitirán estimar y presentar gráficamente tales estimaciones, y las conoceremos a continuación:


## Un resumen

Por ello ocuparemos la función `descr()` de `sjmisc`, que nos presenta un resumen de los estadísticos básicos, incluyendo las etiquetas de cada variable.


```r
sjmisc::descr(datos_proc$ingreso_percapita,
        show = "all",
        out = "viewer",
        encoding = "UTF-8",
        file = "output/figures/tabla-ingreso.doc")
```


```
## 
## ## Basic descriptive statistics
## 
##  var    type                   label      n NA.prc     mean       sd   se
##   dd numeric Ingreso total del hogar 144418      0 355472.2 834151.2 2195
##        md  trimmed                   range      iqr   skew
##  229184.5 266168.1 225200000 (0-225200000) 252277.6 152.42
```

**¡Atención!** utilizaremos la función `descr()` **sólo para variables de clase `numeric`** ¿Qué sentido tiene calcular el promedio de equipos de futbol, o de religiones que existen?

Como ya adelantamos anteriorme, `sjmisc` dialoga con el universo `tidyverse`, por lo cual es posible complementar con funciones como `select()` de `dplyr`, seleccionando más de una variable a la vez para nuestras estimaciones de estadísticos de resumen. Además, el argumento `file =` nos permite **exportar** la tabla de estadísticos que acabamos de generar en formato .doc (¡y otros!). 


```r
datos_proc %>%
select(ingreso_percapita, ife, horas_mens) %>% 
sjmisc::descr(
  show = "all",
  out = "viewer",
  encoding = "UTF-8",
  file = "output/figures/tabla1.doc")
```


```
## 
## ## Basic descriptive statistics
## 
##                var    type
##  ingreso_percapita numeric
##                ife numeric
##         horas_mens numeric
##                                                                         label
##                                                       Ingreso total del hogar
##  y26d_hog. Últimos 12 meses, ¿alguien recibió Ingreso Familiar de Emergencia?
##                      y2_hrs. Número de horas mensuales pactadas con empleador
##       n NA.prc      mean        sd     se       md   trimmed
##  144418   0.00 355472.15 834151.23 2195.0 229184.5 266168.13
##  144418   0.00      1.77      1.00    0.0      2.0      1.70
##   33338  76.92    152.83     54.69    0.3    180.0    159.83
##                    range      iqr   skew
##  225200000 (0-225200000) 252277.6 152.42
##                  8 (1-9)      1.0   5.41
##              719 (1-720)     34.0  -0.98
```

Como podemos ver, `descr()` nos presenta diversa información, como el nombre de la variable en `var`; su tipo en `type`; su etiqueta en `label`; los casos válidos en `n`; el porcentaje de casos perdidos en `NA.prc`; y las diversas medidas de tendencia central, posición de dispersión para cada una de nuestra variables, como la media y la mediana, los cuartiles, la desviación estándar, y muchas otras.


## 4.3. Frecuencias 

### Frecuencias absolutas

Podemos utilizar la función `table()` del paquete `base` de R, que presenta la frecuencia absoluta de cada un de los valores que puede alcanzar alguna de nuestras variables categóricas.


```r
table(datos_proc$sexo) 
```

```
## 
##     1     2 
## 65474 78944
```

También podemos emplear la función `flat_table()`, que permite agrupar la frecuencia absoluta de las categorías de dos o más de nuestras variables categóricas.


```r
flat_table(datos_proc, sexo, ocupacion, ife)
```

```
##                  ife    Sí    No No sabe
## sexo   ocupacion                        
## Hombre Sí             9695 23979     473
##        No            11263 19571     493
## Mujer  Sí             7527 18488     317
##        No            20084 31701     827
```

No obstante, el output de ambas funciones **no se resulta visualmente atractivo** ¿cómo podríamos reportar las frecuencias absolutas (y relativas) en nuestros informes? Si queremos una tabla general usaremos la función `frq()` de `sjmisc`, cuyo output es una tabla de frecuencia que presenta. Esta función devuelve una tabla de frecuencias absolutas y relativas para nuestras variables categóricas (**¡genial!**). Además, si nuestros datos son números etiquetados (`dbl + lbl`), presenta tanto los valores numéricos como las etiquetas asociadas a cada uno de ellos (¡`table()` sólo presenta los valores numéricos! no incluye metadata en su output)


```r
sjmisc::frq(datos_proc$sexo,
        out = "viewer",
        title = "Frecuencias",
        encoding = "UTF-8",
        file = "output/figures/tabla2.doc") 
```

<table style="border-collapse:collapse; border:none;">
<caption style="font-weight: bold; text-align:left;">Frecuencias</caption>
<tr>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; text-align:left;text-align:left; ">val</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; text-align: left;">label</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; text-align: right;">frq</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; text-align: right;">raw.prc</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; text-align: right;">valid.prc</th>
<th style="border-top: double; text-align:center; font-style:italic; font-weight:normal; padding:0.2cm; border-bottom:1px solid black; text-align: right;">cum.prc</th>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">1</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; text-align: left;">Hombre</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; text-align: right;">65474</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; text-align: right;">45.34</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; text-align: right;">45.34</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; text-align: right;">45.34</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; ">2</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; text-align: left;">Mujer</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; text-align: right;">78944</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; text-align: right;">54.66</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; text-align: right;">54.66</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; text-align: right;">100.00</td>
</tr>
<tr>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:left;text-align:left; border-bottom: 1px solid; ">NA</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: 1px solid; text-align: left;">NA</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: 1px solid; text-align: right;">0</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: 1px solid; text-align: right;">0.00</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: 1px solid; text-align: right;">NA</td>
<td style=" padding:0.2cm; text-align:left; vertical-align:top; text-align:center; border-bottom: 1px solid; text-align: right;">NA</td>
</tr>
<tr>
<td colspan="7" style="font-style:italic; border-top:double black; text-align:right;">total N=144418 &middot; valid N=144418 &middot; x&#772;=1.55 &middot; &sigma;=0.50
</td>
</tr>
</table>


#  5. Visualización

Ahora que ya sabemos cómo obtener todos los estadísticos necesarios para escribir nuestros reportes, viene el segundo paso: *visualizar tales estadísticos*. ¡Siempre es mejor presentar un buen gráfico, antes de mostrar un número y ya! Para ello, emplearemos la librería `sjPlot`

Para visualizar las frecuencias usaremos la función `plot_frq`, que se estructura de la siguiente manera


```r
plot_frq(datos,  #base
  ...,          #variable
  title = "",   # título
  type = c("bar", "dot", "histogram", "line", "density", "boxplot", "violin") #tipo de gráfico a especificar 
```

Para los gráficos, tenemos los siguientes códigos

1. Gráfico de barras de frecuencias simple

Si quisiéramos presentar gráficos que entreguen la frecuencia de cada categoría de respuesta, podemos presentarla de la siguiente forma:



```r
plot_frq(datos_proc, edad_tramo,
          title = "Gráfico de frecuencias, barras",
          type = "bar")
```

<img src="/example/07-practico_files/figure-html/casen_barras_simple-1.png" width="672" />

{{< div "note" >}}

Además de la visualización es importante el guardar los datos que se producen y `sjPlot` tiene su propio código para hacerlo a través de la función `save_plot()`, su estructura es esta:


```r
save_plot("ruta/imagen.jpg", fig = last_plot())  #se deja el formato del archivo (.png, .jpg, .svg o .tif) y la ruta de la carpeta
```

Así guardaríamos el gráfico anterior


```r
save_plot("output/figures/tab.png", fig = last_plot())
```
{{< /div >}}


2. Gráfico de puntos

Para variables numéricas ¡podemos presentar un gráfico de puntos!


```r
plot_frq(datos_proc, ingreso_percapita,
          title = "Gráfico de frecuencias, puntos",
          type = "dot")
```

<img src="/example/07-practico_files/figure-html/casen_puntos_simple-1.png" width="672" />

También podemos cambiar el orden de los ejes *x* e *y*


```r
plot_frq(datos_proc$edad_tramo, type = "dot", show.ci = TRUE, sort.frq = "desc",
  coord.flip = TRUE, expand.grid = TRUE, vjust = "bottom", hjust = "left", title = "Gráfico de frecuencias, puntos cambiado"
)
```

<img src="/example/07-practico_files/figure-html/casen_puntos cambiados-1.png" width="672" />
    
Pero, ¿cuál es el argumento que hace esto?

A la hora de trabajar en R, siempre debemos conocer los argumentos que utilizamos en nuestros códigos, puede que un argumento sea innecesario o esté generando un error, para eso debemos consultar en la sección **Help**. Los pasos son los siguientes:

a. Escribe en la consola anteponiendo un `?` en la función que quieres conocer, en este caso será `plot_frq?`, quedando así:

![](https://github.com/learn-R/06-class/raw/main/input/img/image.png)


b. Una vez le des a *Enter*, en la sección **Help** aparecerá información sobre la función, cómo se usa y qué se puede hacer con ella. En **Arguments** explicará la función de cada argumento

![](https://github.com/learn-R/06-class/raw/main/input/img/image2.png)

¡Ahora podrán definir, con completo conocimiento, cómo están personalizando sus gráficos!

3. Histogramas        
       
Otra función que podemos hacer es graficar histogramas. Sin embargo, como ya hemos visto, la variable `ingreso_percapita` tiene casos fuera de rango que distorsionan la imagen que nos podemos hacer de la distribución de la variable en la muestra. Para solucionar esto, ocuparemos lo aprendido en [el práctico anterior](https://learn-r-udp.netlify.app/example/03-practico/) y filtraremos la variable, eliminando de la presentación los ingresos mayores a `$2.000.000`, con la función `filter` de `dplyr`


```r
datos_proc %>%  filter(ingreso_percapita <= 2000000) %>% 
plot_frq(., ingreso_percapita,
          title = "Histograma",
          type = "histogram")
```

<img src="/example/07-practico_files/figure-html/casen_histograma-1.png" width="672" />

4. Densidad

Ahora que vemos la distribución del histograma ¿cómo podemos graficar su densidad? es muy simple: podemos generar un gráfico de densidad con el siguiente código


```r
datos_proc %>%  filter(ingreso_percapita <= 2000000) %>%
plot_frq(., ingreso_percapita,
          title = "Gráfico de densidad",
          type = "density")
```

<img src="/example/07-practico_files/figure-html/casen_densidad-1.png" width="672" />


5. Gráfico de líneas
        
¿Que pasa si me piden un gráfico de lineas?, también hay una función para eso. En esta ocasión queremos graficar la variable `ife`, para lo que usaremos este código:


```r
plot_frq(datos_proc, ife,
          title = "Gráfico de líneas",
          type = "line")
```

<img src="/example/07-practico_files/figure-html/casen_lineas-1.png" width="672" />

6. Gráfico de cajas

Para graficar algunas medidas de posición de una variable y, en específico, los cuartiles de esta, podemos elaborar un gráfico de cajas, para lo cual usaremos este código:


```r
datos_proc %>%  filter(ingreso_percapita <= 2000000) %>%
plot_frq(., ingreso_percapita,
          title = "Gráfico de caja",
          type = "boxplot")
```

<img src="/example/07-practico_files/figure-html/casen box-1.png" width="672" />

          
7. Gráfico de violín

Finalmente, si queremos presentar gráficos de violín, usamos este código
          

```r
datos_proc %>%  filter(ingreso_percapita <= 2000000) %>%
    plot_frq(., ingreso_percapita,
          title = "Gráfico de violín",
          type = "violin")
```

<img src="/example/07-practico_files/figure-html/casen violin-1.png" width="672" />
          
Como pueden ver, el único argumento que se modificaba era `type = `: es decir, para hacer diversos gráficos, sólo se debe especificar el tipo de gráfico que queremos, y luego personalizarlo según nuestro requerimientos, especificando el resto de argumentos.


# 6. Resumen del práctico

¡Eso es todo por este práctico! Hoy aprendimos a:

- Estimar estadísticos de medidas de tendencia central, posición y dispersión para variables cuantitativas
- Calcular las frecuencias absolutas y relativas para cada una de las categorías de respuesta con variables cualitativas
- Presentar ambas estimaciones
- Generar y personalizar gráficos descriptivos univariados para variables categóricas y continuas

# 7. Reporte de progreso

¡Recuerda rellenar tu [reporte de progreso](https://learn-r.formr.org/). En tu correo electrónico está disponible el código mediante al cuál debes acceder para actualizar tu estado de avance del curso.

