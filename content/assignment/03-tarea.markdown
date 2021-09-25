---
title: "Tarea 3. Análisis descriptivo"
linktitle: "3: Análisis descriptivo"
date: "2021-10-01"
due_date: "2021-09-27"
due_time: "23:59 PM"
menu:
  assignment:
    parent: Tareas
    weight: 1
type: docs
toc: true
editor_options: 
  chunk_output_type: console
---

Esta tarea debe ser resuelta en GitHub Class Room. Para acceder a la <i class="fas fa-external-link-square-alt"></i>  [Tarea N°3 hacer click aquí](https://classroom.github.com/g/uF2RyAV_). Si aún tienes dudas de cómo interactuar con [GitHub Class Roomm revisa el práctico](https://learn-r-uah.netlify.app/example/01-practico/)

## Objetivo

La tarea N°3 implica la continuación de la tarea N°2 donde procesaron datos que servirían de "input" para los análisis que deberán presentar en el siguiente ejercicio.


### Instrucciones

De su equipo de trabajo han recibido el procesamiento de sus datos, y luego de unos días, han hecho una serie de correcciones y le han dado consejos para mejorar su avance. Para ver estos deben ir a los comentarios de sus tareas en GitHub.

Además, le han pedido una serie de cambios respecto a sus datos de modo de que el informe de avance contenga los aspectos necesarios para ser presentados. 

**En general**, su proyecto de R (tarea-03.Rproj) debe contener:

**1. R script con procesamiento de datos modificado (`R/01-proc.R`)**
  
  1.1 Datos originales en carpeta *input* (si son muy pesados, indicar en el .gitignore) 
  1.2 Datos procesados (`input/datos/datos_proc.rds`)

**2. Informe descriptivo de los datos**

  2.1 Archivo en RMarkdown que contiene los análisis solicitados en el equipo 02-analisis.Rmd
  2.2 Archivo en html que contiene el informe compilado (02-analisis.html). *Si logra dejar el informe en .pdf tendrá 0.3 adicionales a su nota. Hint: descargar y revisar el paquete tinytext*
  
**3. Adicionales** (0.2 décimas por cada uno)

  3.1 README.md con explicaciones generales para que cualquier usuario pueda reproducir sus análisis (explicar las carpetas, datos descargados y desde donde). Algunos elementos del procesamiento deben ser indicados aquí   3.2 Contribuir con preguntas de compañeras/os sobre **problemas en código** (no sobre instrucciones sobre la tarea)
  3.3 Procesamientos adicionales indicados con [**]
  3.4 Documentos que [editen su formato en html](https://www.datadreaming.org/post/r-markdown-theme-gallery/)
  3.5 Cambiar color y editar sus gráficos de sjPlot.  
  
### 1. Modificaciones en el procesamiento (en .R)

El equipo le ha indicado una serie de consejos que se han estipulado en el *Feedback de GitHub Class Roomm*. Además, le han pedido eliminar, modificar y cambiar las siguientes variables (aquellos que tienen un solo asterisco [*] son obligatorios, no olvide verificar los NA)

**Sociodemográficas**
- Sexo, edad categorizada en tres tramos (18-39 años, 40 a 59 años, 60+, edad (numérica)), región, nivel educacional (CINE)

**Ocupación**
- `activ`
- Grupo ocupacional a 1 dígito (CIUO)
- Rama de actividad económica de la **empresa donde trabaja el ocupado**(CIIU)
- Tamaño de la empresa en categorías (5 niveles)
- Variable de informalidad (Hint: ver página 43 del Libro de Códigos) [*]

**Condiciones laborales**
- Tipo de jornada (completa o parcial)

**Análisis COVID-19**
- **Subempleo horario**: variable que indica que se trabajan menos horas por COVID
- **Desocupación**: Razones de no tener empleo (dejar variable original y crear otra con COVID y no COVID) [*]
- **Inactividad**: Motivos por los cuales no está disponible para trabajar [**]
- **Despidos**: motivos de despido [**]

**Filtros**
- Excluir a las personas menores de 18 años, pertenecientes a "Actividades de organizaciones y órganos extraterritoriales". 


*Adicionales*

- Si usted realiza una simplificación (colapsar categorías) de los puntos indicados con doble asterisco [**] recibirá bonificación adicional.

- Si usted indica en el README que corrobora el cálculo de informalidad (y si no, la razón) recibirá 0.3 puntos. 

**Datos a utilizar y guardar**

1. Debe ocupar la Encuesta Nacional de Empleo (ENE) del Instituto Nacional de Estadísticas, particularmente el trimestre *Junio-Julio-Agosto* del año **2021.**

2. Deben dejar guardados un único set de datos en *datos_proc.rds* con las variables indicadas. No olviden guardar variables de identificación (*año y respondente*) .

### 2. Reporte descriptivo

Deben crear un reporte en RMarkdown reproducible que contenga

1. Título, subítulo, nombre de autores, fecha. Además información institucional que puede poner en los subtitulos (carrera, Universidad,,Profesora, ayudantes)

2. Presentación de la base

- Descripción de la base en fecha de realización, número de observaciones e indicar las variables utilizadas en el análisis.
  
  - *No mostrar chunk de funciones que les dan dimensiones*

- Indicar paquetes con los cuales se realizará el análisis

  - Mostrar chunk donde se cargan paquetes
  
3. Análisis descriptivo univariado

3.1 Distribución de sexo, edad en tramos (y reportar edad numérica), nivel educacional

*Contraste sus resultados con los reportados en el CENSO 2017*

3.2 Distribución de ocupaciones: activ, informalidad, CIUO y CIIU (tablas y gráficos a elección)


*Describa el resultado de activ e informalidad*

3.3 Distribución de variables para el análisis COVID (con gráficos)

*Describa al menos un gráfico*

4. Análisis descriptivo bivariado.

Para ello deben cruzar y reportar los siguientes resultados


-  Edad promedio para cada categoría de informalidad y jornada laboral (tabla)

- `activ` según sexo (gráfico)

- CIUO y razones de desocupación colapsada entre razones COVID y no COVID (gráfico)

- CIIU y motivos de despido (si creó variable colapsada y la reporta aquí recibe 0.2 décimas. Si no, debe hacerlo con la variable original) (tabla)

- Motivos de despido según sexo

Deben describir al menos dos gráficos (los que parezcan más interesantes)

**No olvide los conocimientos evaluados en la tarea N°1** pues también son evaluados. Solo para recordar deben incorporar los siguientes elementos:

1. Un encabezado (YAML) con el título: “Tarea N°1”. También deben incorporar su nombre y fecha. Este encabezado debe tener una salida (output), esta debe ser en html (*si logran agregar una en pdf tendrán bonus*)

2. Texto que indique dos subtítulos que separarán los apartados del documento. Deben ocupar **negritas**, *cursivas* y otros aspectos del formato md cuando sea necesario.

3. Chunks: no olvide las opciones de los chunks (algunos deben estar ocultos y otros no).



## Formato

- Recuerden que puede ser realizada en pareja, la misma durante todo el semestre. 

- La tarea se puede entregar hasta el día viernes 27 de septiembre 23.59


## Recursos

- Recuerde revisar el [Libro de Códigos](https://www.ine.cl/docs/default-source/ocupacion-y-desocupacion/bbdd/libro-de-codigos/libro-de-c%C3%B3digos-base-ene-2021.pdf?sfvrsn=ce7f6448_2)
  

- <i class="fas fa-book"></i> Hadley Wickham, ["R para ciencia de datos - Como usar RMarkdown"](https://es.r4ds.hadley.nz/r-markdown.html) 

- <i class="fab fa-book"></i> Recursos
  - [Recursos del curso](https://learn-r-uah.netlify.app/resource/) 
  - [Tutorial dplyr](https://www.youtube.com/watch?v=APzU10EMMjg)

- <i class="fas fa-external-link-square-alt"></i> [Sesión N°2](/content/02-content)
- <i class="fas fa-external-link-square-alt"></i> [Sesión N°3](/content/03-content)
- <i class="fas fa-external-link-square-alt"></i> [Sesión N°4](/content/04-content)
- <i class="fas fa-external-link-square-alt"></i> [Sesión N°5](/content/05-content)

- <i class="fas fa-external-link-square-alt"></i> [Práctico N°2](/example/02-practico)
- <i class="fas fa-external-link-square-alt"></i> [Práctico N°3](/example/03-practico)
- <i class="fas fa-external-link-square-alt"></i> [Práctico N°4](/example/04-practico)
- <i class="fas fa-external-link-square-alt"></i> [Práctico N°5](/example/05-practico)
- <i class="fas fa-external-link-square-alt"></i> [Práctico N°6](/example/06-practico)



