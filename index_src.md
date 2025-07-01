---
  title: Squirrel Prover
  pagetitle: Index
  mainpagetitle:
  navigation: false

  next_page:
  next_page_url:
  prev_page:
  prev_page_url:

  bibliography: biblio.bib
  csl: ieee.csl
  link-citations: true
 
  nocite: |
    @*
---

The **Squirrel Prover** is a proof assistant dedicated to
cryptographic protocols.
It relies on a higher-order logic
following the *computationnally complete symbolic attacker* approach.
It thus provides guarantees in the computational model.

# Getting started

A 13 minutes introduction to the basic concepts and core ideas of the **Squirrel Prover** can be found [here](https://www.youtube.com/watch?v=n-s_lGe44EM).

A [README](https://github.com/squirrel-prover/squirrel-prover/#readme)
provides installation instructions.

You can also try our **online version**
[here](https://squirrel-prover.github.io/jsquirrel/).

# Documentation

The documentation can be found
[here](https://squirrel-prover.github.io/documentation/).

# Tutorial

This [tutorial](https://squirrel-prover.github.io/documentation/tutorial.html) and some commented [examples](examples.html) allow to start discovering Squirrel.
More complete tutorials have been prepared on the occasion of the
summer schols; see the [events](events.html) page.

A high-level introduction to the theory behind Squirrel was published in the ACM Siglog newsletter [@BDJKL24]. The formal technical details are inside the research papers:

* the computationnally complete symbolic attacker was proposed in [@BC14];
* the tool Squirrel was introduced in [@BDKJM-sp21] as a proof assistant for
a meta-logic on top of the logic of [@BC14];
* the meta-logic was later adapted
  to support protocols with mutable state [@BDKM-csf22];
* a post-quantum sound variant of the logic, meta-logic and tool have been
  given in [@CFJ-sp22];
* recently, the meta-logic approach has been abandonned in favor of
  a self-contained higher-order logic [@BKL23].

# Team

 * [David Baelde](http://www.lsv.fr/~baelde/), _ENS Rennes, Univ Rennes, CNRS, IRISA_
 * [Stéphanie Delaune](http://people.irisa.fr/Stephanie.Delaune/), _Univ Rennes, CNRS, IRISA_
 * [Caroline Fontaine](http://www.lsv.fr/~fontaine/index.html.fr), _Université Paris-Saclay, CNRS, LMF_
 * [Charlie Jacomme](https://charlie.jacomme.fr), _Université de Lorraine, LORIA, Inria Nancy Grand-Est_
 * [Adrien Koutsos](https://adrienkoutsos.fr/), _Inria Paris_
 * [Joseph Lallemand](https://people.irisa.fr/Joseph.Lallemand/), _Univ Rennes, CNRS, IRISA_
 * [Clément Herouard](https://people.irisa.fr/Clement.Herouard/), _Univ Rennes, CNRS, IRISA_
 * [Justine Sauvage](https://fr.linkedin.com/in/justine-sauvage-a05b35179), _Inria Paris_

Former members:

 * [Tito Nguyen](https://nguyentito.eu/), _formerly IRISA, now at ENS Lyon_
 * [Solène Moreau](https://pages.saclay.inria.fr/toccata/solene.moreau/), _formerly IRISA, now at AdaCore_
 * [Thomas Rubiano](https://people.irisa.fr/Thomas.Rubiano/), _formerly Univ Rennes, CNRS, IRISA_

# Source code

**Squirrel** is an open source project, licensed under the MIT
License. All source code is available
[here](https://github.com/squirrel-prover/squirrel-prover/).

# Publications
