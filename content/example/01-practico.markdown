---
title: "Variables aleatorias y distribuciones"
linktitle: "1: Variables aleatorias y distribuciones"
date: "2021-08-09"
menu:
  example:
    parent: Ejemplos
    weight: 1
type: docs
toc: true
editor_options: 
  chunk_output_type: console
---

## 0. Objetivo del práctico

El objetivo de este práctico es realizar un breve repaso a ciertos conceptos clave y definiciones básicas de los **fundamentos de probabilidad**, pasando por la definición de una variable, sus distribuciones, y las formas de medirlas y/o resumirlas.

Recordar que la idea principal que se encuentra a la base de la probabilidad refiere a que cuando observamos el comportamiento del azar, este resulta impredecible con pocas repeticiones pero presenta un **comportamiento regular y predecible** con muchas repeticiones.

### Materiales de la sesión

Recuerden que los archivos asociados a este práctico los pueden encontrar en: Apéndice A1 y B - Woolridge

## 1. Variables aleatorias y sus distribuciones de probabilidad

Las Variables Aleatorias (VA) son **variables estadísticas** en la que sus valores se obtienen a partir del resultado de algún tipo de experimento. En otras palabras, son variables cuyos valores son **resultados numéricos** de un fenómeno aleatorio. Un ejemplo de experimento puede ser algo tan simple como lanzar una moneda 20 veces y anotar las veces que obtenemos cara. La cantidad de veces que efectivamente salió cara en el experimento constituye una variable aleatoria. Este experimento puede ser realizado infinitas veces, y en otro ensayo se puede obtener un resultado completamente distinto.

Las variables aleatorias se dividen en *discretas* y *continuas*. Una **variable aleatoria discreta** es una variable que solo toma una cantidad finita o una cantidad infinita contable de valores. *¿Qué significa esto?* Significa que aunque la variable pueda tener resultados infinitos, estos solo toman valores enteros positivos. Por ejemplo, si lanzamos un dado y anotamos el resultado, solo podemos tener valores del 1 al 6. En ningún caso tendremos un resultado negativo o con decimales. 

En ciertas ocasiones, estimaremos eventos que son cualitativos. Por ejemplo, nos interesa estimar la participación de los alumnos de enseñanza media en manifestaciones del estallido social. En ese caso, la variable también toma valores numéricos. Se puede definir la variable como: *X = 1* si se participa en la manifestación, *X = 0* si no se participa. En esta situación, como podrán notar, nos enfrentamos a una variable aleatoria discreta. Además, cuando una variable **solo** puede tomar los valores de 0 y 1, hablamos de una **variable binaria**.

Las variables aleatorias discretas se describen estadísticamente por su *distribución de probabilidad.* Esta corresponde a la probabilidad de la ocurrencia de cada valor de la variable. Siguiendo con el ejemplo del lanzamiento de un dado, su distribución de probabilidad consiste en todos los valores que puede tomar la variable (1 al 6) y la probabilidad de obtener cada una de ellas (en este caso, cada valor tiene una probabilidad de 1/6). La suma de la distribución de probabilidad es igual a 1.

Las variables aleatorias discretas se pueden representar en tablas o cuadros. Por ejemplo, si la variable corresponde a la cantidad de hijos: 

**Tabla 1: Distribución de Probabilidad Variable Cantidad de Hijos**

![](images/tabla00.png){width="529"}

**Gráfico 1: Distribución de Probabilidad Variable Cantidad de Hijos (en porcentaje)**

![](images/grafico01.png){width="549"}

Además de la distribución de probabilidad, también existe la **distribución de probabilidad acumulada**, la cual determina la probabilidad de que una variable sea igual o menor a un valor concreto. Siguiendo con la variable cantidad de hijos:

**Tabla 2: Distribución de Probabilidad Variable Cantidad de Hijos**

![](images/tabla001.png){width="529"}

***Gráfico 2: Distribución de Probabilidad Acumulada (en porcentaje)***

![](images/grafico02-01.png){width="529"}

Por su parte, las **VA continuas (VAC)** indican que X puede tomar ciertos valores con probabilidad cero, es decir, una variable `\(X\)` es una variable aleatoria continua si la probabilidad de que la variable aleatoria tome cualquier valor real sea igual a cero. *¿Cómo es posible esto?* La idea es que los valores que puede tomar una variable aleatoria continua son tantos que es imposible contarlos. Es por esto que la probabilidad de que la variable tome cada uno de estos valores es cero.

