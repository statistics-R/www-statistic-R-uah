---
title: "Tarea 0. Reporte en RMarkdown"
linktitle: "0: Reporte en RMarkdown"
date: "2021-08-16"
due_date: "2022-03-25"
due_time: "11:59 PM"
menu:
  assignment:
    parent: Tareas
    weight: 1
type: docs
toc: true
editor_options:
  chunk_output_type: console
---


Esta tarea debe ser rusuelta en GitHub Class Room. Para acceder a la <i class="fas fa-external-link-square-alt"></i>  [Tarea N°0 hacer click aquí](https://classroom.github.com/a/zYM3oL16). Si aún tienes dudas de cómo interactuar con [GitHub Class Roomm revisa el práctico](../example/01-practico)

## Objetivo

La tarea N°0 consiste en la creación de un archivo **RMarkdown**, donde deben incorporar elementos claves para la creación de estos archivos, lo que permitirá crear informes que incluyan texto y códigos en R, facilitando la reproducibilidad. 

## Instrucciones

Para completar la tarea ustedes deben incorporar los siguientes elementos en el archivo creado

1. Un encabezado (YAML) con el título: "Tarea N°0". También deben incorporar aspectos formales, como su nombre, fecha, información institucional y del curso (nombre de la profesora y ayudante). Este encabezado debe tener una salida (output), esta debe ser en **html** 

2. Texto que indique tres subtítulos que separarán los dos procedimientos que deben contenerse en la entrega (`## 1. Carga de paquetes`, `## 2. flujo` y `## 3. Descriptivos`). 

3. Chunks:

En el apartado `## 1. Carga de paquetes` debes cargar uno de los paquetes más importantes para el curso. El chunk no se debe ver en el documento final, pero si en tu .Rmd

- Debes explicar:
  - El nombre del paquete cargado
  - Para qué puede utilizarse
  - Un link que dé cuenta de dónde saco la información del paquete (este debe ser uno de los lugares recomendados en la clase [Ver clase 1](https://learn-r-uah.netlify.app/content/01-content/)), debes dejar el link en formato Markdown [Ver práctico 2](https://learn-r-uah.netlify.app/example/02-practico/) o en [Recursos](https://learn-r-uah.netlify.app/resource/markdown/)
  
En el apartado `## 2. Flujo` debes cargar la imagen `flujo.png` (ya sea con formato markdown o en un chunk) y explicar qué elementos van dentro de las siguientes carpetas

  - **input**:
  - **R**:
  - **output**:
  - Para qué sirve el archivo con extensión **.Rproj** (que es lo mismo que el Tipo Rproject)

En el apartado `## 3. Gráfico` debes incorporar una imagen llamada `grafico01.jpg`. Esta imagen la puedes incorporar en formato Markdown o con chunks. Deja una breve explicación de ese gráfico, intenta utilizar _**lenguaje Markdown**_

Finalmente, deben crear una _**tabla simple**_ de un tema interesante para ustedes, junto a una breve descripción.

## Pasos para realizar la tarea

1. Entra a GitHub Class Room para realizar la tarea N°1 (aceptar tarea). Debes clonar este repositorio. Si tienes dudas sobre este procedimiento, revisa el [práctico N°1](https://learn-r-uah.netlify.app/example/01-practico/) o contáctanos vía slack.

2. Una vez la tarea en tu computadora, no olvides crear un .Rproject llamado 00-tarea.Rproj que provenga de una "Carpeta existente"

3. En la carpeta input habrá una carpeta llamada "imagenes". Dentro de esta carpeta encontrarás la imágen `flujo.png` y deberás dejar el `gráfico01.jpg`. Este puede ser cualquiera que resulte interesante para tí.

4. Una vez finalizado todos los pasos del documento **no olvides hacer knit** para que se compile tu documento final.

## Puntaje adicional

Si averiguas como dejar un archivo en pdf **y** explicarlo en el canal #tareas, obtendrás un puntaje adicional para 01-tarea

## Pauta

1. RMarkdown, este ítem evalúa aspectos propios de los archivos .Rmd, desde su estructura hasta su correcto funcionamiento. Es necesario considerar:

   a. Aspectos formales: títulos, nombres, información institucional, fecha, etc.
    
   b. Estructura de los archivos .Rmd
    
   c. Uso correcto y constante de markdown
    
   d. Aspectos solicitados según cada tarea, por ejemplo:
    - Análisis: en estos archivos irán tanto sus reportes como el análisis que realicen
    - Replicación de informes: esto incluye la replicación de análisis con sus outputs, ya sean tablas, gráficos o lo que se solicite en la respectiva tarea.



1. Flujo: Este ítem se encarga de evaluar el flujo de trabajo desarrollado en el curso, para ello se debe considerar los elementos que hacen posible el correcto uso del flujo, para obtener buen puntaje en este ítem deben:

   a. Seguir detalladamente las instrucciones
  
   b. Crear las carpetas y archivos requeridos en cada tarea
  
   c. Nombrar **adecuadamente** los archivos/datos/carpetas 
  
   d. Todos los archivos por utilizar deben estar en su lugar correspondiente.
   


1. R: Este ítem evalúa elementos relacionados a archivos .R. Este puede dividirse en dos etapas a lo largo del curso (Debe seguir un orden lógico):

   a. Carga: esta etapa es necesaria para pasar a procesamiento 
  
   b. Procesamiento: etapa donde se preparan los datos para ser utilizados en el análisis. 



1. Markdown: este ítem evalúa aspectos propios del formato en markdown, ya que su uso será constante en este curso [ver recursos](https://learn-r-uah.netlify.app/resource/markdown/) 


1. Reproducibilidad: En este curso es muy relevante la reproducibilidad, para ello es necesario tener en cuenta lo siguiente:
    
   a. El archivo .R debe poder ejecutarse sin problemas por cualquier persona con el programa, siguiendo el orden lógico requerido para ello.
  
   b. El archivo .Rmd debe poder ejecutarse sin problemas por cualquier persona con el programa. Esto implica que tanto los archivos/tablas/códigos deben visualizarse correctamente en su producto (output) final
Este punto será esencial para lo que más adelante veremos como condición de suficiencia.

1. Condición de suficiencia: son elementos esenciales que si no son cumplidos la asignación de puntaje del ítem será 0, independiente de si lo que sigue a ese punto está realizado correctamente. Deben tener en cuenta que este ítem no será inmediato, sino que será a medida vaya avanzando el curso.

1. Bonus: En el curso habrá constantemente aspectos que brindarán puntos y/o décimas dependiendo de la tarea.

1. Descuentos: ítem que considera descuentos en puntos o décimas por el no logro o ausencia de aspectos de los ítems anteriores.

Si utiliza otros paquetes para resolver la tarea **DEBE** explicar la razón del uso esos paquetes y qué ventajas tienen por sobre los utilizados en el curso, de no ser así se descontará con 0.5 puntos. 


## Recursos

- <i class="fas fa-book"></i> Hadley Wickham, ["R para ciencia de datos - Como usar RMarkdown"](https://es.r4ds.hadley.nz/r-markdown.html) 

- <i class="fab fa-book"></i> Tutoriales
  - [R Markdown](https://rmarkdown.rstudio.com/) 
  - [Tutoriales Markdown](https://rmarkdown.rstudio.com/lesson-1.html) 
  - [cheatsheets](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)
  - Para practicar ir a [Tutorial de Markdown](https://www.markdowntutorial.com/es/)

- <i class="fas fa-external-link-square-alt"></i> [Sesión N°2](/content/02-content)

- <i class="fas fa-external-link-square-alt"></i> [Práctico N°2](/example/02-practico)
