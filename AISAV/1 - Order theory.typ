#import "../utils.typ": *
#show: notes.with(title: [AISAV 1 - Order theory])

#let seq = $subset.eq$
#show "seq": $subset.eq$
#let ssq = $subset.eq.sq$
#show "ssq": $subset.eq.sq$

#set heading(numbering: "I.1. ")

= Partial orders

#def(title: "Partial order")[
  Given a set $X$, a relation $ssq$ is a _partial order_ if it is:
  - *reflexive*: $forall x in X, x ssq x$
  - *antisymmetric*: $forall x, y in X, x ssq y and y ssq x => x = y$
  - *transitive*: $forall x, y, z in X, x ssq y and y ssq z => x ssq z$
  $(X, ssq)$ is a _partially ordered set_ (_poset_).
]

If we drop antisymmetry, we get a *preorder*.

#ex(title: "Partial orders")[
  - $(ZZ, <=)$ is _completely ordered_
  - $(cal(P), subset.eq)$ is not completely ordered
]

#ex(title: "Preorders")[
  - $(cal(P), subset.eq.sq)$ where $a subset.eq.sq b <=> |a| <= |b|$
]

#def(title: "(Least) Upper bounds")[
  - $c$ is an _upper bound_ of $a$ and $b$ if $a ssq c$ and $b ssq c$.
  - $c$ is a _least upper bound_ (_lub_ or _join_) of $a$ and $b$ if
    - $c$ is an upper bound of $a$ and $b$
    - for every upper bound $d$ of $a$ and $b$, $c ssq d$.
]

#let lub = $union.sq$
#let glb = $inter.sq$

#prop(title: "Unicity of least upper bound")[
  If it exists, the lub of $a$ and $b$ is *unique*, and denoted as $a lub b$.
]

Similarly, we define the _greatest lower bound_ (_glb_, _meet_) $a glb b$.

Note: not all posets have lubs and glbs.\
E.g. $a lub b$ is not defined on $({a, b}, =)$.

#def(title: "Chains")[
  $C seq X$ is a _chain_ in $(X, ssq)$ if it is totally ordered by $ssq$: $forall x, y in C, (x ssq y) or (y ssq x)$.
]

#def(title: "Complete partial orders (CPO)")[
  A poset $(X, ssq)$ is a _complete_ partial order (CPO) if every chain $C$ (including $emptyset$) has a least upper bound $lub C$.
]

A CPO has a *least element* $lub emptyset$ denoted $bot$.

#ex(title: "CPO")[
  - $(NN, <=)$ is not complete but $(NN union {infinity}, <=)$ is complete.
  - $({x in QQ | 0 <= x <= 1}, <=)$ is not complete but
  - $({x in RR | 0 <= x <= 1}, <=)$ is complete
  - $(cal(P)(Y), seq)$ is complete for any $Y$
  - $(X, ssq)$ is complete if $X$ is finite
]

= Lattices

#def(title: "Lattice")[
  A _lattice_ $(X, subset.eq.sq, union.sq, inter.sq)$ is a poset with
  - a lub $a union.sq b$ for every pair of elements $a$ and $b$
  - a glb $a inter.sq b$ for every pair of elements $a$ and $b$
]

#ex(title: "Lattice")[
  - integers $(ZZ, <=, max, min)$
  - integer intervals $({[a, b] | a, b in ZZ, a <= b} union {emptyset}, subset.eq, union, inter)$
  - divisibility $(NN^*, |, lcm, gcd)$
]

If we drop one condition, we have a (join or meet) _semilattice_.

#def(title: "Complete lattice")[
  A _complete lattice_ $(X, subset.eq.sq, union.sq, inter.sq, bot, top)$ is a poset with:
  - a lub $union.sq S$ for every set $S subset.eq X$
  - a glb $inter.sq S$ for every set $S subset.eq X$
  - a least element $bot$
  - a greatest element $top$
]