Estas se describen por medio de su **función de densidad de probabilidad (fdp)**, la cual resume la información concerniente a los valores que puede tomar `\(X\)` y a sus correspondientes probabilidades. La fdp de una variable continua solo se utiliza para calcular eventos que comprenden un *rango* de valores. Un ejemplo de una variable continua donde nos podría interesar su rango de valores consiste en los ingresos de un hogar.

***Gráfico 3: Función de Densidad de Probabilidad***

![](images/grafico03.png){width="468"}

En este gráfico podemos observar que:

$$
Pr(-2\leq X \leq 1)
$$

se encuentra representada por el área debajo de la curva. Es decir, la probabilidad de que X se encuentre entre -2 y 1 es el *área bajo la curva* entre esos puntos en el gráfico. Como resume probabilidades, toda el área bajo la curva de la fdp debe ser igual a uno.

Para todas las distribuciones continuas importantes en la probabilidad y en la estadística, las funciones de distribución acumulada ya han sido tabuladas, y la más conocida de estas es la **distribución normal**, la cual tendrá un rol fundamental a lo largo del curso.

## 2. Distribuciones conjuntas, condicionales, marginales e independencia

### 2.1 Distribución Conjunta

En muchos casos, resulta interesante estudiar de manera conjunta el comportamiento de las variables. En dichos caso, se construye lo que se denomina **distribución conjunta**. Su objetivo consiste en determinar cómo la variación de una variable se relaciona con la de otra. En el caso de que  `\((X,Y)\)` sean variables aleatorias discretas, entonces `\((X,Y)\)` tienen una distribución conjunta, descrita completamente por la **función de densidad de probabilidad conjunta** de `\((X,Y)\)`.

En palabras más simples, la distribución conjunta corresponde a la probabilidad de que ocurran dos o más variables aleatorias, al mismo tiempo. Un ejemplo de estudio puede ser la relación entre ingreso y el gasto en vestimentas en un mes.

***Tabla 3: Distribución Conjunta del Gasto en Vestimenta***

![](images/tabla01.png){width="506"}

***Tabla 4: Distribución Marginal del Gasto en Vestimenta***

![](images/tabla02.png){width="489"}

Las casillas en color rosado nos muestra la *distribución marginal* del gasto en vestimenta.

### 2.2 Distribución Marginal

Las distribuciones de la variable fila y de la variable columna, de forma separada, se llaman **distribuciones marginales**, ya que aparecen en los márgenes derecho e inferior de la tabla de contingencia. La columna de totales y la fila de totales de una tabla de contingencia dan las distribuciones marginales de las dos variables de forma separada. **Las distribuciones marginales no dan información sobre la relación entre las variables.**

Cada componente de una variable aleatoria bidimensional es una variable aleatoria unidimensional en sí misma. Es por esto que nos puede interesar conocer la distribución de un componente por separado, sin tener en cuenta el otro componente. Eso se denomina marginar, y la **distribución de la variable unidimensional** por separado se llama distribución marginal.

La **distribución marginal** del gasto en vestimenta equivale a su **distribución unidimensional**:

***Tabla 5: Distribución Marginal del Gasto en Vestimenta***

![](images/table03.png){width="413"}

La **media** es de 2777.5 y la **desviación estándar** es de 1739.

### 2.3 Distribución Condicional

En otras ocasiones, es posible que nos interese el *efecto* que tiene cierta variable sobre otra. Es decir, el efecto que podría tener una variable Y sobre una variable X. Para poder acercarnos a esto recurrimos a la **distribución condicional**, cuya información se encuentra resumida en la *función de densidad de probabilidad condicional*. 

Para hallar la distribución condicional de la variable fila con relación a un valor determinado de la variable columna, fíjate sólo en esa columna de la tabla. Expresa cada valor de la columna como un porcentaje del total de la columna. Existe una distribución condicional de la variable fila para cada columna de la tabla. La comparación de estas distribuciones condicionales es una manera de mostrar la asociación entre la variable fila y la variable columna. Es especialmente útil cuando la variable columna es la variable explicativa.

