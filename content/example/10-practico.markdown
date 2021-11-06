---
title: "Calidad de modelos y otras técnicas de estimación"
linktitle: "10: Calidad de modelos y otras técnicas de estimación"
date: "2021-11-08"
menu:
  example:
    parent: Ejemplos
    weight: 11
type: docs
toc: true
editor_options: 
  chunk_output_type: console
---
<script src="/rmarkdown-libs/kePrint/kePrint.js"></script>
<link href="/rmarkdown-libs/lightable/lightable.css" rel="stylesheet" />




# 0. Objetivo

Esta práctica tiene por objetivo introducir a la valuación de la calidad de nuestros modelos de regresión. Si bien en la estimación tenemos información sobre el ajuste genera según el R2, existen una serie de aspectos que podrían estar afectando nuestra estimación y haciendo que nuestro modelo no represente de buena manera las asociaciones entre las variables.

La siguiente práctica tiene el objetivo de introducir en los **supuestos y robustez del modelo de regresión**, así como también las posibles alternativas de transformación de variables para corregir las estimaciones cuando los supuestos no se cumplen. Para ello, utilizaremos los datos de la encuesta [MOVID-IMPACT](https://movid-impact.netlify.app/) con el objetivo de analizar los determinantes de la **Fatiga pandémica**

# 1. Paquetes a utilizar

En esta ocasión utilizaremos el universo de paquetes `tidyverse`, dentro de los cuales se encuentra `magrittr`, además utilizaremos `sjPlot` para la visualización, mientras que [`performance`](https://easystats.github.io/performance/) se utilizará para evaluar la calidad de los modelos y `summarytools` que nos permitirá visualizar los datos procesados.


```r
pacman::p_load(tidyverse, magrittr, # procesamiento
               summarytools, #decriptivos
               sjPlot, #visualización
               performance, #evaluación de modelos
               see) # herramientas para la visualización
```

# 2. Recursos del práctico

Para este práctico utilizaremos los datos que nos ofrece [MOVID-IMPACT](https://movid-impact.netlify.app/), una encuesta transversal telefónica realizada por el equipo [CoV-IMPACT-C](https://movid19.cl/) del proyecto [ANID N°960](https://movid19.cl/somos/cov-impact). El objetivo de la encuesta es conocer el impacto en la salud y socioeconómico que ha tenido la pandemia sobre la población chilena.

Se cargan los datos directamente desde el sitio de la encuesta


```r
movid <- haven::read_dta(url("https://movid-impact.netlify.app/input/data/MOVID-IMPACT.dta"))
```

## 2.1. Procesamiento previo

Filtraremos los datos solo con la información de los encuestados, seleccionaremos las variables de interés para el práctico y recodificaremos los casos perdidos. 


```r
movid_proc <- movid %>%
  group_by(id_encuesta) %>%  #Para calcular tamano de hogar
  mutate(tamanohogar = n()) %>%
  ungroup() %>%
  filter(entrevistado == 1) %>% #Filtrar solo a entrevistados
  select(sexo, edad, trabaja = g1,ingreso = g47_monto, tingreso= g48, tamanohogar, starts_with("c2"), fatiga = f5_3) %>% #Seleccionar variabes
  mutate_at(vars(-tingreso), ~car::recode(.,"c(8,9) = NA")) %>%
  mutate(tingreso = car::recode(tingreso,"c(98,99) = NA")) %>%
  mutate_at(vars(sexo, trabaja, starts_with("c2"), tingreso, -fatiga), ~ as_factor(.))
```

## 2.2 Explorar datos

Los datos utilizados tienen 1261 observaciones y 11 variables, las cuales serán descritas en la siguiente tabla

**Tabla N°1** Estadísticos descriptivos de base de datos procesadas de MOVID-IMPACT

```r
view(dfSummary(movid_proc, headings = FALSE))
```
Fuente: Elaboración propia en base a MOVID-IMPACT (n=909 casos)



# 3. Introducción

**2. Ajuste** (*post-hoc*): implica abordar qué tan bien ajustan nuestros modelos con los datos utilizados. La *bondad de ajuste* implica que si trabajamos con una

  - 2.1 *Regresión lineal múltiple*, analizaremos el `\(R^2\)` ajustado
  - 2.2 *Regresión logística*, analizaremos el `\(Pseudo\)` `\(R^2\)` y los *Criterios de Información* `\(BIC\)` y `\(AIC\)` (ambos nos dicen cuánta información se está "perdiendo" con las variables que se ocupan en cada modelo. Por ello elegiremos el modelo que tenga un BIC y AIC más bajo)

**3. Comparación**: luego de que hacemos **transformaciones** a los modelos, una etapa importante para la **selección** de estos es compararlos. Para ello consideraremos toda la información que tenemos de ellos en su diagnóstico de **pre y post hoc.**

**¿Cómo evaluar la robustez y ajuste de modelos en `R`?**

En R existen diversas funciones para crear un diagnóstico de supuestos y de ajuste a nuestros modelos. Ahora bien, la gran parte de ello se desenvuelve en distintos paquetes, sobre todo  considerando que, como vimos, **no existen criterios únicos** para evaluar la calidad de nuestros modelos (más aún cuando son su variable dependiente tiene un nivel distinto de medición).

La buena noticia es que el paquete `performace` reúne todas estas herramientas, y que los tres ejes de la **calidad de los modelos** también las distingue en una función para cada una.

![](https://github.com/easystats/performance/blob/master/paper/figure_workflow.png?raw=true)

**Figura 2.** paquete `performance` del proyecto easystats de [Lüdecke et al. (2021)](https://easystats.github.io/performance/)

# 4. Diagnóstico de la calidad de los modelos

Imaginemos que queremos analizar los determinantes de la **Fatiga pandémica**, y para ello estimaremos un modelo de regresión lineal.

```r
model1 <- lm(as.numeric(fatiga) ~ c2_1 + c2_2 + c2_3 + c2_4 +
               trabaja + sexo + edad + ingreso,
             data = movid_proc)
```

**Tabla 1**. Modelo de regresión que predice la fatiga a la pandemia
<table class="texreg" style="margin: 10px auto;border-collapse: collapse;border-spacing: 0px;caption-side: bottom;color: #000000;border-top: 2px solid #000000;">
<thead>
<tr>
<th style="padding-left: 5px;padding-right: 5px;">&nbsp;</th>
<th style="padding-left: 5px;padding-right: 5px;">Modelo 1</th>
</tr>
</thead>
<tbody>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">(Intercept)</td>
<td style="padding-left: 5px;padding-right: 5px;">2.60<sup>&#42;&#42;&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.14)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_1Varios días</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.17</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.10)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_1Más de la mitad de los días</td>
<td style="padding-left: 5px;padding-right: 5px;">0.23</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.16)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_1Casi todos los días</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.08</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.14)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_2Varios días</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.02</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.10)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_2Más de la mitad de los días</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.07</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.17)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_2Casi todos los días</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.10</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.15)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_3Varios días</td>
<td style="padding-left: 5px;padding-right: 5px;">0.19</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.10)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_3Más de la mitad de los días</td>
<td style="padding-left: 5px;padding-right: 5px;">0.23</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.17)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_3Casi todos los días</td>
<td style="padding-left: 5px;padding-right: 5px;">0.29</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.16)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_4Varios días</td>
<td style="padding-left: 5px;padding-right: 5px;">0.16</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.10)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_4Más de la mitad de los días</td>
<td style="padding-left: 5px;padding-right: 5px;">0.24</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.17)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_4Casi todos los días</td>
<td style="padding-left: 5px;padding-right: 5px;">0.32<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.16)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">trabajaNo</td>
<td style="padding-left: 5px;padding-right: 5px;">0.06</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.08)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">sexoMujer</td>
<td style="padding-left: 5px;padding-right: 5px;">0.02</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.08)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">edad</td>
<td style="padding-left: 5px;padding-right: 5px;">0.00</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.00)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">ingreso</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.00</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.00)</td>
</tr>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.04</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Adj. R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.02</td>
</tr>
<tr style="border-bottom: 2px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">Num. obs.</td>
<td style="padding-left: 5px;padding-right: 5px;">917</td>
</tr>
</tbody>
<tfoot>
<tr>
<td style="font-size: 0.8em;" colspan="2"><sup>&#42;&#42;&#42;</sup>p &lt; 0.001; <sup>&#42;&#42;</sup>p &lt; 0.01; <sup>&#42;</sup>p &lt; 0.05</td>
</tr>
</tfoot>
</table>