Remarks:
- 1 implies 2 as $inter.sq S = union.sq {y | forall x in S, y ssq x}$ (and vice-versa)
- 1 and 2 imply 3 and 4
- a complete lattice is also a CPO

#ex(title: "Complete lattice")[
  - powersets $(cal(P)(S, seq, union, inter, emptyset, S))$
  - real segment $[0, 1]$: $([0, 1], <=, max, min, 0, 1)$
  - integer intervals with finite *and infinite* bounds \ $({[a, b] | a in ZZ union {- infinity}, b in ZZ union {+ infinity}} union {emptyset}, seq, union, inter, emptyset, [-infinity, +infinity])$
]

= Functions and fixpoints

#def(title: "Functions")[
  A function $f : (X_1, ssq_1, union.sq_1, bot_1) -> (X_2, ssq_2, union.sq_2, bot_2)$ is:
  - _monotonic_ if $forall x, x', x ssq_1, x' => f(x) ssq_2 f(x')$
  - _strict_ if $f(bot_1) = bot_2$
  - _continuous_ between CPO if $forall C "chain" seq X_1, {f(c) | c in C}$ is a chain in $X_2$ and $f(union.sq_1 C) = union.sq_2 {f(c) | c in C}$
  - a (complete) _$union.sq$-morphism_ between (complete) lattices if  $forall S seq X_1, f(union.sq_1 S) = union.sq_2 {f(s) | s in S}$
  - _extensive_ if $X_1 = X_2$ and $forall x, x ssq_1 f(x)$
  - _reductive_ if $X_1 = X_2$ and $forall x, f(x) ssq_1 x$
]

#prop(title: "Continuity implies monotony")[
  Any continuous function is monotonic.
]

*Proof.* \
Let $x, x' in X_1$ such that $x ssq_1 x'$. Then ${x, x'}$ is a chain. \
By continuity of $f$, ${f(x), f(x')}$ is a chain and $f(union.sq_1 {x, x'}) = union.sq_2 {f(x), f(x')}$. \
And $f(union.sq_1 {x, x'}) = f(x union.sq_1 x') = f(x')$ because $x ssq_1 x'$. \
And $union.sq_2 {f(x), f(x')} = f(x) union.sq_2 f(x')$. \
So we have $f(x') = f(x) union.sq_2 f(x')$.
By definition of the lub, $f(x) ssq_2 f(x) union.sq_2 f(x')$, ie. $f(x) ssq_2 f(x')$.

#def(title: "Fixpoints")[
  Given $f: (X, seq) -> (X, seq):$
  - $x$ is a _fixpoint_ of $f$ if $f(x) = x$
  - $x$ is a _pre_-fixpoint of $f$ if $x ssq f(x)$
  - $x$ is a _post_-fixpoint of $f$ if $f(x) ssq x$
]

#let fp = $"fp"$
#let lfp = $"lfp"$
#let gfp = $"gfp"$

We may have several fixpoints (or none):
- $fp(f) eq.def {x in X | f(x) = x}$
- least fixpoint greather than $x$: $lfp_x(f) = min_ssq {y in fp(f) | x ssq y}$ if it exists
- least fixpoint: $lfp(f) = lfp_bot (f)$
- same definitions for greatest fixpoint $gfp_x (f)$, $gfp(f)$

Fixpoints can be used to express solutions of mutually recursive equation systems.

#th(title: "Tarski's theorem")[
  If $f: X -> X$ is monotonic in a complete lattice $X$, then $fp(f)$ is a complete lattice.
]

#th(title: "Kleene fixpoint theorem")[
  If $f : X -> X$ is continuous in a CPO $X$ and $a ssq f(a)$ then $lfp_a f$ exists.
]

*Remark:* in practice, we are often interested in applying the theorem with $a = bot$.

