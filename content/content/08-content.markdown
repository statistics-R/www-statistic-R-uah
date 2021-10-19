---
title: "Regresiones lineales"
linktitle: "8: Regresiones lineales"
date: "2021-10-04"
start_date: "2021-09-27"
end_date: "2021-11-08"
menu:
  content:
    parent: Contenido
    weight: 8
type: docs
toc: true
bibliography: "../../static/bib/references.bib"
csl: "../../static/bib/chicago-fullnote-bibliography-no-bib.csl"
slides: "08-slides"
---

# Slides

{{% slide-buttons %}}

<ul class="nav nav-tabs" id="slide-tabs" role="tablist">
<li class="nav-item">
<a class="nav-link active" id="rlm-tab" data-toggle="tab" href="#rlm" role="tab" aria-controls="rlm" aria-selected="true">RLM</a>
</li>
<li class="nav-item">
<a class="nav-link" id="lm-tab" data-toggle="tab" href="#lm" role="tab" aria-controls="lm" aria-selected="false">lm()</a>
</li>
<li class="nav-item">
<a class="nav-link" id="glm-y-svyglm-tab" data-toggle="tab" href="#glm-y-svyglm" role="tab" aria-controls="glm-y-svyglm" aria-selected="false">glm() y svyglm()</a>
</li>
<li class="nav-item">
<a class="nav-link" id="predictores-categóricos-tab" data-toggle="tab" href="#predictores-categóricos" role="tab" aria-controls="predictores-categóricos" aria-selected="false">Predictores categóricos</a>
</li>
<li class="nav-item">
<a class="nav-link" id="tranformaciones-funcionales-tab" data-toggle="tab" href="#tranformaciones-funcionales" role="tab" aria-controls="tranformaciones-funcionales" aria-selected="false">Tranformaciones funcionales</a>
</li>
<li class="nav-item">
<a class="nav-link" id="modelo-exploratorio-tab" data-toggle="tab" href="#modelo-exploratorio" role="tab" aria-controls="modelo-exploratorio" aria-selected="false">Modelo exploratorio</a>
</li>
<li class="nav-item">
<a class="nav-link" id="extraer-elementos-tab" data-toggle="tab" href="#extraer-elementos" role="tab" aria-controls="extraer-elementos" aria-selected="false">Extraer elementos</a>
</li>
<li class="nav-item">
<a class="nav-link" id="tablas-tab" data-toggle="tab" href="#tablas" role="tab" aria-controls="tablas" aria-selected="false">Tablas</a>
</li>
<li class="nav-item">
<a class="nav-link" id="gráficos-tab" data-toggle="tab" href="#gráficos" role="tab" aria-controls="gráficos" aria-selected="false">Gráficos</a>
</li>
</ul>

<div id="slide-tabs" class="tab-content">

<div id="rlm" class="tab-pane fade show active" role="tabpanel" aria-labelledby="rlm-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/08-slides.html#1">
</iframe>

</div>

</div>

<div id="lm" class="tab-pane fade" role="tabpanel" aria-labelledby="lm-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/08-slides.html#4">
</iframe>

</div>

</div>

<div id="glm-y-svyglm" class="tab-pane fade" role="tabpanel" aria-labelledby="glm-y-svyglm-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/08-slides.html#10">
</iframe>

</div>

</div>

<div id="predictores-categóricos" class="tab-pane fade" role="tabpanel" aria-labelledby="predictores-categóricos-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/08-slides.html#19">
</iframe>

</div>

</div>

<div id="tranformaciones-funcionales" class="tab-pane fade" role="tabpanel" aria-labelledby="tranformaciones-funcionales-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/08-slides.html#19">
</iframe>

</div>

</div>

<div id="modelo-exploratorio" class="tab-pane fade" role="tabpanel" aria-labelledby="modelo-exploratorio-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/08-slides.html#24">
</iframe>

</div>

</div>

<div id="extraer-elementos" class="tab-pane fade" role="tabpanel" aria-labelledby="extraer-elementos-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/08-slides.html#26">
</iframe>

</div>

</div>

<div id="tablas" class="tab-pane fade" role="tabpanel" aria-labelledby="tablas-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/08-slides.html#30">
</iframe>

</div>

</div>

<div id="gráficos" class="tab-pane fade" role="tabpanel" aria-labelledby="gráficos-tab">

<div class="embed-responsive embed-responsive-16by9">

<iframe class="embed-responsive-item" src="/slides/08-slides.html#30">
</iframe>

</div>

</div>

</div>

{{% div fyi %}}
**¿Cómo ocupar**: Si presionas <kbd>?</kbd> (o <kbd>shift</kbd> + <kbd>/</kbd>) mientras estas viendo las slides, podrás ver los comandos específicos para navegar en ellas.
{{% /div %}}

# Video de la clase

-   [<i class="fas fa-video"></i> `Video de la clase`](https://zoom.us/rec/share/PaJ9H8040XvhE2XcTBm50OHSaEn8uqHRFfGAENmiA_rLFiTkZh3KHXHWskHcq080.DnUXhHQ_z8sUidbw?startTime=1634581803000)

-   -   [<i class="fas fa-video"></i> `Video del práctico`](https://zoom.us/rec/share/WKlV4ubvf3vr68wkI0exigLE-CFutNRtoPbGV3lTL-TCloACTpi7PEW5aXH5MBUH.3q3q36bHty8jf41f?startTime=1634589353000)

# Material de la clase

-   [<i class="fas fa-file-archive"></i> `08-clase.zip`](https://github.com/learn-R/07-class/raw/main/08-clase.zip)

-   [<i class="fas fa-laptop-code"></i> Práctico](/example/08-practico/)

# Materiales adicionales