## 4.1. Robustez y supuestos{#supuestos}

Los modelos de regresión tienen una serie de **supuestos** que se deben cumplir para que las estimaciones sean **fidedignas**.En esa sesión consideraremos los supuestos más esenciales: linealidad, normalidad de residuos, homogeneidad de la varianza,  independencia de variables, multicolinealidad y casos influyentes (*los primeros tres aplican solo para regresiones lineales*).

![](https://docs.google.com/drawings/d/e/2PACX-1vQbb26p4E5LLFdGLr7t_3fvNHEn38d9E4D8uAdLMYk58GMp98uBpfsDqtEoMY4AdvBYftihC_Bst1G1/pub?w=480&amp;h=360)

**Figura 3**. Diferentes funciones de `performance` para evaluar robustez del modelo


### 4.1.1 Linealidad{#linealidad}

Para la regresión lineal múltiple, un supuesto importante es que existe una **relación lineal entre la variable dependiente e independiente**.

Podemos saber si se cumple este supuesto a partir de un *gráfico de dispersión de datos*, que relacione la variable dependiente y la independiente, y verificar de manera "intuitiva" si la **tendencia** de esta relación se puede describir por una **línea recta**. El paquete `performace` nos permite hacer esto con su función `check_model` indicando en el argumento `check = "ncv`


```r
check_model(model1, check = c("ncv", "linearity"))
```

<img src="/example/10-practico_files/figure-html/unnamed-chunk-7-1.png" width="672" />


En este caso podemos notar claramente que no hay una relación lineal. En caso de que no sea claro, una forma numérica para chequear este supuesto es que el valor promedio de los residuos sea cero. Si esto no es así los residuos están sesgados sistemáticamente, entonces probable que el modelo no sea realmente lineal, y esta desviación de los residuos deba corregirse re-especificando (medir de otra manera la variable) algún término de la ecuación de regresión al cuadrado o al cubo. Un modo que se ocupa para testear la necesidad de esta re-especificación es el test RESET de Ramsey que indica que:

`\(H_o\)` cuando el modelo tiene algún término al cuadrado o cubo, la media de los residuos es cero. Es decir, que si no podemos rechazar `\(H_0\)`, nuestro modelo está bien especificado (es decir, es lineal). Como en este caso es claro que se necesita respecificar el predictor elevamos edad al cuadrado. Imaginemos que es el caso

✔️ La línea de referencia es plana y horizontal

### 4.1.2 Homocedasticidad{#homocedasticidad}

Homoce ¿qué? Sí, *homocedasticidad*. Este concepto indica que **los residuos** se distribuyen de forma **homogénea** (por eso el sufijo *homo*). Como ya podrás haber notado este supuesto se vincula con el de [linealidad](#linealidad)

Al igual que la linealidad también puede comprobarse con un gráfico de dispersión entre la variable dependiente ($Y$) e independiente ($X$),  donde podamos ver de manera clara la recta de regresión estimada y la distribución de los residuos. Aceptaremos el supuesto de **homocedasticidad** si la variación de los residuos es homogénea, es decir, no veremos un patrón claro y más bien se *distribuirán de forma aleatoria*. De manera gráfica veremos una nube de puntos que tiene una *forma similar* en todo el rango de las observaciones de la variable independiente.

Para comprobar el supuesto de homocedasticidad de manera más certera utilizaremos la prueba Breusch-Pagan Godfrey cuya hipótesis nula indica que

`\(H_0\)`: La varianza de los residuos del modelo de regresión no es constante (**heterocedasticidad**)

En este caso, buscaremos que rechazar la `\(H_0\)`. Esto implicaría que *"en suma y resta"* si bien hay residuos, estos tienen una variación **homogénea** en todos los tramos de la relación de la variable dependiente con la independiente.

A partir de la función `check_heteroscedasticity` verificaremos qué ocurre con la hipótesis nula

```r
check_heteroscedasticity(model1)
```

OK: Error variance appears to be homoscedastic (p = 0.494).

✔️ La varianza es homocedástica

### 4.1.3 Normalidad de residuos{#normalidad}

Además de la linealidad (media 0), la homocedasticidad (varianza mínima y constante), el método de estimación de la regresión lineal (*OLS* o *MCO* en español) requiere asegurar una **distribución normal** de los residuos pues en caso contrario el modelo no es consistente a través de las variables y observaciones (esto significa que los errores no son aleteatorios).

Al igual que con los otros supuestos, la **normalidad** de los residuos se puede evaluar con métodos numéricos con pruebas que ya conocemos de otros cursos como la prueba de *Shapiro-Wilk* y Kolmogorov-Smirnov

A partir de la función `check_normality` utilizaremos la prueba *Shapiro-Wilk* para ver qué ocurre con la hipótesis nula a

```r
check_normality(model1)
```

Warning: Non-normality of residuals detected (p < .001).

⚠️ Los residuos no son normales

### 4.1.4 Independencia{#independencia}

Evidentemente si los residuos no siguen una distribución normal, es probable que estos no sean independientes entre sí. Esto significa que buscaremos que los errores asociados a nuestro modelo de regresión sean **independientes**. Para saber si se cumple ese criterio se utiliza la prueba de *Durbin-Watson*, donde la `\(H_0\)` supone que **los residuos son independientes**

A partir de la función `check_autocorrelation` utilizaremos la prueba *Durbin-Watson* para ver qué ocurre con la hipótesis nula a


```r
check_autocorrelation(model1)
```

Warning: Autocorrelated residuals detected (p = 0.008).

⚠️ Hay correlación entre los residuos

En síntesis sabemos la regresión lineal requiere de una relación lineal entre sus variables independientes y dependiente. Para ello no solo es importante chequear la distribución de los residuos, sino
dos posibilidades que pueden *tendenciar* esa relación lineal: como casos influyentes en la muestra y predictores que están altamente relacionados. Revisaremos la última de estas

### 4.1.5 Multicolinealidad{#multicolinealidad}

La multicolinealidad es la relación de **dependencia lineal fuerte** entre más de dos **predictores** de un modelo.

El problema que produce es que será *difícil cuantificar con exactitud el efecto de cada predictor sobre la variable dependiente*, precisamente pues puede ocurrir que el efecto que una variable predictora tenga sobre el fenómeno que se busca estudiar dependa del valor de otra variable del modelo.

Para la regresión múltiple esto implica un problema pues suponemos que podemos *"controlar"* por el otro valor de la variable.

Esta relación **endógena** entre predictores la podemos examinar ante la existencia de altas correlaciones (*lineales*) entre variables. La aproximación numérica más utilizada es el **VIF** (factor de inflación de varianza) que indica hasta que punto la varianza de los coeficientes de regresión se debe a la colinealidad (o dependencia) entre otras variables del modelo.

Para evaluar esto ocuparemos el comando `check_collinearity()`. Como podemos ver en el gráfico, todos los valores son menores a 5 (*como recomienda el paquete*).


```r
plot(check_collinearity(model1))
```

<img src="/example/10-practico_files/figure-html/unnamed-chunk-11-1.png" width="672" />

Ahora bien, dado que sabemos que las correlaciones en ciencias sociales nunca son tan altas, un criterio que se ocupa en nuestras disciplinas para evaluar *multicolinealidad* es es evitar valores del VIF mayores a 2.5.


```r
check_collinearity(model1)
```

# Check for Multicollinearity

Low Correlation

    Term  VIF Increased SE Tolerance
    c2_1 2.85         1.69      0.35
    c2_2 2.51         1.59      0.40
    c2_3 3.66         1.91      0.27
    c2_4 2.51         1.58      0.40
 trabaja 1.13         1.06      0.88
    sexo 1.06         1.03      0.94
    edad 1.13         1.06      0.89
 ingreso 1.00         1.00      1.00

⚠️ Como podemos ver los ítems del módulo de salud mental tienen todos valores sobre 2.5. Como veremos en el segundo apartado de esta sesión, las recomendaciones son o eliminar alguno de los predictores o *evaluar si es que estas variables más bien son parte de un mismo constructo* (y para ello las correlacionaremos)

### 4.1.6 Casos influyentes{#outliers}

Un último supuesto que revisaremos, y es el que probablemente parte del que más nos enfrentamos en las ciencias sociales, son los **casos influyentes** (también llamados en inglés, *outliers*). Un ejemplo claro de esto son las variables como ingresos, donde muchas veces tenemos casos extremos con muy bajos salarios y otros muy altos, y que pueden tendenciar nuestras rectas de regresión pese a que no es evidente una relación lineal(o algún tipo de relación) entre la variable independiente y dependiente.

Para verificar si un "caso es *influyente*" examinaremos si la ausencia o presencia de ese caso genera un cambio importante en la estimación del modelo de regresión. Este enfoque se aborda a partir del cálculo de la **Distancia de Cook** (Cook,1977)

Primero podemos graficar la influencia de los casos con `check_outliers()` dentro de un `plot()`

```r
plot(check_outliers(model1))
```

<img src="/example/10-practico_files/figure-html/unnamed-chunk-13-1.png" width="672" />

Luego para verificar si la ausencia o presencia de eliminar algunos de estos casos que presentan mayor distancia producen una **diferencia** significativa en la estimación del modelo, realizamos


```r
check_outliers(model1)
```

OK: No outliers detected.

✔️ No hay outliers


## 4.2 Ajuste del modelo{#fit}

Sabemos por la [práctica 5](https://multivariada.netlify.app/assignment/05-code/) que podemos evaluar qué tan bien ajustan nuestros modelos con los datos utilizados. Sabemos que:

2.1 Si trabajamos una regresión lineal: el `\(R^2\)` ajustado

2.2 Si trabajamos una regresión logística: Pseudo `\(R^2\)` y los *Criterios de Información* BIC y AIC (ambos nos dicen cuánta información se está "perdiendo" con las variables que se ocupan en cada modelo. Por ello elegiremos el modelo que tenga un BIC y AIC más bajo).


```r
performance::model_performance(model1) %>%
  print_md() #print_md() nos permite hacer tablas en buen formato
```



Table: Indices of model performance

|AIC     |     BIC |   R2 | R2 (adj.) | RMSE | Sigma |
|:-------|:-------:|:----:|:---------:|:----:|:-----:|
|2817.44 | 2904.22 | 0.04 |      0.02 | 1.10 |  1.11 |

Es probable que estos ajustes coincidan mejor con el fenómeno que queremos analizar una vez que hicimos el chequeo de supuestos. Esto no implica necesariamente que el ajuste mejore, sino que seremos más *fieles* a la información que realmente nos están otorgando las variables.

Ya hemos dado una serie de  recomendaciones de transformaciones a las variables para manejar el problema de supuestos. En la siguiente tabla sistematizamos algunas de ellas.


<table class="table table-striped table-bordered table-condensed table-responsive" style="font-size: 14px; width: auto !important; margin-left: auto; margin-right: auto;">
 <thead>
  <tr>
   <th style="text-align:left;"> Problema </th>
   <th style="text-align:left;"> Soluciones posibles </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="3"> No linealidad de variable dependiente e independiente </td>
   <td style="text-align:left;"> Transformar predictor al cuadrado o cubo </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> Logaritmizar variable dependiente </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> Dicotomizar variable dependiente </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="3"> No normalidad de residuos </td>
   <td style="text-align:left;"> Transformar predictor al cuadrado o cubo </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> Logaritmizar variable dependiente </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> Dicotomizar variable dependiente </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Heterocedasticidad de residuos </td>
   <td style="text-align:left;"> Calcular errores estándares robustos </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="2"> Dependencia entre predictores </td>
   <td style="text-align:left;"> Interacción entre variables </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> Variables no observadas </td>
  </tr>
  <tr>
   <td style="text-align:left;vertical-align: middle !important;" rowspan="3"> Multicolinealidad </td>
   <td style="text-align:left;"> Creación de índices </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> Interacción entre variables </td>
  </tr>
  <tr>
   
   <td style="text-align:left;"> Eliminar variables </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Casos influyentes </td>
   <td style="text-align:left;"> Eliminar casos influyentes </td>
  </tr>
</tbody>
</table>

Ahora mostraremos de manera operativa como ejecutarlas.

### 4.2.1 Transformar predictor al cuadrado o cubo

Si estamos ante problemas de linealidad, indicamos que el término cuadrático o al cubo de algún predictor produce que la media de los residuos sea 0. Por lo general, por su distribución, esta variable es edad.


```r
movid_proc <- movid_proc %>% mutate(edad2 = (edad)^2)
```

### 4.2.2 Logaritmizar variable dependiente

Otro caso similar ocurre con *ingresos*, donde lo que se hace frecuentemente es transformar ingresos en un logaritmo de ingresos (*log(ingresos)*).

#### 4.2.2.1 Recuperar casos perdidos

¡Pero antes! Es común que en las encuestas sociales cierta variables posean una alta proporción de datos perdidos. Un ejemplo común es en el reporte de los ingresos de los hogares o individuos. Esto generalmente puede generarse por características de la persona (eg. desempleado, estudiante) o por deseabilidad social (eg. personas de altos ingresos desisten de reportar). Por lo general, existen dos estrategias para solicitar que las personas reporten sus ingresos: (1) reporte directo del monto y (2) si la persona no reporta los ingresos, se le presenta la posibilidad de ubicar los ingresos del hogar en tramos.


```r
movid_proc %>% select(ingreso, tingreso) %$%
dfSummary(., headings = FALSE, method = "render", varnumbers = F, lang = "es")
```


Si observamos la tabla de descriptivos para la variable ingreso del hogar (`ingreso`), tenemos un porcentaje 25,3% de datos perdidos. Por esta razón, emplearemos los datos disponibles en `tingreso` para recuperar información en los ingresos del hogar.

La estrategia posee los siguientes pasos:

- **Paso 1:** Calcular la media por cada tramo
- **Paso 2:** En el caso de no tener información, remplazar por la media del tramo


```r
movid_proc <- movid_proc %>%
  mutate(tingreso = case_when(tingreso == "Menos de $200 mil pesos" ~ 200000,
                              tingreso == "Entre $200 y 350 mil pesos" ~ 275000,
                              tingreso == "Entre $351 y 500 mil pesos" ~ 425500,
                              tingreso == "Entre 501 y 800 mil pesos" ~ 650500,
                              tingreso == "Entre 801 mil y 1 millón 200 mil pesos" ~ 1000500,
                              tingreso == "Entre 1 millón 201 mil y 2 millones de pesos" ~ 1600500,
                              tingreso == "Entre 2 millones y 5 millones de pesos" ~ 3500000,
                              tingreso == "Más de 5 millones de pesos" ~ 5000000), #Paso 1
         ingreso = if_else(is.na(ingreso), tingreso, ingreso))
```

- **Paso 3:** Comparar el resultado de los tramos



```r
movid_proc %>% select(ingreso, tingreso) %$%
dfSummary(., headings = FALSE, method = "render", varnumbers = F, lang = "es") #Paso 3
```

Vemos que pasamos de tener 25,3% de datos perdidos en ingresos a un 8,72% (es decir, recuperamos un 16,58% de los casos). A ingresos se le pueden hacer tres transformaciones más

**1. Logaritmizar**: en caso de que queramos seguir trabajando ingresos como una variable continua es una buena opción.

**2. Calcular el ingreso per cápita**: si dividimos el ingreso por el tamaño del hogar (n° de habitantes en este), obtendremos el ingreso por persona.

**3. Cálculo de medidas de posición acumulada**: con los ingresos per cápita se puede calcular la media o mediana de medidas de posición acumulada como quitiles


```r
movid_proc <- movid_proc %>%
  mutate(log_ing = log(ingreso), #Log ingresos
         ing_per = ingreso/tamanohogar, #Ingreso percapita
    quintiles = dplyr::ntile(ing_per,
                              n = 5)) # n de categorias, para quintiles usamos 5
```

### 4.2.3 Dicotomizar variable dependiente

Es recurrente que en las encuestas sociales nos encontremos con preguntas con *Escala Likert*. Sin embargo, muchas veces estas no tienen una distribución normal, y más bien las respuestas están concentradas en algunas categorías de referencia.

Si bien no hay criterios canónicos para trabajar esas variables, tiene sentido indicar que más bien no representan un constructo con 5 o más niveles, sino que probablemente de 2. Re-especificar la variable como dicotómica no solo ayudará a trabajar de manera más *realista* el constructo, sino que **facilitará** las interpretaciones que queramos hacer de nuestro modelo.

Ocuparemos dos criterios para la **dicotomización**:

1. **Medias**: se ocupará como criterio discriminante la media de la variable (donde 1 puede ser los valores mayores a la media, y 0 los inferiores).

2. **Mediana**: la más frecuente en medidas ordinales como las *escalas Likert* es cuando el 50% de los casos se concentra en unas pocas categoría de respuesta (eg, "Muy de acuerdo" y "De acuerdo" serán 1 y el resto 0).

En el caso de la variable `fatiga` que indica *"A medida que ha avanzado la crisis sanitaria, me siento cada vez más desmotivado para seguir las medidas de protección recomendadas"*, recodificaremos a aquellos como *1* a quiénes asienten a esta frase (*"Muy de acuerdo" y "De acuerdo"*)


```r
movid_proc <- movid_proc %>%
  mutate(fatigadummy = case_when(fatiga %in% c(5,4) ~ 1,
                                 fatiga %in% c(3,2,1) ~ 0, TRUE ~ NA_real_))
```

### 4.2.4 Errores estándares robustos

En caso de que estemos ante problemas de heterocedasticidad debemos re-estimar nuestro modelo considerando errores estándares robustos


```r
model_robust<- lmtest::coeftest(model1, vcov=sandwich::vcovHC(model1))
```

### 4.2.5 Creación de índices

En el [tutorial de dplyr](https://www.youtube.com/watch?v=APzU10EMMjg&t=321s) ya habíamos abordado este punto. También está desarrollado de manera extensa en el [práctico N°1](https://multivariada.netlify.app/assignment/01-code/#bonus-track-generaci%C3%B3n-de-%C3%ADndices). Por ello, solo lo cacularemos para aquellos ítems que mostraron posibilidad de ser colineales. Los pasos son

1. **Correlacionar** para verificar que estamos ante la presencia de ítems que podrían estar midiendo un constructo común. Como vemos en la siguiente tabla, las correlaciones son altas


```r
movid_proc %>% select(starts_with("c2")) %>%
  mutate_all(~as.numeric(.)) %>%
sjPlot::tab_corr(., triangle = "lower")
```

<table style="border-collapse:collapse; border:none;">
<tr>
<th style="font-style:italic; font-weight:normal; border-top:double black; border-bottom:1px solid black; padding:0.2cm;">&nbsp;</th>
<th style="font-style:italic; font-weight:normal; border-top:double black; border-bottom:1px solid black; padding:0.2cm;">c2_1</th>
<th style="font-style:italic; font-weight:normal; border-top:double black; border-bottom:1px solid black; padding:0.2cm;">c2_2</th>
<th style="font-style:italic; font-weight:normal; border-top:double black; border-bottom:1px solid black; padding:0.2cm;">c2_3</th>
<th style="font-style:italic; font-weight:normal; border-top:double black; border-bottom:1px solid black; padding:0.2cm;">c2_4</th>
</tr>
<tr>
<td style="font-style:italic;">c2_1</td>
<td style="padding:0.2cm; text-align:center;">&nbsp;</td>
<td style="padding:0.2cm; text-align:center;">&nbsp;</td>
<td style="padding:0.2cm; text-align:center;">&nbsp;</td>
<td style="padding:0.2cm; text-align:center;">&nbsp;</td>
</tr>
<tr>
<td style="font-style:italic;">c2_2</td>
<td style="padding:0.2cm; text-align:center;">0.608<span style="vertical-align:super;font-size:0.8em;">***</span></td>
<td style="padding:0.2cm; text-align:center;">&nbsp;</td>
<td style="padding:0.2cm; text-align:center;">&nbsp;</td>
<td style="padding:0.2cm; text-align:center;">&nbsp;</td>
</tr>
<tr>
<td style="font-style:italic;">c2_3</td>
<td style="padding:0.2cm; text-align:center;">0.599<span style="vertical-align:super;font-size:0.8em;">***</span></td>
<td style="padding:0.2cm; text-align:center;">0.569<span style="vertical-align:super;font-size:0.8em;">***</span></td>
<td style="padding:0.2cm; text-align:center;">&nbsp;</td>
<td style="padding:0.2cm; text-align:center;">&nbsp;</td>
</tr>
<tr>
<td style="font-style:italic;">c2_4</td>
<td style="padding:0.2cm; text-align:center;">0.483<span style="vertical-align:super;font-size:0.8em;">***</span></td>
<td style="padding:0.2cm; text-align:center;">0.465<span style="vertical-align:super;font-size:0.8em;">***</span></td>
<td style="padding:0.2cm; text-align:center;">0.586<span style="vertical-align:super;font-size:0.8em;">***</span></td>
<td style="padding:0.2cm; text-align:center;">&nbsp;</td>
</tr>
<tr>
<td colspan="5" style="border-bottom:double black; border-top:1px solid black; font-style:italic; font-size:0.9em; text-align:right;">Computed correlation used pearson-method with listwise-deletion.</td>
</tr>
 
</table>

2. **Construcción de índice**: este puede ser sumativo o promedio. Esto dependerá de la escala de los ítems y del sentido del constructo final que queremos utilizar. En nuestro caso crearemos una índice sumativa de `salud mental`


```r
movid_proc <- movid_proc %>%
  mutate_at(vars(starts_with("c2")),~as.numeric(.)) %>%
  rowwise() %>%
  mutate(salud_mental = sum(c2_1,c2_2,c2_3,c2_4, na.rm = T))
```


### 4.2.6 Eliminar casos influyentes

En caso de que estemos ante la prescencia de casos influyentes debemos seguir los siguientes pasos


```r
n<- nobs(model1) #n de observaciones
k<- length(coef(model1)) # n de parametros
dcook<- 4/(n-k-1) #Punto de corte
# Datos donde se filtran los valores sobre el punto de corte
movid_proc_so <- broom::augment_columns(model1,data = movid_proc) %>% filter(.cooksd<dcook)
```

Una vez finalizada las transformaciones calcular
dos nuevos modelos


```r
model1_fit <- lm(as.numeric(fatiga) ~ salud_mental +
               trabaja + sexo + edad + ing_per,
             data = movid_proc)
model2 <- lm(as.numeric(fatiga) ~ salud_mental +
               trabaja + sexo + edad2 + ing_per,
             data = movid_proc)
model3 <- glm(fatigadummy ~ salud_mental +
               trabaja + sexo + edad2 + ing_per, family = "binomial",
             data = movid_proc)
```

Luego, podemos hacer un chequeo general de diagnósticos de robustez con `check_model`, pero ahora indicando que queremos evaluar todos los indicadores posibles



```r
check_model(model1_fit, check = c("vif","normality", "linearity", "ncv", "homogeneity"))
```

<img src="/example/10-practico_files/figure-html/unnamed-chunk-28-1.png" width="672" />

```r
check_model(model2, check = c("vif",  "normality", "linearity", "ncv", "homogeneity"))
```

<img src="/example/10-practico_files/figure-html/unnamed-chunk-28-2.png" width="672" />

```r
check_model(model3, check = c("vif",  "homogeneity"))
```

<img src="/example/10-practico_files/figure-html/unnamed-chunk-28-3.png" width="672" />


Existen otros diagnósticos posibles para abordar en nuestros modelos, todo con el propósito de mejorar la calidad de estos. Uno de ellos, y que no abordaremos por su extensión, es la ausencia de
posibles **interacciones** entre las variables que no han sido modeladas (Fox & Weisberg 2018). En caso de su interés pueden revisar esto y ver su [aplicación simple en R en el siguiente link.](https://strengejacke.github.io/ggeffects/articles/introduction_partial_residuals.html)

## 4.3. Comparación

**Tabla 3**. Modelos de regresión que predice la fatiga a la pandemia
<table class="texreg" style="margin: 10px auto;border-collapse: collapse;border-spacing: 0px;caption-side: bottom;color: #000000;border-top: 2px solid #000000;">
<thead>
<tr>
<th style="padding-left: 5px;padding-right: 5px;">&nbsp;</th>
<th style="padding-left: 5px;padding-right: 5px;">Modelo 1</th>
<th style="padding-left: 5px;padding-right: 5px;">Modelo 2</th>
<th style="padding-left: 5px;padding-right: 5px;">Modelo 3</th>
</tr>
</thead>
<tbody>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">(Intercept)</td>
<td style="padding-left: 5px;padding-right: 5px;">2.60<sup>&#42;&#42;&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">2.40<sup>&#42;&#42;&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">-1.09<sup>&#42;&#42;&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.14)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.11)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.20)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_1Varios días</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.17</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.10)</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_1Más de la mitad de los días</td>
<td style="padding-left: 5px;padding-right: 5px;">0.23</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.16)</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_1Casi todos los días</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.08</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.14)</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_2Varios días</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.02</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.10)</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_2Más de la mitad de los días</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.07</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.17)</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_2Casi todos los días</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.10</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.15)</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_3Varios días</td>
<td style="padding-left: 5px;padding-right: 5px;">0.19</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.10)</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_3Más de la mitad de los días</td>
<td style="padding-left: 5px;padding-right: 5px;">0.23</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.17)</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_3Casi todos los días</td>
<td style="padding-left: 5px;padding-right: 5px;">0.29</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.16)</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_4Varios días</td>
<td style="padding-left: 5px;padding-right: 5px;">0.16</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.10)</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_4Más de la mitad de los días</td>
<td style="padding-left: 5px;padding-right: 5px;">0.24</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.17)</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">c2_4Casi todos los días</td>
<td style="padding-left: 5px;padding-right: 5px;">0.32<sup>&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.16)</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">trabajaNo</td>
<td style="padding-left: 5px;padding-right: 5px;">0.06</td>
<td style="padding-left: 5px;padding-right: 5px;">0.12</td>
<td style="padding-left: 5px;padding-right: 5px;">0.28<sup>&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.08)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.07)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.14)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">sexoMujer</td>
<td style="padding-left: 5px;padding-right: 5px;">0.02</td>
<td style="padding-left: 5px;padding-right: 5px;">0.02</td>
<td style="padding-left: 5px;padding-right: 5px;">0.06</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.08)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.07)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.13)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">edad</td>
<td style="padding-left: 5px;padding-right: 5px;">0.00</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.00)</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">ingreso</td>
<td style="padding-left: 5px;padding-right: 5px;">-0.00</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.00)</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">salud_mental</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.04<sup>&#42;&#42;&#42;</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.06<sup>&#42;&#42;</sup></td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.01)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.02)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">edad2</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.00</td>
<td style="padding-left: 5px;padding-right: 5px;">0.00</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.00)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.00)</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">ing_per</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">0.00</td>
<td style="padding-left: 5px;padding-right: 5px;">0.00</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.00)</td>
<td style="padding-left: 5px;padding-right: 5px;">(0.00)</td>
</tr>
<tr style="border-top: 1px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.04</td>
<td style="padding-left: 5px;padding-right: 5px;">0.02</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Adj. R<sup>2</sup></td>
<td style="padding-left: 5px;padding-right: 5px;">0.02</td>
<td style="padding-left: 5px;padding-right: 5px;">0.01</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Num. obs.</td>
<td style="padding-left: 5px;padding-right: 5px;">917</td>
<td style="padding-left: 5px;padding-right: 5px;">1128</td>
<td style="padding-left: 5px;padding-right: 5px;">1128</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">AIC</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">1510.51</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">BIC</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">1540.67</td>
</tr>
<tr>
<td style="padding-left: 5px;padding-right: 5px;">Log Likelihood</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">-749.25</td>
</tr>
<tr style="border-bottom: 2px solid #000000;">
<td style="padding-left: 5px;padding-right: 5px;">Deviance</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">&nbsp;</td>
<td style="padding-left: 5px;padding-right: 5px;">1498.51</td>
</tr>
</tbody>
<tfoot>
<tr>
<td style="font-size: 0.8em;" colspan="4"><sup>&#42;&#42;&#42;</sup>p &lt; 0.001; <sup>&#42;&#42;</sup>p &lt; 0.01; <sup>&#42;</sup>p &lt; 0.05</td>
</tr>
</tfoot>
</table>