#def(title: "Well-ordered set")[
  $(S, ssq)$ is a _well-ordered set_ if:
  - $ssq$ is a total order on $S$
  - every $X seq S$ such that $X != emptyset$ has a least element $inter X in X$
]

#def(title: "Ordinals")[
  Ordinals are $0, 1, 2, ..., omega, omega + 1, ..., 2 omega, 2 omega + 1, ...$ where $omega$ is a limit. Well-ordered sets are ordinals up to order-isomorphism.
]

Intuitively, ordinals provide a way to keep iterating after infinity.

#th(title: "Constructive Tarski theorem")[
  If $f: X -> X$ is monotonic in a CPO $X$ and $a ssq f(a)$, then $lfp_a f = x_delta$ for some ordinal $delta$.
]

#def(title: "Ascending chain condition (ACC)")[
  An _ascending chain_ $C$ in $(X, ssq)$ is a sequence $c_i in X$ such that $i <= j => c_i ssq c_j$.

  A poset $(X, ssq)$ satisfies the _ascending chain condition_ (_ACC_) iff for every ascending chain $C$, $exists i, forall j >= i, c_i = c_j$.
]

Similarly, we can define a _descending chain condition_ (_DCC_).

#th(title: "Kleene finite fixpoint theorem")[
  If $f: X -> X$ is monotonic in an ACC poset $X$ and $a ssq f(a)$ then $lfp_a f$ exists.
]

#table(
  columns: (1fr,) * 5,
  align: center + horizon,
  table.header(
    table.cell(colspan: 5, [*Comparison of fixpoint theorems*]),
    [*theorem*], [*function*], [*domain*], [*fixpoint*], [*method*],
  ),
  [Tarski], [monotonic], [complete lattice], [$fp(f)$], [meet of post-fixpoints],
  [Kleene], [continuous], [CPO], [$lfp_a (f)$], [countable iterations],
  [constructive Tarski], [monotonic], [CPO], [$lfp_a (f)$], [transfinite iterations],
  [ACC Kleene], [monotonic], [ACC poset], [$lfp_a (f)$], [finite iterations],
)

= Galois connections

#let gcon = $arrows.lr_alpha^gamma$

#def(title: "Galois connection")[

  Given two posets $(C, <=)$ and $(A, ssq)$, the pair $(alpha: C -> A, gamma: A -> C)$ is a _Galois connection_ iff: $ forall a in A, forall c in C, alpha(c) ssq a <=> c <= gamma(a) $ which is noted $(C, <=) gcon (A, ssq)$.

  We say that:
  - $A$ is the _abstract domain_ and $alpha$ is the _abstraction_.
  - $C$ is the _concrete domain_ and $gamma$ is the _concretization_.
]

#ex(title: "Galois connection")[
  Abstract domain of intervals of integers $ZZ$ represented as pair of bounds $(a, b)$.

  We have $(cal(P)(ZZ), seq) gcon (I, ssq)$ with
  - $I eq.def (ZZ union {- infinity}) times (ZZ union {+ infinity})$
  - $(a, b) ssq (a', b') <=> (a >= a') and (b <= b')$
  - $alpha(X) eq.def (min X, max X)$
  - $gamma((a, b)) = [a, b]$
]

#prop(title: "Properties of Galois connections")[
  1. $gamma compose alpha$ is extensive
  2. $alpha compose gamma$ is reductive
  3. $alpha$ is monotonic
  4. $gamma$ is monotonic
  5. $gamma compose alpha compose gamma = gamma$
  6. $alpha compose gamma compose alpha = alpha$
  7. $alpha compose gamma$ is idempotent
  8. $gamma compose alpha$ is idempotent
]

