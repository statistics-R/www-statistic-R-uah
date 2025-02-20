---
title: "Inferencia"
linktitle: "2: Inferencia"
date: "2021-08-09"
menu:
  example:
    parent: Ejemplos
    weight: 2
type: docs
toc: true
editor_options: 
  chunk_output_type: console
---

## 0. Objetivo del práctico

Este práctico tiene por objetivo el repaso de los contenidos relacionados con la **inferencia estadística**. Esta hace referencia a los métodos que nos permiten saber algo sobre una población definida, utilizando la información que nos entrega una muestra de esa población.

Repasaremos, específicamente, las propiedades de los estimadores, test de hipótesis e intervalos de confianza.

## 1. Propiedades de Estimadores

Al trabajar en una investigación, es muy probable que no podamos acceder a los datos de la población entera que nos interesa estudiar. Hasta ahora, hemos estudiado propiedades y estadísticos útiles para sacar conclusiones acerca de los datos que poseemos. Pero, **¿Qué pasa cuando necesitamos saber algo acerca de una población?**

Como **población** se entiende cualquier grupo definido de elementos que buscamos estudiar. Este grupo puede ser las personas de un país, los estudiantes de una ciudad, las empresas de determinado rubro, etc. Una población puede ser de interés para investigaciones, diseños de políticas públicas, sondeos de opinión, investigaciones de mercado, entre muchas otras posibilidades.

No obstante, resulta muy difícil acceder a una población para estudiarla. Por ejemplo, si buscamos estudiar a la población chilena mayor de 18 años, es imposible aplicar una encuesta a todas las personas que conforman esta población. Es por esto que se recurre a una **muestra**, la que constituye una selección de una parte de la población que nos interesa. A través de una muestra, podemos conocer algo sobre la población.

Pero, *¿qué es ese algo?*. A las constantes que determinan direcciones y fortalezas de las relaciones entre variables de una población les denominamos **parámetros**. 

Para conocer estos parámetros, es necesario recurrir a los **estimadores**.

Dada una muestra aleatoria { `\(Y_1,Y_2, ..., Y_n\)` } extraída de una población que depende de un parámetro desconocido θ, un **estimador** de θ es un estadístico que asigna a cada resultado posible de la muestra un valor de θ. El valor de un estimador entrega una **estimación puntual** del parámetro poblacional. 

Un ejemplo de estimador es el promedio de una muestra aleatoria, que recibe el nombre de **promedio muestral**. Anteriormente tratamos al promedio como un *estadístico descriptivo* de un conjunto de datos, pero ahora se trata de un *estimador*, en el sentido de que funciona como un estadístico que busca acercarse a la media poblacional ($\mu$)

Formalmente, la media muestral es:
`$$\overline{y} = \frac{1}n\sum_{i=1}^{n}Y_i$$`

Otro ejemplo de estimador corresponde a la **varianza muestral**, que busca estimar la varianza poblacional ($σ²$).

Formalmente, la varianza muestral es: 

`$$S_Y^2 = \frac{1}{n-1}\sum_{i=1}^{n}(Y_i - \overline{Y})^2$$`

Para poder escoger un estimador, es necesario evaluarlos mediante distintas propiedades de su distribución de probabilidades. Estas propiedades dependen de los datos que poseamos: existen propiedades para muestras *pequeñas o finitas*, y propiedades para *muestras grandes*. A continuación repasaremos las más importantes. 

### Propiedades en muestras finitas

Las propiedades que revisaremos a continuación corresponden a muestras **finitas** o **pequeñas**.

#### a) Insesgamiento

Un estimador es insesgado cuando su valor esperado es igual al parámetro que buscamos estimar. Si pudieramos calcular muestras aleatorias infinitas de nuestra población de interés, calcular el estimador para cada una de ellas y después promediar, obtendríamos el parámetro. Que un estimador sea insesgado es muy importante, pues nos asegura que la estimación calculada sea la más aproximnada al valor poblacional real.