Una característica importante de las distribuciones condicionales es que, si X y Y son variables aleatorias independientes, conocer el valor que toma X no dice nada acerca de la probabilidad de que Y tome diversos valores (y viceversa). Por ejemplo, si queremos conocer el impacto que tiene el ingreso en el gasto en vestimenta, no nos interesa realmente la variable ingreso como tal, solo su aporte al gasto en vestimenta. Si estas dos variables son independientes (propiedad que revisaremos más adelante), conocer el gasto en vestimenta no nos dirá nada acerca de los valores que podrían tomar los ingresos.

***Tabla 6: Distribución Condicional del Gasto en Vestimenta***

![](images/tabla04.png){width="456"}

La media condicional para la fila amarilla es de 1815, para la fila verde de 1949.2 y para la fila roja es de 3365.8.

### 2.4. Media condicional

Una manera sencilla de resumir la distribución condicional entre dos variables corresponde a la **esperanza o media condicional**. Esta corresponde al valor esperado de una variable aleatoria respecto a una distribución de probabilidad condicional. Pero, *¿qué es el valor esperado?*

El valor esperado, o esperanza, corresponde a al promedio ponderado de todos los posibles valores de una variable aleatoria X. Este se denota `\(E(X)\)`, `\(μX\)` o `\(μ\)`. Ahondaremos sobre la esperanza más adelante.

***Tabla 7: Media vs media condicional***

![](images/tabla06.png){width="440"}

[Ventaja:]{.ul} aprovechar la información contenida en la variable ingreso.

### 2.5. Independencia

La independencia de variables aleatorias es un concepto muy importante. Decimos que X e Y son independientes si conocer el valor de una de las variables no aporta información sobre la otra. En otras palabras, si la **distribución condicional** de Y dado X es igual a la **distribución marginal** de Y. Por ejemplo, si lanzamos una moneda y en el primer intento da cara, luego en el segundo lanzamiento vuelve a dar cara, decimos que los sucesos "cara en el primer lanzamiento" y "cara en el segundo lanzamiento" son **independientes.** Esto significa que el resultado del primer lanzamiento no puede influir sobre el del segundo.

Formalmente,

$$
Pr(Y=y|X=x)=Pr(Y=y)
$$

Su implicancia es:

$$
Pr(X=x,Y=y)=Pr(X=x)*Pr(Y=y)
$$

## 3. Características de las distribuciones de probabilidad

### 3.1 Medidas de Tendencia Central: Valor esperado o esperanza

El **valor esperado** o la **esperanza** es uno de los conceptos más importantes de la probabilidad al cual también se le suele llamar media poblacional, en especial cuando se quiere hacer énfasis en que representa una variable poblacional (contenido que revisaremos en el siguiente práctico). Es un **promedio ponderado** de todos los posibles valores de X, es decir, la suma de **todas** las puntuaciones de una variable X dividida por el número de observaciones. 

Para manipular los valores esperados, existen ciertas reglas que denominaremos como propiedades. A continuación se exponen las más importantes: 

1. **Propiedad 1:** Para cualquier constante `\(c\)` (es decir, cualquier variable que no depende de ninguna otra), su valor esperado será el valor de la misma constante. Matemáticamente: 

`$$E(c) = c$$`
Recordar que como una constante no depende de ninguna otra variable, su valor es siempre el mismo.

2. **Propiedad 2:** Para cualquier par de constantes *a* y *b*, el valor esperado de la recta `\(aX + b\)` será igual a: 

`$$E(aX + b) = aE(X) + b$$`
Asimismo, 

`$$E(aX) = aE(X)$$`

Esta propiedad es muy importante al momento de interpretar los resultados de una **regresión**, lo que veremos más adelante. 

3. **Propiedad 3:** Si tenemos un conjunto de constantes *a* y un conjunto de variables aleatorias *X*, entonces se puede expresar que el valor esperado de una suma es la suma de los valores esperados. Esto es: 

`$$E(a_1X_1 + a_2X_2 + ... +a_nX_n) = a_1E(X_1) + a_2E(X_2) + ... + a_nE(X_n)$$`
### 3.2 Medidas de tendencia central: Mediana

En general, es la puntuación que se encuentra en la mitad de una distribución de puntuaciones x. Indica el valor bajo el cual se encuentra el 50% de los casos. Su cálculo sólo exige orden en las puntuaciones. En definitiva, es el **valor** que se ubica en la **mitad** de la distribución de los datos.