*Proof.* \
1. Goal: $forall c in C, c <= gamma compose alpha (c)$. \ Let $c in C$, and consider $a = alpha(c) in A$. We have $alpha(c) ssq alpha(c)$ which leads to $c <= gamma (alpha (c))$.
2. Goal: $forall a in A, alpha compose gamma(a) ssq a$. \ Let $a in A$ and consider $c = gamma(a) in C$. Same as above.
3. Let $c, c' in C$ such that $c <= c'$. Then $c' <= gamma compose alpha(c')$. Then, $c <= gamma compose alpha(c')$. Then, $alpha(c) ssq alpha(c')$.
4. Same.
5. Let $a in A$.
  - $gamma compose alpha compose gamma (a) <= gamma(a): alpha compose gamma$ is reductive and $gamma$ is monotonic.
  - $gamma compose alpha compose gamma (a) >= gamma(a): gamma compose alpha$ is extensive.
6. Same.
7. 8. Using above.

#prop(title: "Galois connection characterization")[
  If the pair $(alpha: C -> A, gamma: A -> C)$ satisfies:
  1. $alpha$ is monotonic
  2. $gamma$ is monotonic
  3. $gamma compose alpha$ is extensive
  4. $alpha compose gamma$ is reductive
  then $(alpha, gamma)$ is a Galois connection.
]

#prop(title: "Uniqueness of the adjoint")[
  Given $(C, <=) gcon (A, ssq)$, each adjoint can be uniquely defined in term of the other:
  1. $alpha(c) = inter.sq {a | c <= gamma(a)}$
  2. $gamma(a) = or {c | alpha(c) ssq a}$
]

#prop(title: "Properties of Galois connections")[
  1. $forall X subset.eq C$, if $or X$ exists, then $alpha(or X) = union.sq {alpha(x) | x in X}$
  2. $forall X subset.eq A$, if $inter.sq X$ exists, then $gamma(inter.sq X) = and {gamma(x) | x in X}$
]

#let gemb = $harpoons.ltrb_alpha^gamma$

#def(title: "Galois embeddings")[
  If $(C, <=) gcon (A, ssq)$, the following properties are equivalent:
  1. $alpha$ is surjective
  2. $gamma$ is injective
  3. $alpha compose gamma = id$
  Such $(alpha, gamma)$ is called a _Galois embedding_, which is noted $(C, <=) gemb (A, ssq)$.
]

*Note:* I used a non-standard notation for Galois embeddings. The proper notation would be the arrows of Galois connections with a doubled head for the arrow at the bottom (symbol not available in native Typst AFAIK).

*Remark:* a Galois connection can always be made into an embedding by quotienting $A$ by the equivalence relation $a equiv a' <=> gamma(a) = gamma(a')$.

#ex(title: "Galois embedding")[
  Using the previous example of Galois connection, but we add an extra element $bot$: abstract domain of intervals of integers $ZZ$ represented as pairs of ordered bounds $(a, b)$ or $bot$.

  We have $(cal(P)(ZZ), seq) gemb (I', ssq)$, using previous example:
  - $I' = I union {bot}$
  - $forall x, bot ssq x$
  - $gamma(bot) = emptyset$
  - $alpha(emptyset) = bot$
]

#def(title: "Upper closures")[
  $rho: X -> X$ is an _upper closure_ in the poset $(X, ssq)$ if it is:
  - *monotonic*: $x ssq x' => rho(x) ssq rho(x')$
  - *extensive*: $x ssq rho(x)$
  - *idempotent*: $rho compose rho = rho$
]

Given $(C, <=) gcon (A, ssq)$, $gamma compose alpha$ is an upper closure on $(C, <=)$.

Given an upper closure $rho$ on $(X, ssq)$, we have a Galois embedding $(X, ssq) harpoons.ltrb_rho^id (rho(X), ssq)$.

We can rephrase abstract interpretation using upper closures instead of Galois connections, but we lose:
- the notion of *abstract representation*
- the ability to have several distinct abstract representations for a single concrete object.

= Operator approximations