En otros términos, si `\(t(x)\)` es un estimador de un parámetro θ, y sea f(*t*,θ) la función de densidad de probabilidad de *t*. Entonces, t es *insesgado* si `\(E(t) =\)` θ

La **media muestral** es un ejemplo de estimador insesgado de la media poblacional de una población determinada. Al incrementar el tamaño muestral, su varianza puede acercarse mucho al cero.

En términos matemáticos,sea `\(Y_1, Y_2, ..., Y_n\)` una muestra aleatoria de una población media `\(\mu_y\)`:

$$ \overline{y} =   \frac{1}{n} (Y_1 +Y_2 + ... + Y_n) = \frac{1}{n}\sum_{i=1}^{n} Y_i $$

Reemplazamos en la fórmula del valor esperado:

$$E(\overline{y}) = E(\frac{1}{n}\sum_{i=1}^{n} Y_i) = \frac{1}{n}\sum_{i=1}^{n}E(Y_i) $$ `$$=  \frac{1}{n}\sum_{i=1}^{n}\mu_y = \mu_y$$`

Para un estimador `\(W\)` que no es insesgado, o sea, que es **sesgado** de un parámetro θ, su sesgo se define como:

`$$Sesgo(W) = E(W) - θ$$`

### Propiedades asintóticas

Estas propiedades se encuentran relacionadas con el comportamiento de los estimadores a medida que el tamaño de la muestra aleatoria crece sin límites. También se les suelen denominar **propiedades de muestra grande** ($n → ∞$). Estas se encuentran basadas en la idea de que mientras *más* grande es el tamaño de la muestra, *mejor* es el procedimiento de estimación.

#### a) Consistencia

La consistencia hace referencia a qué tan lejos es probable que el estimador se encuentre del parámetro, a medida que el tamaño de la muestra aumente de manera indefinida. Es decir, un estimador consistente se concentra cada vez más alrededor del valor del parámetro, lo que significa que en las muestras mayores, es cada vez menos probable que el estimador se aleje del parámetro.

En otras palabras, un estimador consistente posee un sesgo que se aproxima a cero cuando el tamaño de la muestra es grande o tiende al infinito.

Si un estimador no es consistente, entonces no es útil saber sobre el parámetro. Es por esta razón que que la consistencia es un **requisito mínimo** de un estimador.

Un estimador consistente es el promedio de una muestra aleatoria, extraído de una población. Esto es porque, mientras más grande sea el tamaño de la muestra, su varianza se acercará al 0. Por tanto, `\(Var(\overline{y}) → 0\)` cuando `\(n → ∞\)`, así que `\(\overline{y}_n\)` es consistente de `\(\mu\)`, además de ser insesgado.

#### b) Precisión

Un estimador es más preciso cuando más pequeña la varianza de su distribución muestral. La precisión del estimador aumentará mientras más grande sea la muestra con la que trabajemos. De hecho, la varianza puede acercarse mucho al cero cuando se incrementa el tamaño muestral.

Mientras más pequeña sea la varianza, y por lo tanto más precisio nuestro estimador, nuestro **error de estimación** será menor. 

#### c) Teorema Central del Límite

Si poseemos una muestra aleatoria de determinada población, su distribución de medias muestrales se acercará cada vez más a una **distribución normal** a medida que el tamaño de la muestra aumente y tienda al infinito.

Sea `\(Y_1, Y_2, ..., Y_n\)` una muestra aleatoria de una población con media `\(\mu\)` y varianza `\(σ²\)`. Entonces,

$$\sqrt{n}(\overline{y} - \mu) →^d N(0,σ²) $$ donde `\(d\)` significa que la expresión converge en distribución normal cuando `\(n\)` tiene al infinito ($n → ∞$)

Este teorema es muy importante, pues para realizar diversos procesos estadísticos como las **pruebas de hipótesis**, es necesario asumir que las medias muestrales se distribuyen de manera normal.

Además, es importante recalcar que este teorema se aplica independientemente de la distribución que presente la población.

