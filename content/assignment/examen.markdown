---
title: "Examen. Proyecto de investigación final"
linktitle: "Examen: Proyecto final"
date: "2021-11-08"
due_date: "2022-11-21"
due_time: "23:59 PM"
menu:
  assignment:
    parent: Proyecto
    weight: 1
type: docs
toc: true
editor_options: 
  chunk_output_type: console
---


## Descripción general

El **Proyecto de investigación** es la instancia de evaluación **final e individual** del curso de Estadistica II. Su objetivo es *evaluar los conocimientos y aprendizajes obtenidos en el curso de manera integra*. Para ello deberán elaborar una investigación simple cuyo centro está en evaluar su capacidad de hacer una investigación aplicando regresiones y en R.

## Datos

Para ello pueden elegir uno de los siguientes datos (aquellos que tienen un asterisco pueden ser escogidos por dos estudiantes)

**Instituciones y organizaciones gubernamentales**
- Encuesta de Presupuestos Familiares
- Encuesta Suplementaria de Ingresos
- ICMO-IR
- Encuesta Caracterización Laboral (ENCLA) *
- Encuesta Nacional de Empleo
- Encuesta Bienestar Social *
- Encuesta Nacional de Salud
- Encuesta Financiera de Hogares
- ENUSC
- IV Encuesta de Violencia contra la Mujer en el Ámbito de Violencia Intrafamiliar y en Otros Espacios (ENVIF-VCM)

**Instituciones y organizaciones académicas**
- ELSOC *
- OHL *
- Observatorio Conflictos
- Termómetro Social
- Latinobarómetro
- MOVID-IMPACT  *
- CEP (2019)

Para todas las encuestas **deben elegir la última versión disponible**

Una vez definidos sus datos, pueden inscribirse con estos hasta el viernes 24 de junio en el [siguiente link](https://docs.google.com/spreadsheets/d/1o_zXJVkQ9C7odalXsREdU2-pT8H5ETN0oKrBplQtJrk/edit?usp=sharing)

## Análisis

Deben construir un reporte donde analicen algún fenómeno que consideraran de interés y que puede ser abordado desde los datos que seleccionaron. Este reporte debe ser reproducible y coherente con el fenómeno que analizaran. Ahora bien, el centro no será evaluar su manejo en el tema, sino que su capacidad de poder presentar un análisis de datos de un fenómeno de interés utilizando herramientas básicas de R. 

# Descripción específica

En este apartado encontrarán algunas de las instrucciones para su investigación.

## Procesamiento (.R)

1. La base final debe contener al menos 5 variables finales
2. Las variables finales deben estar transformadas debidamente, incluyendo los casos perdidos.
3. Poner atención a filtrar observaciones según el fenómeno que están analizando (si trabajarán con un subset o con toda la data)

## Análisis (.Rmd)

1. Estructura: Título, Abstract (100-150 palabras), Introducción (200-250 palabras), Análisis (300-500 palabras), Conclusión (150-200 palabras) y Referencias. Debe indicar su nombre, profesora y ayudantes
  - El centro está en que al leer este breve resumen de investigación, a la docente le quede claro que tipo de transformaciones deberían haber hecho a los datos, junto con qué análisis debieron reportar. Por ejemplo, si su investigación trata sobre el *"Impacto de la educación sobre los salarios* no tiene sentido que elijan unos datos que no tiene la variable educación y salarios, que ocupen la educación como una variable continua si sus hipótesis implica comparar grupos y/o que hagan un análisis descriptivo.
  
2. Análisis de regresión lineal múltiple

Deben utilizar regresiones múltiples y deben construir al menos dos regresiones y compararlas (por ejemplo, cambiando sus formas funcionales o agregando más variables)

Para reportar estos análisis deben hacer al menos **1 tabla y 2 gráficos.** 

3. Los análisis deben ocupar de alguna forma al menos las 5 variables procesadas.

  - No siempre las utilizarán para hacer una regresión, quizás les sirve alguna de ellas para filtrar algún grupo y comparar regresiones.
  
4. El archivo debe ser compilado a formato html o pdf.
  
## Proyecto

1. Para acceder a la tarea [Deben aceptar el repositorio en el link de GitHub Class Room](https://classroom.github.com/a/crXZ_wAu)
2. Deben hacer un README.md explicando aspectos generales del repositorio

# Criterios de evaluación

## Condiciones de suficiencia

En este apartado se indican aquellas condiciones que *en caso de **no cumplirse** se considerará todo el resto del **examen no válido**. Esto permite corroborar aspectos básicos del curso por lo que se consideran como suficientes para aprobar este. Además, permiten verificar que efectivamente hicieron el proyecto. 

En caso de caer en alguna de las condiciones de suficiencia serán evaluados con la nota mínima (*1,0*). El examen solo puede ser entregado hasta la fecha estipulada.

### Proyecto en general

1. Existe un *Rproject*
2. Se identifica un flujo de trabajo

### Procesamiento

1. Presenta un código de proceso que se puede ejecutar integramente (no presenta problemas para llegar al resultado final de la base procesada). 

2. La base original y final son distintas, es decir, que al menos se haya hecho un procesamiento en términos de **selección** y **transformación de variables**. 

### Análisis

1. Existencia de un RMarkdown que haga uso de los datos procesados en el procesamiento. 

2. Las imágenes y tablas deben ser creadas en este archivo. Si se necesitan cargar referencias a imágenes externas estas deben estar contenidas dentro de alguna de las carpetas del flujo de trabajo

## Criterios de evaluación generales

Además de los criterios de suficiencia tome nota de los siguientes puntos

1. Existencia de flujo de trabajo
2. README.md permite presentar sus trabajos debidamente (debe contener sus nombres, profesora y ayudantes)
3. Código de R y .Rmd sigue orden lógico y presentado en el curso
4. Utiliza paquetes vistos en el curso. En caso de ocupar adicionales deben ser justificados en el README.md
5. Cumplir límite de palabras

## Criterios adicionales (0,1 décimas por cada uno)

1. Colaborar ayudando a compañeros/as por el canal #examen
2. Código ordenado y debidamente comentado
3. Repositorio ordenado y debidamente documentado en README.md
4. Archivo de .RMD a html o pdf tiene un tema especial
5. Realiza análisis para algún otro ramo, tesis o práctica (debe indicarlo en el README.md)
6. Hace fork a su examen final y lo deja en su repositorio final

# Entregas

## Primera entrega

- Primera entrega está agendada para la semana del 18 de abril

- En esta entrega deben entregar introducción y base procesada

## Examen

- Entrega final esta definida para la semana del 27 de junio.

- La entrega final considera todo el informe + poster que puede ser entregado hasta el 6 de julio. Ese poster final consiste en un resumen ejecutivo de su investigación y que será impreso y pegado en la Universidad. 

# Otros

## Recursos

1. No olvide revisar los recursos de la clase (prácticos, complementarios, talleres), pueden serles útil en esta etapa (sobre todo las primeras clases cuando les indicamos la importancia de la autonomía buscando soluciones)

- [Prácticos](/example/)
- [Tutoriales](/resource/install/)
- [Material complementario y talleres](/resource/r-datatypes/)



## Horarios de consulta y trabajo conjunto 

Hay dos prácticos dedicados a trabajar en la investigación

- Práctico 3

- Práctico 14

**Los repositorios de esta evaluación final quedarán disponibles para el futuro**


## Ejemplos de trabajos (pronto)

- Informe

- Poster