Si X es continua, entonces la mediana de X, llámese m, es el valor tal que una mitad del área bajo la curva de la Función de Densidad de Probabilidad queda a la izquierda de m y la otra mitad del área queda a la derecha de m. Si X es discreta y toma una cantidad finita de valores, la mediana se obtiene ordenando todos los posibles valores de X y seleccionando después el **valor** que se encuentra al **medio**.

Por ejemplo, si X toma los valores {-4, 0, 2, 8, 10, 13, 17}, entonces la mediana de X es 8. 

Si X toma un número par de valores, como podran imaginar, hay dos valores en el medio. En esos casos, se deben promediar ambos valores para obtener un único valor para la mediana. Por ejemplo, si X toma los valores {-5, 3, 9, 17}, entonces se deben promediar los valores medianos de 3 y 9. La mediana, por lo tanto, es 6.

### 3.3 Medidas de tendencia central: Moda

El **atributo** que más se repite o posee **mayor frecuencia** en una muestra. 

Por ejemplo, si X toma los valores {-2, 0, 5, 5, 7, 8, 8, 8, 8, 17, 20, 20}, la moda es 8.

### 3.4 Medidas de Variabilidad o Dispersión: Varianza

Aunque conocer la esperanza, la mediana y la moda de una variable es algo valioso, no nos entrega toda la información que deseamos sobre la distribución de una variable aleatoria. Es por esto que también se recurre a las **medidas de variabilidad**, que nos resumen la dispersión de las variables. Como se evidencia en el siguiente gráfico, tres variables pueden tener la misma media, pero sus distribuciones pueden ser *muy* distintas. 

(foto del woolridge)

Una de las medidas de variabilidad más importante es la **varianza** ($σ²$). Esta resume que tan lejos se encuentra, en promedio, una variable de su media. Esta se calcula: 

`$$Var (X) = \frac{(x_1 - μ)^2 + (x_2 - μ)^2 + ...+ (x_n - μ)^2}{n}$$`
Recordemos que **x** representa las observaciones. Por ejemplo, **x_1** representa la observación número 1 de la variable. **μ** representa la media de la variable. **n** es el número total de observaciones. La fórmula de la varianza también se puede resumir de la siguiente forma: 

$$Var(X) = \frac{\sum_{i=1}^{n} (x_i - μ)^2}{n} $$
A continuación, presentaremos dos propiedades muy importantes de la varianza: 

1. **Propiedad 1:** La varianza de cualquier constante *c* es cero. Y si `\(Var(X) = 0\)`, significa que la variable es una constante. 

2. **Propiedad 2:** Para cualquier constante *a* y *b*, `\(Var(aX + b) = a^2Var(X)\)`

En palabras simples, esto significa que sumar una constante a una variable aleatoria no modifica la varianza. Por ejemplo, si a todos los valores de una variable le sumo 2, el valor de la varianza se mantiene igual.

Sin embargo, multiplicar una variable aleatoria por una constante aumenta la varianza en un factor igual al *cuadrado* de la constante. 

### 3.5 Medidas de Variabilidad o Dispersión: Desviación Estándar

La **desviación estándar** (σ) de una variable aleatoria también nos entrega información sobre la dispersión de una variable aleatoria. Esta es siempre igual o mayor que cero. En definitiva, no es más que la raíz cuadrada de la varianza. O bien, la varianza es la desviación estándar elevada al cuadrado. Sin embargo, la desviación estándar es mucho más intuitiva cuando llega la hora de interpretar resultados. Una desviación estándar baja indica que la mayor parte de los datos se encuentran agrupados alrededor de su media, mientras que una desviación estándar alta indica que la mayor parte de los datos se alejan de la media, o sea, se extienden sobre un rango de valores más amplio.

`$$sd(X)  \equiv + \sqrt{Var(X)}$$`

De las propiedades de la varianza, se deducen también dos propiedades sobre la desviacón estándar: 

1. **Propiedad 1:** Para toda constante *c*, su desviación estándar es igual a 0.

2.**Propiedad 2:** Para todas las constantes *a* y *b* , 

`$$sd(aX + b) = |a|sd(X)$$`
Cuando a todos los valores de una variable aleatoria se le suma un número, la desviación típica permanece igual. No obstante, cuando todos los valores de la variable son multiplicados por un mismo número, la desviación típica también quedará multiplicada por ese mismo número.