![](https://github.com/statistics-R/practico-2/raw/main/input/TLC.png)

## 2. Test de Hipótesis

Hasta ahora hemos abordado estimadores **puntuales**, en el sentido de que nos entregan un valor poblacional específico. No obstante, esta información no es suficiente para probar teorías , analizar diversas políticas o realizar una investigación social.

Cuando necesitamos una respuesta definitiva de "sí" o "no", recurrimos a una prueba o test de hipótesis. Esta técnica permite evaluar la información contenida en los datos, y poder realizar conclusiones acerca de la población que estamos estudiando.

Una pregunta de investigación que puede ser respondida, por ejemplo, a través de una prueba de hipótesis corresponde a: **¿Las personas negras sufren discriminación en el proceso de contratación?** Mediante esta técnica y un set de datos, podemos llegar a una respuesta.

### a) Planteamiento de Hipótesis

El primer paso para realizar una prueba es establecer una hipótesis. Esta puede ser una respuesta tentativa a una pregunta de investigación, o un planteamiento sobre una población a estudiar. En definitiva, la hipótesis nos dice algo sobre la población, y mediante la prueba de hipótesis podemos evaluar y concluir si ese algo es válido o no.

Una de las hipótesis es la **hipótesis nula** (H~0~). Esta es la hipótesis que queremos contrastar, y siempre se asume que es verdadera hasta que se pruebe lo contrario de manera contundente a través de los datos. Siguiendo el ejemplo, una hipótesis nula es que las personas negras tienen las misma probabilidad de recibir ofertas de trabajo que las personas blancas. En otras palabras, no existiría diferencia entre las personas negras y las personas blancas en un proceso de contratación laboral. 

Frente a esta hipótesis, se plantea una **hipótesis alternativa** (H~1~), que es la hipótesis que buscamos probar utilizando un set de datos. Esta hipótesis anticipa la existencia de una diferencia entre los grupos. Siguiendo el ejemplo, una hipótesis alternativa es que las personas negras poseen una probabilidad menor de recibir ofertas de trabajo frente a las personas blancas. 

### b) Tipos de Error

Cuando se realiza una prueba de hipótesis, se pueden cometer dos tipos de errores. Uno de ellos es rechazar la hipótesis nula H~0~ cuando de hecho es verdadera. Este error recibe el nombre de **error tipo I**. En el ejemplo, un error tipo I sería afirmar que sí existe discriminación hacia las personas negras frente a las personas blancas en un proceso de contratación laboral, cuando en realidad no existe tal cosa.

Otro tipo de error corresponde a aceptar H~0~ como verdadera cuando en realidad es falsa. A este error se le denomina **error tipo II**. En el ejemplo, un error tipo II sería afirmar que no existe discriminación hacia las personas negras en comparación con las personas blancas en un proceso de contratación laboral, cuando en realidad sí existe tal discriminación.

En la práctica, nunca sabremos con certeza si cometimos un error o no. No obstante, es posible calcular la *probabilidad* de cometer un error tipo I. Para aquello, se define el **nivel de significancia** de una prueba, que suele denotarse como `\(\alpha\)`. Se tiene:

`$$\alpha = P(Rechazar H_0 | H_0 verdadero)$$`

Esto se lee como "la probabilidad de rechazar H~0~ cuando H~0~ es verdadera"

### c) Estadístico de contraste

Una vez definidas las hipótesis, es necesario elegir un estadísito de prueba para comparar la información que nos entrega la muestra con la hipótesis nula. El estadístico de prueba (*T*) es una variable aleatoria que depende de la muestra, y a partir de su cálculo, se puede definir una regla de rechazo. En otras palabras, utilizando el estadístico *T* podemos establecer cuándo se rechaza H~0~ en favor de H~1~, y viceversa.

Las reglas del rechazo están basadas en comparar el **valor del estadístico de prueba (*t*)** con un **valor crítico (*c*)**. Para determinar este valor, se debe definir el nivel de significancia de la prueba ($\alpha$). Para el nivel de significancia se suelen utilizar los valores de 0,1; 0,05; 0,01. Este valor implica, por ejemplo, que el investigador está dispuesto a rechazar H~0~ incorrectamente un 5% de las veces, si se considera `\(\alpha\)` = 0,05. En otras palabras, la probabilidad de un error tipo I es de 5%.

Una vez establecido el nivel de significancia, es posible calcular el valor crítico mediante la distribución de *T*, *suponiendo* que H~0~ es verdadera. Los valores de *t* que resulten en el rechazo de la hipótesis nula se conocen como la **región de rechazo**. 

Teniendo eso en consideración, la hipótesis nula se expresa como `\(H_0: \mu = \mu_0\)`, donde `\(\mu_0\)` es un valor que se especifica. Siguiendo el ejemplo expuesto con anterioridad, la hipótesis nula corresponde a `\(H_0: \mu = 0\)`. Es decir, la diferencia de probabilidades de que las personas negras reciban ofertas de trabajo con relación a las personas blancas es 0.

Sobre la hipótesis alternativa, existen tres opciones. Dos de ellas son test unilaterales o de "una cola":

`$$H_1: \mu > \mu_0$$`

`$$H_1: \mu < \mu_0$$`

También existe el test bilateral o de "dos colas":

`$$H_1: \mu ≠ \mu_0$$`

Siguiendo el ejemplo, la hipótesis alternativa corresponde a `\(H_1: \mu < 0\)`. Es decir, la diferencia de probabilidades de que las personas negras reciban ofertas de trabajo con relación a las personas blancas es menor a 0, lo que significaría discriminación en los procesos de contratación. En este caso, $\mu = θ_B - θ_W $ es la diferencia de probabilidades de que las personas negras recibieran ofertas de trabajo con relación a los blancos.

Siguiendo este ejemplo, correspondería realizar un *test unilateral de cola izquierda*.

#### Test Bilateral

![](https://github.com/statistics-R/practico-2/raw/main/input/test_bilateral.png)

En este tipo de test, la regla general para descartar H~0~ es que el valor absoluto del estadístico *t* sea mayor al valor absoluto crítico *c*. Es decir:

`$$|t| > |c|$$`

#### Test Unilateral Derecho

![](https://github.com/statistics-R/practico-2/raw/main/input/test_unilateral_derecho.png)

En este tipo de test, la regla general para descartar H~0~ es que el valor del estadístico *t* sea mayor al valor crítico *c*. Es decir:

`$$t > c$$`

#### Test Unilateral Izquierdo

![](https://github.com/statistics-R/practico-2/raw/main/input/test_unilateral_izquierdo.png)

En este tipo de test, la regla general para descartar H~0~ es que el valor del estadístico *t* sea menor al valor negativo crítico *c*. Es decir:

`$$t <  -c$$`

Supongamos que el valor de estadístico *t* para probar que `\(H_0: \mu = 0\)` en el ejemplo de discriminación laboral es -4.29. El valor crítico, con un nivel de significancia de 0.05, es -2.58. El valor *t* de -4.29 es una evidencia grande en contra de la hipótesis nula, pues se encuentra a la izquierda del valor crítico. Por lo tanto, se aprueba `\(H_1\)` y se concluye que existe discriminación en la contratación entre personas negras y personas blancas. 

### d) Estimación de T

Al realizar una prueba de hipótesis sobre la media muestral, nos podemos encontrar con 3 casos distintos.

Un **primer caso** corresponde a que, al momento de realizar la prueba, conocemos que *Y* se distribuye normalmente y, además, conocemos el valor de la varianza poblacional `\(σ_y^2\)`. Entonces, asumiendo que H~0~ es verdadera, tenemos:

`$$\overline{y}\sim N(\mu_0,\frac{σ_y^2}{n})$$` Por lo tanto, el estadístico de prueba corresponde a:

$$T = \frac{\overline{Y} - \mu_0}{σ_y/\sqrt{n}} \sim N(0,1) $$ Un **segundo caso** corresponde a realiar una prueba de hipótesis sobre la media `\(\mu\)` de una población cuando la varianza `\(σ_y^2\)` es desconocida, y además sabemos que *Y* distribuye normalmente. Como primer paso, se debe estimar la varianza muestral:

`$$S_Y^2 = \frac{1}{n-1}\sum_{i=1}^{n}(Y_i - \overline{Y})^2$$` Luego, el estadístico de prueba corresponde a:

$$T = \frac{\overline{Y} -\mu_0}{S_Y / \sqrt{n}}\sim t_n-1 $$ Un **tercer caso** corresponde a cuando no conocemos ni la distribución de `\(Y\)` ni su varianza `\(σ_y^2\)`. En este tipo de casos recordamos la propiedad asintótica para muestras grandes denominada como *Teorema Central del Límite*. La distribución `\(t_{n-1}\)` converge en una distribución normal estándar a medida que `\(n\)` aumenta, por lo que `\(t\)` y los valores críticos normales estándar estarán muy cerca para un `\(n\)` muy grande.

Entonces, basándonos el el Teorema Central del Límite, la elección entre `\(t\)` y las distribuciones normales estándar suele ser irrelevante debido a que los valores críticos son prácticamente iguales en muestras donde `\(n>120\)`.

Por lo tanto, el estadístico de prueba corresponde a:

`$$T = \frac{\overline{Y} -\mu_0}{S_Y / \sqrt{n}} →^a N(0,1)$$`

### e) Valores -p

Debido a que se pueden definir distintos niveles de significancia para realizar una prueba de hipótesis, surge la pregunta: **¿Cuál es el nivel de significancia máximo al cual se puede realizar la prueba y aún así no rechazar la hipótesis nula**?

Ante esa problemática, se puede calcular el valor*-p* de una prueba, que se define como la probabilidad mínima con la que podemos rechazar la hipótesis nula H~0~ sin necesidad de definir de antemano un nivel de significacia `\(\alpha\)`. El valor*-p* depende de la función de distribución del estadístico de contraste.

Dependiendo del tipo de test de hipótesis que queramos realizar, el valor*-p* se calcula:

`$$P-value = P(T > t | H_0)$$`

`$$P-value = P(T < t | H_0)$$`

`$$P-value = 2P(T > |t|  | H_0)$$`

Si el `\(valor-p < \alpha\)`, entonces se rechaza H~0~. En cambio, si el `\(valor-p ≥ \alpha\)` no se rechaza H~0~. En definitiva, un valor*-p* pequeño es evidencia fuerte en contra de H~0~.

## 3. Intervalos de Confianza

Debido al error de muestreo, es imposible conocer el valor exacto de la media poblacional a partir de los datos muestrales. Una estimación puntual puede ser una aproximación, pero esta no nos entrega información sobre que tan probable es que ese valor sea realmente cercano al parámetro poblacional.

Este problema se soluciona mediante los **intervalos de confianza**. Estos corresponden a un set de valores que contienen el verdadero valor poblacional de un parámetro, para un nivel de probabilidad dado.

Para el cálculo de intervalos de confianza, se suele usar un nivel de confianza de 95%. Esto significa que, para el 95% de las muestras aleatorias, el intervalo de confianza contendrá a la media poblacional.

Después de calcular un intervalo de confianza, se puede realizar una prueba de hipótesis de dos colas. Cuando el intervalo pasa por el valor 0, es posible establecer que se confirma la hipótesis nula `\(H_0\)`. Es decir, no existe significancia estadística. 

Las fórmulas para calcular un intervalo de confianza considerando un test bilateral al 95% de confianza son las siguientes:

-   { `\(\overline{y} ± 1.96 * (σ_y) / \sqrt{n}\)` }, cuando se conoce la distribución normal de `\(Y\)` y su varianza `\(σ_y^2\)`

-   { `\(\overline{y} ± t^{n-1}_{\alpha/2} * SE(\overline{y})\)` }, cuando se conoce la distribución normal de `\(Y\)`, pero se desconoce su varianza `\(σ_y^2\)`

-   { `\(\overline{y} ± 1.96 * SE(\overline{y})\)` }, cuando se desconoce tanto la distribución como la varianza de `\(Y\)`

## Resúmen Prueba de Hipótesis

Para finalizar este práctico, haremos un breve repaso acerca del procemiento para realizar una prueba de hipótesis. 

1. **Identificar las hipótesis**. De acuerdo al parámetro que estamos buscando y las suposiciones que surgen respecto a él, debemos identificar la *hipótesis nula* y la *hipótesis alternativa*. Importante es recordar que la hipótesis que se pondrá aprueba es la nula ($H_0$).

2. **Naturaleza de la prueba**. De acuerdo a la hipótesis alternativa establecida, se define la naturaleza de la prueba. Esta puede ser una *prueba de dos colas*, *prueba de una cola izquierda* o una *prueba de una cola derecha*. De acuerdo a la naturaleza, cambia la regla de rechazo para descartar `\(H_0\)`. 

3. **Nivel de confianza de la prueba**. El siguiente paso es establecer el nivel de confianza de la prueba de hipótesis, lo que nos permitirá posteriormente calcular el valor del estadístico de prueba. Para el nivel de significancia se suelen utilizar los valores de 0,1; 0,05; 0,01. En la mayoría de situaciones, utilizaremos un `\(\alpha\)` igual a 0,05 (95% de confianza)

4. **Valor crítico de t**. A continuación, buscaremos el valor crítico del estadístico de prueba de nuestro test. Para conocer este valor, necesitamos saber el *nivel de confianza* de la prueba (definido en el paso anterior) y los *grados de libertad*. Estos últimos, para la distribución *t de Student*, corresponden a `\(n-1\)`. En otras palabras, los grados de libertad a utilizar serán el valor del tamaño de la muestra, menos 1. Con esa información a mano, podemos buscar el valor crítico de nuestra prueba de hipótesis. Estos ya están calculados y se pueden encontrar en diversos softwares de estadística (como R), o bien seguir el método tradicional que es buscarlo en la **Tabla de la prueba T de Student**.

![](https://github.com/statistics-R/practico-2/raw/main/input/tabla_pruebat.jpg)

Por ejemplo, si establezco un nivel de confianza de 95% (0,05) y el valor de los grados de libertad es 14, el valor crítico para una prueba de una cola corresponde a 1.761. Si este valor es positivo o negativo depende del tipo de prueba que esté realizando. Si es una prueba de *cola izquierda*, el valor es -1.761, mientras si es una prueba de *cola derecha*, el valor es 1.761. 

Siguiendo el mismo ejemplo, el valor crítico para una prueba de dos colas corresponde a ±2.145. 

**¡Recordar!** Como vimos anteriormente, el valor crítico de muestras superiores a 120 es practicamente igual en la distribución t como en la distribución normal estándar. Es por esto que la tabla termina formalmente en el valor de 120 grados de libertad, y el siguiendo valor corresponde a un símbolo infinito ∞. Esto significa que se considera a los valores mayores a 120 como *muestras grandes* y, por lo tanto, se aplica el Teorema Central del Límite. 

5. **Cálculo estadístico de contraste**. De acuerdo a la información que tengamos disponible, seleccionamos la fórmula para calcular el estadístico de contraste. Esta elección dependerá de si poseemos el valor de la varianza y/o conocemos que la media poblacional se distribuye de manera normal. Como vimos anteriormente, existen 3 casos posibles. 

6. **Comparar estadístico de prueba y valor crítico**. Una vez calculado nuestro estadístico t, corresponde compararlo con el valor crítico de la prueba, siguiendo la regla de rechazo de `\(H_0\)` anteriormente escogida. De acuerdo a esto, se *acepta* o *rechaza* la hipótesis nula. 

**Opcional**. También podemos utilizar el *valor-p*, como revisamos anteriormente. Para aquello, debemos seguir las fórmulas expuestas arriba y comparar tal valor con nuestro nivel de significancia escogido. Recordar que mientras más pequeño sea el *valor-p*, más evidencia existe en contra de `\(H_0\)`.

7. **Sacar conclusiones**. Si bien ya terminamos con la parte más pesada de la prueba de hipótesis, es muy importante detallar nuestras conclusiones y explicar nuestros hallazgos de manera concreta y sencilla. 