#def(title: "Sound abstraction, exact abstraction")[
  Given a concrete $(C, <=)$ and an abstract $(A, ssq)$ poset and a monotonic concretization $gamma : A -> C$:
  - $a in A$ is a _sound abstraction_ of $c in C$ if $c <= gamma(a)$.
  - $g: A -> A$ is a _sound abstraction_ of $f : C -> C$ if $forall a in A, f compose gamma (a) <= gamma compose g (a)$.
  - $g: A -> A$ is an _exact abstraction_ of $f: C -> C$ if $f compose gamma = gamma compose g$
]

#ex(title: "Sound abstraction, exact abstraction")[
  - $[0, 10]$ is a sound abstraction of ${0, 1, 2, 5}$ in the integer interval domain
  - $lambda [a,b].[- infinity, + infinity]$ is a sound abstraction of $lambda X. {x + 1 | x in X}$
  - $lambda [a, b].[a + 1, b + 1]$ is an exact abstraction of $lambda X . {x + 1 | x in X}$
]

#prop(title: "Best abstractions")[
  - Given $c in C$, its _best abstraction_ is $alpha(c)$.
  - Given $f: C -> C$, its _best abstraction_ is $alpha compose f compose gamma$.
]

#prop(title: "Composition of sound, best, exact abstractions")[
  If $g$ and $g'$ soundly abstract respectively $f$ and $f'$:
  1. if $f$ is monotonic, then $g compose g'$ is a sound abstraction of $f compose f'$.
  2. if $g$ and $g'$ are exact abstractions of $f$ and $f'$ then $g compose g'$ is an exact abstraction.
  3. if $g$ and $g'$ are the best abstractions of $f$ and $f'$, then *$g compose g'$ is not always the best abstraction*.
]

*Proof.* \
1. $forall a in A, f' compose gamma(a) <= gamma compose g' (a)$ by soudness of $g'$, then $f compose f' compose gamma(a) <= f compose gamma compose g'(a)$ by monotonicity of $f$, then $f compose f' compose gamma(a) <= gamma compose g compose g' (a)$ by soundess of $g$, ie. the soudness of $g compose g'$.
2. $f compose f' compose gamma = f compose gamma compose g'$ because $g'$ exactly abstract $f'$, then $f compose gamma compose g' = gamma compose g compose g'$ because $g$ exactly abstract $f$, ie. $g compose g'$ exactly abstract $f compose f'$.

#ex(title: "Best abstractions composition counterexample")[
  Consider $(cal(P)(ZZ), seq) gcon (I, ssq)$ where $I$ is the set of intervals of integers mentioned before.

  The functions
  - $g([a, b]) = [a, min(b, 1)]$
  - $g'([a, b])= [2a, 2b]$
  are the best abstractions of
  - $f(X) = {x in X | x <= 1}$
  - $f'(X) = {2x | x in X}$
  but $(g compose g')([0,1]) = [0,1]$, whereas $(alpha compose f compose f' compose gamma)([0,1]) = [0, 0]$.
]

= Fixpoint approximations

#th(title: "Fixpoint transfer")[
  If we have:
  - a Galois connection $(C, <=) gcon (A, ssq)$ between *CPOs*
  - *monotonic* concrete and abstract functions $f: C -> C$, $f^\#: A -> A$
  - a *commutation condition* $alpha compose f = f^\# compose alpha$
  - a *pre-fixpoint* $a$ of $f$ and its abstraction $a^\#= alpha(a)$

  Then $alpha(lfp_a f) = lfp_(a^\#) f^\#$.
]

#th(title: "Fixpoint approximation")[
  If we have:
  - a *complete lattice* $(C, <=, or, and, bot, top)$
  - a *monotonic* concrete function $f$
  - a *sound abstraction* $f^\#: A -> A$ of $f$
  - a *post-fixpoint* $a^\#$ of $f^\#$

  Then $a^\#$ is a *sound abstraction of $lfp f$*: $lfp f <= gamma(a^\#)$.
]

Please refer to the slides for the proofs.

*Remark:* other fixpoint transfer / approximation theorems can be constructed.
