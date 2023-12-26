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
  csl: ieee
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
You can also try our online version
[here](https://squirrel-prover.github.io/jsquirrel/?open=0-logic.sp).

# Documentation

The documentation can be found
[here](https://squirrel-prover.github.io/documentation/).

# Tutorial

This [tutorial](https://squirrel-prover.github.io/documentation/tutorial.html) and some commented [examples](examples.html) allow to start discovering Squirrel.
A more complete tutorial has been prepared on the occasion of the
Cyber in Nancy summer school; see below.

The technical details are inside the research papers:

* the computationnally complete symbolic attacker was proposed in [@BC14];
* the tool Squirrel was introduced in [@BDKJM-sp21] as a proof assistant for
a meta-logic on top of the logic of [@BC14];
* the meta-logic was later adapted
  to support protocols with mutable state [@BDKM-csf22];
* a post-quantum sound variant of the logic, meta-logic and tool have been
  given in [@CFJ-sp22];
* recently, the meta-logic approach has been abandonned in favor of
  a self-contained higher-order logic [@BKL23].

# Event: Cyber in Nancy

Slides are available [here](nancy22.pdf).

The school featured a Squirrel tutorial, consisting of a series of
exercises of increasing difficulty, covering:

* the basic logical constructs and tactics manipulating them,
* several cryptographic assumptions,
* accessibility properties (authentication, injective authentication),
* equivalence properties (unlinkability),
* stateful protocol, and
* protocol composition.

As support material to go through the exercises, we provide
syntax documentation [here](doc-nancy.html),
and tactics documentation [there](tactics.html).

The files of the tutorial are now part of the official Squirrel
distribution, under the `examples/tutorial/` directory.
They are also accessible directly below:

- [0-logic](files/0-logic.sp)
- [1-crypto-hash](files/1-crypto-hash.sp)
- [2-crypto-enc](files/2-crypto-enc.sp)
- [3-hash-lock-auth](files/3-hash-lock-auth.sp)
- [4-hash-lock-unlink](files/4-hash-lock-unlink.sp)
- [5-stateful](files/5-stateful.sp)
- [6-key-establishment](files/6-key-establishment.sp)

Those, again, are available on our online version [here](https://squirrel-prover.github.io/jsquirrel/?open=0-logic.sp)

# Event: MOVEP

Slides are available [here](movep.pdf).

Examples used for the presentation are [here](examples.html).

# Team

 * [David Baelde](http://www.lsv.fr/~baelde/), _ENS Rennes, Univ Rennes, CNRS, IRISA_
 * [Stéphanie Delaune](http://people.irisa.fr/Stephanie.Delaune/), _Univ Rennes, CNRS, IRISA_
 * [Caroline Fontaine](http://www.lsv.fr/~fontaine/index.html.fr), _Université Paris-Saclay, CNRS, LMF_
 * [Charlie Jacomme](https://charlie.jacomme.fr), _Inria Nancy_
 * [Adrien Koutsos](https://adrienkoutsos.fr/), _Inria Paris_
 * [Joseph Lallemand](https://people.irisa.fr/Joseph.Lallemand/), _Univ Rennes, CNRS, IRISA_
 * [Thomas Rubiano](https://people.irisa.fr/Thomas.Rubiano/), _Univ Rennes, CNRS, IRISA_
 * [Clément Herouard](https://people.irisa.fr/Clement.Herouard/), _Univ Rennes, CNRS, IRISA_
 * [Justine Sauvage](https://fr.linkedin.com/in/justine-sauvage-a05b35179), _Inria Paris_

Former members:

 * [Tito Nguyen](https://nguyentito.eu/), _formerly IRISA, now at ENS Lyon_
 * [Solène Moreau](https://pages.saclay.inria.fr/toccata/solene.moreau/), _formerly IRISA, now at AdaCore_


# Source code

**Squirrel** is an open source project, licensed under the MIT
License. All source code is available
[here](https://github.com/squirrel-prover/squirrel-prover/).

# Publications
