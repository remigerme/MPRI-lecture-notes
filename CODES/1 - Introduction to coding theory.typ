#import "../utils.typ": *
#import "utils.typ": *
#show: notes.with(title: "CODES 1 - Introduction to coding theory")

= First examples

#ex(title: "French social security number")[
  A French social security number has the following format: $s space y y space m m space d d space i i i space o o o o space k k$, where:
  - $s$: 1 for male, 2 for female
  - $y y$: year of birth
  - $m m$: month of birth
  - $d d$: department of birth
  - $i i i$ and $o o o$: Insee number and registering order
  - $k k$: a security key to be able to identify errors in the values above.
]

#ex(title: "Repetition encoding")[
  $b in FF_2 mapsto (b, ..., b) in FF_2^n$:
  - detects any error pattern of $< n$ errors.
  - corrects up to $floor((n-1)/2)$ errors by majority voting.
  - but not efficient because we transmit many bits.
]

#ex(title: "Parity encoding")[
  $(b_1, ..., b_(n-1)) mapsto (b_1, ..., b_(n-1), lsum_(i=1)^(n-1)b_i)$:
  - detects only one error.
  - does not correct.
]

= Error correcting codes

== Definitions

#def(title: "Linear code")[A _linear code_ is a subspace $cC seq FF_2^n$.]

Remarks:
- In the next lectures, $FF_2$ might be replaced by $FF_q space (q > 2)$.
- Anne C. will use a bit _non-linear codes_ (ie. $cC$ is an arbitrary subset of $FF_2^n$).

== Parameters

#def(title: "Hamming distance")[
  The _Hamming distance_ between $x, y in FF_2^n$ is $d_H (x, y) = |{i | x_i != y_i}|$.

  The _Hamming weight_ of $x in FF_2^n$ is $w_H (x) = d_H (x, 0)$.
]

A code $cC in FF_2^n$ is associated to 3 fundamental parameters:
- its length $n$
- its dimension $k = dim_FF_2 (cC) = log_2 | cC |$ (for non-linear codes)
- its minimal distance $d = d_min cC = limits(min)_(x, y in cC \ x != y) {d_H (x, y)}$

Equivalently, if $cC$ is linear, $d = d_min (cC) = limits(min)_(x in cC \ x != 0) {w_H (x)}$.

#ex(title: "Repetition code")[
  ${(0 ... 0), (1 ... 1)} seq FF_2^n$ with parameters:
  - $n$
  - $k = 1$
  - $d = n$
]

#ex(title: "Parity code")[
  ${c in FF_2^n | w_H (c) "is even"}$ with parameters:
  - $n$
  - $k = n - 1$
  - $d = 2$
]

*Exercise.* Show that this is a linear space. \
Let $x, y in cC$, we want to prove that $w_H (x+y)$ is even too, ie. $x + y$ has an even number of $1$'s. \
$x$ and $y$ both have an even number of $1$'s because they belong in $cC$.
- We can remove $1$'s where $x$ and $y$ agree (all indexes $i$ such that $x_i = y_i = 1$), because they lead to $0$'s. We're left with $p$ indexes in $x$ that will add up to a $0$ in $y$ leading to a $1$, and $p + 2k (k in ZZ)$ indexes from $y$ in a similar fashion. Thus, there are $2p + 2k space 1$'s in $x+y$.

Intuitively *$k/n$ is a measure of efficiency* and *$d/n$ of ability to correct*.

*Notations.*
- We usually denote parameters of $cC seq FF_2^n$ as $nkdq$ or $nkq$ if $d$ is unknown.
- We denote:
  - $R := k / n$ the _rate of the code_
  - $delta := d / n$ the _relative distance_

There is a tradeoff between $R$ and $delta$.

Having a $delta$ close to 1 is a good criterion to indicate that we might be able to correct, but it is not sufficient by itself.

== How to represent a linear code?

=== Using generator matrices

#def(title: "Generator matrix")[
  A _generator matrix_ $G in FF_2^(l times n)$ is a matrix whose rows span $cC$ as a vector space ($l >= k$), ie. $cC = {m G | m in FF_2^l}$.
]

*Remark.*
$cases(delim: #none, FF_2^l -> FF_2^n, m mapsto m G)$ is an encoding map (take $l = k$).

Note that in coding theory, vector are rows.

=== Parity-check matrices

#def(title: "Parity-check matrix")[
  A _parity-check matrix_ (_p.c.m._) $H in FF_2^(l times n) space (l <= n - k)$ is a matrix whose right kernel is $cC$, ie. $cC = {y in FF_2^n | H y^T = 0}$.
]

=== Examples of such matrices

#ex(title: "Repetition code")[
  - $G = mat(1, ..., 1)$
  - $H = mat(1, 1, 0, 0, ..., 0; 0, 1, 1, 0, ..., 0; dots.v, dots.down, dots.down, dots.down, dots.down, dots.v; 0, ..., 0, 0, 1, 1)$
]

#ex(title: "Parity code")[
  - $G$: take $H$ above.
  - $H$: take $G$ above.
]

There will be a lecture on this duality.

= The Hamming code

== Further properties of the minimal distance

#prop(title: "Disjoint balls")[
  Let $cC seq FF_2^n$ be a code with minimum distance $d$.

  Then, the sets $B(c, floor((d-1)/2))$ when $c$ ranges over $cC$ are pairwise disjoint.
]

*Proof.* Exercise or see the official lecture notes.

#prop(title: "Linearly linked columns of p.c.m.")[
  Let $cC seq FF_2^n$ be a code with parity-check matrix $H$.

  Then, $d$ is the smallest number of linearly linked columns of $H$.
]

*Proof.* Same as above.

== Definition

#def(title: "Hamming code")[
  The _Hamming code_ is the code in $FF_2^7$ with p.c.m. $ H = mat(1, 0, 0, 1, 1, 0, 1; 0, 1, 0, 1, 0, 1, 1; 0, 0, 1, 0, 1, 1, 1) $
]

#prop(title: "Hamming code parameters")[
  The Hamming code is $[7, 4, 3]_2$.
]

#let rk = $"rk"$

*Proof.* \
- dimension $= 4$, indeed, $rk(H) = 3$ so $dim(ker(H)) = 7 - rk(H)$ (by rank nullity theorem).
- minimum distance:
  - $d <= 3$: $y = mat(1, 1, 0, 1, 0, 0, 0)$ is in the code
  - $d > 1$: since no zero column in $H$
  - $d > 2$: no two equal columns (because we're in $FF_2$)

*(Fun?) fact:* the Hamming code *corrects one error*: \ Suppose we receive $y = c + e$ with $c in ker(H)$ and $w_H(e) = 1$, ie $e = mat(0, ..., underbrace(1, i-"th position"), 0, ... 0)$ \ Compute $H y^T = underbrace(H c^T, 0) + underbrace(H e^T, i"-th column of" H)$ then return $y + e_i$.

== Comparison

- *Hamming code* has rate $R = 4/7$ that corrects a $1/7$ error ratio.
- *Repetition code* has rate $R = 1/7$ and corrects a $3/7$ error ratio.

Hamming code yields a better tradeoff.
