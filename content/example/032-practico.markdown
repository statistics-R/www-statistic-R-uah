---
title: "RStudio, tidyverse y RMarkdown"
linktitle: "3: RMarkdown"
date: "2021-08-16"
menu:
  example:
    parent: Ejemplos
    weight: 2
type: docs
toc: true
editor_options:
  chunk_output_type: console
---

# 0. Objetivo del práctico

El objetivo de este práctico es crear nuestro primer reporte en **RMarkdown** y contener en este el **primer paso de un código en R: cargar paquetes**.

Para ello repasaremos algunos conceptos básicos de R y Markdown, y los pasos necesarios para la creación de su propio archivo en .Rmd. Este práctico será clave para la realización de tu [tarea N°1](/assignment/01-tarea/)

##  Materiales de la sesión

Recuerden que los archivos asociados a este práctico se pueden descargar aquí:

- [<i class="fas fa-file-archive"></i> `02-class.zip`](https://github.com/learn-R/02-class/raw/main/02-clase.zip) 

## 1. Conceptos clave

[**RMarkdown**](https://rmarkdown.rstudio.com/) es un archivo que puede integrar código de R (mediante chunks) y texto en [**Markdown**](https://learn-r-uah.netlify.app/resource/markdown/) a la vez. Todo el sitio web de este curso está creado con RMarkdown (y [un paquete llamado **blogdown**](https://bookdown.org/yihui/blogdown/)).


{{< div "note" >}}
**RMarkdown** tienen una estructura de al menos 3 partes

1. Encabezado (YAML)
2. Texto
3. Código de R

{{< /div >}}

![](img/02/02rmd-example.jpg)

¡Vamos a profundizar en cada una de ellas! Pero antes te iremos mostrando el paso a paso para crear un archivo en .Rmd

##  2. Paso a paso para crear un RMarkdown

### Paso 1: Instalación de paquetes

Como vimos en la sesión, para la creación de un RMarkdown necesitamos dar una extensión a R que le permita "compilar" los archivos construidos en .Rmd a formatos como `.pdf`, `.html`, `.doc`. Para ello instalaremos 2 paquetes: `knitr` y `rmarkdown`

Usualmente para cargar paquetes lo hacemos de la siguiente manera:


```r
  install.packages("paquete")
  library(paquete)
```

Pero en esta ocasión utilizaremos un paquete llamado **pacman**, que facilita y agiliza la lectura de los paquetes a utilizar en R. De esta forma lo instalamos 1 única vez así:


```r
install.packages("pacman")
library (pacman)
```

Luego instalaremos y cargaremos los paquetes de R de la siguiente manera, volviendo más eficiente el procedimiento de carga de paquetes. Para este práctico cargaremos el paquete **rmarkdown** y **knit**.


```r
pacman::p_load(rmarkdown,
               knitr)
```

### Paso 2: Crear un nuevo archivo en Rmarkdown

1. Una vez cargados los paquetes deben dirigirse a `File > New File > R Markdown`

![](../../../../../../../../img/example/02practico/open_rmark_file.png)<!-- -->

2. Luego deben darle un título, poner su nombre y especificar un _formato de salida_, ya sea en **HTML**, **PDF** o **Word**

![](../../../../../../../../img/example/02practico/open_rmark_file2.png)<!-- -->

3. Se creará un archivo con un **_YAML_**, que tendrá la información general del documento; y un **_chunk_**, o trozo de código

![](../../../../../../../../img/example/02practico/open_rmark_file3.png)<!-- -->

4. Ya pueden comenzar a escribir sus informes en RMarkdown. Veremos en seguida las [configuraciones para dejarlo más lindo y presentable](#config)

### Paso 3: Crear el archivo con formato desde el .Rmd

![](https://github.com/hadley/r4ds/raw/master/images/RMarkdownFlow.png)

{{< div "note" >}}
Es el botón que permite *compilar* (tejer o unir) el documento que hemos escrito. Combinará tanto el código de R (insertado en *chunks*) y como el texto plano, a partir de las instrucciones que dimos en el YAML (¡por eso es tan importante!) 

{{< /div >}}

 <img src="../../../../../../../../img/assignments/knit-button.png" width="30%" />

Es **fundamental** que sepan que, cuando se hace **Knit**, RStudio ejecuta cada uno de los trozos **secuencialmente**. No es necesario entender el proceso posterior a cabalidad (aún) [^1]: lo importante que debes saber  es que, si todo lo que está dentro de tu .Rmd está bien hecho, deberías ver como resultado un archivo en el formato de salida que definiste en tu YAML (.pdf, .doc o .html).



[^1]: Luego de presionar *knit*, se convierte la salida de cada trozo en un archivo intermedio en Markdown. Posteriormente, RStudio hace "pasar" ese documento vía [pandoc](https://pandoc.org/) para convertirlo en HTML, PDF o Word (o cualquier salida que haya seleccionado).



## 3. Configuraciones del RMarkdown {#config}

### 3.1 Encabezado (YAML)

Al inicio del Markdown siempre especificar cierta información sobre el documento, por ejemplo, el título, la fecha, autor, entre otras. Esta parte del Markdown se llama [YAML](https://learn.getgrav.org/16/advanced/yaml).

Básicamente, con esto establecemos las "configuraciones" del texto.

Por ejemplo, si queremos que nuestro archivo esté en PDF, colores, si queremos que incluya bibliografía, entre otros. La "cabeza" del Markdown o **YAML** está dividida del resto del cuerpo del texto al inicio y al final con tres guiones (`---`).

```yaml
---
title: Título de mi tesis
date: "16 de Agosto, 2021"
author: "Estudiante UAH"
---
```
Debes poner el texto entre comillas. Si quieres ocupar comillas dentro de tu título, puedes utilizar comillas simples (e.g. mi tesis se titula  `Mi tesis: la más "genial" de Chile`), entonces ponemos

```yaml
---
title: `Mi tesis: la más "genial" de Chile`
---
```


#### Instrucciones de salida en YAML (Output formats)

Los formatos de salida se ven en el encabezado (**YAML**) del documento: aquí puedes especificar en qué formato quieres que te entregue tu archivo. De esta forma, puedes especificar qué tipo de documento creas cuando _"Kniteas"_  (es como _"tejer"_, *construir*) 

```yaml
---
title: "Mi documento"
output:
  html_document: default
  pdf_document: default
  word_document: default
---
```

También puedes hacer click en la flecha hacia abajo del botón "Knit" para elegir la salida *y* generar el YAML apropiado. Si hace click en el icono del engranaje junto al botón "Knit" y elige "Output options" (opciones de salida), puede cambiar la configuración para cada tipo de salida en específico, como las dimensiones de las figuras por defecto o si se incluye o no un índice.

<img src="../../../../../../../../img/reference/output-options.png" width="35%" />

El primer tipo de salida que aparece en `output:` será el que se genere al pulsar el botón **"Knit"** o al pulsar el atajo de teclado (`⌘⇧K` en macOS; `control + shift + K` en Windows). Si elige una salida diferente con el menú del botón "Knit", esa salida se moverá a la parte superior de la sección `output`.

##### Adicionales en YAML

El encabezado o YAML es **importantísimo**, especialmente cuando tienes configuraciones anidadas bajo cada tipo de salida. Cuando uno ya está más avanzado así es como una sección `output` suele verse:


```yaml
---
title: "Mi tesis"
author: "Valentina Andrade"
date: "16 Agosto 2021"
output: 
  html_document:
    theme: cerulean
    toc: true
    toc_depth: 2
    toc_float: true
    number_sections: true
  pdf_document: 
    latex_engine: xelatex  # Para hacer pdf
    toc: true
  word_document: 
    toc: true
---
```

En el **YAML** o **encabezado** del documento, se puede modificar:

- `title` y `subtitle`: es el título y subtítulo. Como cualquier carácter en R lo mejor es poner entre comillas su contenido

- `author`: nombre del autor/a

- `date`: fecha, puede ser escrita como ustedes quieran

- `output`: opciones de salida (html, pdf, doc, ¡incluso ppt!)

- `toc`: "Table of contents" o, en español, índice. El término `depth` indica "profundidad" para ver cuántos títulos mostrar y `float` para ver si se desliza automáticamente

Si quieres ver más opciones, [temas para tu documento puedes ver aquí](https://bookdown.org/yihui/rmarkdown/html-document.html)

### 3.2 Texto (Markdown)

Abajo del YAML ya podrás escribir texto simple. En la siguiente tabla podrás ver un resumen de los formatos básicos de Markdown, sin embargo pueden repasarlo [en la sección recursos](https://learn-r-uah.netlify.app/resource/markdown/) o [acá](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)

<table>
<colgroup>
<col width="40%" />
<col width="21%" />
<col width="38%" />
</colgroup>
<thead>
<tr class="header">
<th>Escribe…</th>
<th>…o…</th>
<th>…para obtener</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><pre>Algo de texto en el párrafo.<br>
Más texto
espacio entre lineas.</pre></td>
<td></td>
<td><p>Algo de texto.</p>
<p>Algo de texto en el párrafo. Siempre utilizando
espacios para dividir párrafos</p></td>
</tr>
<tr class="even">
<td><code>*Cursivas*</code></td>
<td><code>_Cursivas_</code></td>
<td><em>Cursivas</em></td>
</tr>
<tr class="odd">
<td><code>**Negrita**</code></td>
<td><code>__Negrita__</code></td>
<td><strong>Negrita</strong></td>
</tr>
<tr class="even">
<td><code># Título 1</code></td>
<td></td>
<td><h1 class="smaller-h1">
Título 1
</h1></td>
</tr>
<tr class="odd">
<td><code>## Título 2</code></td>
<td></td>
<td><h2 class="smaller-h2">
Título 2
</h2></td>
</tr>
<tr class="even">
<td><code>### Título 3</code></td>
<td></td>
<td><h3 class="smaller-h3">
Título 3
</h3></td>
</tr>
<tr class="odd">
<td>(puedes llegar hasta un título N° 6 con <code>######</code>)</td>
<td></td>
<td></td>
</tr>
<tr class="even">
<td><code>[Link text](http://www.example.com)</code></td>
<td></td>
<td><a href="http://www.example.com">Link text</a></td>
</tr>
<tr class="odd">
<td><code>![Image caption](/path/to/image.png)</code></td>
<td></td>
<td><img src="/img/mstile-144x144.png" title="fig:" alt="Class logo" /></td>
</tr>
<tr class="even">
<td>`<code>Inline code` with backticks</code></td>
<td></td>
<td><code>Inline code</code> with backticks</td>
</tr>
<tr class="odd">
<td><code>&gt; Citas</code></td>
<td></td>
<td><blockquote>
<p>Citas</p>
</blockquote></td>
</tr>
<tr class="even">
<td><pre>- Cosas en
- listas
- desordenadas</pre></td>
<td><pre>* Cosas en
* listas
* desordenadas</pre></td>
<td><ul>
<li>Cosas en</li>
<li>listas</li>
<li>desordenadas</li>
</ul></td>
</tr>
<tr class="odd">
<td><pre>1. Cosas en
2. listas
3. ordenadas</pre></td>
<td><pre>1) Cosas en
2) listas
3) ordenadas</pre></td>
<td><ol style="list-style-type: decimal">
<li>Cosas en</li>
<li>listas</li>
<li>ordenadas</li>
</ol></td>
</tr>
<tr class="even">
<td><pre>Línea horizontal

---</pre></td>
<td><pre>Línea horizontal

***</pre></td>
<td><p>Línea horizontal</p>
<hr /></td>
</tr>
</tbody>
</table>

### 3.3 Código en R (Chunks)

Para ingresar **trozos** de código en R a nuestro documento ocuparemos los **chunks**. Estos permiten hacer análisis estadísticos dentro del documento visualizando los resultados en el documento final 

Los chunks se ven así dentro del .Rmd:

    ```{r}
    # El codigo va aquí
    
    ````


#### 3.3.1 Añadir Chunks

Hay tres formas de insertar chunks:

1. Pulsar `⌘⌥I` en macOS o  `Control + Alt + I` en Windows

2. Pulsa el botón "Insert" en la parte superior de la ventana del editor

 <img src="../../../../../../../../img/reference/insert-chunk.png" width="30%" />

3. Escribirlo manualmente (no recomendado)

#### 3.3.2 Nombrar chunks

Se puede añadir nombres a los chunks para hacer más fácil la navegación por el documento. Si haces clic en el pequeño menú desplegable en la parte inferior de tu editor en RStudio, puedes ver una tabla de contenidos que muestra todos los títulos y chunks. Si nombras los chunks, aparecerán en la lista. Si no incluyes un nombre, el chunk seguirá apareciendo, pero no sabrás lo que hace.

<img src="../../../../../../../../img/reference/chunk-toc.png" width="40%" />

Para añadir un nombre, inclúyelo inmediatamente después de la `{r` en la primera línea del chunk. Los nombres no pueden contener espacios, pero sí guiones bajos y guiones.

Importante: **Todos los nombres de chunk de tu documento deben ser únicos.**

    ```{r nombre-chunk}
    # El codigo va aquí
    
    ````

#### 3.3.3 Opciones de chunks

Hay un montón de opciones diferentes que puedes establecer para cada chunk. Puedes ver una lista completa en la [Guía de referencia de RMarkdown](https://rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf) o en el [sitio web de **knitr**](https://yihui.org/knitr/options/).

Las opciones van dentro de la sección `{r}` del chunk:

    ```{r nombre-chunk, message = F, echo = F}
    # El codigo va aquí
    
    ````
    
Las opciones de chunk más comunes son estas:

- `fig.width=5` y `fig.height=3` (*o el número que quieras*): Establece las dimensiones de las figuras

- `echo=FALSE`: El código no se muestra en el documento final, pero los resultados si

- `message=FALSE`: Se omiten los mensajes que genera R (como todas las notas que aparecen después de cargar un paquete)

- `warning=FALSE`: Se omiten las advertencias que genera R

- `include=FALSE`: El chunk se sigue ejecutando, pero el código y los resultados no se incluyen en el documento final

También puedes configurar las opciones del chunk haciendo clic en el pequeño icono del engranaje en la esquina superior derecha de cualquier chunk:

<img src="../../../../../../../../img/reference/chunk-options.png" width="70%" />


## 4. Resumen

Dentro de la creación de archivos en RMarkdown, hay algunos **conceptos claves** que _sí o sií_ debes manejar para ir construyendo tus documentos en RMarkdown. 

1. **YAML**: Es un encabezado al inicio del documento que inicia y acaba con tres guiones **---***. Acá se introducen aspectos básicos del documento, como el título, el autor, la fecha y el formato de salida (output)

2. **Chunk**: son **trozos** de códigos de R, que permiten hacer análisis estadísticos dentro del documento, visualizando los resultados **directamente** en el documento final 

3. **Knit**: Es el botón que permite *compilar* (tejer o unir) el documento que hemos escrito. Combinará tanto el código de R y el texto, a partir de las instrucciones que dimos en el YAML


### 4.1 Actividad del práctico

La actividad tendrá relación con la entrega de la [**Tarea 1**](https://learn-r-uah.netlify.app/assignment/01-tarea/). Esta actividad consiste en la creación de un RMarkdown que contenga lo siguiente:

* Un encabezado (YAML) con el título: "Práctico 2". También deben incorporar su nombre y fecha

* Este encabezado debe tener una salida (output), deben elegir `html_output`

* En el documento  deben incorporarla imagen `grafico01` (que está en el .zip asociado a la clase)

* Finalmente, deben crear una tabla simple.


## 5. Recursos

- [RMarkdown en Ciencia de Datos - Hadley Whickham](https://es.r4ds.hadley.nz/r-markdown.html)
- [R Markdown](https://rmarkdown.rstudio.com/) 
- [Tutoriales Markdown](https://rmarkdown.rstudio.com/lesson-1.html) 
- [cheatsheets](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)
- Para practicar ir a [Tutorial de Markdown](https://www.markdowntutorial.com/es/)