Si bien en con la tabla N°3  podemos tener un panorama, es **imprescindible** recordar que para comparar modelos (en su robustez y ajuste) es necesario que estos tengan *(1) la misma variable de respuesta y (2) el mismo número de observaciones.*

```r
compare_performance(model1_fit, model2) %>%
  print_md()
```



Table: Comparison of Model Performance Indices

|Name       | Model |     AIC |     BIC |   R2 | R2 (adj.) | RMSE | Sigma |
|:----------|:-----:|:-------:|:-------:|:----:|:---------:|:----:|:-----:|
|model1_fit |    lm | 3452.28 | 3487.48 | 0.02 |      0.01 | 1.11 |  1.11 |
|model2     |    lm | 3452.24 | 3487.44 | 0.02 |      0.01 | 1.11 |  1.11 |

```r
plot(compare_performance(model1_fit, model2))
```

<img src="/example/10-practico_files/figure-html/unnamed-chunk-30-1.png" width="672" />

Ahora bien, esto no quita que, considerando que el ajuste entre el `model1_fit` y el `modelo2` no cambia sustantivamente, consideremos en seleccionar el `modelo3` por criterios más sustantivos. Podemos asegurarnos de esta comparación entre el modelo1 y modelo2 con un test que permite facilitar la decisión sobre la significancia de los índices que estamos viendo


```r
test_performance(model1_fit, model2) %>%
  print_md()
```



|Name       | Model|   BF|
|:----------|-----:|----:|
|model1_fit |    lm|     |
|model2     |    lm| 1.02|
Each model is compared to model1_fit.


# 5. Recursos

Lüdecke, Makowski, Waggoner & Patil (2020). Assessment of Regression   Models Performance. CRAN. Available from   https://easystats.github.io/performance/

Lüdecke, Makowski, Waggoner & Patil (2021). performance: Assessment of Regression   Models Performance. Journal of Open Source Software. 60(6). pp.3139. doi: 10.21105/joss.03139

Fox J, Weisberg S. Visualizing Fit and Lack of Fit in Complex Regression Models with Predictor Effect Plots and Partial Residuals. Journal of Statistical Software 2018;87. https://www.jstatsoft.org/article/view/v087i09

# 6. Reporte de progreso

¡Recuerda rellenar tu [reporte de progreso](). En tu correo electrónico está disponible el código mediante al cuál debes acceder para actualizar tu estado de avance del curso.