## 4. Características de las distribuciones conjuntas y de las condicionales

### 4.1 Covarianza

En el primer apartado, introducimos el concepto de probabilidad conjunta, cuando dos VA pueden tomar simultáneamente ciertos valores concretos. A pesar de esto, es útil tener una medida resumida del promedio de la variación de estas dos variables aleatorias, unas respecto a la otra. 

La **covarianza** refleja la **relación lineal** de dos variables aleatorias. Es una medida de dependencia lineal entre dos variables y si es positiva indica que las dos variables aleatorias se mueven en la misma dirección, mientras que si es negativa indica que las dos variables se mueven en direcciones opuestas. 

Formalmente,

$$
Cov(X,Y)=E[(X-\mu_x)(Y-\mu_y)]= \sigma_{xy} 
$$

Dos propiedades importantes de la covarianza son las siguientes: 

1. **Propiedad 1**: Si X e Y son independientes, entonces su covarianza es 0. 

Es importante recalcar que el inverso **no** es verdad: cero covarianza entre X e Y no implica que X e Y sean independientes. Esto solo implica que no existe una relación *lineal* entre ellas. 

2. **Propiedad 2**: Para todas las constantes `\(a_1, b_1, a_2\)` y `\(b_2\)`, 

$$Cov(a_1X + b_1, a_2Y + b_2) = a_1a_2Cov(X, Y) $$
De esto se desprende que la covarianza entre dos variables aleatorias puede alterarse simplemente multiplicando una o las dos variables por una constante. 

### 4.2 Correlación

Como vimos en la segunda propiedad de la covarianza, esta se altera fácilmente al multiplicarla por cualquier constante. Por ejemplo, si queremos calcular la covarianza entre ingresos y cantidad de educación, esta dependerá si ingresos se mide en dólares, miles de dólares, miles de pesos, etc. Asimismo, dependerá también si cantidad de educación se mide en años o meses. Esta deficiencia se supera mediante el **coeficiente de correlación**, lo que facilita la interpretación de resultados. 

Formalmente,

$$ corr(X,Y)=\frac{cov(X,Y)}{\sqrt{var(X)var(Y)}}=\frac{\sigma_{xy}}{\sigma_{x}\sigma_{y}}$$
Si X e Y son independientes, entonces su correlación es igual a 0. Pero la correlación cero no implica independencia, solo significa que no existe una relación lineal entre las variables. 

Dos propiedades importantes de la correlación son:

1. **Propiedad 1**: $-1\leq corr(X,Y) \leq1 $

Esto significa que los valores del coeficiente de correlación van desde -1 a 1. Si `\(Corr(X, Y) = 0\)`, se dice que X e Y son variables aleatorias no correlacionadas. De lo contrario, están correlacionadas. 

`\(Corr(X, Y) = 1\)` implica una relación lineal positiva perfecta, mientras `\(Corr(X, Y) = -1\)` implica una relación lineal negativa perfecta. Rara vez se obtienen estos valores, pero mientras más cerca esté la correlación del 1 o el -1, más fuerte es la relación lineal. 

2. **Propiedad 2**: Para todas las constantes `\(a_1, b_1, a_2\)` y `\(b_2\)`, con `\(a_1, a_2 > 0\)`:

`$$Corr(a_1X + b, a_2Y + b_2) = Corr(X, Y)$$`
Con `\(a_1, a_2 < 0\)`: 

`$$Corr(a_1X + b, a_2Y + b_2) = - Corr(X, Y)$$`
Esto significa que, al multiplicar las variables por una constante, la correlación no sufre cambios. Por ejemplo, tenemos que la correlación entre cantidad de educación e ingresos es 0.15. Este resultado no cambia, es independiente si los ingresos se miden en dólares o millones de pesos, o si la educación se mida en años, meses o semestres.

***Gráfico 5: Tipos de correlaciones***

![](images/grafico05.png){width="468"}

## 5. Resumen

En este práctico realizamos un repaso de algunos **conceptos claves** que son fundamentales estadística básica e inferencial aplicada a la probabilidad, estos se centraron en:

1.  Distribución Conjunta, Marginal, y Condicional

2.  Independencia

3.  Covarianza y Correlación
